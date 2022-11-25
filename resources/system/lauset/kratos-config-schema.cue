package kube

import (
	"list"
	"strings"
)

#KratosConfigSchema: {
	// Ory Kratos Configuration
	@jsonschema(schema="http://json-schema.org/draft-07/schema#")
	@jsonschema(id="https://github.com/ory/kratos/embedx/config.schema.json")
	selfservice: {
		default_browser_return_url: #defaultReturnTo

		// Allowed Return To URLs
		//
		// List of URLs that are allowed to be redirected to. A
		// redirection request is made by appending `?return_to=...` to
		// Login, Registration, and other self-service flows.
		allowed_return_urls?: list.UniqueItems() & [...string]
		flows?: {
			settings?: {
				// URL of the Settings page.
				//
				// URL where the Settings UI is hosted. Check the [reference
				// implementation](https://github.com/ory/kratos-selfservice-ui-node).
				ui_url?:                     string | *"https://www.ory.sh/kratos/docs/fallback/settings"
				lifespan?:                   =~"^([0-9]+(ns|us|ms|s|m|h))+$" | *"1h"
				privileged_session_max_age?: =~"^([0-9]+(ns|us|ms|s|m|h))+$" | *"1h"
				required_aal?:               #featureRequiredAal
				after?:                      #selfServiceAfterSettings
			}
			logout?: after?: default_browser_return_url?: #defaultReturnTo
			registration?: {
				// Enable User Registration
				//
				// If set to true will enable [User
				// Registration](https://www.ory.sh/kratos/docs/self-service/flows/user-registration/).
				enabled?: bool | *true

				// Registration UI URL
				//
				// URL where the Registration UI is hosted. Check the [reference
				// implementation](https://github.com/ory/kratos-selfservice-ui-node).
				ui_url?:   string | *"https://www.ory.sh/kratos/docs/fallback/registration"
				lifespan?: =~"^([0-9]+(ns|us|ms|s|m|h))+$" | *"1h"
				before?:   #selfServiceBeforeRegistration
				after?:    #selfServiceAfterRegistration
			}
			login?: {
				// Login UI URL
				//
				// URL where the Login UI is hosted. Check the [reference
				// implementation](https://github.com/ory/kratos-selfservice-ui-node).
				ui_url?:   string | *"https://www.ory.sh/kratos/docs/fallback/login"
				lifespan?: =~"^([0-9]+(ns|us|ms|s|m|h))+$" | *"1h"
				before?:   #selfServiceBeforeLogin
				after?:    #selfServiceAfterLogin
			}

			// Email and Phone Verification and Account Activation
			// Configuration
			verification?: {
				// Enable Email/Phone Verification
				//
				// If set to true will enable [Email and Phone Verification and
				// Account
				// Activation](https://www.ory.sh/kratos/docs/self-service/flows/verify-email-account-activation/).
				enabled?: bool | *false

				// Verify UI URL
				//
				// URL where the Ory Verify UI is hosted. This is the page where
				// users activate and / or verify their email or telephone
				// number. Check the [reference
				// implementation](https://github.com/ory/kratos-selfservice-ui-node).
				ui_url?: string | *"https://www.ory.sh/kratos/docs/fallback/verification"
				after?:  #selfServiceAfterVerification

				// Self-Service Verification Request Lifespan
				//
				// Sets how long the verification request (for the UI interaction)
				// is valid.
				lifespan?: =~"^([0-9]+(ns|us|ms|s|m|h))+$" | *"1h"
			}

			// Account Recovery Configuration
			recovery?: {
				// Enable Account Recovery
				//
				// If set to true will enable [Account
				// Recovery](https://www.ory.sh/kratos/docs/self-service/flows/password-reset-account-recovery/).
				enabled?: bool | *false

				// Recovery UI URL
				//
				// URL where the Ory Recovery UI is hosted. This is the page where
				// users request and complete account recovery. Check the
				// [reference
				// implementation](https://github.com/ory/kratos-selfservice-ui-node).
				ui_url?: string | *"https://www.ory.sh/kratos/docs/fallback/recovery"
				after?:  #selfServiceAfterRecovery

				// Self-Service Recovery Request Lifespan
				//
				// Sets how long the recovery request is valid. If expired, the
				// user has to redo the flow.
				lifespan?: =~"^([0-9]+(ns|us|ms|s|m|h))+$" | *"1h"
			}
			error?: {
				// Ory Kratos Error UI URL
				//
				// URL where the Ory Kratos Error UI is hosted. Check the
				// [reference
				// implementation](https://github.com/ory/kratos-selfservice-ui-node).
				ui_url?: string | *"https://www.ory.sh/kratos/docs/fallback/error"
			}
		}
		methods?: {
			profile?: {
				// Enables Profile Management Method
				enabled?: bool | *true
			}
			link?: {
				// Enables Link Method
				enabled?: bool | *true

				// Link Configuration
				//
				// Additional configuration for the link strategy.
				config?: {
					// Override the base URL which should be used as the base for
					// recovery and verification links.
					base_url?: string

					// How long a link is valid for
					lifespan?: =~"^([0-9]+(ns|us|ms|s|m|h))+$" | *"1h"
					...
				}
			}
			password?: {
				// Enables Username/Email and Password Method
				enabled?: bool | *true

				// Password Configuration
				//
				// Define how passwords are validated.
				config?: {
					// Custom haveibeenpwned host
					//
					// Allows changing the default HIBP host to a self hosted version.
					haveibeenpwned_host?: string | *"api.pwnedpasswords.com"

					// Enable the HaveIBeenPwned API
					//
					// If set to false the password validation does not utilize the
					// Have I Been Pwnd API.
					haveibeenpwned_enabled?: bool | *true

					// Allow Password Breaches
					//
					// Defines how often a password may have been breached before it
					// is rejected.
					max_breaches?: int & >=0 & <=100 | *0

					// Ignore Lookup Network Errors
					//
					// If set to false the password validation fails when the network
					// or the Have I Been Pwnd API is down.
					ignore_network_errors?: bool | *true

					// Minimum Password Length
					//
					// Defines the minimum length of the password.
					min_password_length?: int & >=6 | *8

					// Enable password-identifier similarity check
					//
					// If set to false the password validation does not check for
					// similarity between the password and the user identifier.
					identifier_similarity_check_enabled?: bool | *true
				}
			}
			totp?: {
				// Enables the TOTP method
				enabled?: bool | *false

				// TOTP Configuration
				config?: {
					// TOTP Issuer
					//
					// The issuer (e.g. a domain name) will be shown in the TOTP app
					// (e.g. Google Authenticator). It helps the user differentiate
					// between different codes.
					issuer?: string
				}
			}
			lookup_secret?: {
				// Enables the lookup secret method
				enabled?: bool | *false
			}
			webauthn?: {
				// Enables the WebAuthn method
				enabled?: bool | *false

				// WebAuthn Configuration
				config?: {
					// Use For Passwordless Flows
					//
					// If enabled will have the effect that WebAuthn is used for
					// passwordless flows (as a first factor) and not for
					// multi-factor set ups. With this set to true, users will see an
					// option to sign up with WebAuthn on the registration screen.
					passwordless?: bool

					// Relying Party (RP) Config
					rp?: {
						// Relying Party Display Name
						//
						// An name to help the user identify this RP.
						display_name: string

						// Relying Party Identifier
						//
						// The id must be a subset of the domain currently in the browser.
						id: string

						// Relying Party Origin
						//
						// An explicit RP origin. If left empty, this defaults to `id`.
						origin?: string

						// Relying Party Icon
						//
						// An icon to help the user identify this RP.
						icon?: string
						...
					}
				}
			}

			// Specify OpenID Connect and OAuth2 Configuration
			oidc?: {
				// Enables OpenID Connect Method
				enabled?: bool | *false
				config?: {
					// Base URL for OAuth2 Redirect URIs
					//
					// Can be used to modify the base URL for OAuth2 Redirect URLs. If
					// unset, the Public Base URL will be used.
					base_redirect_uri?: string

					// OpenID Connect and OAuth2 Providers
					//
					// A list and configuration of OAuth2 and OpenID Connect providers
					// Ory Kratos should integrate with.
					providers?: [...#selfServiceOIDCProvider]
				}
			}
		}
	}

	// Data Source Name
	//
	// DSN is used to specify the database credentials as a connection
	// URI.
	dsn?: string

	// Courier configuration
	//
	// The courier is responsible for sending and delivering messages
	// over email, sms, and other means.
	courier?: {
		templates?: {
			recovery?:     #courierTemplates
			verification?: #courierTemplates
		}

		// Override message templates
		//
		// You can override certain or all message templates by pointing
		// this key to the path where the templates are located.
		template_override_path?: string

		// Defines a Time-To-Live for courier messages that could not be
		// delivered. After the defined TTL has expired for a message
		// that message is abandoned.
		message_ttl?: =~"^([0-9]+(ns|us|ms|s|m|h))+$" | *"1h"

		// SMTP Configuration
		//
		// Configures outgoing emails using the SMTP protocol.
		smtp: {
			// SMTP connection string
			//
			// This URI will be used to connect to the SMTP server. Use the
			// scheme smtps for implicit TLS sessions or smtp for explicit
			// StartTLS/cleartext sessions. Please note that TLS is always
			// enforced with certificate trust verification by default for
			// security reasons on both schemes. With the smtp scheme you can
			// use the query parameter (`?disable_starttls=true`) to allow
			// cleartext sessions or (`?disable_starttls=false`) to enforce
			// StartTLS (default behaviour). Additionally, use the query
			// parameter to allow (`?skip_ssl_verify=true`) or disallow
			// (`?skip_ssl_verify=false`) self-signed TLS certificates
			// (default behaviour) on both implicit and explicit TLS
			// sessions.
			connection_uri: =~"^smtps?:\\/\\/.*"

			// SMTP Client certificate path
			//
			// Path of the client X.509 certificate, in case of certificate
			// based client authentication to the SMTP server.
			client_cert_path?: string | *""

			// SMTP Client private key path
			//
			// Path of the client certificate private key, in case of
			// certificate based client authentication to the SMTP server
			client_key_path?: string | *""

			// SMTP Sender Address
			//
			// The recipient of an email will see this as the sender address.
			from_address?: string | *"no-reply@ory.kratos.sh"

			// SMTP Sender Name
			//
			// The recipient of an email will see this as the sender name.
			from_name?: string

			// SMTP Headers
			//
			// These headers will be passed in the SMTP conversation -- e.g.
			// when using the AWS SES SMTP interface for cross-account
			// sending.
			headers?: {
				...
			}

			// SMTP HELO/EHLO name
			//
			// Identifier used in the SMTP HELO/EHLO command. Some SMTP relays
			// require a unique identifier.
			local_name?: string | *"localhost"
		}

		// SMS sender configuration
		//
		// Configures outgoing sms messages using HTTP protocol with
		// generic SMS provider
		sms?: {
			// Determines if SMS functionality is enabled
			enabled?: bool | *false

			// SMS Sender Address
			//
			// The recipient of a sms will see this as the sender address.
			from?: string | *"Ory Kratos"
			request_config?: {
				// HTTP address of API endpoint
				//
				// This URL will be used to connect to the SMS provider.
				url: =~"^https?:\\/\\/.*"

				// The HTTP method to use (GET, POST, etc).
				method: string

				// The HTTP headers that must be applied to request
				header?: {
					[string]: string
				}

				// URI pointing to the jsonnet template used for payload
				// generation. Only used for those HTTP methods, which support
				// HTTP body payloads
				body?: =~"^(http|https|file|base64)://"

				// Auth mechanisms
				//
				// Define which auth mechanism to use for auth with the SMS
				// provider
				auth?: #webHookAuthApiKeyProperties | #webHookAuthBasicAuthProperties
			}
		}
	}
	serve?: {
		admin?: {
			request_log?: {
				// Disable health endpoints request logging
				//
				// Disable request logging for /health/alive and /health/ready
				// endpoints
				disable_for_health?: bool | *false
			}

			// Admin Base URL
			//
			// The URL where the admin endpoint is exposed at.
			base_url?: string

			// Admin Host
			//
			// The host (interface) kratos' admin endpoint listens on.
			host?: string | *"0.0.0.0"

			// Admin Port
			//
			// The port kratos' admin endpoint listens on.
			port?:   int & >=1 & <=65535 | *4434
			socket?: #socket
			tls?:    #tlsx
		}
		public?: {
			request_log?: {
				// Disable health endpoints request logging
				//
				// Disable request logging for /health/alive and /health/ready
				// endpoints
				disable_for_health?: bool | *false
			}

			// Configures Cross Origin Resource Sharing for public endpoints.
			cors?: {
				// Sets whether CORS is enabled.
				enabled?: bool | *false

				// A list of origins a cross-domain request can be executed from.
				// If the special * value is present in the list, all origins
				// will be allowed. An origin may contain a wildcard (*) to
				// replace 0 or more characters (i.e.: http://*.domain.com). Only
				// one wildcard can be used per origin.
				allowed_origins?: list.UniqueItems() & [...(string | "*") & strings.MinRunes(1)] | *["*"]

				// A list of HTTP methods the user agent is allowed to use with
				// cross-domain requests.
				allowed_methods?: [..."POST" | "GET" | "PUT" | "PATCH" | "DELETE" | "CONNECT" | "HEAD" | "OPTIONS" | "TRACE"] | *["POST", "GET", "PUT", "PATCH", "DELETE"]

				// A list of non simple headers the client is allowed to use with
				// cross-domain requests.
				allowed_headers?: [...string] | *["Authorization", "Content-Type", "X-Session-Token"]

				// Sets which headers are safe to expose to the API of a CORS API
				// specification.
				exposed_headers?: [...string] | *["Content-Type"]

				// Sets whether the request can include user credentials like
				// cookies, HTTP authentication or client side SSL certificates.
				allow_credentials?: bool | *true

				// TODO
				options_passthrough?: bool | *false

				// Sets how long (in seconds) the results of a preflight request
				// can be cached. If set to 0, every request is preceded by a
				// preflight request.
				max_age?: int & >=0 | *0

				// Adds additional log output to debug server side CORS issues.
				debug?: bool | *false
			}
			base_url?: #baseUrl

			// Public Host
			//
			// The host (interface) kratos' public endpoint listens on.
			host?: string | *"0.0.0.0"

			// Public Port
			//
			// The port kratos' public endpoint listens on.
			port?:   int & >=1 & <=65535 | *4433
			socket?: #socket
			tls?:    #tlsx
		}
	}
	tracing?: #OtelxTracingConfig

	// Log
	//
	// Configure logging using the following options. Logging will
	// always be sent to stdout and stderr.
	log?: {
		// Debug enables stack traces on errors. Can also be set using
		// environment variable LOG_LEVEL.
		level?: "trace" | "debug" | "info" | "warning" | "error" | "fatal" | "panic" | *"info"

		// Leak Sensitive Log Values
		//
		// If set will leak sensitive values (e.g. emails) in the logs.
		leak_sensitive_values?: bool

		// Sensitive log value redaction text
		//
		// Text to use, when redacting sensitive log value.
		redaction_text?: string

		// The log format can either be text or JSON.
		format?: "json" | "text"
	}
	identity: {
		// The default Identity Schema
		//
		// This Identity Schema will be used as the default for
		// self-service flows. Its ID needs to exist in the "schemas"
		// list.
		default_schema_id?: string | *"default"

		// All JSON Schemas for Identity Traits
		//
		// Note that identities that used the "default_schema_url" field
		// in older kratos versions will be corrupted unless you specify
		// their schema url with the id "default" in this list.
		schemas: [_, ...] & [...{
			// The schema's ID.
			id: string

			// JSON Schema URL for identity traits schema
			//
			// URL for JSON Schema which describes a identity's traits. Can be
			// a file path, a https URL, or a base64 encoded string.
			url: string
			...
		}]
	}
	secrets?: {
		// Default Encryption Signing Secrets
		//
		// The first secret in the array is used for signing and
		// encrypting things while all other keys are used to verify and
		// decrypt older things that were signed with that old secret.
		default?: list.UniqueItems() & [...strings.MinRunes(16)]

		// Signing Keys for Cookies
		//
		// The first secret in the array is used for encrypting cookies
		// while all other keys are used to decrypt older cookies that
		// were signed with that old secret.
		cookie?: list.UniqueItems() & [...strings.MinRunes(16)]

		// Secrets to use for encryption by cipher
		//
		// The first secret in the array is used for encryption data while
		// all other keys are used to decrypt older data that were signed
		// with.
		cipher?: [...strings.MinRunes(32) & strings.MaxRunes(32)] & [_, ...]
	}

	// Hashing Algorithm Configuration
	hashers?: {
		// Password hashing algorithm
		//
		// One of the values: argon2, bcrypt.
		// Any other hashes will be migrated to the set algorithm once an
		// identity authenticates using their password.
		algorithm?: "argon2" | "bcrypt" | *"bcrypt"

		// Configuration for the Argon2id hasher.
		argon2?: {
			memory?:     =~"^[0-9]+(B|KB|MB|GB|TB|PB|EB)" | *"128MB"
			iterations?: int & >=1 | *1

			// Number of parallel workers, defaults to 2*runtime.NumCPU().
			parallelism?: int & >=1
			salt_length?: int & >=16 | *16
			key_length?:  int & >=16 | *32

			// The time a hashing operation (~login latency) should take.
			expected_duration?: =~"^([0-9]+(ns|us|ms|s|m|h))+$" | *"500ms"

			// The standard deviation expected for hashing operations. If this
			// value is exceeded you will be warned in the logs to adjust the
			// parameters.
			expected_deviation?: =~"^([0-9]+(ns|us|ms|s|m|h))+$" | *"500ms"

			// The memory dedicated for Kratos. As password hashing is very
			// resource intense, Kratos will monitor the memory consumption
			// and warn about high values.
			dedicated_memory?: =~"^[0-9]+(B|KB|MB|GB|TB|PB|EB)" | *"1GB"
		}

		// Configuration for the Bcrypt hasher. Minimum is 4 when --dev
		// flag is used and 12 otherwise.
		bcrypt?: {
			cost: int & >=4 & <=31 | *12
		}
	}

	// Cipher Algorithm Configuration
	ciphers?: {
		// ciphering algorithm
		//
		// One of the values: noop, aes, xchacha20-poly1305
		algorithm?: "noop" | "aes" | "xchacha20-poly1305" | *"noop"
		...
	}

	// HTTP Cookie Configuration
	//
	// Configure the HTTP Cookies. Applies to both CSRF and session
	// cookies.
	cookies?: {
		// HTTP Cookie Domain
		//
		// Sets the cookie domain for session and CSRF cookies. Useful
		// when dealing with subdomains. Use with care!
		domain?: string

		// HTTP Cookie Path
		//
		// Sets the session and CSRF cookie path. Use with care!
		path?: string | *"/"

		// HTTP Cookie Same Site Configuration
		//
		// Sets the session and CSRF cookie SameSite.
		same_site?: "Strict" | "Lax" | "None" | *"Lax"
	}
	session?: {
		// WhoAmI / ToSession Settings
		//
		// Control how the `/sessions/whoami` endpoint is behaving.
		whoami?: {
			required_aal?: #featureRequiredAal
		}

		// Session Lifespan
		//
		// Defines how long a session is active. Once that lifespan has
		// been reached, the user needs to sign in again.
		lifespan?: =~"^([0-9]+(ns|us|ms|s|m|h))+$" | *"24h"
		cookie?: {
			// Session Cookie Domain
			//
			// Sets the session cookie domain. Useful when dealing with
			// subdomains. Use with care! Overrides `cookies.domain`.
			domain?: string

			// Session Cookie Name
			//
			// Sets the session cookie name. Use with care!
			name?: string | *"ory_kratos_session"

			// Make Session Cookie Persistent
			//
			// If set to true will persist the cookie in the end-user's
			// browser using the `max-age` parameter which is set to the
			// `session.lifespan` value. Persistent cookies are not deleted
			// when the browser is closed (e.g. on reboot or alt+f4).
			persistent?: bool | *true

			// Session Cookie Path
			//
			// Sets the session cookie path. Use with care! Overrides
			// `cookies.path`.
			path?: string

			// Session Cookie SameSite Configuration
			//
			// Sets the session cookie SameSite. Overrides
			// `cookies.same_site`.
			same_site?: "Strict" | "Lax" | "None"
		}

		// Earliest Possible Session Extension
		//
		// Sets when a session can be extended. Settings this value to
		// `24h` will prevent the session from being extended before
		// until 24 hours before it expires. This setting prevents
		// excessive writes to the database. We highly recommend setting
		// this value.
		earliest_possible_extend?: =~"^([0-9]+(ns|us|ms|s|m|h))+$" | *"24h"
	}

	// The kratos version this config is written for.
	//
	// SemVer according to https://semver.org/ prefixed with `v` as in
	// our releases.
	version?: =~"^(v(0|[1-9]\\d*)\\.(0|[1-9]\\d*)\\.(0|[1-9]\\d*)(?:-((?:0|[1-9]\\d*|\\d*[a-zA-Z-][0-9a-zA-Z-]*)(?:\\.(?:0|[1-9]\\d*|\\d*[a-zA-Z-][0-9a-zA-Z-]*))*))?(?:\\+([0-9a-zA-Z-]+(?:\\.[0-9a-zA-Z-]+)*))?)|$"
	dev?:     bool
	help?:    bool

	// This is a CLI flag and environment variable and can not be set
	// using the config file.
	"sqa-opt-out"?: bool | *false

	// This is a CLI flag and environment variable and can not be set
	// using the config file.
	"watch-courier"?: bool | *false

	// Metrics port
	//
	// The port the courier's metrics endpoint listens on (0/disabled
	// by default). This is a CLI flag and environment variable and
	// can not be set using the config file.
	"expose-metrics-port"?: int & >=0 & <=65535 | *0

	// This is a CLI flag and environment variable and can not be set
	// using the config file.
	config?: [...string]

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
			...
		}
		...
	}

	#baseUrl: string

	#socket: {
		// Owner of unix socket. If empty, the owner will be the user
		// running Kratos.
		owner?: string | *""

		// Group of unix socket. If empty, the group will be the primary
		// group of the user running Kratos.
		group?: string | *""

		// Mode of unix socket in numeric form
		mode?: int & >=0 & <=511 | *493
	}

	#defaultReturnTo: string

	#selfServiceSessionRevokerHook: hook: "revoke_active_sessions"

	#selfServiceSessionIssuerHook: hook: "session"

	#selfServiceRequireVerifiedAddressHook: hook: "require_verified_address"

	#webHookAuthBasicAuthProperties: null | bool | number | string | [...] | {
		type: "basic_auth"
		config: {
			// user name for basic auth
			user: string

			// password for basic auth
			password: string
		}
	}

	#webHookAuthApiKeyProperties: null | bool | number | string | [...] | {
		type: "api_key"
		config: {
			// The name of the api key
			name: string

			// The value of the api key
			value: string

			// How the api key should be transferred
			in: "header" | "cookie"
		}
	}

	#selfServiceWebHook: {
		hook: "web_hook"

		// Web-Hook Configuration
		//
		// Define what the hook should do
		config: {
			// Response Handling
			//
			// How the web hook should handle the response
			response?: {
				// Ignore the response from the web hook. If enabled the request
				// will be made asynchronously which can be useful if you only
				// wish to notify another system but do not parse the response.
				ignore?: bool | *false
			}

			// The URL the Web-Hook should call
			url: string

			// The HTTP method to use (GET, POST, etc).
			method: string
			body?:  =~"^(http|https|file|base64)://" | string

			// Auth mechanisms
			//
			// Define which auth mechanism the Web-Hook should use
			auth?: #webHookAuthApiKeyProperties | #webHookAuthBasicAuthProperties
		}
	}

	#OIDCClaims: {
		{[=~"^userinfo$|^id_token$" & !~"^()$"]: {
			{[=~".*" & !~"^()$"]: null | {
						// Indicates whether the Claim being requested is an Essential
						// Claim.
						essential?: bool

				// Requests that the Claim be returned with a particular value.
				value?: _

				// Requests that the Claim be returned with one of a set of
				// values, with the values appearing in order of preference.
				values?: [...]
			}}
		}}
		...
	}

	#selfServiceOIDCProvider: {
		id: string

		// Provider
		//
		// Can be one of github, github-app, gitlab, generic, google,
		// microsoft, discord, slack, facebook, auth0, vk, yandex,
		// spotify.
		provider: "github" | "github-app" | "gitlab" | "generic" | "google" | "microsoft" | "discord" | "slack" | "facebook" | "auth0" | "vk" | "yandex" | "apple" | "spotify" | "netid"

		// Optional string which will be used when generating labels for
		// UI buttons.
		label?:         string
		client_id:      string
		client_secret?: string
		issuer_url?:    string
		auth_url?:      string
		token_url?:     string

		// Jsonnet Mapper URL
		//
		// The URL where the jsonnet source is located for mapping the
		// provider's data to Ory Kratos data.
		mapper_url: string
		scope?: [...string]

		// Azure AD Tenant
		//
		// The Azure AD Tenant to use for authentication.
		microsoft_tenant?: string

		// Microsoft subject source
		//
		// Controls which source the subject identifier is taken from by
		// microsoft provider. If set to `userinfo` (the default) then
		// the identifier is taken from the `sub` field of OIDC ID token
		// or data received from `/userinfo` standard OIDC endpoint. If
		// set to `me` then the `id` field of data structure received
		// from `https://graph.microsoft.com/v1.0/me` is taken as an
		// identifier.
		subject_source?: "userinfo" | "me" | *"userinfo"

		// Apple Developer Team ID
		//
		// Apple Developer Team ID needed for generating a JWT token for
		// client secret
		apple_team_id?: string

		// Apple Private Key Identifier
		//
		// Sign In with Apple Private Key Identifier needed for generating
		// a JWT token for client secret
		apple_private_key_id?: string

		// Apple Private Key
		//
		// Sign In with Apple Private Key needed for generating a JWT
		// token for client secret
		apple_private_key?: string
		requested_claims?:  #OIDCClaims
	}

	#selfServiceHooks: list.UniqueItems() & [...#selfServiceWebHook & _]

	#selfServiceAfterRecoveryHooks: list.UniqueItems() & [...(#selfServiceWebHook | #selfServiceSessionRevokerHook) & _]

	#selfServiceAfterSettingsMethod: {
		default_browser_return_url?: #defaultReturnTo
		hooks?:                      list.UniqueItems() & [...#selfServiceWebHook & _]
	}

	#selfServiceAfterDefaultLoginMethod: {
		default_browser_return_url?: #defaultReturnTo
		hooks?:                      list.UniqueItems() & [...(#selfServiceSessionRevokerHook | #selfServiceRequireVerifiedAddressHook | #selfServiceWebHook) & _]
	}

	#selfServiceAfterOIDCLoginMethod: {
		default_browser_return_url?: #defaultReturnTo
		hooks?:                      list.UniqueItems() & [...(#selfServiceSessionRevokerHook | #selfServiceWebHook) & _]
	}

	#selfServiceAfterRegistrationMethod: {
		default_browser_return_url?: #defaultReturnTo
		hooks?:                      list.UniqueItems() & [...(#selfServiceSessionIssuerHook | #selfServiceWebHook) & _]
	}

	#featureRequiredAal: "aal1" | "highest_available" | *"highest_available"

	#selfServiceAfterSettings: {
		default_browser_return_url?: #defaultReturnTo
		password?:                   #selfServiceAfterSettingsMethod
		profile?:                    #selfServiceAfterSettingsMethod
		hooks?:                      #selfServiceHooks
	}

	#selfServiceBeforeLogin: hooks?: #selfServiceHooks

	#selfServiceAfterLogin: {
		default_browser_return_url?: #defaultReturnTo
		password?:                   #selfServiceAfterDefaultLoginMethod
		webauthn?:                   #selfServiceAfterDefaultLoginMethod
		oidc?:                       #selfServiceAfterOIDCLoginMethod
		hooks?:                      #selfServiceHooks
	}

	#selfServiceBeforeRegistration: hooks?: #selfServiceHooks

	#selfServiceAfterRegistration: {
		default_browser_return_url?: #defaultReturnTo
		password?:                   #selfServiceAfterRegistrationMethod
		webauthn?:                   #selfServiceAfterRegistrationMethod
		oidc?:                       #selfServiceAfterRegistrationMethod
		hooks?:                      #selfServiceHooks
	}

	#selfServiceAfterVerification: {
		default_browser_return_url?: #defaultReturnTo
		hooks?:                      #selfServiceHooks
	}

	#selfServiceAfterRecovery: {
		default_browser_return_url?: #defaultReturnTo
		hooks?:                      #selfServiceAfterRecoveryHooks
	}

	#tlsxSource: {
		// Path to PEM-encoded Fle
		path?: string

		// Base64 Encoded Inline
		//
		// The base64 string of the PEM-encoded file content. Can be
		// generated using for example `base64 -i path/to/file.pem`.
		base64?: string
	}

	#tlsx: {
		// Private Key (PEM)
		key?: #tlsxSource

		// TLS Certificate (PEM)
		cert?: #tlsxSource
	}

	#courierTemplates: {
		invalid?: email: #emailCourierTemplate
		valid?: email: #emailCourierTemplate
	}

	#emailCourierTemplate: {
		body?: {
			// The fallback template for email clients that do not support
			// html.
			plaintext?: string

			// The default template used for sending out emails. The template
			// can contain HTML
			html?: string
		}
		subject?: string
	}

	#OtelxTracingConfig: {
		@jsonschema(id="ory://tracing-config")

		// Set this to the tracing backend you wish to use. Supports
		// Jaeger, Zipkin, and OTEL.
		provider?: "jaeger" | "otel" | "zipkin"

		// Specifies the service name to use on the tracer.
		service_name?: string
		providers?: {
			// Configures the jaeger tracing backend.
			jaeger?: {
				// The address of the jaeger-agent where spans should be sent to.
				local_agent_address?: (=~"^\\[(([0-9a-fA-F]{1,4}:){7}[0-9a-fA-F]{1,4}|([0-9a-fA-F]{1,4}:){1,7}:|([0-9a-fA-F]{1,4}:){1,6}:[0-9a-fA-F]{1,4}|([0-9a-fA-F]{1,4}:){1,5}(:[0-9a-fA-F]{1,4}){1,2}|([0-9a-fA-F]{1,4}:){1,4}(:[0-9a-fA-F]{1,4}){1,3}|([0-9a-fA-F]{1,4}:){1,3}(:[0-9a-fA-F]{1,4}){1,4}|([0-9a-fA-F]{1,4}:){1,2}(:[0-9a-fA-F]{1,4}){1,5}|[0-9a-fA-F]{1,4}:((:[0-9a-fA-F]{1,4}){1,6})|:((:[0-9a-fA-F]{1,4}){1,7}|:)|fe80:(:[0-9a-fA-F]{0,4}){0,4}%[0-9a-zA-Z]{1,}|::(ffff(:0{1,4}){0,1}:){0,1}((25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])\\.){3,3}(25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])|([0-9a-fA-F]{1,4}:){1,4}:((25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])\\.){3,3}(25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9]))]:([0-9]*)$" | =~"^([0-9]{1,3}\\.){3}[0-9]{1,3}:([0-9]*)$" | =~"^(([a-zA-Z0-9]|[a-zA-Z0-9][a-zA-Z0-9\\-]*[a-zA-Z0-9])\\.)*([A-Za-z0-9]|[A-Za-z0-9][A-Za-z0-9\\-]*[A-Za-z0-9]):([0-9]*)$") & string
				sampling?:            {
					["server_url"]: _
				} & {
					// The address of jaeger-agent's HTTP sampling server
					server_url?: string
				}
			}

			// Configures the zipkin tracing backend.
			zipkin?: {
				// The address of the Zipkin server where spans should be sent to.
				server_url?: string
				sampling?:   {
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
			}
		}
	}
}
