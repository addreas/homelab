package util

copyStatic: {
    name:  "copy-static"
    image: "quay.io/quay/busybox"
    command: [
        "cp",
        "-r",
        "--no-target-directory",
        "/static",
        "/",
    ]
}
