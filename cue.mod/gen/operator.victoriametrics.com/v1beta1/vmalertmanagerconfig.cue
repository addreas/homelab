package v1beta1

import (
	"strings"
	"time"
)

#VMAlertmanagerConfig: {
	_embeddedResource

	// APIVersion defines the versioned schema of this representation of an object.
	// Servers should convert recognized schemas to the latest internal value, and
	// may reject unrecognized values.
	// More info:
	// https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
	apiVersion?: string

	// Kind is a string value representing the REST resource this object represents.
	// Servers may infer this from the endpoint the client submits requests to.
	// Cannot be updated.
	// In CamelCase.
	// More info:
	// https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
	kind?: string
	metadata?: {}

	// VMAlertmanagerConfigSpec defines configuration for VMAlertmanagerConfig
	// it must reference only locally defined objects
	spec?: {
		// InhibitRules will only apply for alerts matching
		// the resource's namespace.
		inhibit_rules?: [...{
			// Labels that must have an equal value in the source and target alert for
			// the inhibition to take effect.
			equal?: [...string]

			// SourceMatchers defines a list of matchers for which one or more alerts have
			// to exist for the inhibition to take effect.
			source_matchers?: [...string]

			// TargetMatchers defines a list of matchers that have to be fulfilled by the target
			// alerts to be muted.
			target_matchers?: [...string]
		}]

		// Receivers defines alert receivers
		receivers?: [...{
			discord_configs?: [...{
				// AvatarURL defines message avatar URL
				// Available from alertmanager v0.28.0
				avatar_url?: string

				// Content defines message content template
				// Available from alertmanager v0.28.0
				content?: strings.MaxRunes(
						2000)

				// HTTP client configuration.
				http_config?: {
					// Authorization header configuration for the client.
					// This is mutually exclusive with BasicAuth and is only available starting from
					// Alertmanager v0.22+.
					authorization?: {
						// Reference to the secret with value for authorization
						credentials?: {
							// The key of the secret to select from. Must be a valid secret key.
							key!: string

							// Name of the referent.
							// This field is effectively required, but due to backwards compatibility is
							// allowed to be empty. Instances of this type with an empty value here are
							// almost certainly wrong.
							// More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
							name?: string

							// Specify whether the Secret or its key must be defined
							optional?: bool
						}

						// File with value for authorization
						credentialsFile?: string

						// Type of authorization, default to bearer
						type?: string
					}

					// BasicAuth for the client.
					basic_auth?: {
						// Password defines reference for secret with password value
						// The secret needs to be in the same namespace as scrape object
						password?: {
							// The key of the secret to select from. Must be a valid secret key.
							key!: string

							// Name of the referent.
							// This field is effectively required, but due to backwards compatibility is
							// allowed to be empty. Instances of this type with an empty value here are
							// almost certainly wrong.
							// More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
							name?: string

							// Specify whether the Secret or its key must be defined
							optional?: bool
						}

						// PasswordFile defines path to password file at disk
						// must be pre-mounted
						password_file?: string

						// Username defines reference for secret with username value
						// The secret needs to be in the same namespace as scrape object
						username?: {
							// The key of the secret to select from. Must be a valid secret key.
							key!: string

							// Name of the referent.
							// This field is effectively required, but due to backwards compatibility is
							// allowed to be empty. Instances of this type with an empty value here are
							// almost certainly wrong.
							// More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
							name?: string

							// Specify whether the Secret or its key must be defined
							optional?: bool
						}
					}

					// BearerTokenFile defines filename for bearer token, it must be mounted to pod.
					bearer_token_file?: string

					// The secret's key that contains the bearer token
					// It must be at them same namespace as CRD
					bearer_token_secret?: {
						// The key of the secret to select from. Must be a valid secret key.
						key!: string

						// Name of the referent.
						// This field is effectively required, but due to backwards compatibility is
						// allowed to be empty. Instances of this type with an empty value here are
						// almost certainly wrong.
						// More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
						name?: string

						// Specify whether the Secret or its key must be defined
						optional?: bool
					}

					// FollowRedirects controls redirects for scraping.
					follow_redirects?: bool

					// HTTPHeaders defines custom HTTP headers to be sent along with each request.
					// Only supported starting from Alertmanager v0.28.0; ignored by older versions.
					http_headers?: [string]: {
						// Files are paths on the vmalertmanager container's filesystem to read header values from.
						files?: [...string]

						// Secrets are header values read from Kubernetes Secrets.
						secrets?: [...{
							// The key of the secret to select from. Must be a valid secret key.
							key!: string

							// Name of the referent.
							// This field is effectively required, but due to backwards compatibility is
							// allowed to be empty. Instances of this type with an empty value here are
							// almost certainly wrong.
							// More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
							name?: string

							// Specify whether the Secret or its key must be defined
							optional?: bool
						}]

						// Values are literal header values to send as-is.
						values?: [...string]
					}

					// NoProxy defines a comma-separated string that can contain IPs, CIDR notation,
					// domain names that should be excluded from proxying.
					// IP and domain names can contain port numbers.
					noProxy?: string

					// OAuth2 client credentials used to fetch a token for the targets.
					oauth2?: {
						// The secret or configmap containing the OAuth2 client id
						client_id!: {
							// ConfigMap containing data to use for the targets.
							configMap?: {
								// The key to select from the ConfigMap's Data field.
								// Keys in the BinaryData field are not currently propagated to container env vars.
								key!: string

								// Name of the referent.
								// This field is effectively required, but due to backwards compatibility is
								// allowed to be empty. Instances of this type with an empty value here are
								// almost certainly wrong.
								// More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
								name?: string

								// Specify whether the ConfigMap or its key must be defined
								optional?: bool
							}

							// Secret containing data to use for the targets.
							secret?: {
								// The key of the secret to select from. Must be a valid secret key.
								key!: string

								// Name of the referent.
								// This field is effectively required, but due to backwards compatibility is
								// allowed to be empty. Instances of this type with an empty value here are
								// almost certainly wrong.
								// More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
								name?: string

								// Specify whether the Secret or its key must be defined
								optional?: bool
							}
						}

						// The secret containing the OAuth2 client secret
						client_secret?: {
							// The key of the secret to select from. Must be a valid secret key.
							key!: string

							// Name of the referent.
							// This field is effectively required, but due to backwards compatibility is
							// allowed to be empty. Instances of this type with an empty value here are
							// almost certainly wrong.
							// More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
							name?: string

							// Specify whether the Secret or its key must be defined
							optional?: bool
						}

						// ClientSecretFile defines path for client secret file.
						client_secret_file?: string

						// Parameters to append to the token URL
						endpoint_params?: [string]: string

						// The proxy URL for token_url connection
						// Is only supported by Scrape objects family
						proxy_url?: string

						// OAuth2 scopes used for the token request
						scopes?: [...string]

						// TLSConfig for token_url connection
						// Is only supported by Scrape objects family
						tls_config?: null | bool | number | string | [...] | {
							...
						}

						// The URL to fetch the token from
						token_url!: strings.MinRunes(
								1)
					}

					// ProxyConnectHeader optionally specifies headers to send to proxies during CONNECT requests.
					proxyConnectHeader?: [string]: [...{
						// The key of the secret to select from. Must be a valid secret key.
						key!: string

						// Name of the referent.
						// This field is effectively required, but due to backwards compatibility is
						// allowed to be empty. Instances of this type with an empty value here are
						// almost certainly wrong.
						// More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
						name?: string

						// Specify whether the Secret or its key must be defined
						optional?: bool
					}]

					// ProxyFromEnvironment defines whether to use the proxy configuration defined
					// by environment variables (HTTP_PROXY, HTTPS_PROXY, and NO_PROXY).
					proxyFromEnvironment?: bool

					// ProxyUrl defines the HTTP proxy server to use.
					proxyURL?: =~"^(http|https|socks5)://.+$"

					// TLS configuration for the client.
					tls_config?: {
						// Struct containing the CA cert to use for the targets.
						ca?: {
							// ConfigMap containing data to use for the targets.
							configMap?: {
								// The key to select from the ConfigMap's Data field.
								// Keys in the BinaryData field are not currently propagated to container env vars.
								key!: string

								// Name of the referent.
								// This field is effectively required, but due to backwards compatibility is
								// allowed to be empty. Instances of this type with an empty value here are
								// almost certainly wrong.
								// More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
								name?: string

								// Specify whether the ConfigMap or its key must be defined
								optional?: bool
							}

							// Secret containing data to use for the targets.
							secret?: {
								// The key of the secret to select from. Must be a valid secret key.
								key!: string

								// Name of the referent.
								// This field is effectively required, but due to backwards compatibility is
								// allowed to be empty. Instances of this type with an empty value here are
								// almost certainly wrong.
								// More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
								name?: string

								// Specify whether the Secret or its key must be defined
								optional?: bool
							}
						}

						// Path to the CA cert in the container to use for the targets.
						caFile?: string

						// Struct containing the client cert file for the targets.
						cert?: {
							// ConfigMap containing data to use for the targets.
							configMap?: {
								// The key to select from the ConfigMap's Data field.
								// Keys in the BinaryData field are not currently propagated to container env vars.
								key!: string

								// Name of the referent.
								// This field is effectively required, but due to backwards compatibility is
								// allowed to be empty. Instances of this type with an empty value here are
								// almost certainly wrong.
								// More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
								name?: string

								// Specify whether the ConfigMap or its key must be defined
								optional?: bool
							}

							// Secret containing data to use for the targets.
							secret?: {
								// The key of the secret to select from. Must be a valid secret key.
								key!: string

								// Name of the referent.
								// This field is effectively required, but due to backwards compatibility is
								// allowed to be empty. Instances of this type with an empty value here are
								// almost certainly wrong.
								// More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
								name?: string

								// Specify whether the Secret or its key must be defined
								optional?: bool
							}
						}

						// Path to the client cert file in the container for the targets.
						certFile?: string

						// Disable target certificate validation.
						insecureSkipVerify?: bool

						// Path to the client key file in the container for the targets.
						keyFile?: string

						// Secret containing the client key file for the targets.
						keySecret?: {
							// The key of the secret to select from. Must be a valid secret key.
							key!: string

							// Name of the referent.
							// This field is effectively required, but due to backwards compatibility is
							// allowed to be empty. Instances of this type with an empty value here are
							// almost certainly wrong.
							// More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
							name?: string

							// Specify whether the Secret or its key must be defined
							optional?: bool
						}

						// Used to verify the hostname for the targets.
						serverName?: string
					}
				}

				// The message body template
				message?: string

				// SendResolved controls notify about resolved alerts.
				send_resolved?: bool

				// The message title template
				title?: string

				// Username defines message username
				// Available from alertmanager v0.28.0
				username?: string

				// The discord webhook URL
				// one of `urlSecret` and `url` must be defined.
				webhook_url?: string

				// URLSecret defines secret name and key at the CRD namespace.
				// It must contain the webhook URL.
				// one of `urlSecret` and `url` must be defined.
				webhook_url_secret?: {
					// The key of the secret to select from. Must be a valid secret key.
					key!: string

					// Name of the referent.
					// This field is effectively required, but due to backwards compatibility is
					// allowed to be empty. Instances of this type with an empty value here are
					// almost certainly wrong.
					// More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
					name?: string

					// Specify whether the Secret or its key must be defined
					optional?: bool
				}
			}]

			// EmailConfigs defines email notification configurations.
			email_configs?: [...{
				// The identity to use for authentication.
				auth_identity?: string

				// AuthPassword defines secret name and key at CRD namespace.
				auth_password?: {
					// The key of the secret to select from. Must be a valid secret key.
					key!: string

					// Name of the referent.
					// This field is effectively required, but due to backwards compatibility is
					// allowed to be empty. Instances of this type with an empty value here are
					// almost certainly wrong.
					// More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
					name?: string

					// Specify whether the Secret or its key must be defined
					optional?: bool
				}

				// AuthSecret defines secret name and key at CRD namespace.
				// It must contain the CRAM-MD5 secret.
				auth_secret?: {
					// The key of the secret to select from. Must be a valid secret key.
					key!: string

					// Name of the referent.
					// This field is effectively required, but due to backwards compatibility is
					// allowed to be empty. Instances of this type with an empty value here are
					// almost certainly wrong.
					// More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
					name?: string

					// Specify whether the Secret or its key must be defined
					optional?: bool
				}

				// The username to use for authentication.
				auth_username?: string

				// The sender address.
				// fallback to global setting if empty
				from?: string

				// Further headers email header key/value pairs. Overrides any headers
				// previously set by the notification implementation.
				headers?: [string]: string

				// The hostname to identify to the SMTP server.
				hello?: string

				// The HTML body of the email notification.
				html?: string

				// The SMTP TLS requirement.
				// Note that Go does not support unencrypted connections to remote SMTP endpoints.
				require_tls?: bool

				// SendResolved controls notify about resolved alerts.
				send_resolved?: bool

				// The SMTP host through which emails are sent.
				// fallback to global setting if empty
				smarthost?: string

				// The text body of the email notification.
				text?: string

				// TLS configuration
				tls_config?: {
					// Struct containing the CA cert to use for the targets.
					ca?: {
						// ConfigMap containing data to use for the targets.
						configMap?: {
							// The key to select from the ConfigMap's Data field.
							// Keys in the BinaryData field are not currently propagated to container env vars.
							key!: string

							// Name of the referent.
							// This field is effectively required, but due to backwards compatibility is
							// allowed to be empty. Instances of this type with an empty value here are
							// almost certainly wrong.
							// More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
							name?: string

							// Specify whether the ConfigMap or its key must be defined
							optional?: bool
						}

						// Secret containing data to use for the targets.
						secret?: {
							// The key of the secret to select from. Must be a valid secret key.
							key!: string

							// Name of the referent.
							// This field is effectively required, but due to backwards compatibility is
							// allowed to be empty. Instances of this type with an empty value here are
							// almost certainly wrong.
							// More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
							name?: string

							// Specify whether the Secret or its key must be defined
							optional?: bool
						}
					}

					// Path to the CA cert in the container to use for the targets.
					caFile?: string

					// Struct containing the client cert file for the targets.
					cert?: {
						// ConfigMap containing data to use for the targets.
						configMap?: {
							// The key to select from the ConfigMap's Data field.
							// Keys in the BinaryData field are not currently propagated to container env vars.
							key!: string

							// Name of the referent.
							// This field is effectively required, but due to backwards compatibility is
							// allowed to be empty. Instances of this type with an empty value here are
							// almost certainly wrong.
							// More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
							name?: string

							// Specify whether the ConfigMap or its key must be defined
							optional?: bool
						}

						// Secret containing data to use for the targets.
						secret?: {
							// The key of the secret to select from. Must be a valid secret key.
							key!: string

							// Name of the referent.
							// This field is effectively required, but due to backwards compatibility is
							// allowed to be empty. Instances of this type with an empty value here are
							// almost certainly wrong.
							// More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
							name?: string

							// Specify whether the Secret or its key must be defined
							optional?: bool
						}
					}

					// Path to the client cert file in the container for the targets.
					certFile?: string

					// Disable target certificate validation.
					insecureSkipVerify?: bool

					// Path to the client key file in the container for the targets.
					keyFile?: string

					// Secret containing the client key file for the targets.
					keySecret?: {
						// The key of the secret to select from. Must be a valid secret key.
						key!: string

						// Name of the referent.
						// This field is effectively required, but due to backwards compatibility is
						// allowed to be empty. Instances of this type with an empty value here are
						// almost certainly wrong.
						// More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
						name?: string

						// Specify whether the Secret or its key must be defined
						optional?: bool
					}

					// Used to verify the hostname for the targets.
					serverName?: string
				}

				// The email address to send notifications to.
				to?: string
			}]
			incidentio_configs?: [...{
				// AlertSourceToken is used to authenticate with incident.io.
				// Mutually exclusive with AlertSourceTokenFile.
				alert_source_token?: {
					// The key of the secret to select from. Must be a valid secret key.
					key!: string

					// Name of the referent.
					// This field is effectively required, but due to backwards compatibility is
					// allowed to be empty. Instances of this type with an empty value here are
					// almost certainly wrong.
					// More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
					name?: string

					// Specify whether the Secret or its key must be defined
					optional?: bool
				}

				// AlertSourceTokenFile defines the path to a file that contains the alert source token.
				// Mutually exclusive with AlertSourceToken.
				alert_source_token_file?: string
				http_config?: null | bool | number | string | [...] | {
					...
				}

				// MaxAlerts defines maximum number of alerts to be sent per incident.io message.
				max_alerts?: int

				// SendResolved controls notify about resolved alerts.
				send_resolved?: bool

				// Timeout is the maximum time allowed to invoke incident.io
				timeout?: string

				// The URL to send the incident.io alert. This would typically be provided by the
				// incident.io team when setting up an alert source.
				// Mutually exclusive with URLFile.
				url?: string

				// URLFile defines the path to a file that holds the incident.io alert URL.
				// Mutually exclusive with URL.
				url_file?: string
			}]
			jira_configs?: [...{
				// The URL to send API requests to. The full API path must be included.
				// Example: https://company.atlassian.net/rest/api/2/
				api_url?: string

				// Other issue and custom fields.
				// Jira issue field can have multiple types.
				// Depends on the field type, the values must be provided differently.
				// See
				// https://developer.atlassian.com/server/jira/platform/jira-rest-api-examples/#setting-custom-field-data-for-other-field-types
				// for further examples.
				custom_fields?: [string]: null | bool | number | string | [...] | {
					...
				}

				// Issue description template.
				description?: string

				// The HTTP client's configuration. You must use this configuration to supply
				// the personal access token (PAT) as part of the HTTP `Authorization` header.
				// For Jira Cloud, use basic_auth with the email address as the username and the
				// PAT as the password.
				// For Jira Data Center, use the 'authorization' field with 'credentials: <PAT value>'.
				http_config?: null | bool | number | string | [...] | {
					...
				}

				// Type of the issue (e.g. Bug)
				issue_type!: string

				// Labels to be added to the issue
				labels?: [...string]

				// Priority of the issue
				priority?: string

				// The project key where issues are created
				project!: string

				// If reopen_transition is defined, reopen the issue when it is not older than
				// this value (rounded down to the nearest minute).
				// The resolutiondate field is used to determine the age of the issue.
				reopen_duration?: =~"^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$"

				// Name of the workflow transition to resolve an issue.
				// The target status must have the category "done".
				reopen_transition?: string

				// Name of the workflow transition to reopen an issue.
				// The target status should not have the category "done".
				resolve_transition?: string

				// SendResolved controls notify about resolved alerts.
				send_resolved?: bool

				// Issue summary template
				summary?: string

				// If reopen_transition is defined, ignore issues with that resolution.
				wont_fix_resolution?: string
			}]

			// MattermostConfigs defines Mattermost notification configurations.
			mattermost_configs?: [...{
				// Attachments defines richer formatting options
				attachments?: [...{
					author_icon?: string
					author_link?: string
					author_name?: string
					color?:       string
					fallback?:    string
					fields?: [...{
						short?: bool
						title?: string
						value?: string
					}]
					footer?:      string
					footer_icon?: string
					image_url?:   string
					pretext?:     string
					text?:        string
					thumb_url?:   string
					title?:       string
					title_link?:  string
				}]

				// Channel overrides the channel the message posts in.
				channel?: string
				http_config?: null | bool | number | string | [...] | {
					...
				}

				// IconEmoji overrides the profile picture and icon_url parameter.
				icon_emoji?: string

				// IconURL overrides the profile picture the message posts with.
				icon_url?: string
				priority?: {
					persistent_notifications?: bool
					priority?:                 string
					requested_ack?:            bool
				}
				props?: card?: string

				// SendResolved controls notify about resolved alerts.
				send_resolved?: bool

				// Text defines markdown-formatted message to display in the post.
				text!: string

				// URL to send requests to,
				// one of `urlSecret` and `url` must be defined.
				url?: string

				// URLSecret defines secret name and key at the CRD namespace.
				// It must contain the Mattermost URL.
				// one of `urlSecret` and `url` must be defined.
				url_secret?: {
					// The key of the secret to select from. Must be a valid secret key.
					key!: string

					// Name of the referent.
					// This field is effectively required, but due to backwards compatibility is
					// allowed to be empty. Instances of this type with an empty value here are
					// almost certainly wrong.
					// More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
					name?: string

					// Specify whether the Secret or its key must be defined
					optional?: bool
				}

				// Username overrides the username the message posts as
				username?: string
			}]
			msteams_configs?: [...{
				// HTTP client configuration.
				http_config?: {
					// Authorization header configuration for the client.
					// This is mutually exclusive with BasicAuth and is only available starting from
					// Alertmanager v0.22+.
					authorization?: {
						// Reference to the secret with value for authorization
						credentials?: {
							// The key of the secret to select from. Must be a valid secret key.
							key!: string

							// Name of the referent.
							// This field is effectively required, but due to backwards compatibility is
							// allowed to be empty. Instances of this type with an empty value here are
							// almost certainly wrong.
							// More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
							name?: string

							// Specify whether the Secret or its key must be defined
							optional?: bool
						}

						// File with value for authorization
						credentialsFile?: string

						// Type of authorization, default to bearer
						type?: string
					}

					// BasicAuth for the client.
					basic_auth?: {
						// Password defines reference for secret with password value
						// The secret needs to be in the same namespace as scrape object
						password?: {
							// The key of the secret to select from. Must be a valid secret key.
							key!: string

							// Name of the referent.
							// This field is effectively required, but due to backwards compatibility is
							// allowed to be empty. Instances of this type with an empty value here are
							// almost certainly wrong.
							// More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
							name?: string

							// Specify whether the Secret or its key must be defined
							optional?: bool
						}

						// PasswordFile defines path to password file at disk
						// must be pre-mounted
						password_file?: string

						// Username defines reference for secret with username value
						// The secret needs to be in the same namespace as scrape object
						username?: {
							// The key of the secret to select from. Must be a valid secret key.
							key!: string

							// Name of the referent.
							// This field is effectively required, but due to backwards compatibility is
							// allowed to be empty. Instances of this type with an empty value here are
							// almost certainly wrong.
							// More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
							name?: string

							// Specify whether the Secret or its key must be defined
							optional?: bool
						}
					}

					// BearerTokenFile defines filename for bearer token, it must be mounted to pod.
					bearer_token_file?: string

					// The secret's key that contains the bearer token
					// It must be at them same namespace as CRD
					bearer_token_secret?: {
						// The key of the secret to select from. Must be a valid secret key.
						key!: string

						// Name of the referent.
						// This field is effectively required, but due to backwards compatibility is
						// allowed to be empty. Instances of this type with an empty value here are
						// almost certainly wrong.
						// More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
						name?: string

						// Specify whether the Secret or its key must be defined
						optional?: bool
					}

					// FollowRedirects controls redirects for scraping.
					follow_redirects?: bool

					// HTTPHeaders defines custom HTTP headers to be sent along with each request.
					// Only supported starting from Alertmanager v0.28.0; ignored by older versions.
					http_headers?: [string]: {
						// Files are paths on the vmalertmanager container's filesystem to read header values from.
						files?: [...string]

						// Secrets are header values read from Kubernetes Secrets.
						secrets?: [...{
							// The key of the secret to select from. Must be a valid secret key.
							key!: string

							// Name of the referent.
							// This field is effectively required, but due to backwards compatibility is
							// allowed to be empty. Instances of this type with an empty value here are
							// almost certainly wrong.
							// More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
							name?: string

							// Specify whether the Secret or its key must be defined
							optional?: bool
						}]

						// Values are literal header values to send as-is.
						values?: [...string]
					}

					// NoProxy defines a comma-separated string that can contain IPs, CIDR notation,
					// domain names that should be excluded from proxying.
					// IP and domain names can contain port numbers.
					noProxy?: string

					// OAuth2 client credentials used to fetch a token for the targets.
					oauth2?: {
						// The secret or configmap containing the OAuth2 client id
						client_id!: {
							// ConfigMap containing data to use for the targets.
							configMap?: {
								// The key to select from the ConfigMap's Data field.
								// Keys in the BinaryData field are not currently propagated to container env vars.
								key!: string

								// Name of the referent.
								// This field is effectively required, but due to backwards compatibility is
								// allowed to be empty. Instances of this type with an empty value here are
								// almost certainly wrong.
								// More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
								name?: string

								// Specify whether the ConfigMap or its key must be defined
								optional?: bool
							}

							// Secret containing data to use for the targets.
							secret?: {
								// The key of the secret to select from. Must be a valid secret key.
								key!: string

								// Name of the referent.
								// This field is effectively required, but due to backwards compatibility is
								// allowed to be empty. Instances of this type with an empty value here are
								// almost certainly wrong.
								// More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
								name?: string

								// Specify whether the Secret or its key must be defined
								optional?: bool
							}
						}

						// The secret containing the OAuth2 client secret
						client_secret?: {
							// The key of the secret to select from. Must be a valid secret key.
							key!: string

							// Name of the referent.
							// This field is effectively required, but due to backwards compatibility is
							// allowed to be empty. Instances of this type with an empty value here are
							// almost certainly wrong.
							// More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
							name?: string

							// Specify whether the Secret or its key must be defined
							optional?: bool
						}

						// ClientSecretFile defines path for client secret file.
						client_secret_file?: string

						// Parameters to append to the token URL
						endpoint_params?: [string]: string

						// The proxy URL for token_url connection
						// Is only supported by Scrape objects family
						proxy_url?: string

						// OAuth2 scopes used for the token request
						scopes?: [...string]

						// TLSConfig for token_url connection
						// Is only supported by Scrape objects family
						tls_config?: null | bool | number | string | [...] | {
							...
						}

						// The URL to fetch the token from
						token_url!: strings.MinRunes(
								1)
					}

					// ProxyConnectHeader optionally specifies headers to send to proxies during CONNECT requests.
					proxyConnectHeader?: [string]: [...{
						// The key of the secret to select from. Must be a valid secret key.
						key!: string

						// Name of the referent.
						// This field is effectively required, but due to backwards compatibility is
						// allowed to be empty. Instances of this type with an empty value here are
						// almost certainly wrong.
						// More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
						name?: string

						// Specify whether the Secret or its key must be defined
						optional?: bool
					}]

					// ProxyFromEnvironment defines whether to use the proxy configuration defined
					// by environment variables (HTTP_PROXY, HTTPS_PROXY, and NO_PROXY).
					proxyFromEnvironment?: bool

					// ProxyUrl defines the HTTP proxy server to use.
					proxyURL?: =~"^(http|https|socks5)://.+$"

					// TLS configuration for the client.
					tls_config?: {
						// Struct containing the CA cert to use for the targets.
						ca?: {
							// ConfigMap containing data to use for the targets.
							configMap?: {
								// The key to select from the ConfigMap's Data field.
								// Keys in the BinaryData field are not currently propagated to container env vars.
								key!: string

								// Name of the referent.
								// This field is effectively required, but due to backwards compatibility is
								// allowed to be empty. Instances of this type with an empty value here are
								// almost certainly wrong.
								// More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
								name?: string

								// Specify whether the ConfigMap or its key must be defined
								optional?: bool
							}

							// Secret containing data to use for the targets.
							secret?: {
								// The key of the secret to select from. Must be a valid secret key.
								key!: string

								// Name of the referent.
								// This field is effectively required, but due to backwards compatibility is
								// allowed to be empty. Instances of this type with an empty value here are
								// almost certainly wrong.
								// More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
								name?: string

								// Specify whether the Secret or its key must be defined
								optional?: bool
							}
						}

						// Path to the CA cert in the container to use for the targets.
						caFile?: string

						// Struct containing the client cert file for the targets.
						cert?: {
							// ConfigMap containing data to use for the targets.
							configMap?: {
								// The key to select from the ConfigMap's Data field.
								// Keys in the BinaryData field are not currently propagated to container env vars.
								key!: string

								// Name of the referent.
								// This field is effectively required, but due to backwards compatibility is
								// allowed to be empty. Instances of this type with an empty value here are
								// almost certainly wrong.
								// More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
								name?: string

								// Specify whether the ConfigMap or its key must be defined
								optional?: bool
							}

							// Secret containing data to use for the targets.
							secret?: {
								// The key of the secret to select from. Must be a valid secret key.
								key!: string

								// Name of the referent.
								// This field is effectively required, but due to backwards compatibility is
								// allowed to be empty. Instances of this type with an empty value here are
								// almost certainly wrong.
								// More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
								name?: string

								// Specify whether the Secret or its key must be defined
								optional?: bool
							}
						}

						// Path to the client cert file in the container for the targets.
						certFile?: string

						// Disable target certificate validation.
						insecureSkipVerify?: bool

						// Path to the client key file in the container for the targets.
						keyFile?: string

						// Secret containing the client key file for the targets.
						keySecret?: {
							// The key of the secret to select from. Must be a valid secret key.
							key!: string

							// Name of the referent.
							// This field is effectively required, but due to backwards compatibility is
							// allowed to be empty. Instances of this type with an empty value here are
							// almost certainly wrong.
							// More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
							name?: string

							// Specify whether the Secret or its key must be defined
							optional?: bool
						}

						// Used to verify the hostname for the targets.
						serverName?: string
					}
				}

				// SendResolved controls notify about resolved alerts.
				send_resolved?: bool

				// The text body of the teams notification.
				text?: string

				// The title of the teams notification.
				title?: string

				// The incoming webhook URL
				// one of `urlSecret` and `url` must be defined.
				webhook_url?: string

				// URLSecret defines secret name and key at the CRD namespace.
				// It must contain the webhook URL.
				// one of `urlSecret` and `url` must be defined.
				webhook_url_secret?: {
					// The key of the secret to select from. Must be a valid secret key.
					key!: string

					// Name of the referent.
					// This field is effectively required, but due to backwards compatibility is
					// allowed to be empty. Instances of this type with an empty value here are
					// almost certainly wrong.
					// More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
					name?: string

					// Specify whether the Secret or its key must be defined
					optional?: bool
				}
			}]
			msteamsv2_configs?: [...{
				http_config?: null | bool | number | string | [...] | {
					...
				}

				// SendResolved controls notify about resolved alerts.
				send_resolved?: bool

				// Message body template.
				text?: string

				// Message title template.
				title?: string

				// The incoming webhook URL
				// one of `urlSecret` and `url` must be defined.
				webhook_url?: string

				// URLSecret defines secret name and key at the CRD namespace.
				// It must contain the webhook URL.
				// one of `webhook_url` or `webhook_url_secret` must be defined.
				webhook_url_secret?: {
					// The key of the secret to select from. Must be a valid secret key.
					key!: string

					// Name of the referent.
					// This field is effectively required, but due to backwards compatibility is
					// allowed to be empty. Instances of this type with an empty value here are
					// almost certainly wrong.
					// More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
					name?: string

					// Specify whether the Secret or its key must be defined
					optional?: bool
				}
			}]

			// Name of the receiver. Must be unique across all items from the list.
			name!: strings.MinRunes(
				1)

			// OpsGenieConfigs defines ops genie notification configurations.
			opsgenie_configs?: [...{
				// Comma separated list of actions that will be available for the alert.
				actions?: string

				// The secret's key that contains the OpsGenie API key.
				// It must be at them same namespace as CRD
				// fallback to global setting if empty
				api_key?: {
					// The key of the secret to select from. Must be a valid secret key.
					key!: string

					// Name of the referent.
					// This field is effectively required, but due to backwards compatibility is
					// allowed to be empty. Instances of this type with an empty value here are
					// almost certainly wrong.
					// More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
					name?: string

					// Specify whether the Secret or its key must be defined
					optional?: bool
				}

				// The URL to send OpsGenie API requests to.
				apiURL?: string

				// Description of the incident.
				description?: string

				// A set of arbitrary key/value pairs that provide further detail about the incident.
				details?: [string]: string

				// Optional field that can be used to specify which domain alert is related to.
				entity?: string

				// HTTP client configuration.
				http_config?: {
					...
				}

				// Alert text limited to 130 characters.
				message?: string

				// Additional alert note.
				note?: string

				// Priority level of alert. Possible values are P1, P2, P3, P4, and P5.
				priority?: string

				// List of responders responsible for notifications.
				responders?: [...{
					// ID of the responder.
					id?: string

					// Name of the responder.
					name?: string

					// Type of responder.
					type!: strings.MinRunes(
						1)

					// Username of the responder.
					username?: string
				}]

				// SendResolved controls notify about resolved alerts.
				send_resolved?: bool

				// Backlink to the sender of the notification.
				source?: string

				// Comma separated list of tags attached to the notifications.
				tags?: string

				// Whether to update message and description of the alert in OpsGenie if it already exists
				// By default, the alert is never updated in OpsGenie, the new message only appears in activity log.
				update_alerts?: bool
			}]

			// PagerDutyConfigs defines pager duty notification configurations.
			pagerduty_configs?: [...{
				// The class/type of the event.
				class?: string

				// Client identification.
				client?: string

				// Backlink to the sender of notification.
				client_url?: string

				// The part or component of the affected system that is broken.
				component?: string

				// Description of the incident.
				description?: string

				// Arbitrary key/value pairs that provide further detail about the incident.
				details?: [string]: string

				// A cluster or grouping of sources.
				group?: string

				// HTTP client configuration.
				http_config?: {
					...
				}

				// Images to attach to the incident.
				images?: [...{
					alt?:    string
					href?:   string
					source!: string
				}]

				// Links to attach to the incident.
				links?: [...{
					href!: string
					text?: string
				}]

				// The secret's key that contains the PagerDuty integration key (when using
				// Events API v2). Either this field or `serviceKey` needs to be defined.
				// It must be at them same namespace as CRD
				routing_key?: {
					// The key of the secret to select from. Must be a valid secret key.
					key!: string

					// Name of the referent.
					// This field is effectively required, but due to backwards compatibility is
					// allowed to be empty. Instances of this type with an empty value here are
					// almost certainly wrong.
					// More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
					name?: string

					// Specify whether the Secret or its key must be defined
					optional?: bool
				}

				// SendResolved controls notify about resolved alerts.
				send_resolved?: bool

				// The secret's key that contains the PagerDuty service key (when using
				// integration type "Prometheus"). Either this field or `routingKey` needs to
				// be defined.
				// It must be at them same namespace as CRD
				service_key?: {
					// The key of the secret to select from. Must be a valid secret key.
					key!: string

					// Name of the referent.
					// This field is effectively required, but due to backwards compatibility is
					// allowed to be empty. Instances of this type with an empty value here are
					// almost certainly wrong.
					// More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
					name?: string

					// Specify whether the Secret or its key must be defined
					optional?: bool
				}

				// Severity of the incident.
				severity?: string

				// The URL to send requests to.
				url?: string
			}]

			// PushoverConfigs defines push over notification configurations.
			pushover_configs?: [...{
				// How long your notification will continue to be retried for, unless the user
				// acknowledges the notification.
				expire?: string

				// Whether notification message is HTML or plain text.
				html?: bool

				// HTTP client configuration.
				http_config?: {
					...
				}

				// Notification message.
				message?: string

				// Priority, see https://pushover.net/api#priority
				priority?: string

				// How often the Pushover servers will send the same notification to the user.
				// Must be at least 30 seconds.
				retry?: string

				// SendResolved controls notify about resolved alerts.
				send_resolved?: bool

				// The name of one of the sounds supported by device clients to override the
				// user's default sound choice
				sound?: string

				// Notification title.
				title?: string

				// The secret's key that contains the registered application’s API token, see
				// https://pushover.net/apps.
				// It must be at them same namespace as CRD
				token?: {
					// The key of the secret to select from. Must be a valid secret key.
					key!: string

					// Name of the referent.
					// This field is effectively required, but due to backwards compatibility is
					// allowed to be empty. Instances of this type with an empty value here are
					// almost certainly wrong.
					// More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
					name?: string

					// Specify whether the Secret or its key must be defined
					optional?: bool
				}

				// A supplementary URL shown alongside the message.
				url?: string

				// A title for supplementary URL, otherwise just the URL is shown
				url_title?: string

				// The secret's key that contains the recipient user’s user key.
				// It must be at them same namespace as CRD
				user_key?: {
					// The key of the secret to select from. Must be a valid secret key.
					key!: string

					// Name of the referent.
					// This field is effectively required, but due to backwards compatibility is
					// allowed to be empty. Instances of this type with an empty value here are
					// almost certainly wrong.
					// More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
					name?: string

					// Specify whether the Secret or its key must be defined
					optional?: bool
				}
			}]
			rocketchat_configs?: [...{
				actions?: [...{
					msg?:  string
					text?: string
					type?: string
					url?:  string
				}]
				api_url?: string

				// RocketChat channel override, (like #other-channel or @username).
				channel?: string
				color?:   string
				emoji?:   string
				fields?: [...{
					short?: bool
					title?: string
					value?: string
				}]
				http_config?: null | bool | number | string | [...] | {
					...
				}
				icon_url?:   string
				image_url?:  string
				link_names?: bool

				// SendResolved controls notify about resolved alerts.
				send_resolved?: bool
				short_fields?:  bool
				text?:          string
				thumb_url?:     string
				title?:         string
				title_link?:    string

				// SecretKeySelector selects a key of a Secret.
				token?: {
					// The key of the secret to select from. Must be a valid secret key.
					key!: string

					// Name of the referent.
					// This field is effectively required, but due to backwards compatibility is
					// allowed to be empty. Instances of this type with an empty value here are
					// almost certainly wrong.
					// More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
					name?: string

					// Specify whether the Secret or its key must be defined
					optional?: bool
				}

				// The sender token and token_id
				// See https://docs.rocket.chat/docs/manage-personal-access-tokens
				token_id?: {
					// The key of the secret to select from. Must be a valid secret key.
					key!: string

					// Name of the referent.
					// This field is effectively required, but due to backwards compatibility is
					// allowed to be empty. Instances of this type with an empty value here are
					// almost certainly wrong.
					// More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
					name?: string

					// Specify whether the Secret or its key must be defined
					optional?: bool
				}
			}]

			// SlackConfigs defines slack notification configurations.
			slack_configs?: [...{
				// A list of Slack actions that are sent with each notification.
				actions?: [...{
					// SlackConfirmationField protect users from destructive actions or
					// particularly distinguished decisions by asking them to confirm their button
					// click one more time.
					// See https://api.slack.com/docs/interactive-message-field-guide#confirmation_fields
					// for more information.
					confirm?: {
						dismiss_text?: string
						ok_text?:      string
						text!:         strings.MinRunes(
								1)
						title?:        string
					}
					name?:  string
					style?: string
					text!:  strings.MinRunes(
						1)
					type!:  strings.MinRunes(
						1)
					url?:   string
					value?: string
				}]

				// The secret's key that contains the Slack webhook URL.
				// It must be at them same namespace as CRD
				// fallback to global setting if empty
				api_url?: {
					// The key of the secret to select from. Must be a valid secret key.
					key!: string

					// Name of the referent.
					// This field is effectively required, but due to backwards compatibility is
					// allowed to be empty. Instances of this type with an empty value here are
					// almost certainly wrong.
					// More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
					name?: string

					// Specify whether the Secret or its key must be defined
					optional?: bool
				}
				callback_id?: string

				// The channel or user to send notifications to.
				channel?:  string
				color?:    string
				fallback?: string

				// A list of Slack fields that are sent with each notification.
				fields?: [...{
					short?: bool
					title!: strings.MinRunes(
						1)
					value!: strings.MinRunes(
						1)
				}]
				footer?: string

				// HTTP client configuration.
				http_config?: {
					...
				}
				icon_emoji?: string
				icon_url?:   string
				image_url?:  string
				link_names?: bool
				mrkdwn_in?: [...string]
				pretext?: string

				// SendResolved controls notify about resolved alerts.
				send_resolved?: bool
				short_fields?:  bool
				text?:          string
				thumb_url?:     string
				title?:         string
				title_link?:    string

				// Whether to update the original message in-place instead of sending a new one.
				// Requires Slack Bot API and chat:write scope.
				// Available since alertmanager v0.32.0.
				update_message?: bool
				username?:       string
			}]
			sns_configs?: [...{
				// The api URL
				api_url?: string

				// SNS message attributes
				attributes?: [string]: string

				// HTTP client configuration.
				http_config?: {
					// Authorization header configuration for the client.
					// This is mutually exclusive with BasicAuth and is only available starting from
					// Alertmanager v0.22+.
					authorization?: {
						// Reference to the secret with value for authorization
						credentials?: {
							// The key of the secret to select from. Must be a valid secret key.
							key!: string

							// Name of the referent.
							// This field is effectively required, but due to backwards compatibility is
							// allowed to be empty. Instances of this type with an empty value here are
							// almost certainly wrong.
							// More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
							name?: string

							// Specify whether the Secret or its key must be defined
							optional?: bool
						}

						// File with value for authorization
						credentialsFile?: string

						// Type of authorization, default to bearer
						type?: string
					}

					// BasicAuth for the client.
					basic_auth?: {
						// Password defines reference for secret with password value
						// The secret needs to be in the same namespace as scrape object
						password?: {
							// The key of the secret to select from. Must be a valid secret key.
							key!: string

							// Name of the referent.
							// This field is effectively required, but due to backwards compatibility is
							// allowed to be empty. Instances of this type with an empty value here are
							// almost certainly wrong.
							// More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
							name?: string

							// Specify whether the Secret or its key must be defined
							optional?: bool
						}

						// PasswordFile defines path to password file at disk
						// must be pre-mounted
						password_file?: string

						// Username defines reference for secret with username value
						// The secret needs to be in the same namespace as scrape object
						username?: {
							// The key of the secret to select from. Must be a valid secret key.
							key!: string

							// Name of the referent.
							// This field is effectively required, but due to backwards compatibility is
							// allowed to be empty. Instances of this type with an empty value here are
							// almost certainly wrong.
							// More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
							name?: string

							// Specify whether the Secret or its key must be defined
							optional?: bool
						}
					}

					// BearerTokenFile defines filename for bearer token, it must be mounted to pod.
					bearer_token_file?: string

					// The secret's key that contains the bearer token
					// It must be at them same namespace as CRD
					bearer_token_secret?: {
						// The key of the secret to select from. Must be a valid secret key.
						key!: string

						// Name of the referent.
						// This field is effectively required, but due to backwards compatibility is
						// allowed to be empty. Instances of this type with an empty value here are
						// almost certainly wrong.
						// More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
						name?: string

						// Specify whether the Secret or its key must be defined
						optional?: bool
					}

					// FollowRedirects controls redirects for scraping.
					follow_redirects?: bool

					// HTTPHeaders defines custom HTTP headers to be sent along with each request.
					// Only supported starting from Alertmanager v0.28.0; ignored by older versions.
					http_headers?: [string]: {
						// Files are paths on the vmalertmanager container's filesystem to read header values from.
						files?: [...string]

						// Secrets are header values read from Kubernetes Secrets.
						secrets?: [...{
							// The key of the secret to select from. Must be a valid secret key.
							key!: string

							// Name of the referent.
							// This field is effectively required, but due to backwards compatibility is
							// allowed to be empty. Instances of this type with an empty value here are
							// almost certainly wrong.
							// More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
							name?: string

							// Specify whether the Secret or its key must be defined
							optional?: bool
						}]

						// Values are literal header values to send as-is.
						values?: [...string]
					}

					// NoProxy defines a comma-separated string that can contain IPs, CIDR notation,
					// domain names that should be excluded from proxying.
					// IP and domain names can contain port numbers.
					noProxy?: string

					// OAuth2 client credentials used to fetch a token for the targets.
					oauth2?: {
						// The secret or configmap containing the OAuth2 client id
						client_id!: {
							// ConfigMap containing data to use for the targets.
							configMap?: {
								// The key to select from the ConfigMap's Data field.
								// Keys in the BinaryData field are not currently propagated to container env vars.
								key!: string

								// Name of the referent.
								// This field is effectively required, but due to backwards compatibility is
								// allowed to be empty. Instances of this type with an empty value here are
								// almost certainly wrong.
								// More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
								name?: string

								// Specify whether the ConfigMap or its key must be defined
								optional?: bool
							}

							// Secret containing data to use for the targets.
							secret?: {
								// The key of the secret to select from. Must be a valid secret key.
								key!: string

								// Name of the referent.
								// This field is effectively required, but due to backwards compatibility is
								// allowed to be empty. Instances of this type with an empty value here are
								// almost certainly wrong.
								// More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
								name?: string

								// Specify whether the Secret or its key must be defined
								optional?: bool
							}
						}

						// The secret containing the OAuth2 client secret
						client_secret?: {
							// The key of the secret to select from. Must be a valid secret key.
							key!: string

							// Name of the referent.
							// This field is effectively required, but due to backwards compatibility is
							// allowed to be empty. Instances of this type with an empty value here are
							// almost certainly wrong.
							// More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
							name?: string

							// Specify whether the Secret or its key must be defined
							optional?: bool
						}

						// ClientSecretFile defines path for client secret file.
						client_secret_file?: string

						// Parameters to append to the token URL
						endpoint_params?: [string]: string

						// The proxy URL for token_url connection
						// Is only supported by Scrape objects family
						proxy_url?: string

						// OAuth2 scopes used for the token request
						scopes?: [...string]

						// TLSConfig for token_url connection
						// Is only supported by Scrape objects family
						tls_config?: null | bool | number | string | [...] | {
							...
						}

						// The URL to fetch the token from
						token_url!: strings.MinRunes(
								1)
					}

					// ProxyConnectHeader optionally specifies headers to send to proxies during CONNECT requests.
					proxyConnectHeader?: [string]: [...{
						// The key of the secret to select from. Must be a valid secret key.
						key!: string

						// Name of the referent.
						// This field is effectively required, but due to backwards compatibility is
						// allowed to be empty. Instances of this type with an empty value here are
						// almost certainly wrong.
						// More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
						name?: string

						// Specify whether the Secret or its key must be defined
						optional?: bool
					}]

					// ProxyFromEnvironment defines whether to use the proxy configuration defined
					// by environment variables (HTTP_PROXY, HTTPS_PROXY, and NO_PROXY).
					proxyFromEnvironment?: bool

					// ProxyUrl defines the HTTP proxy server to use.
					proxyURL?: =~"^(http|https|socks5)://.+$"

					// TLS configuration for the client.
					tls_config?: {
						// Struct containing the CA cert to use for the targets.
						ca?: {
							// ConfigMap containing data to use for the targets.
							configMap?: {
								// The key to select from the ConfigMap's Data field.
								// Keys in the BinaryData field are not currently propagated to container env vars.
								key!: string

								// Name of the referent.
								// This field is effectively required, but due to backwards compatibility is
								// allowed to be empty. Instances of this type with an empty value here are
								// almost certainly wrong.
								// More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
								name?: string

								// Specify whether the ConfigMap or its key must be defined
								optional?: bool
							}

							// Secret containing data to use for the targets.
							secret?: {
								// The key of the secret to select from. Must be a valid secret key.
								key!: string

								// Name of the referent.
								// This field is effectively required, but due to backwards compatibility is
								// allowed to be empty. Instances of this type with an empty value here are
								// almost certainly wrong.
								// More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
								name?: string

								// Specify whether the Secret or its key must be defined
								optional?: bool
							}
						}

						// Path to the CA cert in the container to use for the targets.
						caFile?: string

						// Struct containing the client cert file for the targets.
						cert?: {
							// ConfigMap containing data to use for the targets.
							configMap?: {
								// The key to select from the ConfigMap's Data field.
								// Keys in the BinaryData field are not currently propagated to container env vars.
								key!: string

								// Name of the referent.
								// This field is effectively required, but due to backwards compatibility is
								// allowed to be empty. Instances of this type with an empty value here are
								// almost certainly wrong.
								// More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
								name?: string

								// Specify whether the ConfigMap or its key must be defined
								optional?: bool
							}

							// Secret containing data to use for the targets.
							secret?: {
								// The key of the secret to select from. Must be a valid secret key.
								key!: string

								// Name of the referent.
								// This field is effectively required, but due to backwards compatibility is
								// allowed to be empty. Instances of this type with an empty value here are
								// almost certainly wrong.
								// More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
								name?: string

								// Specify whether the Secret or its key must be defined
								optional?: bool
							}
						}

						// Path to the client cert file in the container for the targets.
						certFile?: string

						// Disable target certificate validation.
						insecureSkipVerify?: bool

						// Path to the client key file in the container for the targets.
						keyFile?: string

						// Secret containing the client key file for the targets.
						keySecret?: {
							// The key of the secret to select from. Must be a valid secret key.
							key!: string

							// Name of the referent.
							// This field is effectively required, but due to backwards compatibility is
							// allowed to be empty. Instances of this type with an empty value here are
							// almost certainly wrong.
							// More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
							name?: string

							// Specify whether the Secret or its key must be defined
							optional?: bool
						}

						// Used to verify the hostname for the targets.
						serverName?: string
					}
				}

				// The message content of the SNS notification.
				message?: string

				// Phone number if message is delivered via SMS
				// Specify this, topic_arn or target_arn
				phone_number?: string

				// SendResolved controls notify about resolved alerts.
				send_resolved?: bool

				// Configure the AWS Signature Verification 4 signing process
				sigv4?: {
					// The AWS API keys. Both access_key and secret_key must be supplied or both must be blank.
					// If blank the environment variables `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` are used.
					access_key?: string

					// secret key selector to get the keys from a Kubernetes Secret
					access_key_selector?: {
						// The key of the secret to select from. Must be a valid secret key.
						key!: string

						// Name of the referent.
						// This field is effectively required, but due to backwards compatibility is
						// allowed to be empty. Instances of this type with an empty value here are
						// almost certainly wrong.
						// More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
						name?: string

						// Specify whether the Secret or its key must be defined
						optional?: bool
					}

					// Named AWS profile used to authenticate
					profile?: string

					// AWS region, if blank the region from the default credentials chain is used
					region?: string

					// AWS Role ARN, an alternative to using AWS API keys
					role_arn?: string

					// secret key selector to get the keys from a Kubernetes Secret
					secret_key_selector?: {
						// The key of the secret to select from. Must be a valid secret key.
						key!: string

						// Name of the referent.
						// This field is effectively required, but due to backwards compatibility is
						// allowed to be empty. Instances of this type with an empty value here are
						// almost certainly wrong.
						// More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
						name?: string

						// Specify whether the Secret or its key must be defined
						optional?: bool
					}
				}

				// The subject line if message is delivered to an email endpoint.
				subject?: string

				// Mobile platform endpoint ARN if message is delivered via mobile notifications
				// Specify this, topic_arn or phone_number
				target_arn?: string

				// SNS topic ARN, either specify this, phone_number or target_arn
				topic_arn?: string
			}]
			telegram_configs?: [...{
				// APIUrl the Telegram API URL i.e. https://api.telegram.org.
				api_url?: string

				// BotToken token for the bot
				// https://core.telegram.org/bots/api
				bot_token!: {
					// The key of the secret to select from. Must be a valid secret key.
					key!: string

					// Name of the referent.
					// This field is effectively required, but due to backwards compatibility is
					// allowed to be empty. Instances of this type with an empty value here are
					// almost certainly wrong.
					// More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
					name?: string

					// Specify whether the Secret or its key must be defined
					optional?: bool
				}

				// ChatID is ID of the chat where to send the messages.
				chat_id!: int

				// DisableNotifications
				disable_notifications?: bool

				// HTTP client configuration.
				http_config?: {
					...
				}

				// Message is templated message
				message?: string

				// MessageThreadID defines ID of the message thread where to send the messages.
				message_thread_id?: int

				// ParseMode for telegram message,
				// supported values are MarkdownV2, Markdown, Markdown and empty string for plain text.
				parse_mode?: string

				// SendResolved controls notify about resolved alerts.
				send_resolved?: bool
			}]

			// VictorOpsConfigs defines victor ops notification configurations.
			victorops_configs?: [...{
				// The secret's key that contains the API key to use when talking to the VictorOps API.
				// It must be at them same namespace as CRD
				// fallback to global setting if empty
				api_key?: {
					// The key of the secret to select from. Must be a valid secret key.
					key!: string

					// Name of the referent.
					// This field is effectively required, but due to backwards compatibility is
					// allowed to be empty. Instances of this type with an empty value here are
					// almost certainly wrong.
					// More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
					name?: string

					// Specify whether the Secret or its key must be defined
					optional?: bool
				}

				// The VictorOps API URL.
				api_url?: string

				// Adds optional custom fields
				// https://github.com/prometheus/alertmanager/blob/v0.24.0/config/notifiers.go#L537
				custom_fields?: [string]: string

				// Contains summary of the alerted problem.
				entity_display_name?: string

				// The HTTP client's configuration.
				http_config?: {
					// Authorization header configuration for the client.
					// This is mutually exclusive with BasicAuth and is only available starting from
					// Alertmanager v0.22+.
					authorization?: {
						// Reference to the secret with value for authorization
						credentials?: {
							// The key of the secret to select from. Must be a valid secret key.
							key!: string

							// Name of the referent.
							// This field is effectively required, but due to backwards compatibility is
							// allowed to be empty. Instances of this type with an empty value here are
							// almost certainly wrong.
							// More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
							name?: string

							// Specify whether the Secret or its key must be defined
							optional?: bool
						}

						// File with value for authorization
						credentialsFile?: string

						// Type of authorization, default to bearer
						type?: string
					}

					// BasicAuth for the client.
					basic_auth?: {
						// Password defines reference for secret with password value
						// The secret needs to be in the same namespace as scrape object
						password?: {
							// The key of the secret to select from. Must be a valid secret key.
							key!: string

							// Name of the referent.
							// This field is effectively required, but due to backwards compatibility is
							// allowed to be empty. Instances of this type with an empty value here are
							// almost certainly wrong.
							// More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
							name?: string

							// Specify whether the Secret or its key must be defined
							optional?: bool
						}

						// PasswordFile defines path to password file at disk
						// must be pre-mounted
						password_file?: string

						// Username defines reference for secret with username value
						// The secret needs to be in the same namespace as scrape object
						username?: {
							// The key of the secret to select from. Must be a valid secret key.
							key!: string

							// Name of the referent.
							// This field is effectively required, but due to backwards compatibility is
							// allowed to be empty. Instances of this type with an empty value here are
							// almost certainly wrong.
							// More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
							name?: string

							// Specify whether the Secret or its key must be defined
							optional?: bool
						}
					}

					// BearerTokenFile defines filename for bearer token, it must be mounted to pod.
					bearer_token_file?: string

					// The secret's key that contains the bearer token
					// It must be at them same namespace as CRD
					bearer_token_secret?: {
						// The key of the secret to select from. Must be a valid secret key.
						key!: string

						// Name of the referent.
						// This field is effectively required, but due to backwards compatibility is
						// allowed to be empty. Instances of this type with an empty value here are
						// almost certainly wrong.
						// More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
						name?: string

						// Specify whether the Secret or its key must be defined
						optional?: bool
					}

					// FollowRedirects controls redirects for scraping.
					follow_redirects?: bool

					// HTTPHeaders defines custom HTTP headers to be sent along with each request.
					// Only supported starting from Alertmanager v0.28.0; ignored by older versions.
					http_headers?: [string]: {
						// Files are paths on the vmalertmanager container's filesystem to read header values from.
						files?: [...string]

						// Secrets are header values read from Kubernetes Secrets.
						secrets?: [...{
							// The key of the secret to select from. Must be a valid secret key.
							key!: string

							// Name of the referent.
							// This field is effectively required, but due to backwards compatibility is
							// allowed to be empty. Instances of this type with an empty value here are
							// almost certainly wrong.
							// More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
							name?: string

							// Specify whether the Secret or its key must be defined
							optional?: bool
						}]

						// Values are literal header values to send as-is.
						values?: [...string]
					}

					// NoProxy defines a comma-separated string that can contain IPs, CIDR notation,
					// domain names that should be excluded from proxying.
					// IP and domain names can contain port numbers.
					noProxy?: string

					// OAuth2 client credentials used to fetch a token for the targets.
					oauth2?: {
						// The secret or configmap containing the OAuth2 client id
						client_id!: {
							// ConfigMap containing data to use for the targets.
							configMap?: {
								// The key to select from the ConfigMap's Data field.
								// Keys in the BinaryData field are not currently propagated to container env vars.
								key!: string

								// Name of the referent.
								// This field is effectively required, but due to backwards compatibility is
								// allowed to be empty. Instances of this type with an empty value here are
								// almost certainly wrong.
								// More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
								name?: string

								// Specify whether the ConfigMap or its key must be defined
								optional?: bool
							}

							// Secret containing data to use for the targets.
							secret?: {
								// The key of the secret to select from. Must be a valid secret key.
								key!: string

								// Name of the referent.
								// This field is effectively required, but due to backwards compatibility is
								// allowed to be empty. Instances of this type with an empty value here are
								// almost certainly wrong.
								// More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
								name?: string

								// Specify whether the Secret or its key must be defined
								optional?: bool
							}
						}

						// The secret containing the OAuth2 client secret
						client_secret?: {
							// The key of the secret to select from. Must be a valid secret key.
							key!: string

							// Name of the referent.
							// This field is effectively required, but due to backwards compatibility is
							// allowed to be empty. Instances of this type with an empty value here are
							// almost certainly wrong.
							// More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
							name?: string

							// Specify whether the Secret or its key must be defined
							optional?: bool
						}

						// ClientSecretFile defines path for client secret file.
						client_secret_file?: string

						// Parameters to append to the token URL
						endpoint_params?: [string]: string

						// The proxy URL for token_url connection
						// Is only supported by Scrape objects family
						proxy_url?: string

						// OAuth2 scopes used for the token request
						scopes?: [...string]

						// TLSConfig for token_url connection
						// Is only supported by Scrape objects family
						tls_config?: null | bool | number | string | [...] | {
							...
						}

						// The URL to fetch the token from
						token_url!: strings.MinRunes(
								1)
					}

					// ProxyConnectHeader optionally specifies headers to send to proxies during CONNECT requests.
					proxyConnectHeader?: [string]: [...{
						// The key of the secret to select from. Must be a valid secret key.
						key!: string

						// Name of the referent.
						// This field is effectively required, but due to backwards compatibility is
						// allowed to be empty. Instances of this type with an empty value here are
						// almost certainly wrong.
						// More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
						name?: string

						// Specify whether the Secret or its key must be defined
						optional?: bool
					}]

					// ProxyFromEnvironment defines whether to use the proxy configuration defined
					// by environment variables (HTTP_PROXY, HTTPS_PROXY, and NO_PROXY).
					proxyFromEnvironment?: bool

					// ProxyUrl defines the HTTP proxy server to use.
					proxyURL?: =~"^(http|https|socks5)://.+$"

					// TLS configuration for the client.
					tls_config?: {
						// Struct containing the CA cert to use for the targets.
						ca?: {
							// ConfigMap containing data to use for the targets.
							configMap?: {
								// The key to select from the ConfigMap's Data field.
								// Keys in the BinaryData field are not currently propagated to container env vars.
								key!: string

								// Name of the referent.
								// This field is effectively required, but due to backwards compatibility is
								// allowed to be empty. Instances of this type with an empty value here are
								// almost certainly wrong.
								// More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
								name?: string

								// Specify whether the ConfigMap or its key must be defined
								optional?: bool
							}

							// Secret containing data to use for the targets.
							secret?: {
								// The key of the secret to select from. Must be a valid secret key.
								key!: string

								// Name of the referent.
								// This field is effectively required, but due to backwards compatibility is
								// allowed to be empty. Instances of this type with an empty value here are
								// almost certainly wrong.
								// More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
								name?: string

								// Specify whether the Secret or its key must be defined
								optional?: bool
							}
						}

						// Path to the CA cert in the container to use for the targets.
						caFile?: string

						// Struct containing the client cert file for the targets.
						cert?: {
							// ConfigMap containing data to use for the targets.
							configMap?: {
								// The key to select from the ConfigMap's Data field.
								// Keys in the BinaryData field are not currently propagated to container env vars.
								key!: string

								// Name of the referent.
								// This field is effectively required, but due to backwards compatibility is
								// allowed to be empty. Instances of this type with an empty value here are
								// almost certainly wrong.
								// More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
								name?: string

								// Specify whether the ConfigMap or its key must be defined
								optional?: bool
							}

							// Secret containing data to use for the targets.
							secret?: {
								// The key of the secret to select from. Must be a valid secret key.
								key!: string

								// Name of the referent.
								// This field is effectively required, but due to backwards compatibility is
								// allowed to be empty. Instances of this type with an empty value here are
								// almost certainly wrong.
								// More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
								name?: string

								// Specify whether the Secret or its key must be defined
								optional?: bool
							}
						}

						// Path to the client cert file in the container for the targets.
						certFile?: string

						// Disable target certificate validation.
						insecureSkipVerify?: bool

						// Path to the client key file in the container for the targets.
						keyFile?: string

						// Secret containing the client key file for the targets.
						keySecret?: {
							// The key of the secret to select from. Must be a valid secret key.
							key!: string

							// Name of the referent.
							// This field is effectively required, but due to backwards compatibility is
							// allowed to be empty. Instances of this type with an empty value here are
							// almost certainly wrong.
							// More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
							name?: string

							// Specify whether the Secret or its key must be defined
							optional?: bool
						}

						// Used to verify the hostname for the targets.
						serverName?: string
					}
				}

				// Describes the behavior of the alert (CRITICAL, WARNING, INFO).
				message_type?: string

				// The monitoring tool the state message is from.
				monitoring_tool?: string

				// A key used to map the alert to a team.
				routing_key!: string

				// SendResolved controls notify about resolved alerts.
				send_resolved?: bool

				// Contains long explanation of the alerted problem.
				state_message?: string
			}]
			webex_configs?: [...{
				// The Webex Teams API URL, i.e. https://webexapis.com/v1/messages
				api_url?: string

				// HTTP client configuration. You must use this configuration to supply the bot
				// token as part of the HTTP `Authorization` header.
				http_config?: {
					// Authorization header configuration for the client.
					// This is mutually exclusive with BasicAuth and is only available starting from
					// Alertmanager v0.22+.
					authorization?: {
						// Reference to the secret with value for authorization
						credentials?: {
							// The key of the secret to select from. Must be a valid secret key.
							key!: string

							// Name of the referent.
							// This field is effectively required, but due to backwards compatibility is
							// allowed to be empty. Instances of this type with an empty value here are
							// almost certainly wrong.
							// More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
							name?: string

							// Specify whether the Secret or its key must be defined
							optional?: bool
						}

						// File with value for authorization
						credentialsFile?: string

						// Type of authorization, default to bearer
						type?: string
					}

					// BasicAuth for the client.
					basic_auth?: {
						// Password defines reference for secret with password value
						// The secret needs to be in the same namespace as scrape object
						password?: {
							// The key of the secret to select from. Must be a valid secret key.
							key!: string

							// Name of the referent.
							// This field is effectively required, but due to backwards compatibility is
							// allowed to be empty. Instances of this type with an empty value here are
							// almost certainly wrong.
							// More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
							name?: string

							// Specify whether the Secret or its key must be defined
							optional?: bool
						}

						// PasswordFile defines path to password file at disk
						// must be pre-mounted
						password_file?: string

						// Username defines reference for secret with username value
						// The secret needs to be in the same namespace as scrape object
						username?: {
							// The key of the secret to select from. Must be a valid secret key.
							key!: string

							// Name of the referent.
							// This field is effectively required, but due to backwards compatibility is
							// allowed to be empty. Instances of this type with an empty value here are
							// almost certainly wrong.
							// More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
							name?: string

							// Specify whether the Secret or its key must be defined
							optional?: bool
						}
					}

					// BearerTokenFile defines filename for bearer token, it must be mounted to pod.
					bearer_token_file?: string

					// The secret's key that contains the bearer token
					// It must be at them same namespace as CRD
					bearer_token_secret?: {
						// The key of the secret to select from. Must be a valid secret key.
						key!: string

						// Name of the referent.
						// This field is effectively required, but due to backwards compatibility is
						// allowed to be empty. Instances of this type with an empty value here are
						// almost certainly wrong.
						// More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
						name?: string

						// Specify whether the Secret or its key must be defined
						optional?: bool
					}

					// FollowRedirects controls redirects for scraping.
					follow_redirects?: bool

					// HTTPHeaders defines custom HTTP headers to be sent along with each request.
					// Only supported starting from Alertmanager v0.28.0; ignored by older versions.
					http_headers?: [string]: {
						// Files are paths on the vmalertmanager container's filesystem to read header values from.
						files?: [...string]

						// Secrets are header values read from Kubernetes Secrets.
						secrets?: [...{
							// The key of the secret to select from. Must be a valid secret key.
							key!: string

							// Name of the referent.
							// This field is effectively required, but due to backwards compatibility is
							// allowed to be empty. Instances of this type with an empty value here are
							// almost certainly wrong.
							// More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
							name?: string

							// Specify whether the Secret or its key must be defined
							optional?: bool
						}]

						// Values are literal header values to send as-is.
						values?: [...string]
					}

					// NoProxy defines a comma-separated string that can contain IPs, CIDR notation,
					// domain names that should be excluded from proxying.
					// IP and domain names can contain port numbers.
					noProxy?: string

					// OAuth2 client credentials used to fetch a token for the targets.
					oauth2?: {
						// The secret or configmap containing the OAuth2 client id
						client_id!: {
							// ConfigMap containing data to use for the targets.
							configMap?: {
								// The key to select from the ConfigMap's Data field.
								// Keys in the BinaryData field are not currently propagated to container env vars.
								key!: string

								// Name of the referent.
								// This field is effectively required, but due to backwards compatibility is
								// allowed to be empty. Instances of this type with an empty value here are
								// almost certainly wrong.
								// More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
								name?: string

								// Specify whether the ConfigMap or its key must be defined
								optional?: bool
							}

							// Secret containing data to use for the targets.
							secret?: {
								// The key of the secret to select from. Must be a valid secret key.
								key!: string

								// Name of the referent.
								// This field is effectively required, but due to backwards compatibility is
								// allowed to be empty. Instances of this type with an empty value here are
								// almost certainly wrong.
								// More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
								name?: string

								// Specify whether the Secret or its key must be defined
								optional?: bool
							}
						}

						// The secret containing the OAuth2 client secret
						client_secret?: {
							// The key of the secret to select from. Must be a valid secret key.
							key!: string

							// Name of the referent.
							// This field is effectively required, but due to backwards compatibility is
							// allowed to be empty. Instances of this type with an empty value here are
							// almost certainly wrong.
							// More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
							name?: string

							// Specify whether the Secret or its key must be defined
							optional?: bool
						}

						// ClientSecretFile defines path for client secret file.
						client_secret_file?: string

						// Parameters to append to the token URL
						endpoint_params?: [string]: string

						// The proxy URL for token_url connection
						// Is only supported by Scrape objects family
						proxy_url?: string

						// OAuth2 scopes used for the token request
						scopes?: [...string]

						// TLSConfig for token_url connection
						// Is only supported by Scrape objects family
						tls_config?: null | bool | number | string | [...] | {
							...
						}

						// The URL to fetch the token from
						token_url!: strings.MinRunes(
								1)
					}

					// ProxyConnectHeader optionally specifies headers to send to proxies during CONNECT requests.
					proxyConnectHeader?: [string]: [...{
						// The key of the secret to select from. Must be a valid secret key.
						key!: string

						// Name of the referent.
						// This field is effectively required, but due to backwards compatibility is
						// allowed to be empty. Instances of this type with an empty value here are
						// almost certainly wrong.
						// More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
						name?: string

						// Specify whether the Secret or its key must be defined
						optional?: bool
					}]

					// ProxyFromEnvironment defines whether to use the proxy configuration defined
					// by environment variables (HTTP_PROXY, HTTPS_PROXY, and NO_PROXY).
					proxyFromEnvironment?: bool

					// ProxyUrl defines the HTTP proxy server to use.
					proxyURL?: =~"^(http|https|socks5)://.+$"

					// TLS configuration for the client.
					tls_config?: {
						// Struct containing the CA cert to use for the targets.
						ca?: {
							// ConfigMap containing data to use for the targets.
							configMap?: {
								// The key to select from the ConfigMap's Data field.
								// Keys in the BinaryData field are not currently propagated to container env vars.
								key!: string

								// Name of the referent.
								// This field is effectively required, but due to backwards compatibility is
								// allowed to be empty. Instances of this type with an empty value here are
								// almost certainly wrong.
								// More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
								name?: string

								// Specify whether the ConfigMap or its key must be defined
								optional?: bool
							}

							// Secret containing data to use for the targets.
							secret?: {
								// The key of the secret to select from. Must be a valid secret key.
								key!: string

								// Name of the referent.
								// This field is effectively required, but due to backwards compatibility is
								// allowed to be empty. Instances of this type with an empty value here are
								// almost certainly wrong.
								// More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
								name?: string

								// Specify whether the Secret or its key must be defined
								optional?: bool
							}
						}

						// Path to the CA cert in the container to use for the targets.
						caFile?: string

						// Struct containing the client cert file for the targets.
						cert?: {
							// ConfigMap containing data to use for the targets.
							configMap?: {
								// The key to select from the ConfigMap's Data field.
								// Keys in the BinaryData field are not currently propagated to container env vars.
								key!: string

								// Name of the referent.
								// This field is effectively required, but due to backwards compatibility is
								// allowed to be empty. Instances of this type with an empty value here are
								// almost certainly wrong.
								// More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
								name?: string

								// Specify whether the ConfigMap or its key must be defined
								optional?: bool
							}

							// Secret containing data to use for the targets.
							secret?: {
								// The key of the secret to select from. Must be a valid secret key.
								key!: string

								// Name of the referent.
								// This field is effectively required, but due to backwards compatibility is
								// allowed to be empty. Instances of this type with an empty value here are
								// almost certainly wrong.
								// More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
								name?: string

								// Specify whether the Secret or its key must be defined
								optional?: bool
							}
						}

						// Path to the client cert file in the container for the targets.
						certFile?: string

						// Disable target certificate validation.
						insecureSkipVerify?: bool

						// Path to the client key file in the container for the targets.
						keyFile?: string

						// Secret containing the client key file for the targets.
						keySecret?: {
							// The key of the secret to select from. Must be a valid secret key.
							key!: string

							// Name of the referent.
							// This field is effectively required, but due to backwards compatibility is
							// allowed to be empty. Instances of this type with an empty value here are
							// almost certainly wrong.
							// More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
							name?: string

							// Specify whether the Secret or its key must be defined
							optional?: bool
						}

						// Used to verify the hostname for the targets.
						serverName?: string
					}
				}

				// The message body template
				message?: string

				// The ID of the Webex Teams room where to send the messages
				room_id!: string

				// SendResolved controls notify about resolved alerts.
				send_resolved?: bool
			}]

			// WebhookConfigs defines webhook notification configurations.
			webhook_configs?: [...{
				// HTTP client configuration.
				http_config?: {
					...
				}

				// Maximum number of alerts to be sent per webhook message. When 0, all alerts are included.
				max_alerts?: int32 & int & >=0

				// SendResolved controls notify about resolved alerts.
				send_resolved?: bool

				// Timeout is the maximum time allowed to invoke the webhook
				// available since v0.28.0 alertmanager version
				timeout?: =~"^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$"

				// URL to send requests to,
				// one of `urlSecret` and `url` must be defined.
				url?: string

				// URLSecret defines secret name and key at the CRD namespace.
				// It must contain the webhook URL.
				// one of `urlSecret` and `url` must be defined.
				url_secret?: {
					// The key of the secret to select from. Must be a valid secret key.
					key!: string

					// Name of the referent.
					// This field is effectively required, but due to backwards compatibility is
					// allowed to be empty. Instances of this type with an empty value here are
					// almost certainly wrong.
					// More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
					name?: string

					// Specify whether the Secret or its key must be defined
					optional?: bool
				}
			}]

			// WechatConfigs defines wechat notification configurations.
			wechat_configs?: [...{
				agent_id?: string

				// The secret's key that contains the WeChat API key.
				// The secret needs to be in the same namespace as the AlertmanagerConfig
				// fallback to global alertmanager setting if empty
				api_secret?: {
					// The key of the secret to select from. Must be a valid secret key.
					key!: string

					// Name of the referent.
					// This field is effectively required, but due to backwards compatibility is
					// allowed to be empty. Instances of this type with an empty value here are
					// almost certainly wrong.
					// More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
					name?: string

					// Specify whether the Secret or its key must be defined
					optional?: bool
				}

				// The WeChat API URL.
				// fallback to global alertmanager setting if empty
				api_url?: string

				// The corp id for authentication.
				// fallback to global alertmanager setting if empty
				corp_id?: string

				// HTTP client configuration.
				http_config?: {
					// Authorization header configuration for the client.
					// This is mutually exclusive with BasicAuth and is only available starting from
					// Alertmanager v0.22+.
					authorization?: {
						// Reference to the secret with value for authorization
						credentials?: {
							// The key of the secret to select from. Must be a valid secret key.
							key!: string

							// Name of the referent.
							// This field is effectively required, but due to backwards compatibility is
							// allowed to be empty. Instances of this type with an empty value here are
							// almost certainly wrong.
							// More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
							name?: string

							// Specify whether the Secret or its key must be defined
							optional?: bool
						}

						// File with value for authorization
						credentialsFile?: string

						// Type of authorization, default to bearer
						type?: string
					}

					// BasicAuth for the client.
					basic_auth?: {
						// Password defines reference for secret with password value
						// The secret needs to be in the same namespace as scrape object
						password?: {
							// The key of the secret to select from. Must be a valid secret key.
							key!: string

							// Name of the referent.
							// This field is effectively required, but due to backwards compatibility is
							// allowed to be empty. Instances of this type with an empty value here are
							// almost certainly wrong.
							// More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
							name?: string

							// Specify whether the Secret or its key must be defined
							optional?: bool
						}

						// PasswordFile defines path to password file at disk
						// must be pre-mounted
						password_file?: string

						// Username defines reference for secret with username value
						// The secret needs to be in the same namespace as scrape object
						username?: {
							// The key of the secret to select from. Must be a valid secret key.
							key!: string

							// Name of the referent.
							// This field is effectively required, but due to backwards compatibility is
							// allowed to be empty. Instances of this type with an empty value here are
							// almost certainly wrong.
							// More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
							name?: string

							// Specify whether the Secret or its key must be defined
							optional?: bool
						}
					}

					// BearerTokenFile defines filename for bearer token, it must be mounted to pod.
					bearer_token_file?: string

					// The secret's key that contains the bearer token
					// It must be at them same namespace as CRD
					bearer_token_secret?: {
						// The key of the secret to select from. Must be a valid secret key.
						key!: string

						// Name of the referent.
						// This field is effectively required, but due to backwards compatibility is
						// allowed to be empty. Instances of this type with an empty value here are
						// almost certainly wrong.
						// More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
						name?: string

						// Specify whether the Secret or its key must be defined
						optional?: bool
					}

					// FollowRedirects controls redirects for scraping.
					follow_redirects?: bool

					// HTTPHeaders defines custom HTTP headers to be sent along with each request.
					// Only supported starting from Alertmanager v0.28.0; ignored by older versions.
					http_headers?: [string]: {
						// Files are paths on the vmalertmanager container's filesystem to read header values from.
						files?: [...string]

						// Secrets are header values read from Kubernetes Secrets.
						secrets?: [...{
							// The key of the secret to select from. Must be a valid secret key.
							key!: string

							// Name of the referent.
							// This field is effectively required, but due to backwards compatibility is
							// allowed to be empty. Instances of this type with an empty value here are
							// almost certainly wrong.
							// More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
							name?: string

							// Specify whether the Secret or its key must be defined
							optional?: bool
						}]

						// Values are literal header values to send as-is.
						values?: [...string]
					}

					// NoProxy defines a comma-separated string that can contain IPs, CIDR notation,
					// domain names that should be excluded from proxying.
					// IP and domain names can contain port numbers.
					noProxy?: string

					// OAuth2 client credentials used to fetch a token for the targets.
					oauth2?: {
						// The secret or configmap containing the OAuth2 client id
						client_id!: {
							// ConfigMap containing data to use for the targets.
							configMap?: {
								// The key to select from the ConfigMap's Data field.
								// Keys in the BinaryData field are not currently propagated to container env vars.
								key!: string

								// Name of the referent.
								// This field is effectively required, but due to backwards compatibility is
								// allowed to be empty. Instances of this type with an empty value here are
								// almost certainly wrong.
								// More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
								name?: string

								// Specify whether the ConfigMap or its key must be defined
								optional?: bool
							}

							// Secret containing data to use for the targets.
							secret?: {
								// The key of the secret to select from. Must be a valid secret key.
								key!: string

								// Name of the referent.
								// This field is effectively required, but due to backwards compatibility is
								// allowed to be empty. Instances of this type with an empty value here are
								// almost certainly wrong.
								// More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
								name?: string

								// Specify whether the Secret or its key must be defined
								optional?: bool
							}
						}

						// The secret containing the OAuth2 client secret
						client_secret?: {
							// The key of the secret to select from. Must be a valid secret key.
							key!: string

							// Name of the referent.
							// This field is effectively required, but due to backwards compatibility is
							// allowed to be empty. Instances of this type with an empty value here are
							// almost certainly wrong.
							// More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
							name?: string

							// Specify whether the Secret or its key must be defined
							optional?: bool
						}

						// ClientSecretFile defines path for client secret file.
						client_secret_file?: string

						// Parameters to append to the token URL
						endpoint_params?: [string]: string

						// The proxy URL for token_url connection
						// Is only supported by Scrape objects family
						proxy_url?: string

						// OAuth2 scopes used for the token request
						scopes?: [...string]

						// TLSConfig for token_url connection
						// Is only supported by Scrape objects family
						tls_config?: null | bool | number | string | [...] | {
							...
						}

						// The URL to fetch the token from
						token_url!: strings.MinRunes(
								1)
					}

					// ProxyConnectHeader optionally specifies headers to send to proxies during CONNECT requests.
					proxyConnectHeader?: [string]: [...{
						// The key of the secret to select from. Must be a valid secret key.
						key!: string

						// Name of the referent.
						// This field is effectively required, but due to backwards compatibility is
						// allowed to be empty. Instances of this type with an empty value here are
						// almost certainly wrong.
						// More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
						name?: string

						// Specify whether the Secret or its key must be defined
						optional?: bool
					}]

					// ProxyFromEnvironment defines whether to use the proxy configuration defined
					// by environment variables (HTTP_PROXY, HTTPS_PROXY, and NO_PROXY).
					proxyFromEnvironment?: bool

					// ProxyUrl defines the HTTP proxy server to use.
					proxyURL?: =~"^(http|https|socks5)://.+$"

					// TLS configuration for the client.
					tls_config?: {
						// Struct containing the CA cert to use for the targets.
						ca?: {
							// ConfigMap containing data to use for the targets.
							configMap?: {
								// The key to select from the ConfigMap's Data field.
								// Keys in the BinaryData field are not currently propagated to container env vars.
								key!: string

								// Name of the referent.
								// This field is effectively required, but due to backwards compatibility is
								// allowed to be empty. Instances of this type with an empty value here are
								// almost certainly wrong.
								// More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
								name?: string

								// Specify whether the ConfigMap or its key must be defined
								optional?: bool
							}

							// Secret containing data to use for the targets.
							secret?: {
								// The key of the secret to select from. Must be a valid secret key.
								key!: string

								// Name of the referent.
								// This field is effectively required, but due to backwards compatibility is
								// allowed to be empty. Instances of this type with an empty value here are
								// almost certainly wrong.
								// More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
								name?: string

								// Specify whether the Secret or its key must be defined
								optional?: bool
							}
						}

						// Path to the CA cert in the container to use for the targets.
						caFile?: string

						// Struct containing the client cert file for the targets.
						cert?: {
							// ConfigMap containing data to use for the targets.
							configMap?: {
								// The key to select from the ConfigMap's Data field.
								// Keys in the BinaryData field are not currently propagated to container env vars.
								key!: string

								// Name of the referent.
								// This field is effectively required, but due to backwards compatibility is
								// allowed to be empty. Instances of this type with an empty value here are
								// almost certainly wrong.
								// More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
								name?: string

								// Specify whether the ConfigMap or its key must be defined
								optional?: bool
							}

							// Secret containing data to use for the targets.
							secret?: {
								// The key of the secret to select from. Must be a valid secret key.
								key!: string

								// Name of the referent.
								// This field is effectively required, but due to backwards compatibility is
								// allowed to be empty. Instances of this type with an empty value here are
								// almost certainly wrong.
								// More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
								name?: string

								// Specify whether the Secret or its key must be defined
								optional?: bool
							}
						}

						// Path to the client cert file in the container for the targets.
						certFile?: string

						// Disable target certificate validation.
						insecureSkipVerify?: bool

						// Path to the client key file in the container for the targets.
						keyFile?: string

						// Secret containing the client key file for the targets.
						keySecret?: {
							// The key of the secret to select from. Must be a valid secret key.
							key!: string

							// Name of the referent.
							// This field is effectively required, but due to backwards compatibility is
							// allowed to be empty. Instances of this type with an empty value here are
							// almost certainly wrong.
							// More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
							name?: string

							// Specify whether the Secret or its key must be defined
							optional?: bool
						}

						// Used to verify the hostname for the targets.
						serverName?: string
					}
				}

				// API request data as defined by the WeChat API.
				message?:      string
				message_type?: string

				// SendResolved controls notify about resolved alerts.
				send_resolved?: bool
				to_party?:      string
				to_tag?:        string
				to_user?:       string
			}]
		}]

		// Route definition for alertmanager, may include nested routes.
		route?: {
			// ActiveTimeIntervals Times when the route should be active
			// These must match the name at time_intervals
			active_time_intervals?: [...string]

			// Continue indicating whether an alert should continue matching subsequent
			// sibling nodes. It will always be true for the first-level route if
			// disableRouteContinueEnforce for vmalertmanager not set.
			continue?: bool

			// List of labels to group by.
			group_by?: [...string]

			// How long to wait before sending an updated notification.
			group_interval?: =~"[0-9]+(ms|s|m|h)"

			// How long to wait before sending the initial notification.
			group_wait?: =~"[0-9]+(ms|s|m|h)"

			// List of matchers that the alert’s labels should match. For the first
			// level route, the operator adds a namespace: "CRD_NS" matcher.
			// https://prometheus.io/docs/alerting/latest/configuration/#matcher
			matchers?: [...string]

			// MuteTimeIntervals is a list of interval names that will mute matched alert
			mute_time_intervals?: [...string]

			// Name of the receiver for this route.
			receiver!: string

			// How long to wait before repeating the last notification.
			repeat_interval?: =~"[0-9]+(ms|s|m|h)"

			// Child routes.
			// https://prometheus.io/docs/alerting/latest/configuration/#route
			routes?: [...null | bool | number | string | [...] | {
				...
			}]
		}

		// TimeIntervals defines named interval for active/mute notifications interval
		// See https://prometheus.io/docs/alerting/latest/configuration/#time_interval
		time_intervals?: [...{
			// Name of interval
			name!: string

			// TimeIntervals interval configuration
			time_intervals!: [...{
				// DayOfMonth defines list of numerical days in the month. Days begin at 1.
				// Negative values are also accepted.
				// for example, ['1:5', '-3:-1']
				days_of_month?: [...string]

				// Location in golang time location form, e.g. UTC
				location?: string

				// Months defines list of calendar months identified by a case-insensitive name
				// (e.g. ‘January’) or numeric 1.
				// For example, ['1:3', 'may:august', 'december']
				months?: [...string]

				// Times defines time range for mute
				times?: [...{
					// EndTime for example HH:MM
					end_time!: string

					// StartTime for example HH:MM
					start_time!: string
				}]

				// Weekdays defines list of days of the week, where the week begins on Sunday and ends on Saturday.
				weekdays?: [...string]

				// Years defines numerical list of years, ranges are accepted.
				// For example, ['2020:2022', '2030']
				years?: [...string]
			}]
		}]
	}

	// VMAlertmanagerConfigStatus defines the observed state of VMAlertmanagerConfig
	//
	// `updateStatus` is set to `operational` unless the operator cannot parse the spec,
	// in which case it is set to `failed`. It never reports whether the applications
	// selecting this object accepted its content - `conditions` carries that.
	// See https://github.com/VictoriaMetrics/operator/issues/2649
	status?: {
		// Known .status.conditions.type are: "Available", "Progressing", and "Degraded"
		conditions?: [...{
			// lastTransitionTime is the last time the condition transitioned from one status to another.
			lastTransitionTime!: time.Time

			// LastUpdateTime is the last time of given type update.
			// This value is used for status TTL update and removal
			lastUpdateTime!: time.Time

			// message is a human readable message indicating details about the transition.
			// This may be an empty string.
			message?: strings.MaxRunes(
					32768)

			// observedGeneration represents the .metadata.generation that the condition was set based upon.
			// For instance, if .metadata.generation is currently 12, but the
			// .status.conditions[x].observedGeneration is 9, the condition is out of date
			// with respect to the current state of the instance.
			observedGeneration?: int64 & int & >=0

			// reason contains a programmatic identifier indicating the reason for the
			// condition's last transition.
			// Producers of specific condition types may define expected values and meanings for this field,
			// and whether the values are considered a guaranteed API.
			// The value should be a CamelCase string.
			// This field may not be empty.
			reason!: strings.MaxRunes(
					1024) & strings.MinRunes(
					1)

			// status of the condition, one of True, False, Unknown.
			status!: "True" | "False" | "Unknown"

			// Type of condition in CamelCase or in name.namespace.resource.victoriametrics.com/CamelCase.
			type!: strings.MaxRunes(
				316)
		}]
		lastErrorParentAlertmanagerName?: string

		// ObservedGeneration defines current generation picked by operator for the
		// reconcile
		observedGeneration?: int64 & int

		// Reason defines human readable error reason
		reason?: string

		// UpdateStatus defines a status for update rollout
		updateStatus?: string
	}

	_embeddedResource: {
		apiVersion!: string
		kind!:       string
		metadata?: {
			...
		}
	}
	apiVersion: "operator.victoriametrics.com/v1beta1"
	kind:       "VMAlertmanagerConfig"
	metadata!: {
		name!:      string
		namespace!: string
		labels?: [string]: string
		annotations?: [string]: string
		...
	}
}
