import { serve } from "https://deno.land/std@0.167.0/http/mod.ts";
import { parse } from "https://deno.land/std@0.167.0/flags/mod.ts";
import * as colors from "https://deno.land/std@0.167.0/fmt/colors.ts";
import { router } from "https://deno.land/x/rutt@0.0.14/mod.ts";

type HandlerContext = {
  hostConfigs: Record<string, unknown>;
  githubToken: string;
  persistanceRoot: string;
};

const routeHandler = router<HandlerContext>({
  "/v1/boot/:mac": (_req, { hostConfigs, persistanceRoot }, match) => {
    const mac = match.mac;
    if ([...Deno.readDirSync(persistanceRoot)].map((d) => d.name).includes(mac)) {
      console.log(
        "Skipping already provisioned node",
        mac,
        "because",
        persistanceRoot,
        "contained a file called",
        mac,
      );
    } else if (mac in hostConfigs) {
      console.log("Serving host config for", mac, hostConfigs[mac]);
      return Response.json(hostConfigs[mac]);
    }
    return new Response(null, { status: 404 });
  },
  "POST@/v1/ssh-key/:title": async (req, { githubToken }, match) => {
    const title = match.title;
    const key = await req.text();

    return await fetchGithub("/repos/addreas/flakefiles/keys", {
      githubToken,
      method: "POST",
      body: JSON.stringify({ key: key.trim(), title, read_only: false }),
    });
  },
  "POST@/v1/install-finished/:mac": async (
    _req,
    { hostConfigs, persistanceRoot },
    match,
  ) => {
    const mac = match.mac;
    await Deno.writeTextFile(
      `${persistanceRoot}/${mac}`,
      new Date().toISOString(),
    );
    return new Response(`Disabled further pixie booting of ${mac}`);
  },
});

const args = parse(Deno.args);

if (!("configs" in args)) throw new Error("Missing --configs arg");
if (!("github-client-id" in args)) {
  throw new Error("Missing --github-client-id arg");
}

const hostConfigs = JSON.parse(await Deno.readTextFile(args.configs));
const persistanceRoot = args.persist ?? "/tmp/pixie-api";
const githubToken = await githubDeviceFlow(
  args["github-client-id"],
  persistanceRoot,
);

serve(
  async (req, conn) => {
    const before = window.performance.now();
    try {
      const res = await routeHandler(req, {
        ...conn,
        hostConfigs,
        githubToken,
        persistanceRoot,
      });
      const durationMs = window.performance.now() - before;
      console.log(
        `${new Date().toISOString()} | ${
          statusColor(res.status)(`${res.status}`)
        } | ${durationMs}ms | ${formatAddr(conn.remoteAddr)} | ${
          methodColor(req.method)(req.method)
        } | ${req.url}`,
      );
      return res;
    } catch (e) {
      const durationMs = window.performance.now() - before;
      console.log(
        `${new Date().toISOString()} | EXCEPTION THROWN | ${durationMs}ms | ${
          formatAddr(conn.remoteAddr)
        } | ${methodColor(req.method)(req.method)} | ${req.url}`,
      );
      throw e;
    }
  },
  {
    port: parseInt(args.port),
    hostname: args.host,
  },
);

function statusColor(code: number) {
  if (code < 200) {
    return colors.bgBlue;
  } else if (code >= 200 && code < 300) {
    return colors.bgGreen;
  } else if (code >= 300 && code < 500) {
    return colors.bgYellow;
  } else {
    return colors.bgRed;
  }
}

function methodColor(method: string) {
  switch (method) {
    case "HEAD":
    case "OPTIONS":
    case "GET":
      return colors.bgBlue;

    case "PUT":
    case "PATCH":
    case "POST":
      return colors.bgBrightGreen;

    case "DELETE":
      return colors.bgRed;

    default:
      return colors.bgYellow;
  }
}

function formatAddr(addr: Deno.Addr): string {
  switch (addr.transport) {
    case "tcp":
    case "udp":
      return `${addr.transport}://${addr.hostname}:${addr.port}`;

    case "unix":
    case "unixpacket":
      return addr.path;
  }
}

async function githubDeviceFlow(
  client_id: string,
  persistanceRoot: string,
): Promise<string> {
  const tokenPath = `${persistanceRoot}/github-token`;
  try {
    const tmpToken = await Deno.readTextFile(tokenPath);
    if ((await fetchGithub("/user", { githubToken: tmpToken })).ok) {
      return tmpToken;
    }
  } catch (e) {
    console.log(e);
  }

  while (true) {
    const deviceCodeRes = await fetch(
      "https://github.com/login/device/code",
      {
        method: "POST",
        headers: [
          ["Accept", "application/json"],
          ["Content-Type", "application/json"],
        ],
        body: JSON.stringify({
          client_id,
          scope: "repo",
        }),
      },
    ).then((r) => r.json());

    if (!deviceCodeRes.user_code) {
      throw new Error(`Missing user_code in ${JSON.stringify(deviceCodeRes)}`);
    }

    const expiry = Date.now() + 900 * 1000;

    while (Date.now() < expiry) {
      console.log(
        "You should enter the code",
        deviceCodeRes.user_code,
        "at",
        deviceCodeRes.verification_uri,
      );

      const accessTokenRes = await fetch(
        "https://github.com/login/oauth/access_token",
        {
          method: "POST",
          headers: [
            ["Accept", "application/json"],
            ["Content-Type", "application/json"],
          ],
          body: JSON.stringify({
            client_id,
            grant_type: "urn:ietf:params:oauth:grant-type:device_code",
            device_code: deviceCodeRes.device_code,
          }),
        },
      ).then((r) => r.json());

      if (accessTokenRes.access_token) {
        const token = accessTokenRes.access_token;
        await Deno.mkdir(persistanceRoot, {recursive: true}).catch(() => {});
        await Deno.writeTextFile(tokenPath, token);
        return token;
      }

      await new Promise((resolve) =>
        setTimeout(resolve, deviceCodeRes.interval * 1000)
      );
    }
  }
}

function fetchGithub(
  path: string,
  init: RequestInit & { githubToken: string; headers?: [string, string][] },
) {
  return fetch(`https://api.github.com${path}`, {
    ...init,
    headers: [
      ["Accept", "application/vnd.github+json"],
      ["Authorization", `Bearer ${init.githubToken}`],
      ["X-GitHub-Api-Version", "2022-11-28"],
      ...(init.headers ?? []),
    ],
  });
}
