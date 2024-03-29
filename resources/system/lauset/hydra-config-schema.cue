package kube

import (
	"strings"
	"list"
)

#HydraConfigSchema: {
	// Ory Hydra Configuration
	@jsonschema(schema="http://json-schema.org/draft-07/schema#")
	@jsonschema(id="https://github.com/ory/hydra/spec/config.json")

	// Configures the database connection
	db?: {
		// Ignore scan errors when columns in the SQL result have no
		// fields in the destination struct
		ignore_unknown_table_columns?: bool | *false
	}

	// Configures the logger
	log?: {
		// Sets the log level.
		level?: "panic" | "fatal" | "error" | "warn" | "info" | "debug" | "trace" | *"info"

		// Logs sensitive values such as cookie and URL parameter.
		leak_sensitive_values?: bool | *false

		// Sensitive log value redaction text
		//
		// Text to use, when redacting sensitive log value.
		redaction_text?: string

		// Sets the log format.
		format?: "json" | "json_pretty" | "text" | *"text"
	}

	// Controls the configuration for the http(s) daemon(s).
	serve?: {
		// Controls the public daemon serving public API endpoints like
		// /oauth2/auth, /oauth2/token, /.well-known/jwks.json
		public?: {
			port?: #portNumber & int | *4444

			// The interface or unix socket Ory Hydra should listen and handle
			// public API requests on. Use the prefix `unix:` to specify a
			// path to a unix socket. Leave empty to listen on all
			// interfaces.
			host?:   string | *""
			cors?:   #cors
			socket?: #socket

			// Access Log configuration for public server.
			request_log?: {
				// Disable access log for health endpoints.
				disable_for_health?: bool | *false
			}
			tls?: #tls_config
		}
		admin?: {
			port?: #portNumber & int | *4445

			// The interface or unix socket Ory Hydra should listen and handle
			// administrative API requests on. Use the prefix `unix:` to
			// specify a path to a unix socket. Leave empty to listen on all
			// interfaces.
			host?:   string | *""
			cors?:   #cors
			socket?: #socket

			// Access Log configuration for admin server.
			request_log?: {
				// Disable access log for health endpoints.
				disable_for_health?: bool | *false
			}
			tls?: #tls_config
		}
		tls?: #tls_config
		cookies?: {
			// Specify the SameSite mode that cookies should be sent with.
			same_site_mode?: "Strict" | "Lax" | "None" | *"None"

			// Some older browser versions don’t work with SameSite=None. This
			// option enables the workaround defined in
			// https://web.dev/samesite-cookie-recipes/ which essentially
			// stores a second cookie without SameSite as a fallback.
			same_site_legacy_workaround?: bool | *false

			// HTTP Cookie Domain
			//
			// Sets the cookie domain for session and CSRF cookies. Useful
			// when dealing with subdomains. Use with care!
			domain?: string

			// HTTP Cookie Secure Flag in Development Mode
			//
			// Sets the HTTP Cookie secure flag in development mode. HTTP
			// Cookies always have the secure flag in production mode.
			secure?: bool | *false

			// Cookie Names
			//
			// Sets the session cookie name. Use with care!
			names?: {
				// CSRF Cookie Name
				login_csrf?: string | *"ory_hydra_login_csrf"

				// CSRF Cookie Name
				consent_csrf?: string | *"ory_hydra_consent_csrf"

				// Session Cookie Name
				session?: string | *"ory_hydra_session"
				...
			}

			// Cookie Paths
			//
			// Sets the path for which session cookie is scoped. Use with
			// care!
			paths?: {
				// Session Cookie Path
				session?: string | *"/"
				...
			}
		}
	}

	// Sets the data source name. This configures the backend where
	// Ory Hydra persists data. If dsn is `memory`, data will be
	// written to memory and is lost when you restart this instance.
	// Ory Hydra supports popular SQL databases. For more detailed
	// configuration information go to:
	// https://www.ory.sh/docs/hydra/dependencies-environment#sql
	dsn?: string

	// Global outgoing network settings
	//
	// Configure how outgoing network calls behave.
	clients?: {
		// Global HTTP client configuration
		//
		// Configure how outgoing HTTP calls behave.
		http?: {
			// Disallow private IP ranges
			//
			// Disallow all outgoing HTTP calls to private IP ranges. This
			// feature can help protect against SSRF attacks.
			disallow_private_ip_ranges?: bool | *false
		}
	}

	// Configures Hardware Security Module.
	hsm?: {
		enabled?: bool

		// Full path (including file extension) of the HSM vendor PKCS#11
		// library
		library?: string

		// PIN code for token operations
		pin?: string

		// Slot ID of the token to use (if label is not specified)
		slot?: int

		// Label of the token to use (if slot is not specified). If both
		// slot and label are set, token label takes preference over
		// slot. In this case first slot, that contains this label is
		// used.
		token_label?: string

		// Key set prefix can be used in case of multiple Ory Hydra
		// instances need to store keys on the same HSM partition. For
		// example if `hsm.key_set_prefix=app1.` then key set
		// `hydra.openid.id-token` would be generated/requested/deleted
		// on HSM with `CKA_LABEL=app1.hydra.openid.id-token`.
		key_set_prefix?: string | *""
	}

	// Configures ./well-known/ settings.
	webfinger?: {
		// Configures the /.well-known/jwks.json endpoint.
		jwks?: {
			// A list of JSON Web Keys that should be exposed at that
			// endpoint. This is usually the public key for verifying OpenID
			// Connect ID Tokens. However, you might want to add additional
			// keys here as well.
			broadcast_keys?: [...string] | *["hydra.openid.id-token"]
		}

		// Configures OpenID Connect Discovery
		// (/.well-known/openid-configuration).
		oidc_discovery?: {
			// Overwrites the JWKS URL
			jwks_url?: string

			// Overwrites the OAuth2 Token URL
			token_url?: string

			// Overwrites the OAuth2 Auth URL
			auth_url?: string

			// Sets the OpenID Connect Dynamic Client Registration Endpoint
			client_registration_url?: string

			// A list of supported claims to be broadcasted. Claim `sub` is
			// always included.
			supported_claims?: [...string]

			// The scope OAuth 2.0 Clients may request. Scope `offline`,
			// `offline_access`, and `openid` are always included.
			supported_scope?: [...string]

			// A URL of the userinfo endpoint to be advertised at the OpenID
			// Connect Discovery endpoint /.well-known/openid-configuration.
			// Defaults to Ory Hydra's userinfo endpoint at /userinfo. Set
			// this value if you want to handle this endpoint yourself.
			userinfo_url?: string
		}
	}

	// Configures OpenID Connect features.
	oidc?: {
		// Configures the Subject Identifier algorithm. For more
		// information please head over to the documentation:
		// https://www.ory.sh/docs/hydra/advanced#subject-identifier-algorithms
		subject_identifiers?: ({
			...
		} | {
			...
		}) & {
			// A list of algorithms to enable.
			supported_types?: [..."public" | "pairwise"] | *["public"]

			// Configures the pairwise algorithm.
			pairwise?: {
				salt: string
			}
		}

		// Configures OpenID Connect Dynamic Client Registration (exposed
		// as admin endpoints /clients/...).
		dynamic_client_registration?: {
			// Enable dynamic client registration.
			enabled?: bool | *false

			// The OpenID Connect Dynamic Client Registration specification
			// has no concept of whitelisting OAuth 2.0 Scope. If you want to
			// expose Dynamic Client Registration, you should set the default
			// scope enabled for newly registered clients. Keep in mind that
			// users can overwrite this default by setting the `scope` key in
			// the registration payload, effectively disabling the concept of
			// whitelisted scopes.
			default_scope?: [...string]
		}
	}
	urls?: {
		self?: {
			// This value will be used as the `issuer` in access and ID
			// tokens. It must be specified and using HTTPS protocol, unless
			// --dev is set. This should typically be equal to the public
			// value.
			issuer?: string

			// This is the base location of the public endpoints of your Ory
			// Hydra installation. This should typically be equal to the
			// issuer value. If left unspecified, it falls back to the issuer
			// value.
			public?: string

			// This is the base location of the admin endpoints of your Ory
			// Hydra installation.
			admin?: string
		}

		// Sets the OAuth2 Login Endpoint URL of the OAuth2 User Login &
		// Consent flow. Defaults to an internal fallback URL showing an
		// error.
		login?: string

		// Sets the consent endpoint of the User Login & Consent flow.
		// Defaults to an internal fallback URL showing an error.
		consent?: string

		// Sets the logout endpoint. Defaults to an internal fallback URL
		// showing an error.
		logout?: string

		// Sets the error endpoint. The error ui will be shown when an
		// OAuth2 error occurs that which can not be sent back to the
		// client. Defaults to an internal fallback URL showing an error.
		error?: string

		// When a user agent requests to logout, it will be redirected to
		// this url afterwards per default.
		post_logout_redirect?: string
	}
	strategies?: {
		// Defines how scopes are matched. For more details have a look at
		// https://github.com/ory/fosite#scopes
		scope?: "exact" | "wildcard" | *"wildcard"

		// Defines access token type. jwt is a bad idea, see
		// https://www.ory.sh/docs/hydra/advanced#json-web-tokens
		access_token?: "opaque" | "jwt" | *"opaque"
	}

	// Configures time to live.
	ttl?: {
		// Configures how long a user login and consent flow may take.
		login_consent_request?: #duration | *"30m"

		// Configures how long access tokens are valid.
		access_token?: #duration | *"1h"

		// Configures how long refresh tokens are valid. Set to -1 for
		// refresh tokens to never expire.
		refresh_token?: #duration | ("-1" | -1) | *"720h"

		// Configures how long id tokens are valid.
		id_token?: #duration | *"1h"

		// Configures how long auth codes are valid.
		auth_code?: #duration | *"10m"
	}
	oauth2?: {
		// Set this to true if you want to share error debugging
		// information with your OAuth 2.0 clients. Keep in mind that
		// debug information is very valuable when dealing with errors,
		// but might also expose database error codes and similar errors.
		expose_internal_errors?: bool | *false
		session?: {
			// Encrypt OAuth2 Session
			//
			// If set to true (default) Ory Hydra encrypt OAuth2 and OpenID
			// Connect session data using AES-GCM and the system secret
			// before persisting it in the database.
			encrypt_at_rest?: bool | *true
			...
		}

		// Set to true if you want to exclude claim `nbf (not before)`
		// part of access token.
		exclude_not_before_claim?: bool | *false

		// A list of custom claims which are allowed to be added top level
		// to the Access Token. They cannot override reserved claims.
		allowed_top_level_claims?: [...string]

		// Configures hashing algorithms. Supports only BCrypt and PBKDF2
		// at the moment.
		hashers?: {
			// Password hashing algorithm
			//
			// One of the values: pbkdf2, bcrypt.
			//
			// Warning! This value can not be changed once set as all existing
			// OAuth 2.0 Clients will not be able to sign in any more.
			algorithm?: "pbkdf2" | "bcrypt" | *"pbkdf2"

			// Configures the BCrypt hashing algorithm used for hashing OAuth
			// 2.0 Client Secrets.
			bcrypt?: {
				// Sets the BCrypt cost. The higher the value, the more CPU time
				// is being used to generate hashes.
				cost?: int & >=4 & <=31 | *10
			}

			// Configures the PBKDF2 hashing algorithm used for hashing OAuth
			// 2.0 Client Secrets.
			pbkdf2?: {
				// Sets the PBKDF2 iterations. The higher the value, the more CPU
				// time is being used to generate hashes.
				iterations?: int & >=1 | *25000
			}
		}
		pkce?: {
			// Sets whether PKCE should be enforced for all clients.
			enforced?: bool

			// Sets whether PKCE should be enforced for public clients.
			enforced_for_public_clients?: bool
		}
		client_credentials?: {
			// Automatically grant authorized OAuth2 Scope in OAuth2 Client
			// Credentials Flow. Each OAuth2 Client is allowed to request a
			// predefined OAuth2 Scope (for example `read write`). If this
			// option is enabled, the full
			// scope is automatically granted when performing the OAuth2
			// Client Credentials flow.
			//
			// If disabled, the OAuth2 Client has to request the scope in the
			// OAuth2 request by providing the `scope` query parameter.
			// Setting this option to true is common if you need
			// compatibility with MITREid.
			default_grant_allowed_scope?: bool
		}
		grant?: {
			// Authorization Grants using JWT configuration
			jwt?: {
				// Configures if the JSON Web Token ID (`jti`) claim is required
				// in the JSON Web Token (JWT) Profile for OAuth 2.0 Client
				// Authentication and Authorization Grants (RFC7523). If set to
				// `false`, the `jti` claim is required. Set this value to `true`
				// only after careful consideration.
				jti_optional?: bool | *false

				// Configures if the issued at (`iat`) claim is required in the
				// JSON Web Token (JWT) Profile for OAuth 2.0 Client
				// Authentication and Authorization Grants (RFC7523). If set to
				// `false`, the `iat` claim is required. Set this value to `true`
				// only after careful consideration.
				iat_optional?: bool | *false

				// Configures what the maximum age of a JWT assertion used in the
				// JSON Web Token (JWT) Profile for OAuth 2.0 Client
				// Authentication and Authorization Grants (RFC7523) can be. This
				// feature uses the `exp` claim and `iat` claim to calculate
				// assertion age. Assertions exceeding the max age will be
				// denied. Useful as a safety measure and recommended to keep
				// below 720h. This governs the `grant.jwt.max_ttl` setting.
				max_ttl?: #duration | *"720h"
			}
		}

		// Sets the refresh token hook endpoint. If set it will be called
		// during token refresh to receive updated token claims.
		refresh_token_hook?: string

		// Sets the token hook endpoint for all grant types. If set it
		// will be called while providing token to customize claims.
		token_hook?: string
	}

	// The secrets section configures secrets used for encryption and
	// signing of several systems. All secrets can be rotated, for
	// more information on this topic go to:
	// https://www.ory.sh/docs/hydra/advanced#rotation-of-hmac-token-signing-and-database-and-cookie-encryption-keys
	secrets?: {
		// The system secret must be at least 16 characters long. If none
		// is provided, one will be generated. They key is used to
		// encrypt sensitive data using AES-GCM (256 bit) and validate
		// HMAC signatures. The first item in the list is used for
		// signing and encryption. The whole list is used for verifying
		// signatures and decryption.
		system?: [...strings.MinRunes(16)]

		// A secret that is used to encrypt cookie sessions. Defaults to
		// secrets.system. It is recommended to use a separate secret in
		// production. The first item in the list is used for signing and
		// encryption. The whole list is used for verifying signatures
		// and decryption.
		cookie?: [...strings.MinRunes(16)]
	}

	// Enables profiling if set. For more details on profiling, head
	// over to: https://blog.golang.org/profiling-go-programs
	profiling?: "cpu" | "mem"
	tracing?:   #OtelxTracingConfig

	// Software Quality Assurance telemetry configuration section
	sqa?: {
		// Disables anonymized telemetry reports - for more information
		// please visit https://www.ory.sh/docs/ecosystem/sqa
		opt_out?: bool | *false
		...
	}

	// The Hydra version this config is written for.
	//
	// SemVer according to https://semver.org/ prefixed with `v` as in
	// our releases.
	version?: =~"^v(0|[1-9]\\d*)\\.(0|[1-9]\\d*)\\.(0|[1-9]\\d*)(?:-((?:0|[1-9]\\d*|\\d*[a-zA-Z-][0-9a-zA-Z-]*)(?:\\.(?:0|[1-9]\\d*|\\d*[a-zA-Z-][0-9a-zA-Z-]*))*))?(?:\\+([0-9a-zA-Z-]+(?:\\.[0-9a-zA-Z-]+)*))?$"

	// Ory Hydra can respect Linux container CPU quota
	cgroups?: {
		// Configures parameters using cgroups v1 hierarchy
		v1?: {
			// Set GOMAXPROCS automatically according to cgroups limits
			auto_max_procs_enabled?: bool | *false
		}
	}

	// Enable development mode
	//
	// If true, disables critical security measures to allow easier
	// local development. Do not use in production.
	dev?: bool | *false

	#http_method: "POST" | "GET" | "PUT" | "PATCH" | "DELETE" | "CONNECT" | "HEAD" | "OPTIONS" | "TRACE"

	#portNumber: null | bool | >=1 & <=65535 | string | [...] | {
		...
	}

	#socket: {
		// Owner of unix socket. If empty, the owner will be the user
		// running hydra.
		owner?: string | *""

		// Group of unix socket. If empty, the group will be the primary
		// group of the user running hydra.
		group?: string | *""

		// Mode of unix socket in numeric form
		mode?: int & >=0 & <=511 | *493
	}

	#cors: {
		// Sets whether CORS is enabled.
		enabled?: bool | *false

		// A list of origins a cross-domain request can be executed from.
		// If the special * value is present in the list, all origins
		// will be allowed. An origin may contain a wildcard (*) to
		// replace 0 or more characters (i.e.: http://*.domain.com). Only
		// one wildcard can be used per origin.
		allowed_origins?: list.UniqueItems() & [...(string | "*") & strings.MinRunes(1)]

		// A list of HTTP methods the user agent is allowed to use with
		// cross-domain requests.
		allowed_methods?: [..."POST" | "GET" | "PUT" | "PATCH" | "DELETE" | "CONNECT" | "HEAD" | "OPTIONS" | "TRACE"] | *["POST", "GET", "PUT", "PATCH", "DELETE", "CONNECT", "HEAD", "OPTIONS", "TRACE"]

		// A list of non simple headers the client is allowed to use with
		// cross-domain requests.
		allowed_headers?: [...string] | *["Accept", "Content-Type", "Content-Length", "Accept-Language", "Content-Language", "Authorization"]

		// Sets which headers are safe to expose to the API of a CORS API
		// specification.
		exposed_headers?: [...string] | *["Cache-Control", "Expires", "Last-Modified", "Pragma", "Content-Length", "Content-Language", "Content-Type"]

		// Sets whether the request can include user credentials like
		// cookies, HTTP authentication or client side SSL certificates.
		allow_credentials?: bool | *true

		// Sets how long (in seconds) the results of a preflight request
		// can be cached. If set to 0, every request is preceded by a
		// preflight request.
		max_age?: int & >=0 | *0

		// Adds additional log output to debug server side CORS issues.
		debug?: bool | *false
	}

	#cidr: =~"^(([0-9a-fA-F]{1,4}:){7}[0-9a-fA-F]{1,4}|([0-9a-fA-F]{1,4}:){1,7}:|([0-9a-fA-F]{1,4}:){1,6}:[0-9a-fA-F]{1,4}|([0-9a-fA-F]{1,4}:){1,5}(:[0-9a-fA-F]{1,4}){1,2}|([0-9a-fA-F]{1,4}:){1,4}(:[0-9a-fA-F]{1,4}){1,3}|([0-9a-fA-F]{1,4}:){1,3}(:[0-9a-fA-F]{1,4}){1,4}|([0-9a-fA-F]{1,4}:){1,2}(:[0-9a-fA-F]{1,4}){1,5}|[0-9a-fA-F]{1,4}:((:[0-9a-fA-F]{1,4}){1,6})|:((:[0-9a-fA-F]{1,4}){1,7}|:)|fe80:(:[0-9a-fA-F]{0,4}){0,4}%[0-9a-zA-Z]{1,}|::(ffff(:0{1,4}){0,1}:){0,1}((25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])\\.){3,3}(25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])|([0-9a-fA-F]{1,4}:){1,4}:((25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])\\.){3,3}(25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9]))/([0-9]|[1-9][0-9]|1[0-1][0-9]|12[0-8])$" | =~"^([0-9]{1,3}\\.){3}[0-9]{1,3}/([0-9]|[1-2][0-9]|3[0-2])$"

	#pem_file: {
		// The path to the pem file.
		path: string
	} | {
		// The base64 encoded string (without padding).
		base64: string
	}

	#duration: =~"^(\\d+(ns|us|ms|s|m|h))+$"

	#tls_config: {
		// Setting enabled to false drops the TLS requirement for the
		// admin endpoint, even if TLS is enabled on the public endpoint.
		enabled?: bool

		// Configures the private key (pem encoded).
		key?: #pem_file

		// Configures the public certificate (pem encoded).
		cert?: #pem_file

		// Whitelist one or multiple CIDR address ranges and allow them to
		// terminate TLS connections. Be aware that the X-Forwarded-Proto
		// header must be set and must never be modifiable by anyone but
		// your proxy / gateway / load balancer. Supports ipv4 and ipv6.
		// Hydra serves http instead of https when this option is set.
		allow_termination_from?: [...#cidr]
		...
	}

	#OtelxTracingConfig: {
		@jsonschema(id="ory://tracing-config")

		// Set this to the tracing backend you wish to use. Supports
		// Jaeger, Zipkin, and OTEL.
		provider?: "jaeger" | "otel" | "zipkin"

		// Specifies the service name to use on the tracer.
		service_name?: string

		// Specifies the deployment environment to use on the tracer.
		deployment_environment?: string
		providers?: {
			// Configures the jaeger tracing backend.
			jaeger?: {
				// The address of the jaeger-agent where spans should be sent to.
				local_agent_address?: (=~"^\\[(([0-9a-fA-F]{1,4}:){7}[0-9a-fA-F]{1,4}|([0-9a-fA-F]{1,4}:){1,7}:|([0-9a-fA-F]{1,4}:){1,6}:[0-9a-fA-F]{1,4}|([0-9a-fA-F]{1,4}:){1,5}(:[0-9a-fA-F]{1,4}){1,2}|([0-9a-fA-F]{1,4}:){1,4}(:[0-9a-fA-F]{1,4}){1,3}|([0-9a-fA-F]{1,4}:){1,3}(:[0-9a-fA-F]{1,4}){1,4}|([0-9a-fA-F]{1,4}:){1,2}(:[0-9a-fA-F]{1,4}){1,5}|[0-9a-fA-F]{1,4}:((:[0-9a-fA-F]{1,4}){1,6})|:((:[0-9a-fA-F]{1,4}){1,7}|:)|fe80:(:[0-9a-fA-F]{0,4}){0,4}%[0-9a-zA-Z]{1,}|::(ffff(:0{1,4}){0,1}:){0,1}((25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])\\.){3,3}(25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])|([0-9a-fA-F]{1,4}:){1,4}:((25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])\\.){3,3}(25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9]))]:([0-9]*)$" | =~"^([0-9]{1,3}\\.){3}[0-9]{1,3}:([0-9]*)$" | =~"^(([a-zA-Z0-9]|[a-zA-Z0-9][a-zA-Z0-9\\-]*[a-zA-Z0-9])\\.)*([A-Za-z0-9]|[A-Za-z0-9][A-Za-z0-9\\-]*[A-Za-z0-9]):([0-9]*)$") & string
				sampling?: {
					["server_url" | "trace_id_ratio"]: _
				} & {
					// The address of jaeger-agent's HTTP sampling server
					server_url?: string

					// Trace Id ratio sample
					trace_id_ratio?: number
				}
			}

			// Configures the zipkin tracing backend.
			zipkin?: {
				// The address of the Zipkin server where spans should be sent to.
				server_url?: string
				sampling?: {
					["sampling_ratio"]: _
				} & {
					// Sampling ratio for spans.
					sampling_ratio?: number
				}
			}

			// Configures the OTLP tracing backend.
			otlp?: {
				// The endpoint of the OTLP exporter (HTTP) where spans should be
				// sent to.
				server_url?: (=~"^\\[(([0-9a-fA-F]{1,4}:){7}[0-9a-fA-F]{1,4}|([0-9a-fA-F]{1,4}:){1,7}:|([0-9a-fA-F]{1,4}:){1,6}:[0-9a-fA-F]{1,4}|([0-9a-fA-F]{1,4}:){1,5}(:[0-9a-fA-F]{1,4}){1,2}|([0-9a-fA-F]{1,4}:){1,4}(:[0-9a-fA-F]{1,4}){1,3}|([0-9a-fA-F]{1,4}:){1,3}(:[0-9a-fA-F]{1,4}){1,4}|([0-9a-fA-F]{1,4}:){1,2}(:[0-9a-fA-F]{1,4}){1,5}|[0-9a-fA-F]{1,4}:((:[0-9a-fA-F]{1,4}){1,6})|:((:[0-9a-fA-F]{1,4}){1,7}|:)|fe80:(:[0-9a-fA-F]{0,4}){0,4}%[0-9a-zA-Z]{1,}|::(ffff(:0{1,4}){0,1}:){0,1}((25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])\\.){3,3}(25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])|([0-9a-fA-F]{1,4}:){1,4}:((25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])\\.){3,3}(25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9]))]:([0-9]*)$" | =~"^([0-9]{1,3}\\.){3}[0-9]{1,3}:([0-9]*)$" | =~"^(([a-zA-Z0-9]|[a-zA-Z0-9][a-zA-Z0-9\\-]*[a-zA-Z0-9])\\.)*([A-Za-z0-9]|[A-Za-z0-9][A-Za-z0-9\\-]*[A-Za-z0-9]):([0-9]*)$") & string

				// Will use HTTP if set to true; defaults to HTTPS.
				insecure?: bool
				sampling?: {
					["sampling_ratio"]: _
				} & {
					// Sampling ratio for spans.
					sampling_ratio?: number
				}
				authorization_header?: string
			}
		}
	}
}
