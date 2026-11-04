package v1beta1

import (
	"strings"
	"time"
)

#VMScrapeConfig: {
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

	// VMScrapeConfigSpec defines the desired state of VMScrapeConfig
	spec?: {
		// Authorization with http header Authorization
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

		// AzureSDConfigs defines a list of Azure service discovery configurations.
		azureSDConfigs?: [...{
			// # The authentication method, either OAuth or ManagedIdentity.
			// See
			// https://docs.microsoft.com/en-us/azure/active-directory/managed-identities-azure-resources/overview
			authenticationMethod?: "OAuth" | "ManagedIdentity"

			// Authorization header to use on every scrape request.
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

			// BasicAuth information to use on every scrape request.
			basicAuth?: {
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

			// Optional client ID. Only required with the OAuth authentication method.
			clientID?: string

			// Optional client secret. Only required with the OAuth authentication method.
			clientSecret?: {
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

			// The Azure environment.
			environment?: string

			// Configure whether HTTP requests follow HTTP 3xx redirects.
			followRedirects?: bool

			// OAuth2 defines auth configuration
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

			// The port to scrape metrics from. If using the public IP address, this must
			// instead be specified in the relabeling rule.
			port?: int32 & int

			// ProxyClientConfig configures proxy auth settings for scraping
			// See [feature
			// description](https://docs.victoriametrics.com/victoriametrics/vmagent/#scraping-targets-via-a-proxy)
			proxy_client_config?: {
				// Authorization with http header Authorization
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

				// BasicAuth allows proxy to authenticate over basic authentication
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

				// Secret to mount to read bearer token for scraping targets proxy auth. The secret
				// needs to be in the same namespace as the scrape object and accessible by
				// the victoria-metrics operator.
				bearer_token?:
					null | {
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

				// BearerTokenFile defines file to read bearer token from for proxy auth.
				bearer_token_file?: string

				// OAuth2 defines auth configuration
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

				// TLSConfig configuration to use when scraping the endpoint
				tls_config?: null | bool | number | string | [...] | {
					...
				}
			}

			// ProxyURL eg http://proxyserver:2195 Directs scrapes to proxy through this endpoint.
			proxyURL?: string

			// Optional resource group name. Limits discovery to this resource group.
			resourceGroup?: string

			// The subscription ID. Always required.
			subscriptionID!: strings.MinRunes(
						1)

			// Optional tenant ID. Only required with the OAuth authentication method.
			tenantID?: string

			// TLS configuration to use on every scrape request
			tlsConfig?: {
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
		}]

		// BasicAuth allow an endpoint to authenticate over basic authentication
		basicAuth?: {
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

		// File to read bearer token for scraping targets.
		bearerTokenFile?: string

		// Secret to mount to read bearer token for scraping targets. The secret
		// needs to be in the same namespace as the scrape object and accessible by
		// the victoria-metrics operator.
		bearerTokenSecret?:
			null | {
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

		// ConsulAgentSDConfigs defines a list of Consul Agent service discovery configurations.
		consulAgentSDConfigs?: [...{
			// Authorization header to use on every scrape request.
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

			// BasicAuth information to use on every scrape request.
			basicAuth?: {
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

			// Consul Datacenter name, if not provided it will use the local Consul Agent Datacenter.
			datacenter?: string

			// Filter defines filter for service discovery requests.
			// See https://developer.hashicorp.com/consul/api-docs/features/filtering
			filter?: string

			// Configure whether HTTP requests follow HTTP 3xx redirects.
			followRedirects?: bool

			// Namespaces are only supported in Consul Enterprise.
			namespace?: string

			// OAuth2 defines auth configuration
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

			// ProxyClientConfig configures proxy auth settings for scraping
			// See [feature
			// description](https://docs.victoriametrics.com/victoriametrics/vmagent/#scraping-targets-via-a-proxy)
			proxy_client_config?: {
				// Authorization with http header Authorization
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

				// BasicAuth allows proxy to authenticate over basic authentication
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

				// Secret to mount to read bearer token for scraping targets proxy auth. The secret
				// needs to be in the same namespace as the scrape object and accessible by
				// the victoria-metrics operator.
				bearer_token?:
					null | {
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

				// BearerTokenFile defines file to read bearer token from for proxy auth.
				bearer_token_file?: string

				// OAuth2 defines auth configuration
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

				// TLSConfig configuration to use when scraping the endpoint
				tls_config?: null | bool | number | string | [...] | {
					...
				}
			}

			// ProxyURL eg http://proxyserver:2195 Directs scrapes to proxy through this endpoint.
			proxyURL?: string

			// HTTP Scheme default "http"
			scheme?: "HTTP" | "HTTPS" | "http" | "https"

			// Server address of the Consul Agent. Defaults to localhost:8500.
			server?: string

			// A list of services for which targets are retrieved. If omitted, all services are scraped.
			services?: [...string]

			// The string by which Consul tags are joined into the tag label.
			tagSeparator?: string

			// TLS configuration to use on every scrape request
			tlsConfig?: {
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

			// Consul ACL TokenRef, if not provided it will use the ACL from the local Consul Agent.
			tokenRef?: {
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

		// ConsulSDConfigs defines a list of Consul service discovery configurations.
		consulSDConfigs?: [...{
			// Allow stale Consul results (see
			// https://developer.hashicorp.com/consul/api-docs/features/consistency ). Will
			// reduce load on Consul.
			// If unset, use its default value.
			allowStale?: bool

			// Authorization header to use on every scrape request.
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

			// BasicAuth information to use on every scrape request.
			basicAuth?: {
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

			// Consul Datacenter name, if not provided it will use the local Consul Agent Datacenter.
			datacenter?: string

			// Filter defines filter for /v1/catalog/services requests
			// See https://developer.hashicorp.com/consul/api-docs/features/filtering
			filter?: string

			// Configure whether HTTP requests follow HTTP 3xx redirects.
			followRedirects?: bool

			// Namespaces are only supported in Consul Enterprise.
			namespace?: string

			// Node metadata key/value pairs to filter nodes for a given service.
			nodeMeta?: [string]: string

			// OAuth2 defines auth configuration
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

			// Admin Partitions are only supported in Consul Enterprise.
			partition?: string

			// ProxyClientConfig configures proxy auth settings for scraping
			// See [feature
			// description](https://docs.victoriametrics.com/victoriametrics/vmagent/#scraping-targets-via-a-proxy)
			proxy_client_config?: {
				// Authorization with http header Authorization
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

				// BasicAuth allows proxy to authenticate over basic authentication
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

				// Secret to mount to read bearer token for scraping targets proxy auth. The secret
				// needs to be in the same namespace as the scrape object and accessible by
				// the victoria-metrics operator.
				bearer_token?:
					null | {
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

				// BearerTokenFile defines file to read bearer token from for proxy auth.
				bearer_token_file?: string

				// OAuth2 defines auth configuration
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

				// TLSConfig configuration to use when scraping the endpoint
				tls_config?: null | bool | number | string | [...] | {
					...
				}
			}

			// ProxyURL eg http://proxyserver:2195 Directs scrapes to proxy through this endpoint.
			proxyURL?: string

			// HTTP Scheme default "http"
			scheme?: "HTTP" | "HTTPS"

			// A valid string consisting of a hostname or IP followed by an optional port number.
			server!: strings.MinRunes(
					1)

			// A list of services for which targets are retrieved. If omitted, all services are scraped.
			services?: [...string]

			// The string by which Consul tags are joined into the tag label.
			// If unset, use its default value.
			tagSeparator?: string

			// An optional list of tags used to filter nodes for a given service. Services
			// must contain all tags in the list.
			tags?: [...string]

			// TLS configuration to use on every scrape request
			tlsConfig?: {
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

			// Consul ACL TokenRef, if not provided it will use the ACL from the local Consul Agent.
			tokenRef?: {
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

		// DigitalOceanSDConfigs defines a list of DigitalOcean service discovery configurations.
		digitalOceanSDConfigs?: [...{
			// Authorization header to use on every scrape request.
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

			// BasicAuth information to use on every scrape request.
			basicAuth?: {
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

			// Configure whether HTTP requests follow HTTP 3xx redirects.
			followRedirects?: bool

			// OAuth2 defines auth configuration
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

			// The port to scrape metrics from.
			port?: int32 & int

			// ProxyClientConfig configures proxy auth settings for scraping
			// See [feature
			// description](https://docs.victoriametrics.com/victoriametrics/vmagent/#scraping-targets-via-a-proxy)
			proxy_client_config?: {
				// Authorization with http header Authorization
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

				// BasicAuth allows proxy to authenticate over basic authentication
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

				// Secret to mount to read bearer token for scraping targets proxy auth. The secret
				// needs to be in the same namespace as the scrape object and accessible by
				// the victoria-metrics operator.
				bearer_token?:
					null | {
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

				// BearerTokenFile defines file to read bearer token from for proxy auth.
				bearer_token_file?: string

				// OAuth2 defines auth configuration
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

				// TLSConfig configuration to use when scraping the endpoint
				tls_config?: null | bool | number | string | [...] | {
					...
				}
			}

			// ProxyURL eg http://proxyserver:2195 Directs scrapes to proxy through this endpoint.
			proxyURL?: string

			// Server is an optional DigitalOcean API server to query.
			// By default, https://api.digitalocean.com is used.
			server?: string

			// TLS configuration to use on every scrape request
			tlsConfig?: {
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
		}]

		// DNSSDConfigs defines a list of DNS service discovery configurations.
		dnsSDConfigs?: [...{
			// A list of DNS domain names to be queried.
			names!: [...string] & [_, ...]

			// The port number used if the query type is not SRV
			// Ignored for SRV records
			port?: int32 & int
			type?: "SRV" | "A" | "AAAA" | "MX"
		}]

		// DockerSDConfigs defines a list of Docker service discovery configurations.
		dockerSDConfigs?: [...{
			// Authorization header to use on every scrape request.
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

			// BasicAuth information to use on every scrape request.
			basicAuth?: {
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

			// Filters are optional filters to limit the discovery process to a subset of available resources.
			filters?: [...{
				// Name of the filter.
				name!: string

				// Values for the filter.
				values!: [...string]
			}]

			// Configure whether HTTP requests follow HTTP 3xx redirects.
			followRedirects?: bool

			// Host to connect to the Docker daemon.
			// Defaults to unix:///var/run/docker.sock.
			host?: string

			// HostNetworkingHost is used when containers are in host networking mode.
			hostNetworkingHost?: string

			// MatchFirstNetwork controls whether to match the first network if there are multiple networks.
			matchFirstNetwork?: bool

			// OAuth2 defines auth configuration
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

			// Port to scrape metrics from, when containers expose multiple ports.
			port?: int32 & int

			// ProxyClientConfig configures proxy auth settings for scraping
			// See [feature
			// description](https://docs.victoriametrics.com/victoriametrics/vmagent/#scraping-targets-via-a-proxy)
			proxy_client_config?: {
				// Authorization with http header Authorization
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

				// BasicAuth allows proxy to authenticate over basic authentication
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

				// Secret to mount to read bearer token for scraping targets proxy auth. The secret
				// needs to be in the same namespace as the scrape object and accessible by
				// the victoria-metrics operator.
				bearer_token?:
					null | {
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

				// BearerTokenFile defines file to read bearer token from for proxy auth.
				bearer_token_file?: string

				// OAuth2 defines auth configuration
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

				// TLSConfig configuration to use when scraping the endpoint
				tls_config?: null | bool | number | string | [...] | {
					...
				}
			}

			// ProxyURL eg http://proxyserver:2195 Directs scrapes to proxy through this endpoint.
			proxyURL?: string

			// TLS configuration to use on every scrape request
			tlsConfig?: {
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
		}]

		// DockerSwarmSDConfigs defines a list of Docker Swarm service discovery configurations.
		dockerSwarmSDConfigs?: [...{
			// Authorization header to use on every scrape request.
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

			// BasicAuth information to use on every scrape request.
			basicAuth?: {
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

			// Filters are optional filters to limit the discovery process to a subset of available resources.
			filters?: [...{
				// Name of the filter.
				name!: string

				// Values for the filter.
				values!: [...string]
			}]

			// Configure whether HTTP requests follow HTTP 3xx redirects.
			followRedirects?: bool

			// Host to connect to the Docker daemon.
			host!: string

			// OAuth2 defines auth configuration
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

			// Port to scrape metrics from, when containers expose multiple ports.
			port?: int32 & int

			// ProxyClientConfig configures proxy auth settings for scraping
			// See [feature
			// description](https://docs.victoriametrics.com/victoriametrics/vmagent/#scraping-targets-via-a-proxy)
			proxy_client_config?: {
				// Authorization with http header Authorization
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

				// BasicAuth allows proxy to authenticate over basic authentication
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

				// Secret to mount to read bearer token for scraping targets proxy auth. The secret
				// needs to be in the same namespace as the scrape object and accessible by
				// the victoria-metrics operator.
				bearer_token?:
					null | {
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

				// BearerTokenFile defines file to read bearer token from for proxy auth.
				bearer_token_file?: string

				// OAuth2 defines auth configuration
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

				// TLSConfig configuration to use when scraping the endpoint
				tls_config?: null | bool | number | string | [...] | {
					...
				}
			}

			// ProxyURL eg http://proxyserver:2195 Directs scrapes to proxy through this endpoint.
			proxyURL?: string

			// Role of the target in Docker Swarm.
			role!: "services" | "tasks" | "nodes"

			// TLS configuration to use on every scrape request
			tlsConfig?: {
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
		}]

		// EC2SDConfigs defines a list of EC2 service discovery configurations.
		ec2SDConfigs?: [...{
			// AccessKey is the AWS API key.
			accessKey?: {
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

			// Filters can be used optionally to filter the instance list by other criteria.
			// Available filter criteria can be found here:
			// https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_DescribeInstances.html
			// Filter API documentation: https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_Filter.html
			filters?: [...{
				name!: string
				values!: [...string]
			}]

			// The port to scrape metrics from. If using the public IP address, this must
			// instead be specified in the relabeling rule.
			port?: int32 & int

			// The AWS region
			region?: string

			// AWS Role ARN, an alternative to using AWS API keys.
			roleARN?: string

			// SecretKey is the AWS API secret.
			secretKey?: {
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

		// EurekaSDConfigs defines a list of Eureka service discovery configurations.
		eurekaSDConfigs?: [...{
			// Authorization header to use on every scrape request.
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

			// BasicAuth information to use on every scrape request.
			basicAuth?: {
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

			// Configure whether HTTP requests follow HTTP 3xx redirects.
			followRedirects?: bool

			// OAuth2 defines auth configuration
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

			// ProxyClientConfig configures proxy auth settings for scraping
			// See [feature
			// description](https://docs.victoriametrics.com/victoriametrics/vmagent/#scraping-targets-via-a-proxy)
			proxy_client_config?: {
				// Authorization with http header Authorization
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

				// BasicAuth allows proxy to authenticate over basic authentication
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

				// Secret to mount to read bearer token for scraping targets proxy auth. The secret
				// needs to be in the same namespace as the scrape object and accessible by
				// the victoria-metrics operator.
				bearer_token?:
					null | {
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

				// BearerTokenFile defines file to read bearer token from for proxy auth.
				bearer_token_file?: string

				// OAuth2 defines auth configuration
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

				// TLSConfig configuration to use when scraping the endpoint
				tls_config?: null | bool | number | string | [...] | {
					...
				}
			}

			// ProxyURL eg http://proxyserver:2195 Directs scrapes to proxy through this endpoint.
			proxyURL?: string

			// Server is an optional URL to connect to the Eureka server.
			// By default, the http://localhost:8080/eureka/v2 is used.
			server?: string

			// TLS configuration to use on every scrape request
			tlsConfig?: {
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
		}]

		// FileSDConfigs defines a list of file service discovery configurations.
		fileSDConfigs?: [...{
			// List of files to be used for file discovery.
			files!: [...string] & [_, ...]
		}]

		// FollowRedirects controls redirects for scraping.
		follow_redirects?: bool

		// GCESDConfigs defines a list of GCE service discovery configurations.
		gceSDConfigs?: [...{
			// Filter can be used optionally to filter the instance list by other criteria
			// Syntax of this filter is described in the filter query parameter section:
			// https://cloud.google.com/compute/docs/reference/latest/instances/list
			filter?: string

			// The port to scrape metrics from. If using the public IP address, this must
			// instead be specified in the relabeling rule.
			port?: int32 & int

			// The Google Cloud Project ID
			project!: strings.MinRunes(
					1)

			// The tag separator is used to separate the tags on concatenation
			tagSeparator?: string

			// The zone of the scrape targets. If you need multiple zones use multiple GCESDConfigs.
			zone!: null | bool | number | string | [...] | {
				...
			}
		}]

		// HetznerSDConfigs defines a list of Hetzner service discovery configurations.
		hetznerSDConfigs?: [...{
			// Authorization header to use on every scrape request.
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

			// BasicAuth information to use on every scrape request.
			basicAuth?: {
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

			// Configure whether HTTP requests follow HTTP 3xx redirects.
			followRedirects?: bool

			// OAuth2 defines auth configuration
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

			// Port is an optional port to scrape metrics from
			port?: int32 & int

			// ProxyClientConfig configures proxy auth settings for scraping
			// See [feature
			// description](https://docs.victoriametrics.com/victoriametrics/vmagent/#scraping-targets-via-a-proxy)
			proxy_client_config?: {
				// Authorization with http header Authorization
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

				// BasicAuth allows proxy to authenticate over basic authentication
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

				// Secret to mount to read bearer token for scraping targets proxy auth. The secret
				// needs to be in the same namespace as the scrape object and accessible by
				// the victoria-metrics operator.
				bearer_token?:
					null | {
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

				// BearerTokenFile defines file to read bearer token from for proxy auth.
				bearer_token_file?: string

				// OAuth2 defines auth configuration
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

				// TLSConfig configuration to use when scraping the endpoint
				tls_config?: null | bool | number | string | [...] | {
					...
				}
			}

			// ProxyURL eg http://proxyserver:2195 Directs scrapes to proxy through this endpoint.
			proxyURL?: string

			// Role defines mandatory Hetzner role for entity discovery.
			role!: "robot" | "Robot" | "hcloud" | "Cloud"

			// TLS configuration to use on every scrape request
			tlsConfig?: {
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
		}]

		// HonorLabels chooses the metric's labels on collisions with target labels.
		honorLabels?: bool

		// HonorTimestamps controls whether vmagent or vmsingle respects the timestamps
		// present in scraped data.
		honorTimestamps?: bool

		// HTTPSDConfigs defines a list of HTTP service discovery configurations.
		httpSDConfigs?: [...{
			// Authorization header to use on every scrape request.
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

			// BasicAuth information to use on every scrape request.
			basicAuth?: {
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

			// Configure whether HTTP requests follow HTTP 3xx redirects.
			followRedirects?: bool

			// OAuth2 defines auth configuration
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

			// ProxyClientConfig configures proxy auth settings for scraping
			// See [feature
			// description](https://docs.victoriametrics.com/victoriametrics/vmagent/#scraping-targets-via-a-proxy)
			proxy_client_config?: {
				// Authorization with http header Authorization
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

				// BasicAuth allows proxy to authenticate over basic authentication
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

				// Secret to mount to read bearer token for scraping targets proxy auth. The secret
				// needs to be in the same namespace as the scrape object and accessible by
				// the victoria-metrics operator.
				bearer_token?:
					null | {
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

				// BearerTokenFile defines file to read bearer token from for proxy auth.
				bearer_token_file?: string

				// OAuth2 defines auth configuration
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

				// TLSConfig configuration to use when scraping the endpoint
				tls_config?: null | bool | number | string | [...] | {
					...
				}
			}

			// ProxyURL eg http://proxyserver:2195 Directs scrapes to proxy through this endpoint.
			proxyURL?: string

			// TLS configuration to use on every scrape request
			tlsConfig?: {
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

			// URL from which the targets are fetched.
			url!: strings.MinRunes(
				1) & =~"^http(s)?://.+$"
		}]

		// Interval at which metrics should be scraped
		interval?: string

		// KubernetesSDConfigs defines a list of Kubernetes service discovery configurations.
		kubernetesSDConfigs?: [...{
			// The API server address consisting of a hostname or IP address followed
			// by an optional port number.
			// If left empty, assuming process is running inside
			// of the cluster. It will discover API servers automatically and use the pod's
			// CA certificate and bearer token file at /var/run/secrets/kubernetes.io/serviceaccount/.
			apiServer?: string

			// AttachMetadata configures metadata attaching from service discovery
			attach_metadata?: {
				// Namespace instructs vmagent or vmsingle to add namespace specific metadata from service discovery
				// Valid for roles: pod, service, endpoints, endpointslice, ingress.
				namespace?: bool

				// Node instructs vmagent or vmsingle to add node specific metadata from service discovery
				// Valid for roles: pod, endpoints, endpointslice.
				node?: bool
			}

			// Authorization header to use on every scrape request.
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

			// BasicAuth information to use on every scrape request.
			basicAuth?: {
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

			// Configure whether HTTP requests follow HTTP 3xx redirects.
			followRedirects?: bool

			// Optional namespace discovery. If omitted, discover targets across all namespaces.
			namespaces?: {
				// List of namespaces where to watch for resources.
				// If empty and `ownNamespace` isn't true, watch for resources in all namespaces.
				names?: [...string]

				// Includes the namespace in which the pod exists to the list of watched namespaces.
				ownNamespace?: bool
			}

			// OAuth2 defines auth configuration
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

			// ProxyClientConfig configures proxy auth settings for scraping
			// See [feature
			// description](https://docs.victoriametrics.com/victoriametrics/vmagent/#scraping-targets-via-a-proxy)
			proxy_client_config?: {
				// Authorization with http header Authorization
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

				// BasicAuth allows proxy to authenticate over basic authentication
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

				// Secret to mount to read bearer token for scraping targets proxy auth. The secret
				// needs to be in the same namespace as the scrape object and accessible by
				// the victoria-metrics operator.
				bearer_token?:
					null | {
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

				// BearerTokenFile defines file to read bearer token from for proxy auth.
				bearer_token_file?: string

				// OAuth2 defines auth configuration
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

				// TLSConfig configuration to use when scraping the endpoint
				tls_config?: null | bool | number | string | [...] | {
					...
				}
			}

			// ProxyURL eg http://proxyserver:2195 Directs scrapes to proxy through this endpoint.
			proxyURL?: string

			// Role of the Kubernetes entities that should be discovered.
			role!: "node" | "pod" | "service" | "endpoints" | "endpointslice" | "ingress"

			// Selector to select objects.
			selectors?: [...{
				field?: string
				label?: string
				role!:  "node" | "pod" | "service" | "endpoints" | "endpointslice" | "ingress"
			}]

			// TLS configuration to use on every scrape request
			tlsConfig?: {
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
		}]

		// KumaSDConfigs defines a list of Kuma service discovery configurations.
		kumaSDConfigs?: [...{
			// Authorization header to use on every scrape request.
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

			// BasicAuth information to use on every scrape request.
			basicAuth?: {
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

			// ClientID is an optional client ID to send to Kuma Control Plane.
			// The hostname of the server where vmagent runs is used if it isn't set.
			// If the hostname is empty, then "vmagent" string is used as client_id.
			clientID?: string

			// Configure whether HTTP requests follow HTTP 3xx redirects.
			followRedirects?: bool

			// OAuth2 defines auth configuration
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

			// ProxyClientConfig configures proxy auth settings for scraping
			// See [feature
			// description](https://docs.victoriametrics.com/victoriametrics/vmagent/#scraping-targets-via-a-proxy)
			proxy_client_config?: {
				// Authorization with http header Authorization
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

				// BasicAuth allows proxy to authenticate over basic authentication
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

				// Secret to mount to read bearer token for scraping targets proxy auth. The secret
				// needs to be in the same namespace as the scrape object and accessible by
				// the victoria-metrics operator.
				bearer_token?:
					null | {
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

				// BearerTokenFile defines file to read bearer token from for proxy auth.
				bearer_token_file?: string

				// OAuth2 defines auth configuration
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

				// TLSConfig configuration to use when scraping the endpoint
				tls_config?: null | bool | number | string | [...] | {
					...
				}
			}

			// ProxyURL eg http://proxyserver:2195 Directs scrapes to proxy through this endpoint.
			proxyURL?: string

			// Server must contain the URL of Kuma Control Plane's MADS xDS server.
			server!: strings.MinRunes(
					1)

			// TLS configuration to use on every scrape request
			tlsConfig?: {
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
		}]

		// MarathonSDConfigs defines a list of Marathon service discovery configurations.
		marathonSDConfigs?: [...{
			// Authorization header to use on every scrape request.
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

			// BasicAuth information to use on every scrape request.
			basicAuth?: {
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

			// Configure whether HTTP requests follow HTTP 3xx redirects.
			followRedirects?: bool

			// OAuth2 defines auth configuration
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

			// ProxyClientConfig configures proxy auth settings for scraping
			// See [feature
			// description](https://docs.victoriametrics.com/victoriametrics/vmagent/#scraping-targets-via-a-proxy)
			proxy_client_config?: {
				// Authorization with http header Authorization
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

				// BasicAuth allows proxy to authenticate over basic authentication
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

				// Secret to mount to read bearer token for scraping targets proxy auth. The secret
				// needs to be in the same namespace as the scrape object and accessible by
				// the victoria-metrics operator.
				bearer_token?:
					null | {
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

				// BearerTokenFile defines file to read bearer token from for proxy auth.
				bearer_token_file?: string

				// OAuth2 defines auth configuration
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

				// TLSConfig configuration to use when scraping the endpoint
				tls_config?: null | bool | number | string | [...] | {
					...
				}
			}

			// ProxyURL eg http://proxyserver:2195 Directs scrapes to proxy through this endpoint.
			proxyURL?: string

			// Servers is a list of Marathon servers.
			servers!: [...string] & [_, ...]

			// TLS configuration to use on every scrape request
			tlsConfig?: {
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
		}]

		// MaxScrapeSize defines a maximum size of scraped data for a job
		max_scrape_size?: string

		// MetricRelabelConfigs to apply to samples after scrapping.
		metricRelabelConfigs?: [...{
			// Action to perform based on regex matching. Default is 'replace'
			action?: string

			// If represents metricsQL match expression (or list of expressions): '{__name__=~"foo_.*"}'
			if?: null | bool | number | string | [...] | {
				...
			}

			// Labels is used together with Match for `action: graphite`
			labels?: [string]: string

			// Match is used together with Labels for `action: graphite`
			match?: string

			// Modulus to take of the hash of the source label values.
			modulus?: int64 & int

			// Regular expression against which the extracted value is matched. Default is '(.*)'
			// victoriaMetrics supports multiline regex joined with |
			// https://docs.victoriametrics.com/victoriametrics/vmagent/#relabeling-enhancements
			regex?: null | bool | number | string | [...] | {
				...
			}

			// Replacement value against which a regex replace is performed if the
			// regular expression matches. Regex capture groups are available. Default is '$1'
			replacement?: string

			// Separator placed between concatenated source label values. default is ';'.
			separator?: string

			// UnderScoreSourceLabels - additional form of source labels source_labels
			// for compatibility with original relabel config.
			// if set both sourceLabels and source_labels, sourceLabels has priority.
			// for details https://github.com/VictoriaMetrics/operator/issues/131
			source_labels?: [...string]

			// The source labels select values from existing labels. Their content is concatenated
			// using the configured separator and matched against the configured regular expression
			// for the replace, keep, and drop actions.
			sourceLabels?: [...string]

			// UnderScoreTargetLabel - additional form of target label - target_label
			// for compatibility with original relabel config.
			// if set both targetLabel and target_label, targetLabel has priority.
			// for details https://github.com/VictoriaMetrics/operator/issues/131
			target_label?: string

			// Label to which the resulting value is written in a replace action.
			// It is mandatory for replace actions. Regex capture groups are available.
			targetLabel?: string
		}]

		// NomadSDConfigs defines a list of Nomad service discovery configurations.
		nomadSDConfigs?: [...{
			// Allow stale Nomad results to reduce load on Nomad.
			// If unset, use its default value.
			allowStale?: bool

			// Authorization header to use on every scrape request.
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

			// BasicAuth information to use on every scrape request.
			basicAuth?: {
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

			// Configure whether HTTP requests follow HTTP 3xx redirects.
			followRedirects?: bool

			// Namespace to use for Nomad service discovery.
			namespace?: string

			// OAuth2 defines auth configuration
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

			// ProxyClientConfig configures proxy auth settings for scraping
			// See [feature
			// description](https://docs.victoriametrics.com/victoriametrics/vmagent/#scraping-targets-via-a-proxy)
			proxy_client_config?: {
				// Authorization with http header Authorization
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

				// BasicAuth allows proxy to authenticate over basic authentication
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

				// Secret to mount to read bearer token for scraping targets proxy auth. The secret
				// needs to be in the same namespace as the scrape object and accessible by
				// the victoria-metrics operator.
				bearer_token?:
					null | {
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

				// BearerTokenFile defines file to read bearer token from for proxy auth.
				bearer_token_file?: string

				// OAuth2 defines auth configuration
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

				// TLSConfig configuration to use when scraping the endpoint
				tls_config?: null | bool | number | string | [...] | {
					...
				}
			}

			// ProxyURL eg http://proxyserver:2195 Directs scrapes to proxy through this endpoint.
			proxyURL?: string

			// Region to use for Nomad service discovery.
			region?: string

			// A valid string consisting of a hostname or IP followed by an optional port number.
			server!: strings.MinRunes(
					1)

			// The string by which Nomad tags are joined into the tag label.
			// If unset, use its default value.
			tagSeparator?: string

			// TLS configuration to use on every scrape request
			tlsConfig?: {
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
		}]

		// OAuth2 defines auth configuration
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

		// OpenStackSDConfigs defines a list of OpenStack service discovery configurations.
		openstackSDConfigs?: [...{
			// Whether the service discovery should list all instances for all projects.
			// It is only relevant for the 'instance' role and usually requires admin permissions.
			allTenants?: bool

			// ApplicationCredentialID
			applicationCredentialId?: string

			// The ApplicationCredentialID or ApplicationCredentialName fields are
			// required if using an application credential to authenticate. Some providers
			// allow you to create an application credential to authenticate rather than a
			// password.
			applicationCredentialName?: string

			// The applicationCredentialSecret field is required if using an application
			// credential to authenticate.
			applicationCredentialSecret?: {
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

			// Availability of the endpoint to connect to.
			availability?: "Public" | "public" | "Admin" | "admin" | "Internal" | "internal"

			// DomainID
			domainID?: string

			// At most one of domainId and domainName must be provided if using username
			// with Identity V3. Otherwise, either are optional.
			domainName?: string

			// IdentityEndpoint specifies the HTTP endpoint that is required to work with
			// the Identity API of the appropriate version.
			identityEndpoint?: string

			// Password for the Identity V2 and V3 APIs. Consult with your provider's
			// control panel to discover your account's preferred method of authentication.
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

			// The port to scrape metrics from. If using the public IP address, this must
			// instead be specified in the relabeling rule.
			port?: int32 & int

			// ProjectID
			projectID?: string

			// The ProjectId and ProjectName fields are optional for the Identity V2 API.
			// Some providers allow you to specify a ProjectName instead of the ProjectId.
			// Some require both. Your provider's authentication policies will determine
			// how these fields influence authentication.
			projectName?: string

			// The OpenStack Region.
			region!: strings.MinRunes(
					1)

			// The OpenStack role of entities that should be discovered.
			role!: "Instance" | "instance" | "Hypervisor" | "hypervisor"

			// TLS configuration to use on every scrape request
			tlsConfig?: {
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

			// UserID
			userid?: string

			// Username is required if using Identity V2 API. Consult with your provider's
			// control panel to discover your account's username.
			// In Identity V3, either userid or a combination of username
			// and domainId or domainName are needed
			username?: string
		}]

		// OVHCloudSDConfigs defines a list of OVH Cloud service discovery configurations.
		ovhcloudSDConfigs?: [...{
			// ApplicationKey defines a self generated token.
			applicationKey!: strings.MinRunes(
						1)

			// ApplicationSecret defines a generated secret.
			applicationSecret!: {
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

			// Authorization header to use on every scrape request.
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

			// BasicAuth information to use on every scrape request.
			basicAuth?: {
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

			// ConsumerKey holds user/app specific token
			consumerKey!: {
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

			// Endpoint defines OVH Cloud endpoint
			endpoint?: string

			// Configure whether HTTP requests follow HTTP 3xx redirects.
			followRedirects?: bool

			// OAuth2 defines auth configuration
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

			// ProxyClientConfig configures proxy auth settings for scraping
			// See [feature
			// description](https://docs.victoriametrics.com/victoriametrics/vmagent/#scraping-targets-via-a-proxy)
			proxy_client_config?: {
				// Authorization with http header Authorization
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

				// BasicAuth allows proxy to authenticate over basic authentication
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

				// Secret to mount to read bearer token for scraping targets proxy auth. The secret
				// needs to be in the same namespace as the scrape object and accessible by
				// the victoria-metrics operator.
				bearer_token?:
					null | {
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

				// BearerTokenFile defines file to read bearer token from for proxy auth.
				bearer_token_file?: string

				// OAuth2 defines auth configuration
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

				// TLSConfig configuration to use when scraping the endpoint
				tls_config?: null | bool | number | string | [...] | {
					...
				}
			}

			// ProxyURL eg http://proxyserver:2195 Directs scrapes to proxy through this endpoint.
			proxyURL?: string

			// Service could be either `vps` or `dedicated_server`
			service!: "vps" | "VPS" | "dedicated_server" | "DedicatedServer"

			// TLS configuration to use on every scrape request
			tlsConfig?: {
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
		}]

		// Optional HTTP URL parameters
		params?: [string]: [...string]

		// HTTP path to scrape for metrics.
		path?: string

		// ProxyURL eg http://proxyserver:2195 Directs scrapes to proxy through this endpoint.
		proxyURL?: string

		// PuppetDBSDConfigs defines a list of PuppetDB service discovery configurations.
		puppetDBSDConfigs?: [...{
			// Authorization header to use on every scrape request.
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

			// BasicAuth information to use on every scrape request.
			basicAuth?: {
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

			// Configure whether HTTP requests follow HTTP 3xx redirects.
			followRedirects?: bool

			// IncludeParameters defines if parameters should be included as meta labels.
			includeParameters?: bool

			// OAuth2 defines auth configuration
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

			// Port defines port to scrape metrics from
			port?: int32 & int

			// ProxyClientConfig configures proxy auth settings for scraping
			// See [feature
			// description](https://docs.victoriametrics.com/victoriametrics/vmagent/#scraping-targets-via-a-proxy)
			proxy_client_config?: {
				// Authorization with http header Authorization
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

				// BasicAuth allows proxy to authenticate over basic authentication
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

				// Secret to mount to read bearer token for scraping targets proxy auth. The secret
				// needs to be in the same namespace as the scrape object and accessible by
				// the victoria-metrics operator.
				bearer_token?:
					null | {
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

				// BearerTokenFile defines file to read bearer token from for proxy auth.
				bearer_token_file?: string

				// OAuth2 defines auth configuration
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

				// TLSConfig configuration to use when scraping the endpoint
				tls_config?: null | bool | number | string | [...] | {
					...
				}
			}

			// ProxyURL eg http://proxyserver:2195 Directs scrapes to proxy through this endpoint.
			proxyURL?: string

			// Query defines PQL query that allows to filter discovered resources.
			query!: string

			// TLS configuration to use on every scrape request
			tlsConfig?: {
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

			// URL of the PuppetDB root query endpoint
			url!: string
		}]

		// RelabelConfigs to apply to samples during service discovery.
		relabelConfigs?: [...{
			// Action to perform based on regex matching. Default is 'replace'
			action?: string

			// If represents metricsQL match expression (or list of expressions): '{__name__=~"foo_.*"}'
			if?: null | bool | number | string | [...] | {
				...
			}

			// Labels is used together with Match for `action: graphite`
			labels?: [string]: string

			// Match is used together with Labels for `action: graphite`
			match?: string

			// Modulus to take of the hash of the source label values.
			modulus?: int64 & int

			// Regular expression against which the extracted value is matched. Default is '(.*)'
			// victoriaMetrics supports multiline regex joined with |
			// https://docs.victoriametrics.com/victoriametrics/vmagent/#relabeling-enhancements
			regex?: null | bool | number | string | [...] | {
				...
			}

			// Replacement value against which a regex replace is performed if the
			// regular expression matches. Regex capture groups are available. Default is '$1'
			replacement?: string

			// Separator placed between concatenated source label values. default is ';'.
			separator?: string

			// UnderScoreSourceLabels - additional form of source labels source_labels
			// for compatibility with original relabel config.
			// if set both sourceLabels and source_labels, sourceLabels has priority.
			// for details https://github.com/VictoriaMetrics/operator/issues/131
			source_labels?: [...string]

			// The source labels select values from existing labels. Their content is concatenated
			// using the configured separator and matched against the configured regular expression
			// for the replace, keep, and drop actions.
			sourceLabels?: [...string]

			// UnderScoreTargetLabel - additional form of target label - target_label
			// for compatibility with original relabel config.
			// if set both targetLabel and target_label, targetLabel has priority.
			// for details https://github.com/VictoriaMetrics/operator/issues/131
			target_label?: string

			// Label to which the resulting value is written in a replace action.
			// It is mandatory for replace actions. Regex capture groups are available.
			targetLabel?: string
		}]

		// SampleLimit defines per-scrape limit on number of scraped samples that will be accepted.
		sampleLimit?: int

		// HTTP scheme to use for scraping.
		scheme?: "http" | "https" | "HTTPS" | "HTTP"

		// ScrapeInterval is the same as Interval and has priority over it.
		// one of scrape_interval or interval can be used
		scrape_interval?: string

		// ScrapeClass defined scrape class to apply
		scrapeClass?: string

		// Timeout after which the scrape is ended
		scrapeTimeout?: string

		// SeriesLimit defines per-scrape limit on number of unique time series
		// a single target can expose during all the scrapes on the time window of 24h.
		seriesLimit?: int

		// StaticConfigs defines a list of static targets with a common label set.
		staticConfigs?: [...{
			// Labels assigned to all metrics scraped from the targets.
			labels?: [string]: string

			// List of targets for this static configuration.
			targets?: [...string]
		}]

		// TLSConfig configuration to use when scraping the endpoint
		tlsConfig?: {
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

		// VMScrapeParams defines VictoriaMetrics specific scrape parameters
		vm_scrape_params?: {
			// DisableCompression
			disable_compression?: bool

			// disable_keepalive allows disabling HTTP keep-alive when scraping targets.
			// By default, HTTP keep-alive is enabled, so TCP connections to scrape targets
			// could be reused.
			// See https://docs.victoriametrics.com/victoriametrics/vmagent/#scrape_config-enhancements
			disable_keep_alive?: bool

			// Headers allows sending custom headers to scrape targets
			// must be in of semicolon separated header with it's value
			// eg:
			// headerName: headerValue
			// vmagent and vmsingle support since 1.79.0 version
			headers?: [...string]
			no_stale_markers?: bool

			// ProxyClientConfig configures proxy auth settings for scraping
			// See feature description
			// https://docs.victoriametrics.com/victoriametrics/vmagent/#scraping-targets-via-a-proxy
			proxy_client_config?: {
				// Authorization with http header Authorization
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

				// BasicAuth allows proxy to authenticate over basic authentication
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

				// Secret to mount to read bearer token for scraping targets proxy auth. The secret
				// needs to be in the same namespace as the scrape object and accessible by
				// the victoria-metrics operator.
				bearer_token?:
					null | {
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

				// BearerTokenFile defines file to read bearer token from for proxy auth.
				bearer_token_file?: string

				// OAuth2 defines auth configuration
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

				// TLSConfig configuration to use when scraping the endpoint
				tls_config?: null | bool | number | string | [...] | {
					...
				}
			}
			scrape_align_interval?: string
			scrape_offset?:         string
			stream_parse?:          bool
		}

		// VultrSDConfigs defines a list of Vultr service discovery configurations.
		vultrSDConfigs?: [...{
			// Authorization header to use on every scrape request.
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

			// BasicAuth information to use on every scrape request.
			basicAuth?: {
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

			// FirewallGroupID is an optional query arguments to filter instances by firewall group id.
			firewallGroupID?: string

			// Configure whether HTTP requests follow HTTP 3xx redirects.
			followRedirects?: bool

			// Hostname is an optional query arguments to filter instances by hostname.
			hostname?: string

			// Label is an optional query arguments to filter instances by label.
			label?: string

			// MainIP is an optional query arguments to filter instances by main ip address.
			mainIP?: string

			// OAuth2 defines auth configuration
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

			// Port is an optional port to scrape metrics from.
			port?: int32 & int

			// ProxyClientConfig configures proxy auth settings for scraping
			// See [feature
			// description](https://docs.victoriametrics.com/victoriametrics/vmagent/#scraping-targets-via-a-proxy)
			proxy_client_config?: {
				// Authorization with http header Authorization
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

				// BasicAuth allows proxy to authenticate over basic authentication
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

				// Secret to mount to read bearer token for scraping targets proxy auth. The secret
				// needs to be in the same namespace as the scrape object and accessible by
				// the victoria-metrics operator.
				bearer_token?:
					null | {
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

				// BearerTokenFile defines file to read bearer token from for proxy auth.
				bearer_token_file?: string

				// OAuth2 defines auth configuration
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

				// TLSConfig configuration to use when scraping the endpoint
				tls_config?: null | bool | number | string | [...] | {
					...
				}
			}

			// ProxyURL eg http://proxyserver:2195 Directs scrapes to proxy through this endpoint.
			proxyURL?: string

			// Region is an optional query arguments to filter instances by region id.
			region?: string

			// TLS configuration to use on every scrape request
			tlsConfig?: {
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
		}]

		// YandexCloudSDConfigs defines a list of Yandex Cloud service discovery configurations.
		yandexCloudSDConfigs?: [...{
			// APIEndpoint is the Yandex Cloud API endpoint.
			apiEndpoint?: string

			// FolderIDs are the Yandex Cloud folder IDs to discover resources in.
			folderIDs?: [...string]

			// Service is the Yandex Cloud service to discover targets for.
			service!: "compute" | "ydb"

			// TLSConfig to use on every scrape request.
			tlsConfig?: {
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

			// YandexPassportOAuthToken is the Yandex Passport OAuth token.
			yandexPassportOAuthToken?: {
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
	}

	// ScrapeObjectStatus defines the observed state of ScrapeObjects
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
	kind:       "VMScrapeConfig"
	metadata!: {
		name!:      string
		namespace!: string
		labels?: [string]: string
		annotations?: [string]: string
		...
	}
}
