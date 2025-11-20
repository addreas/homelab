package v1alpha1

import (
	"list"
	"strings"
)

#OAuth2Client: {
	_embeddedResource

	// APIVersion defines the versioned schema of this representation
	// of an object.
	// Servers should convert recognized schemas to the latest
	// internal value, and
	// may reject unrecognized values.
	// More info:
	// https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
	apiVersion?: string

	// Kind is a string value representing the REST resource this
	// object represents.
	// Servers may infer this from the endpoint the client submits
	// requests to.
	// Cannot be updated.
	// In CamelCase.
	// More info:
	// https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
	kind?: string
	metadata?: {}

	// OAuth2ClientSpec defines the desired state of OAuth2Client
	spec?: {
		// AccessTokenStrategy is the OAuth 2.0 Access Token Strategy
		accessTokenStrategy?: "jwt" | "opaque"

		// AllowedCorsOrigins is an array of allowed CORS origins
		allowedCorsOrigins?: [...=~"\\w+:/?/?[^\\s]+"]

		// Audience is a whitelist defining the audiences this client is
		// allowed to request tokens for
		audience?: [...string]

		// BackChannelLogoutSessionRequired Boolean value specifying
		// whether the RP requires that a sid (session ID) Claim be
		// included in the Logout Token to identify the RP session with
		// the OP when the backchannel_logout_uri is used. If omitted,
		// the default value is false.
		backChannelLogoutSessionRequired?: bool

		// BackChannelLogoutURI RP URL that will cause the RP to log
		// itself out when sent a Logout Token by the OP
		backChannelLogoutURI?: =~"(^$|^https?://.*)"

		// ClientName is the human-readable string name of the client to
		// be presented to the end-user during authorization.
		clientName?: string

		// ClientSecretExpiresAt is the timestamp when the client secret
		// expires (currently always 0)
		clientSecretExpiresAt?: int64 & int & >=0

		// ClientUri is a URL string of a web page providing information
		// about the client
		clientUri?: =~"(^$|^https?://.*)"

		// Contacts is an array of strings representing ways to contact
		// people responsible for this client
		contacts?: [...string]

		// Indicates if a deleted OAuth2Client custom resource should
		// delete the database row or not.
		// Values can be 'delete' to delete the OAuth2 client, value
		// 'orphan' to keep an orphan oauth2 client.
		deletionPolicy?: "delete" | "orphan"

		// FrontChannelLogoutSessionRequired Boolean value specifying
		// whether the RP requires that iss (issuer) and sid (session ID)
		// query parameters be included to identify the RP session with
		// the OP when the frontchannel_logout_uri is used
		frontChannelLogoutSessionRequired?: bool

		// FrontChannelLogoutURI RP URL that will cause the RP to log
		// itself out when rendered in an iframe by the OP. An iss
		// (issuer) query parameter and a sid (session ID) query
		// parameter MAY be included by the OP to enable the RP to
		// validate the request and to determine which of the potentially
		// multiple sessions is to be logged out; if either is included,
		// both MUST be
		frontChannelLogoutURI?: =~"(^$|^https?://.*)"

		// GrantTypes is an array of grant types the client is allowed to
		// use.
		grantTypes!: list.MaxItems(4) & [..."client_credentials" | "authorization_code" | "implicit" | "refresh_token"] & [_, ...]

		// HydraAdmin is the optional configuration to use for managing
		// this client
		hydraAdmin?: {
			// Endpoint is the endpoint for the hydra instance on which
			// to set up the client. This value will override the value
			// provided to `--endpoint` (defaults to `"/clients"` in the
			// application)
			endpoint?: =~"(^$|^/.*)"

			// ForwardedProto overrides the `--forwarded-proto` flag. The
			// value "off" will force this to be off even if
			// `--forwarded-proto` is specified
			forwardedProto?: =~"(^$|https?|off)"

			// Port is the port for the hydra instance on
			// which to set up the client. This value will override the value
			// provided to `--hydra-port`
			port?: int & <=65535

			// URL is the URL for the hydra instance on
			// which to set up the client. This value will override the value
			// provided to `--hydra-url`
			url?: strings.MaxRunes(
				256) & =~"(^$|^https?://.*)"
		}

		// JwksUri Define the URL where the JSON Web Key Set should be
		// fetched from when performing the private_key_jwt client
		// authentication method.
		jwksUri?: =~"(^$|^https?://.*)"

		// LogoUri is the URI to the logo of the client.
		// This is used to display the logo in the consent screen.
		// It should be a valid URL pointing to an image.
		logoUri?: =~"(^$|^https?://.*)"

		// Metadata is arbitrary data
		metadata?:
			null | {
				...
			}

		// PolicyUri is a URL string that points to a human-readable
		// privacy policy document
		policyUri?: =~"(^$|^https?://.*)"

		// PostLogoutRedirectURIs is an array of the post logout redirect
		// URIs allowed for the application
		postLogoutRedirectUris?: [...=~"\\w+:/?/?[^\\s]+"]

		// RedirectURIs is an array of the redirect URIs allowed for the
		// application
		redirectUris?: [...=~"\\w+:/?/?[^\\s]+"]

		// RequestObjectSigningAlg is the algorithm that must be used for
		// signing request objects
		requestObjectSigningAlg?: string

		// RequestURIs is an array of request URIs that can be used in
		// authorization requests
		requestUris?: [...=~"\\w+:/?/?[^\\s]+"]

		// ResponseTypes is an array of the OAuth 2.0 response type
		// strings that the client can
		// use at the authorization endpoint.
		responseTypes?: list.MaxItems(3) & [..."id_token" | "code" | "token" | "code token" | "code id_token" | "id_token token" | "code id_token token"] & [_, ...]

		// Scope is a string containing a space-separated list of scope
		// values (as
		// described in Section 3.3 of OAuth 2.0 [RFC6749]) that the
		// client
		// can use when requesting access tokens.
		// Use scopeArray instead.
		scope?: =~"([a-zA-Z0-9\\.\\*]+\\s?)*"

		// Scope is an array of scope values (as described in Section 3.3
		// of OAuth 2.0 [RFC6749])
		// that the client can use when requesting access tokens.
		scopeArray?: [...string]

		// SecretName points to the K8s secret that contains this client's
		// ID and password
		secretName!: strings.MaxRunes(
				253) & strings.MinRunes(
				1) & =~"[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*"

		// SectorIdentifierUri is a URL using the https scheme to be used
		// in calculating Pseudonymous Identifiers
		sectorIdentifierUri?: =~"(^$|^https?://.*)"

		// SkipConsent skips the consent screen for this client.
		skipConsent?: bool

		// SkipLogoutConsent skips asking the user to confirm the logout
		// request
		skipLogoutConsent?: bool

		// SubjectType is the requested subject type
		subjectType?: "public" | "pairwise"

		// Indication which authentication method should be used for the
		// token endpoint
		tokenEndpointAuthMethod?: matchN(2, ["client_secret_basic" | "client_secret_post" | "private_key_jwt" | "none", "client_secret_basic" | "client_secret_post" | "private_key_jwt" | "none"])

		// TokenEndpointAuthSigningAlg is the algorithm used to sign JWT
		// tokens for client authentication
		tokenEndpointAuthSigningAlg?: string

		// TokenLifespans is the configuration to use for managing
		// different token lifespans
		// depending on the used grant type.
		tokenLifespans?: {
			// AuthorizationCodeGrantAccessTokenLifespan is the access token
			// lifespan
			// issued on an authorization_code grant.
			authorization_code_grant_access_token_lifespan?: =~"[0-9]+(ns|us|ms|s|m|h)"

			// AuthorizationCodeGrantIdTokenLifespan is the id token lifespan
			// issued on an authorization_code grant.
			authorization_code_grant_id_token_lifespan?: =~"[0-9]+(ns|us|ms|s|m|h)"

			// AuthorizationCodeGrantRefreshTokenLifespan is the refresh token
			// lifespan
			// issued on an authorization_code grant.
			authorization_code_grant_refresh_token_lifespan?: =~"[0-9]+(ns|us|ms|s|m|h)"

			// AuthorizationCodeGrantRefreshTokenLifespan is the access token
			// lifespan
			// issued on a client_credentials grant.
			client_credentials_grant_access_token_lifespan?: =~"[0-9]+(ns|us|ms|s|m|h)"

			// ImplicitGrantAccessTokenLifespan is the access token lifespan
			// issued on an implicit grant.
			implicit_grant_access_token_lifespan?: =~"[0-9]+(ns|us|ms|s|m|h)"

			// ImplicitGrantIdTokenLifespan is the id token lifespan
			// issued on an implicit grant.
			implicit_grant_id_token_lifespan?: =~"[0-9]+(ns|us|ms|s|m|h)"

			// JwtBearerGrantAccessTokenLifespan is the access token lifespan
			// issued on a jwt_bearer grant.
			jwt_bearer_grant_access_token_lifespan?: =~"[0-9]+(ns|us|ms|s|m|h)"

			// RefreshTokenGrantAccessTokenLifespan is the access token
			// lifespan
			// issued on a refresh_token grant.
			refresh_token_grant_access_token_lifespan?: =~"[0-9]+(ns|us|ms|s|m|h)"

			// RefreshTokenGrantIdTokenLifespan is the id token lifespan
			// issued on a refresh_token grant.
			refresh_token_grant_id_token_lifespan?: =~"[0-9]+(ns|us|ms|s|m|h)"

			// RefreshTokenGrantRefreshTokenLifespan is the refresh token
			// lifespan
			// issued on a refresh_token grant.
			refresh_token_grant_refresh_token_lifespan?: =~"[0-9]+(ns|us|ms|s|m|h)"
		}

		// TosUri is a URL string that points to a human-readable terms of
		// service document
		tosUri?: =~"(^$|^https?://.*)"

		// UserinfoSignedResponseAlg is the algorithm used to sign
		// UserInfo responses
		userinfoSignedResponseAlg?: string
	}

	// OAuth2ClientStatus defines the observed state of OAuth2Client
	status?: {
		conditions?: [...{
			status!: "True" | "False" | "Unknown"
			type!:   string
		}]

		// ObservedGeneration represents the most recent generation
		// observed by the daemon set controller.
		observedGeneration?: int64 & int

		// ReconciliationError represents an error that occurred during
		// the reconciliation process
		reconciliationError?: {
			// Description is the description of the reconciliation error
			description?: string

			// Code is the status code of the reconciliation error
			statusCode?: string
		}
	}

	_embeddedResource: {
		apiVersion!: string
		kind!:       string
		metadata?: {
			...
		}
	}
	apiVersion: "hydra.ory.sh/v1alpha1"
	kind:       "OAuth2Client"
	metadata!: {
		name!:      string
		namespace!: string
		labels?: [string]: string
		annotations?: [string]: string
		...
	}
}
