package v1beta1

import (
	"list"
	"strings"
	"time"
)

#HTTPRoute: {
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

	// Spec defines the desired state of HTTPRoute.
	spec!: {
		// Hostnames defines a set of hostnames that should match against
		// the HTTP Host
		// header to select a HTTPRoute used to process the request.
		// Implementations
		// MUST ignore any port value specified in the HTTP Host header
		// while
		// performing a match and (absent of any applicable header
		// modification
		// configuration) MUST forward this header unmodified to the
		// backend.
		//
		// Valid values for Hostnames are determined by RFC 1123
		// definition of a
		// hostname with 2 notable exceptions:
		//
		// 1. IPs are not allowed.
		// 2. A hostname may be prefixed with a wildcard label (`*.`). The
		// wildcard
		// label must appear by itself as the first label.
		//
		// If a hostname is specified by both the Listener and HTTPRoute,
		// there
		// must be at least one intersecting hostname for the HTTPRoute to
		// be
		// attached to the Listener. For example:
		//
		// * A Listener with `test.example.com` as the hostname matches
		// HTTPRoutes
		// that have either not specified any hostnames, or have specified
		// at
		// least one of `test.example.com` or `*.example.com`.
		// * A Listener with `*.example.com` as the hostname matches
		// HTTPRoutes
		// that have either not specified any hostnames or have specified
		// at least
		// one hostname that matches the Listener hostname. For example,
		// `*.example.com`, `test.example.com`, and `foo.test.example.com`
		// would
		// all match. On the other hand, `example.com` and
		// `test.example.net` would
		// not match.
		//
		// Hostnames that are prefixed with a wildcard label (`*.`) are
		// interpreted
		// as a suffix match. That means that a match for `*.example.com`
		// would match
		// both `test.example.com`, and `foo.test.example.com`, but not
		// `example.com`.
		//
		// If both the Listener and HTTPRoute have specified hostnames,
		// any
		// HTTPRoute hostnames that do not match the Listener hostname
		// MUST be
		// ignored. For example, if a Listener specified `*.example.com`,
		// and the
		// HTTPRoute specified `test.example.com` and `test.example.net`,
		// `test.example.net` must not be considered for a match.
		//
		// If both the Listener and HTTPRoute have specified hostnames,
		// and none
		// match with the criteria above, then the HTTPRoute is not
		// accepted. The
		// implementation must raise an 'Accepted' Condition with a status
		// of
		// `False` in the corresponding RouteParentStatus.
		//
		// In the event that multiple HTTPRoutes specify intersecting
		// hostnames (e.g.
		// overlapping wildcard matching and exact matching hostnames),
		// precedence must
		// be given to rules from the HTTPRoute with the largest number
		// of:
		//
		// * Characters in a matching non-wildcard hostname.
		// * Characters in a matching hostname.
		//
		// If ties exist across multiple Routes, the matching precedence
		// rules for
		// HTTPRouteMatches takes over.
		//
		// Support: Core
		hostnames?: list.MaxItems(16) & [...strings.MaxRunes(
			253) & strings.MinRunes(
			1) & =~"^(\\*\\.)?[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"]

		// ParentRefs references the resources (usually Gateways) that a
		// Route wants
		// to be attached to. Note that the referenced parent resource
		// needs to
		// allow this for the attachment to be complete. For Gateways,
		// that means
		// the Gateway needs to allow attachment from Routes of this kind
		// and
		// namespace. For Services, that means the Service must either be
		// in the same
		// namespace for a "producer" route, or the mesh implementation
		// must support
		// and allow "consumer" routes for the referenced Service.
		// ReferenceGrant is
		// not applicable for governing ParentRefs to Services - it is not
		// possible to
		// create a "producer" route for a Service in a different
		// namespace from the
		// Route.
		//
		// There are two kinds of parent resources with "Core" support:
		//
		// * Gateway (Gateway conformance profile)
		// * Service (Mesh conformance profile, ClusterIP Services only)
		//
		// This API may be extended in the future to support additional
		// kinds of parent
		// resources.
		//
		// ParentRefs must be _distinct_. This means either that:
		//
		// * They select different objects. If this is the case, then
		// parentRef
		// entries are distinct. In terms of fields, this means that the
		// multi-part key defined by `group`, `kind`, `namespace`, and
		// `name` must
		// be unique across all parentRef entries in the Route.
		// * They do not select different objects, but for each optional
		// field used,
		// each ParentRef that selects the same object must set the same
		// set of
		// optional fields to different values. If one ParentRef sets a
		// combination of optional fields, all must set the same
		// combination.
		//
		// Some examples:
		//
		// * If one ParentRef sets `sectionName`, all ParentRefs
		// referencing the
		// same object must also set `sectionName`.
		// * If one ParentRef sets `port`, all ParentRefs referencing the
		// same
		// object must also set `port`.
		// * If one ParentRef sets `sectionName` and `port`, all
		// ParentRefs
		// referencing the same object must also set `sectionName` and
		// `port`.
		//
		// It is possible to separately reference multiple distinct
		// objects that may
		// be collapsed by an implementation. For example, some
		// implementations may
		// choose to merge compatible Gateway Listeners together. If that
		// is the
		// case, the list of routes attached to those resources should
		// also be
		// merged.
		//
		// Note that for ParentRefs that cross namespace boundaries, there
		// are specific
		// rules. Cross-namespace references are only valid if they are
		// explicitly
		// allowed by something in the namespace they are referring to.
		// For example,
		// Gateway has the AllowedRoutes field, and ReferenceGrant
		// provides a
		// generic way to enable other kinds of cross-namespace reference.
		parentRefs?: list.MaxItems(32) & [...{
			// Group is the group of the referent.
			// When unspecified, "gateway.networking.k8s.io" is inferred.
			// To set the core API group (such as for a "Service" kind
			// referent),
			// Group must be explicitly set to "" (empty string).
			//
			// Support: Core
			group?: strings.MaxRunes(
				253) & =~"^$|^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

			// Kind is kind of the referent.
			//
			// There are two kinds of parent resources with "Core" support:
			//
			// * Gateway (Gateway conformance profile)
			// * Service (Mesh conformance profile, ClusterIP Services only)
			//
			// Support for other resources is Implementation-Specific.
			kind?: strings.MaxRunes(
				63) & strings.MinRunes(
				1) & =~"^[a-zA-Z]([-a-zA-Z0-9]*[a-zA-Z0-9])?$"

			// Name is the name of the referent.
			//
			// Support: Core
			name!: strings.MaxRunes(
				253) & strings.MinRunes(
				1)

			// Namespace is the namespace of the referent. When unspecified,
			// this refers
			// to the local namespace of the Route.
			//
			// Note that there are specific rules for ParentRefs which cross
			// namespace
			// boundaries. Cross-namespace references are only valid if they
			// are explicitly
			// allowed by something in the namespace they are referring to.
			// For example:
			// Gateway has the AllowedRoutes field, and ReferenceGrant
			// provides a
			// generic way to enable any other kind of cross-namespace
			// reference.
			//
			// Support: Core
			namespace?: strings.MaxRunes(
					63) & strings.MinRunes(
					1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"

			// Port is the network port this Route targets. It can be
			// interpreted
			// differently based on the type of parent resource.
			//
			// When the parent resource is a Gateway, this targets all
			// listeners
			// listening on the specified port that also support this kind of
			// Route(and
			// select this Route). It's not recommended to set `Port` unless
			// the
			// networking behaviors specified in a Route must apply to a
			// specific port
			// as opposed to a listener(s) whose port(s) may be changed. When
			// both Port
			// and SectionName are specified, the name and port of the
			// selected listener
			// must match both specified values.
			//
			// Implementations MAY choose to support other parent resources.
			// Implementations supporting other types of parent resources MUST
			// clearly
			// document how/if Port is interpreted.
			//
			// For the purpose of status, an attachment is considered
			// successful as
			// long as the parent resource accepts it partially. For example,
			// Gateway
			// listeners can restrict which Routes can attach to them by Route
			// kind,
			// namespace, or hostname. If 1 of 2 Gateway listeners accept
			// attachment
			// from the referencing Route, the Route MUST be considered
			// successfully
			// attached. If no Gateway listeners accept attachment from this
			// Route,
			// the Route MUST be considered detached from the Gateway.
			//
			// Support: Extended
			port?: int32 & int & <=65535 & >=1

			// SectionName is the name of a section within the target
			// resource. In the
			// following resources, SectionName is interpreted as the
			// following:
			//
			// * Gateway: Listener name. When both Port (experimental) and
			// SectionName
			// are specified, the name and port of the selected listener must
			// match
			// both specified values.
			// * Service: Port name. When both Port (experimental) and
			// SectionName
			// are specified, the name and port of the selected listener must
			// match
			// both specified values.
			//
			// Implementations MAY choose to support attaching Routes to other
			// resources.
			// If that is the case, they MUST clearly document how SectionName
			// is
			// interpreted.
			//
			// When unspecified (empty string), this will reference the entire
			// resource.
			// For the purpose of status, an attachment is considered
			// successful if at
			// least one section in the parent resource accepts it. For
			// example, Gateway
			// listeners can restrict which Routes can attach to them by Route
			// kind,
			// namespace, or hostname. If 1 of 2 Gateway listeners accept
			// attachment from
			// the referencing Route, the Route MUST be considered
			// successfully
			// attached. If no Gateway listeners accept attachment from this
			// Route, the
			// Route MUST be considered detached from the Gateway.
			//
			// Support: Core
			sectionName?: strings.MaxRunes(
					253) & strings.MinRunes(
					1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
		}]

		// Rules are a list of HTTP matchers, filters and actions.
		rules?: list.MaxItems(16) & [...{
			// BackendRefs defines the backend(s) where matching requests
			// should be
			// sent.
			//
			// Failure behavior here depends on how many BackendRefs are
			// specified and
			// how many are invalid.
			//
			// If *all* entries in BackendRefs are invalid, and there are also
			// no filters
			// specified in this route rule, *all* traffic which matches this
			// rule MUST
			// receive a 500 status code.
			//
			// See the HTTPBackendRef definition for the rules about what
			// makes a single
			// HTTPBackendRef invalid.
			//
			// When a HTTPBackendRef is invalid, 500 status codes MUST be
			// returned for
			// requests that would have otherwise been routed to an invalid
			// backend. If
			// multiple backends are specified, and some are invalid, the
			// proportion of
			// requests that would otherwise have been routed to an invalid
			// backend
			// MUST receive a 500 status code.
			//
			// For example, if two backends are specified with equal weights,
			// and one is
			// invalid, 50 percent of traffic must receive a 500.
			// Implementations may
			// choose how that 50 percent is determined.
			//
			// When a HTTPBackendRef refers to a Service that has no ready
			// endpoints,
			// implementations SHOULD return a 503 for requests to that
			// backend instead.
			// If an implementation chooses to do this, all of the above rules
			// for 500 responses
			// MUST also apply for responses that return a 503.
			//
			// Support: Core for Kubernetes Service
			//
			// Support: Extended for Kubernetes ServiceImport
			//
			// Support: Implementation-specific for any other resource
			//
			// Support for weight: Core
			backendRefs?: list.MaxItems(16) & [...{
				// Filters defined at this level should be executed if and only if
				// the
				// request is being forwarded to the backend defined here.
				//
				// Support: Implementation-specific (For broader support of
				// filters, use the
				// Filters field in HTTPRouteRule.)
				filters?: list.MaxItems(16) & [...{
					// CORS defines a schema for a filter that responds to the
					// cross-origin request based on HTTP response header.
					//
					// Support: Extended
					cors?: {
						// AllowCredentials indicates whether the actual cross-origin
						// request allows
						// to include credentials.
						//
						// When set to true, the gateway will include the
						// `Access-Control-Allow-Credentials`
						// response header with value true (case-sensitive).
						//
						// When set to false or omitted the gateway will omit the header
						// `Access-Control-Allow-Credentials` entirely (this is the
						// standard CORS
						// behavior).
						//
						// Support: Extended
						allowCredentials?: bool

						// AllowHeaders indicates which HTTP request headers are supported
						// for
						// accessing the requested resource.
						//
						// Header names are not case-sensitive.
						//
						// Multiple header names in the value of the
						// `Access-Control-Allow-Headers`
						// response header are separated by a comma (",").
						//
						// When the `AllowHeaders` field is configured with one or more
						// headers, the
						// gateway must return the `Access-Control-Allow-Headers` response
						// header
						// which value is present in the `AllowHeaders` field.
						//
						// If any header name in the `Access-Control-Request-Headers`
						// request header
						// is not included in the list of header names specified by the
						// response
						// header `Access-Control-Allow-Headers`, it will present an error
						// on the
						// client side.
						//
						// If any header name in the `Access-Control-Allow-Headers`
						// response header
						// does not recognize by the client, it will also occur an error
						// on the
						// client side.
						//
						// A wildcard indicates that the requests with all HTTP headers
						// are allowed.
						// If config contains the wildcard "*" in allowHeaders and the
						// request is
						// not credentialed, the `Access-Control-Allow-Headers` response
						// header
						// can either use the `*` wildcard or the value of
						// Access-Control-Request-Headers from the request.
						//
						// When the request is credentialed, the gateway must not specify
						// the `*`
						// wildcard in the `Access-Control-Allow-Headers` response header.
						// When
						// also the `AllowCredentials` field is true and `AllowHeaders`
						// field
						// is specified with the `*` wildcard, the gateway must specify
						// one or more
						// HTTP headers in the value of the `Access-Control-Allow-Headers`
						// response
						// header. The value of the header `Access-Control-Allow-Headers`
						// is same as
						// the `Access-Control-Request-Headers` header provided by the
						// client. If
						// the header `Access-Control-Request-Headers` is not included in
						// the
						// request, the gateway will omit the
						// `Access-Control-Allow-Headers`
						// response header, instead of specifying the `*` wildcard.
						//
						// Support: Extended
						allowHeaders?: list.MaxItems(64) & [...strings.MaxRunes(
							256) & strings.MinRunes(
							1) & =~"^[A-Za-z0-9!#$%&'*+\\-.^_\\x60|~]+$"]

						// AllowMethods indicates which HTTP methods are supported for
						// accessing the
						// requested resource.
						//
						// Valid values are any method defined by RFC9110, along with the
						// special
						// value `*`, which represents all HTTP methods are allowed.
						//
						// Method names are case-sensitive, so these values are also
						// case-sensitive.
						// (See https://www.rfc-editor.org/rfc/rfc2616#section-5.1.1)
						//
						// Multiple method names in the value of the
						// `Access-Control-Allow-Methods`
						// response header are separated by a comma (",").
						//
						// A CORS-safelisted method is a method that is `GET`, `HEAD`, or
						// `POST`.
						// (See https://fetch.spec.whatwg.org/#cors-safelisted-method) The
						// CORS-safelisted methods are always allowed, regardless of
						// whether they
						// are specified in the `AllowMethods` field.
						//
						// When the `AllowMethods` field is configured with one or more
						// methods, the
						// gateway must return the `Access-Control-Allow-Methods` response
						// header
						// which value is present in the `AllowMethods` field.
						//
						// If the HTTP method of the `Access-Control-Request-Method`
						// request header
						// is not included in the list of methods specified by the
						// response header
						// `Access-Control-Allow-Methods`, it will present an error on the
						// client
						// side.
						//
						// If config contains the wildcard "*" in allowMethods and the
						// request is
						// not credentialed, the `Access-Control-Allow-Methods` response
						// header
						// can either use the `*` wildcard or the value of
						// Access-Control-Request-Method from the request.
						//
						// When the request is credentialed, the gateway must not specify
						// the `*`
						// wildcard in the `Access-Control-Allow-Methods` response header.
						// When
						// also the `AllowCredentials` field is true and `AllowMethods`
						// field
						// specified with the `*` wildcard, the gateway must specify one
						// HTTP method
						// in the value of the Access-Control-Allow-Methods response
						// header. The
						// value of the header `Access-Control-Allow-Methods` is same as
						// the
						// `Access-Control-Request-Method` header provided by the client.
						// If the
						// header `Access-Control-Request-Method` is not included in the
						// request,
						// the gateway will omit the `Access-Control-Allow-Methods`
						// response header,
						// instead of specifying the `*` wildcard.
						//
						// Support: Extended
						allowMethods?: list.MaxItems(9) & [..."GET" | "HEAD" | "POST" | "PUT" | "DELETE" | "CONNECT" | "OPTIONS" | "TRACE" | "PATCH" | "*"]

						// AllowOrigins indicates whether the response can be shared with
						// requested
						// resource from the given `Origin`.
						//
						// The `Origin` consists of a scheme and a host, with an optional
						// port, and
						// takes the form `<scheme>://<host>(:<port>)`.
						//
						// Valid values for scheme are: `http` and `https`.
						//
						// Valid values for port are any integer between 1 and 65535 (the
						// list of
						// available TCP/UDP ports). Note that, if not included, port `80`
						// is
						// assumed for `http` scheme origins, and port `443` is assumed
						// for `https`
						// origins. This may affect origin matching.
						//
						// The host part of the origin may contain the wildcard character
						// `*`. These
						// wildcard characters behave as follows:
						//
						// * `*` is a greedy match to the _left_, including any number of
						// DNS labels to the left of its position. This also means that
						// `*` will include any number of period `.` characters to the
						// left of its position.
						// * A wildcard by itself matches all hosts.
						//
						// An origin value that includes _only_ the `*` character
						// indicates requests
						// from all `Origin`s are allowed.
						//
						// When the `AllowOrigins` field is configured with multiple
						// origins, it
						// means the server supports clients from multiple origins. If the
						// request
						// `Origin` matches the configured allowed origins, the gateway
						// must return
						// the given `Origin` and sets value of the header
						// `Access-Control-Allow-Origin` same as the `Origin` header
						// provided by the
						// client.
						//
						// The status code of a successful response to a "preflight"
						// request is
						// always an OK status (i.e., 204 or 200).
						//
						// If the request `Origin` does not match the configured allowed
						// origins,
						// the gateway returns 204/200 response but doesn't set the
						// relevant
						// cross-origin response headers. Alternatively, the gateway
						// responds with
						// 403 status to the "preflight" request is denied, coupled with
						// omitting
						// the CORS headers. The cross-origin request fails on the client
						// side.
						// Therefore, the client doesn't attempt the actual cross-origin
						// request.
						//
						// Conversely, if the request `Origin` matches one of the
						// configured
						// allowed origins, the gateway sets the response header
						// `Access-Control-Allow-Origin` to the same value as the `Origin`
						// header provided by the client.
						//
						// When config has the wildcard ("*") in allowOrigins, and the
						// request
						// is not credentialed (e.g., it is a preflight request), the
						// `Access-Control-Allow-Origin` response header either contains
						// the
						// wildcard as well or the Origin from the request.
						//
						// When the request is credentialed, the gateway must not specify
						// the `*`
						// wildcard in the `Access-Control-Allow-Origin` response header.
						// When
						// also the `AllowCredentials` field is true and `AllowOrigins`
						// field
						// specified with the `*` wildcard, the gateway must return a
						// single origin
						// in the value of the `Access-Control-Allow-Origin` response
						// header,
						// instead of specifying the `*` wildcard. The value of the header
						// `Access-Control-Allow-Origin` is same as the `Origin` header
						// provided by
						// the client.
						//
						// Support: Extended
						allowOrigins?: list.MaxItems(64) & [...strings.MaxRunes(
							253) & strings.MinRunes(
							1) & =~"(^\\*$)|(^(http(s)?):\\/\\/(((\\*\\.)?([a-zA-Z0-9\\-]+\\.)*[a-zA-Z0-9-]+|\\*)(:([0-9]{1,5}))?)$)"]

						// ExposeHeaders indicates which HTTP response headers can be
						// exposed
						// to client-side scripts in response to a cross-origin request.
						//
						// A CORS-safelisted response header is an HTTP header in a CORS
						// response
						// that it is considered safe to expose to the client scripts.
						// The CORS-safelisted response headers include the following
						// headers:
						// `Cache-Control`
						// `Content-Language`
						// `Content-Length`
						// `Content-Type`
						// `Expires`
						// `Last-Modified`
						// `Pragma`
						// (See
						// https://fetch.spec.whatwg.org/#cors-safelisted-response-header-name)
						// The CORS-safelisted response headers are exposed to client by
						// default.
						//
						// When an HTTP header name is specified using the `ExposeHeaders`
						// field,
						// this additional header will be exposed as part of the response
						// to the
						// client.
						//
						// Header names are not case-sensitive.
						//
						// Multiple header names in the value of the
						// `Access-Control-Expose-Headers`
						// response header are separated by a comma (",").
						//
						// A wildcard indicates that the responses with all HTTP headers
						// are exposed
						// to clients. The `Access-Control-Expose-Headers` response header
						// can only
						// use `*` wildcard as value when the request is not credentialed.
						//
						// When the `exposeHeaders` config field contains the "*" wildcard
						// and
						// the request is credentialed, the gateway cannot use the `*`
						// wildcard in
						// the `Access-Control-Expose-Headers` response header.
						//
						// Support: Extended
						exposeHeaders?: list.MaxItems(64) & [...strings.MaxRunes(
							256) & strings.MinRunes(
							1) & =~"^[A-Za-z0-9!#$%&'*+\\-.^_\\x60|~]+$"]

						// MaxAge indicates the duration (in seconds) for the client to
						// cache the
						// results of a "preflight" request.
						//
						// The information provided by the `Access-Control-Allow-Methods`
						// and
						// `Access-Control-Allow-Headers` response headers can be cached
						// by the
						// client until the time specified by `Access-Control-Max-Age`
						// elapses.
						//
						// The default value of `Access-Control-Max-Age` response header
						// is 5
						// (seconds).
						//
						// When the `MaxAge` field is unspecified, the gateway sets the
						// response
						// header "Access-Control-Max-Age: 5" by default.
						maxAge?: int32 & int & >=1
					}

					// ExtensionRef is an optional, implementation-specific extension
					// to the
					// "filter" behavior. For example, resource "myroutefilter" in
					// group
					// "networking.example.net"). ExtensionRef MUST NOT be used for
					// core and
					// extended filters.
					//
					// This filter can be used multiple times within the same rule.
					//
					// Support: Implementation-specific
					extensionRef?: {
						// Group is the group of the referent. For example,
						// "gateway.networking.k8s.io".
						// When unspecified or empty string, core API group is inferred.
						group!: strings.MaxRunes(
							253) & =~"^$|^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

						// Kind is kind of the referent. For example "HTTPRoute" or
						// "Service".
						kind!: strings.MaxRunes(
							63) & strings.MinRunes(
							1) & =~"^[a-zA-Z]([-a-zA-Z0-9]*[a-zA-Z0-9])?$"

						// Name is the name of the referent.
						name!: strings.MaxRunes(
							253) & strings.MinRunes(
							1)
					}

					// RequestHeaderModifier defines a schema for a filter that
					// modifies request
					// headers.
					//
					// Support: Core
					requestHeaderModifier?: {
						// Add adds the given header(s) (name, value) to the request
						// before the action. It appends to any existing values associated
						// with the header name.
						//
						// Input:
						// GET /foo HTTP/1.1
						// my-header: foo
						//
						// Config:
						// add:
						// - name: "my-header"
						// value: "bar,baz"
						//
						// Output:
						// GET /foo HTTP/1.1
						// my-header: foo,bar,baz
						add?: list.MaxItems(16) & [...{
							// Name is the name of the HTTP Header to be matched. Name
							// matching MUST be
							// case-insensitive. (See
							// https://tools.ietf.org/html/rfc7230#section-3.2).
							//
							// If multiple entries specify equivalent header names, the first
							// entry with
							// an equivalent name MUST be considered for a match. Subsequent
							// entries
							// with an equivalent header name MUST be ignored. Due to the
							// case-insensitivity of header names, "foo" and "Foo" are
							// considered
							// equivalent.
							name!: strings.MaxRunes(
								256) & strings.MinRunes(
								1) & =~"^[A-Za-z0-9!#$%&'*+\\-.^_\\x60|~]+$"

							// Value is the value of HTTP Header to be matched.
							value!: strings.MaxRunes(
								4096) & strings.MinRunes(
								1)
						}]

						// Remove the given header(s) from the HTTP request before the
						// action. The
						// value of Remove is a list of HTTP header names. Note that the
						// header
						// names are case-insensitive (see
						// https://datatracker.ietf.org/doc/html/rfc2616#section-4.2).
						//
						// Input:
						// GET /foo HTTP/1.1
						// my-header1: foo
						// my-header2: bar
						// my-header3: baz
						//
						// Config:
						// remove: ["my-header1", "my-header3"]
						//
						// Output:
						// GET /foo HTTP/1.1
						// my-header2: bar
						remove?: list.MaxItems(16) & [...string]

						// Set overwrites the request with the given header (name, value)
						// before the action.
						//
						// Input:
						// GET /foo HTTP/1.1
						// my-header: foo
						//
						// Config:
						// set:
						// - name: "my-header"
						// value: "bar"
						//
						// Output:
						// GET /foo HTTP/1.1
						// my-header: bar
						set?: list.MaxItems(16) & [...{
							// Name is the name of the HTTP Header to be matched. Name
							// matching MUST be
							// case-insensitive. (See
							// https://tools.ietf.org/html/rfc7230#section-3.2).
							//
							// If multiple entries specify equivalent header names, the first
							// entry with
							// an equivalent name MUST be considered for a match. Subsequent
							// entries
							// with an equivalent header name MUST be ignored. Due to the
							// case-insensitivity of header names, "foo" and "Foo" are
							// considered
							// equivalent.
							name!: strings.MaxRunes(
								256) & strings.MinRunes(
								1) & =~"^[A-Za-z0-9!#$%&'*+\\-.^_\\x60|~]+$"

							// Value is the value of HTTP Header to be matched.
							value!: strings.MaxRunes(
								4096) & strings.MinRunes(
								1)
						}]
					}

					// RequestMirror defines a schema for a filter that mirrors
					// requests.
					// Requests are sent to the specified destination, but responses
					// from
					// that destination are ignored.
					//
					// This filter can be used multiple times within the same rule.
					// Note that
					// not all implementations will be able to support mirroring to
					// multiple
					// backends.
					//
					// Support: Extended
					requestMirror?: {
						// BackendRef references a resource where mirrored requests are
						// sent.
						//
						// Mirrored requests must be sent only to a single destination
						// endpoint
						// within this BackendRef, irrespective of how many endpoints are
						// present
						// within this BackendRef.
						//
						// If the referent cannot be found, this BackendRef is invalid and
						// must be
						// dropped from the Gateway. The controller must ensure the
						// "ResolvedRefs"
						// condition on the Route status is set to `status: False` and not
						// configure
						// this backend in the underlying implementation.
						//
						// If there is a cross-namespace reference to an *existing* object
						// that is not allowed by a ReferenceGrant, the controller must
						// ensure the
						// "ResolvedRefs" condition on the Route is set to `status:
						// False`,
						// with the "RefNotPermitted" reason and not configure this
						// backend in the
						// underlying implementation.
						//
						// In either error case, the Message of the `ResolvedRefs`
						// Condition
						// should be used to provide more detail about the problem.
						//
						// Support: Extended for Kubernetes Service
						//
						// Support: Implementation-specific for any other resource
						backendRef!: {
							// Group is the group of the referent. For example,
							// "gateway.networking.k8s.io".
							// When unspecified or empty string, core API group is inferred.
							group?: strings.MaxRunes(
								253) & =~"^$|^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

							// Kind is the Kubernetes resource kind of the referent. For
							// example
							// "Service".
							//
							// Defaults to "Service" when not specified.
							//
							// ExternalName services can refer to CNAME DNS records that may
							// live
							// outside of the cluster and as such are difficult to reason
							// about in
							// terms of conformance. They also may not be safe to forward to
							// (see
							// CVE-2021-25740 for more information). Implementations SHOULD
							// NOT
							// support ExternalName Services.
							//
							// Support: Core (Services with a type other than ExternalName)
							//
							// Support: Implementation-specific (Services with type
							// ExternalName)
							kind?: strings.MaxRunes(
								63) & strings.MinRunes(
								1) & =~"^[a-zA-Z]([-a-zA-Z0-9]*[a-zA-Z0-9])?$"

							// Name is the name of the referent.
							name!: strings.MaxRunes(
								253) & strings.MinRunes(
								1)

							// Namespace is the namespace of the backend. When unspecified,
							// the local
							// namespace is inferred.
							//
							// Note that when a namespace different than the local namespace
							// is specified,
							// a ReferenceGrant object is required in the referent namespace
							// to allow that
							// namespace's owner to accept the reference. See the
							// ReferenceGrant
							// documentation for details.
							//
							// Support: Core
							namespace?: strings.MaxRunes(
									63) & strings.MinRunes(
									1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"

							// Port specifies the destination port number to use for this
							// resource.
							// Port is required when the referent is a Kubernetes Service. In
							// this
							// case, the port number is the service port number, not the
							// target port.
							// For other resources, destination port might be derived from the
							// referent
							// resource or this field.
							port?: int32 & int & <=65535 & >=1
						}

						// Fraction represents the fraction of requests that should be
						// mirrored to BackendRef.
						//
						// Only one of Fraction or Percent may be specified. If neither
						// field
						// is specified, 100% of requests will be mirrored.
						fraction?: {
							denominator?: int32 & int & >=1
							numerator!:   int32 & int & >=0
						}

						// Percent represents the percentage of requests that should be
						// mirrored to BackendRef. Its minimum value is 0 (indicating 0%
						// of
						// requests) and its maximum value is 100 (indicating 100% of
						// requests).
						//
						// Only one of Fraction or Percent may be specified. If neither
						// field
						// is specified, 100% of requests will be mirrored.
						percent?: int32 & int & <=100 & >=0
					}

					// RequestRedirect defines a schema for a filter that responds to
					// the
					// request with an HTTP redirection.
					//
					// Support: Core
					requestRedirect?: {
						// Hostname is the hostname to be used in the value of the
						// `Location`
						// header in the response.
						// When empty, the hostname in the `Host` header of the request is
						// used.
						//
						// Support: Core
						hostname?: strings.MaxRunes(
								253) & strings.MinRunes(
								1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

						// Path defines parameters used to modify the path of the incoming
						// request.
						// The modified path is then used to construct the `Location`
						// header. When
						// empty, the request path is used as-is.
						//
						// Support: Extended
						path?: {
							// ReplaceFullPath specifies the value with which to replace the
							// full path
							// of a request during a rewrite or redirect.
							replaceFullPath?: strings.MaxRunes(
										1024)

							// ReplacePrefixMatch specifies the value with which to replace
							// the prefix
							// match of a request during a rewrite or redirect. For example, a
							// request
							// to "/foo/bar" with a prefix match of "/foo" and a
							// ReplacePrefixMatch
							// of "/xyz" would be modified to "/xyz/bar".
							//
							// Note that this matches the behavior of the PathPrefix match
							// type. This
							// matches full path elements. A path element refers to the list
							// of labels
							// in the path split by the `/` separator. When specified, a
							// trailing `/` is
							// ignored. For example, the paths `/abc`, `/abc/`, and `/abc/def`
							// would all
							// match the prefix `/abc`, but the path `/abcd` would not.
							//
							// ReplacePrefixMatch is only compatible with a `PathPrefix`
							// HTTPRouteMatch.
							// Using any other HTTPRouteMatch type on the same HTTPRouteRule
							// will result in
							// the implementation setting the Accepted Condition for the Route
							// to `status: False`.
							//
							// Request Path | Prefix Match | Replace Prefix | Modified Path
							replacePrefixMatch?: strings.MaxRunes(
										1024)

							// Type defines the type of path modifier. Additional types may be
							// added in a future release of the API.
							//
							// Note that values may be added to this enum, implementations
							// must ensure that unknown values will not cause a crash.
							//
							// Unknown values here must result in the implementation setting
							// the
							// Accepted Condition for the Route to `status: False`, with a
							// Reason of `UnsupportedValue`.
							type!: "ReplaceFullPath" | "ReplacePrefixMatch"
						}

						// Port is the port to be used in the value of the `Location`
						// header in the response.
						//
						// If no port is specified, the redirect port MUST be derived
						// using the
						// following rules:
						//
						// * If redirect scheme is not-empty, the redirect port MUST be
						// the well-known
						// port associated with the redirect scheme. Specifically "http"
						// to port 80
						// and "https" to port 443. If the redirect scheme does not have a
						// well-known port, the listener port of the Gateway SHOULD be
						// used.
						// * If redirect scheme is empty, the redirect port MUST be the
						// Gateway
						// Listener port.
						//
						// Implementations SHOULD NOT add the port number in the
						// 'Location'
						// header in the following cases:
						//
						// * A Location header that will use HTTP (whether that is
						// determined via
						// the Listener protocol or the Scheme field) _and_ use port 80.
						// * A Location header that will use HTTPS (whether that is
						// determined via
						// the Listener protocol or the Scheme field) _and_ use port 443.
						//
						// Support: Extended
						port?: int32 & int & <=65535 & >=1

						// Scheme is the scheme to be used in the value of the `Location`
						// header in
						// the response. When empty, the scheme of the request is used.
						//
						// Scheme redirects can affect the port of the redirect, for more
						// information,
						// refer to the documentation for the port field of this filter.
						//
						// Note that values may be added to this enum, implementations
						// must ensure that unknown values will not cause a crash.
						//
						// Unknown values here must result in the implementation setting
						// the
						// Accepted Condition for the Route to `status: False`, with a
						// Reason of `UnsupportedValue`.
						//
						// Support: Extended
						scheme?: "http" | "https"

						// StatusCode is the HTTP status code to be used in response.
						//
						// Note that values may be added to this enum, implementations
						// must ensure that unknown values will not cause a crash.
						//
						// Unknown values here must result in the implementation setting
						// the
						// Accepted Condition for the Route to `status: False`, with a
						// Reason of `UnsupportedValue`.
						//
						// Support: Core
						statusCode?: (301 | 302 | 303 | 307 | 308) & int
					}

					// ResponseHeaderModifier defines a schema for a filter that
					// modifies response
					// headers.
					//
					// Support: Extended
					responseHeaderModifier?: {
						// Add adds the given header(s) (name, value) to the request
						// before the action. It appends to any existing values associated
						// with the header name.
						//
						// Input:
						// GET /foo HTTP/1.1
						// my-header: foo
						//
						// Config:
						// add:
						// - name: "my-header"
						// value: "bar,baz"
						//
						// Output:
						// GET /foo HTTP/1.1
						// my-header: foo,bar,baz
						add?: list.MaxItems(16) & [...{
							// Name is the name of the HTTP Header to be matched. Name
							// matching MUST be
							// case-insensitive. (See
							// https://tools.ietf.org/html/rfc7230#section-3.2).
							//
							// If multiple entries specify equivalent header names, the first
							// entry with
							// an equivalent name MUST be considered for a match. Subsequent
							// entries
							// with an equivalent header name MUST be ignored. Due to the
							// case-insensitivity of header names, "foo" and "Foo" are
							// considered
							// equivalent.
							name!: strings.MaxRunes(
								256) & strings.MinRunes(
								1) & =~"^[A-Za-z0-9!#$%&'*+\\-.^_\\x60|~]+$"

							// Value is the value of HTTP Header to be matched.
							value!: strings.MaxRunes(
								4096) & strings.MinRunes(
								1)
						}]

						// Remove the given header(s) from the HTTP request before the
						// action. The
						// value of Remove is a list of HTTP header names. Note that the
						// header
						// names are case-insensitive (see
						// https://datatracker.ietf.org/doc/html/rfc2616#section-4.2).
						//
						// Input:
						// GET /foo HTTP/1.1
						// my-header1: foo
						// my-header2: bar
						// my-header3: baz
						//
						// Config:
						// remove: ["my-header1", "my-header3"]
						//
						// Output:
						// GET /foo HTTP/1.1
						// my-header2: bar
						remove?: list.MaxItems(16) & [...string]

						// Set overwrites the request with the given header (name, value)
						// before the action.
						//
						// Input:
						// GET /foo HTTP/1.1
						// my-header: foo
						//
						// Config:
						// set:
						// - name: "my-header"
						// value: "bar"
						//
						// Output:
						// GET /foo HTTP/1.1
						// my-header: bar
						set?: list.MaxItems(16) & [...{
							// Name is the name of the HTTP Header to be matched. Name
							// matching MUST be
							// case-insensitive. (See
							// https://tools.ietf.org/html/rfc7230#section-3.2).
							//
							// If multiple entries specify equivalent header names, the first
							// entry with
							// an equivalent name MUST be considered for a match. Subsequent
							// entries
							// with an equivalent header name MUST be ignored. Due to the
							// case-insensitivity of header names, "foo" and "Foo" are
							// considered
							// equivalent.
							name!: strings.MaxRunes(
								256) & strings.MinRunes(
								1) & =~"^[A-Za-z0-9!#$%&'*+\\-.^_\\x60|~]+$"

							// Value is the value of HTTP Header to be matched.
							value!: strings.MaxRunes(
								4096) & strings.MinRunes(
								1)
						}]
					}

					// Type identifies the type of filter to apply. As with other API
					// fields,
					// types are classified into three conformance levels:
					//
					// - Core: Filter types and their corresponding configuration
					// defined by
					// "Support: Core" in this package, e.g. "RequestHeaderModifier".
					// All
					// implementations must support core filters.
					//
					// - Extended: Filter types and their corresponding configuration
					// defined by
					// "Support: Extended" in this package, e.g. "RequestMirror".
					// Implementers
					// are encouraged to support extended filters.
					//
					// - Implementation-specific: Filters that are defined and
					// supported by
					// specific vendors.
					// In the future, filters showing convergence in behavior across
					// multiple
					// implementations will be considered for inclusion in extended or
					// core
					// conformance levels. Filter-specific configuration for such
					// filters
					// is specified using the ExtensionRef field. `Type` should be set
					// to
					// "ExtensionRef" for custom filters.
					//
					// Implementers are encouraged to define custom implementation
					// types to
					// extend the core API with implementation-specific behavior.
					//
					// If a reference to a custom filter type cannot be resolved, the
					// filter
					// MUST NOT be skipped. Instead, requests that would have been
					// processed by
					// that filter MUST receive a HTTP error response.
					//
					// Note that values may be added to this enum, implementations
					// must ensure that unknown values will not cause a crash.
					//
					// Unknown values here must result in the implementation setting
					// the
					// Accepted Condition for the Route to `status: False`, with a
					// Reason of `UnsupportedValue`.
					type!: "RequestHeaderModifier" | "ResponseHeaderModifier" | "RequestMirror" | "RequestRedirect" | "URLRewrite" | "ExtensionRef" | "CORS"

					// URLRewrite defines a schema for a filter that modifies a
					// request during forwarding.
					//
					// Support: Extended
					urlRewrite?: {
						// Hostname is the value to be used to replace the Host header
						// value during
						// forwarding.
						//
						// Support: Extended
						hostname?: strings.MaxRunes(
								253) & strings.MinRunes(
								1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

						// Path defines a path rewrite.
						//
						// Support: Extended
						path?: {
							// ReplaceFullPath specifies the value with which to replace the
							// full path
							// of a request during a rewrite or redirect.
							replaceFullPath?: strings.MaxRunes(
										1024)

							// ReplacePrefixMatch specifies the value with which to replace
							// the prefix
							// match of a request during a rewrite or redirect. For example, a
							// request
							// to "/foo/bar" with a prefix match of "/foo" and a
							// ReplacePrefixMatch
							// of "/xyz" would be modified to "/xyz/bar".
							//
							// Note that this matches the behavior of the PathPrefix match
							// type. This
							// matches full path elements. A path element refers to the list
							// of labels
							// in the path split by the `/` separator. When specified, a
							// trailing `/` is
							// ignored. For example, the paths `/abc`, `/abc/`, and `/abc/def`
							// would all
							// match the prefix `/abc`, but the path `/abcd` would not.
							//
							// ReplacePrefixMatch is only compatible with a `PathPrefix`
							// HTTPRouteMatch.
							// Using any other HTTPRouteMatch type on the same HTTPRouteRule
							// will result in
							// the implementation setting the Accepted Condition for the Route
							// to `status: False`.
							//
							// Request Path | Prefix Match | Replace Prefix | Modified Path
							replacePrefixMatch?: strings.MaxRunes(
										1024)

							// Type defines the type of path modifier. Additional types may be
							// added in a future release of the API.
							//
							// Note that values may be added to this enum, implementations
							// must ensure that unknown values will not cause a crash.
							//
							// Unknown values here must result in the implementation setting
							// the
							// Accepted Condition for the Route to `status: False`, with a
							// Reason of `UnsupportedValue`.
							type!: "ReplaceFullPath" | "ReplacePrefixMatch"
						}
					}
				}]

				// Group is the group of the referent. For example,
				// "gateway.networking.k8s.io".
				// When unspecified or empty string, core API group is inferred.
				group?: strings.MaxRunes(
					253) & =~"^$|^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

				// Kind is the Kubernetes resource kind of the referent. For
				// example
				// "Service".
				//
				// Defaults to "Service" when not specified.
				//
				// ExternalName services can refer to CNAME DNS records that may
				// live
				// outside of the cluster and as such are difficult to reason
				// about in
				// terms of conformance. They also may not be safe to forward to
				// (see
				// CVE-2021-25740 for more information). Implementations SHOULD
				// NOT
				// support ExternalName Services.
				//
				// Support: Core (Services with a type other than ExternalName)
				//
				// Support: Implementation-specific (Services with type
				// ExternalName)
				kind?: strings.MaxRunes(
					63) & strings.MinRunes(
					1) & =~"^[a-zA-Z]([-a-zA-Z0-9]*[a-zA-Z0-9])?$"

				// Name is the name of the referent.
				name!: strings.MaxRunes(
					253) & strings.MinRunes(
					1)

				// Namespace is the namespace of the backend. When unspecified,
				// the local
				// namespace is inferred.
				//
				// Note that when a namespace different than the local namespace
				// is specified,
				// a ReferenceGrant object is required in the referent namespace
				// to allow that
				// namespace's owner to accept the reference. See the
				// ReferenceGrant
				// documentation for details.
				//
				// Support: Core
				namespace?: strings.MaxRunes(
						63) & strings.MinRunes(
						1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"

				// Port specifies the destination port number to use for this
				// resource.
				// Port is required when the referent is a Kubernetes Service. In
				// this
				// case, the port number is the service port number, not the
				// target port.
				// For other resources, destination port might be derived from the
				// referent
				// resource or this field.
				port?: int32 & int & <=65535 & >=1

				// Weight specifies the proportion of requests forwarded to the
				// referenced
				// backend. This is computed as weight/(sum of all weights in this
				// BackendRefs list). For non-zero values, there may be some
				// epsilon from
				// the exact proportion defined here depending on the precision an
				// implementation supports. Weight is not a percentage and the sum
				// of
				// weights does not need to equal 100.
				//
				// If only one backend is specified and it has a weight greater
				// than 0, 100%
				// of the traffic is forwarded to that backend. If weight is set
				// to 0, no
				// traffic should be forwarded for this entry. If unspecified,
				// weight
				// defaults to 1.
				//
				// Support for this field varies based on the context where used.
				weight?: int32 & int & <=1000000 & >=0
			}]

			// Filters define the filters that are applied to requests that
			// match
			// this rule.
			//
			// Wherever possible, implementations SHOULD implement filters in
			// the order
			// they are specified.
			//
			// Implementations MAY choose to implement this ordering strictly,
			// rejecting
			// any combination or order of filters that cannot be supported.
			// If implementations
			// choose a strict interpretation of filter ordering, they MUST
			// clearly document
			// that behavior.
			//
			// To reject an invalid combination or order of filters,
			// implementations SHOULD
			// consider the Route Rules with this configuration invalid. If
			// all Route Rules
			// in a Route are invalid, the entire Route would be considered
			// invalid. If only
			// a portion of Route Rules are invalid, implementations MUST set
			// the
			// "PartiallyInvalid" condition for the Route.
			//
			// Conformance-levels at this level are defined based on the type
			// of filter:
			//
			// - ALL core filters MUST be supported by all implementations.
			// - Implementers are encouraged to support extended filters.
			// - Implementation-specific custom filters have no API guarantees
			// across
			// implementations.
			//
			// Specifying the same filter multiple times is not supported
			// unless explicitly
			// indicated in the filter.
			//
			// All filters are expected to be compatible with each other
			// except for the
			// URLRewrite and RequestRedirect filters, which may not be
			// combined. If an
			// implementation cannot support other combinations of filters,
			// they must clearly
			// document that limitation. In cases where incompatible or
			// unsupported
			// filters are specified and cause the `Accepted` condition to be
			// set to status
			// `False`, implementations may use the `IncompatibleFilters`
			// reason to specify
			// this configuration error.
			//
			// Support: Core
			filters?: list.MaxItems(16) & [...{
				// CORS defines a schema for a filter that responds to the
				// cross-origin request based on HTTP response header.
				//
				// Support: Extended
				cors?: {
					// AllowCredentials indicates whether the actual cross-origin
					// request allows
					// to include credentials.
					//
					// When set to true, the gateway will include the
					// `Access-Control-Allow-Credentials`
					// response header with value true (case-sensitive).
					//
					// When set to false or omitted the gateway will omit the header
					// `Access-Control-Allow-Credentials` entirely (this is the
					// standard CORS
					// behavior).
					//
					// Support: Extended
					allowCredentials?: bool

					// AllowHeaders indicates which HTTP request headers are supported
					// for
					// accessing the requested resource.
					//
					// Header names are not case-sensitive.
					//
					// Multiple header names in the value of the
					// `Access-Control-Allow-Headers`
					// response header are separated by a comma (",").
					//
					// When the `AllowHeaders` field is configured with one or more
					// headers, the
					// gateway must return the `Access-Control-Allow-Headers` response
					// header
					// which value is present in the `AllowHeaders` field.
					//
					// If any header name in the `Access-Control-Request-Headers`
					// request header
					// is not included in the list of header names specified by the
					// response
					// header `Access-Control-Allow-Headers`, it will present an error
					// on the
					// client side.
					//
					// If any header name in the `Access-Control-Allow-Headers`
					// response header
					// does not recognize by the client, it will also occur an error
					// on the
					// client side.
					//
					// A wildcard indicates that the requests with all HTTP headers
					// are allowed.
					// If config contains the wildcard "*" in allowHeaders and the
					// request is
					// not credentialed, the `Access-Control-Allow-Headers` response
					// header
					// can either use the `*` wildcard or the value of
					// Access-Control-Request-Headers from the request.
					//
					// When the request is credentialed, the gateway must not specify
					// the `*`
					// wildcard in the `Access-Control-Allow-Headers` response header.
					// When
					// also the `AllowCredentials` field is true and `AllowHeaders`
					// field
					// is specified with the `*` wildcard, the gateway must specify
					// one or more
					// HTTP headers in the value of the `Access-Control-Allow-Headers`
					// response
					// header. The value of the header `Access-Control-Allow-Headers`
					// is same as
					// the `Access-Control-Request-Headers` header provided by the
					// client. If
					// the header `Access-Control-Request-Headers` is not included in
					// the
					// request, the gateway will omit the
					// `Access-Control-Allow-Headers`
					// response header, instead of specifying the `*` wildcard.
					//
					// Support: Extended
					allowHeaders?: list.MaxItems(64) & [...strings.MaxRunes(
						256) & strings.MinRunes(
						1) & =~"^[A-Za-z0-9!#$%&'*+\\-.^_\\x60|~]+$"]

					// AllowMethods indicates which HTTP methods are supported for
					// accessing the
					// requested resource.
					//
					// Valid values are any method defined by RFC9110, along with the
					// special
					// value `*`, which represents all HTTP methods are allowed.
					//
					// Method names are case-sensitive, so these values are also
					// case-sensitive.
					// (See https://www.rfc-editor.org/rfc/rfc2616#section-5.1.1)
					//
					// Multiple method names in the value of the
					// `Access-Control-Allow-Methods`
					// response header are separated by a comma (",").
					//
					// A CORS-safelisted method is a method that is `GET`, `HEAD`, or
					// `POST`.
					// (See https://fetch.spec.whatwg.org/#cors-safelisted-method) The
					// CORS-safelisted methods are always allowed, regardless of
					// whether they
					// are specified in the `AllowMethods` field.
					//
					// When the `AllowMethods` field is configured with one or more
					// methods, the
					// gateway must return the `Access-Control-Allow-Methods` response
					// header
					// which value is present in the `AllowMethods` field.
					//
					// If the HTTP method of the `Access-Control-Request-Method`
					// request header
					// is not included in the list of methods specified by the
					// response header
					// `Access-Control-Allow-Methods`, it will present an error on the
					// client
					// side.
					//
					// If config contains the wildcard "*" in allowMethods and the
					// request is
					// not credentialed, the `Access-Control-Allow-Methods` response
					// header
					// can either use the `*` wildcard or the value of
					// Access-Control-Request-Method from the request.
					//
					// When the request is credentialed, the gateway must not specify
					// the `*`
					// wildcard in the `Access-Control-Allow-Methods` response header.
					// When
					// also the `AllowCredentials` field is true and `AllowMethods`
					// field
					// specified with the `*` wildcard, the gateway must specify one
					// HTTP method
					// in the value of the Access-Control-Allow-Methods response
					// header. The
					// value of the header `Access-Control-Allow-Methods` is same as
					// the
					// `Access-Control-Request-Method` header provided by the client.
					// If the
					// header `Access-Control-Request-Method` is not included in the
					// request,
					// the gateway will omit the `Access-Control-Allow-Methods`
					// response header,
					// instead of specifying the `*` wildcard.
					//
					// Support: Extended
					allowMethods?: list.MaxItems(9) & [..."GET" | "HEAD" | "POST" | "PUT" | "DELETE" | "CONNECT" | "OPTIONS" | "TRACE" | "PATCH" | "*"]

					// AllowOrigins indicates whether the response can be shared with
					// requested
					// resource from the given `Origin`.
					//
					// The `Origin` consists of a scheme and a host, with an optional
					// port, and
					// takes the form `<scheme>://<host>(:<port>)`.
					//
					// Valid values for scheme are: `http` and `https`.
					//
					// Valid values for port are any integer between 1 and 65535 (the
					// list of
					// available TCP/UDP ports). Note that, if not included, port `80`
					// is
					// assumed for `http` scheme origins, and port `443` is assumed
					// for `https`
					// origins. This may affect origin matching.
					//
					// The host part of the origin may contain the wildcard character
					// `*`. These
					// wildcard characters behave as follows:
					//
					// * `*` is a greedy match to the _left_, including any number of
					// DNS labels to the left of its position. This also means that
					// `*` will include any number of period `.` characters to the
					// left of its position.
					// * A wildcard by itself matches all hosts.
					//
					// An origin value that includes _only_ the `*` character
					// indicates requests
					// from all `Origin`s are allowed.
					//
					// When the `AllowOrigins` field is configured with multiple
					// origins, it
					// means the server supports clients from multiple origins. If the
					// request
					// `Origin` matches the configured allowed origins, the gateway
					// must return
					// the given `Origin` and sets value of the header
					// `Access-Control-Allow-Origin` same as the `Origin` header
					// provided by the
					// client.
					//
					// The status code of a successful response to a "preflight"
					// request is
					// always an OK status (i.e., 204 or 200).
					//
					// If the request `Origin` does not match the configured allowed
					// origins,
					// the gateway returns 204/200 response but doesn't set the
					// relevant
					// cross-origin response headers. Alternatively, the gateway
					// responds with
					// 403 status to the "preflight" request is denied, coupled with
					// omitting
					// the CORS headers. The cross-origin request fails on the client
					// side.
					// Therefore, the client doesn't attempt the actual cross-origin
					// request.
					//
					// Conversely, if the request `Origin` matches one of the
					// configured
					// allowed origins, the gateway sets the response header
					// `Access-Control-Allow-Origin` to the same value as the `Origin`
					// header provided by the client.
					//
					// When config has the wildcard ("*") in allowOrigins, and the
					// request
					// is not credentialed (e.g., it is a preflight request), the
					// `Access-Control-Allow-Origin` response header either contains
					// the
					// wildcard as well or the Origin from the request.
					//
					// When the request is credentialed, the gateway must not specify
					// the `*`
					// wildcard in the `Access-Control-Allow-Origin` response header.
					// When
					// also the `AllowCredentials` field is true and `AllowOrigins`
					// field
					// specified with the `*` wildcard, the gateway must return a
					// single origin
					// in the value of the `Access-Control-Allow-Origin` response
					// header,
					// instead of specifying the `*` wildcard. The value of the header
					// `Access-Control-Allow-Origin` is same as the `Origin` header
					// provided by
					// the client.
					//
					// Support: Extended
					allowOrigins?: list.MaxItems(64) & [...strings.MaxRunes(
						253) & strings.MinRunes(
						1) & =~"(^\\*$)|(^(http(s)?):\\/\\/(((\\*\\.)?([a-zA-Z0-9\\-]+\\.)*[a-zA-Z0-9-]+|\\*)(:([0-9]{1,5}))?)$)"]

					// ExposeHeaders indicates which HTTP response headers can be
					// exposed
					// to client-side scripts in response to a cross-origin request.
					//
					// A CORS-safelisted response header is an HTTP header in a CORS
					// response
					// that it is considered safe to expose to the client scripts.
					// The CORS-safelisted response headers include the following
					// headers:
					// `Cache-Control`
					// `Content-Language`
					// `Content-Length`
					// `Content-Type`
					// `Expires`
					// `Last-Modified`
					// `Pragma`
					// (See
					// https://fetch.spec.whatwg.org/#cors-safelisted-response-header-name)
					// The CORS-safelisted response headers are exposed to client by
					// default.
					//
					// When an HTTP header name is specified using the `ExposeHeaders`
					// field,
					// this additional header will be exposed as part of the response
					// to the
					// client.
					//
					// Header names are not case-sensitive.
					//
					// Multiple header names in the value of the
					// `Access-Control-Expose-Headers`
					// response header are separated by a comma (",").
					//
					// A wildcard indicates that the responses with all HTTP headers
					// are exposed
					// to clients. The `Access-Control-Expose-Headers` response header
					// can only
					// use `*` wildcard as value when the request is not credentialed.
					//
					// When the `exposeHeaders` config field contains the "*" wildcard
					// and
					// the request is credentialed, the gateway cannot use the `*`
					// wildcard in
					// the `Access-Control-Expose-Headers` response header.
					//
					// Support: Extended
					exposeHeaders?: list.MaxItems(64) & [...strings.MaxRunes(
						256) & strings.MinRunes(
						1) & =~"^[A-Za-z0-9!#$%&'*+\\-.^_\\x60|~]+$"]

					// MaxAge indicates the duration (in seconds) for the client to
					// cache the
					// results of a "preflight" request.
					//
					// The information provided by the `Access-Control-Allow-Methods`
					// and
					// `Access-Control-Allow-Headers` response headers can be cached
					// by the
					// client until the time specified by `Access-Control-Max-Age`
					// elapses.
					//
					// The default value of `Access-Control-Max-Age` response header
					// is 5
					// (seconds).
					//
					// When the `MaxAge` field is unspecified, the gateway sets the
					// response
					// header "Access-Control-Max-Age: 5" by default.
					maxAge?: int32 & int & >=1
				}

				// ExtensionRef is an optional, implementation-specific extension
				// to the
				// "filter" behavior. For example, resource "myroutefilter" in
				// group
				// "networking.example.net"). ExtensionRef MUST NOT be used for
				// core and
				// extended filters.
				//
				// This filter can be used multiple times within the same rule.
				//
				// Support: Implementation-specific
				extensionRef?: {
					// Group is the group of the referent. For example,
					// "gateway.networking.k8s.io".
					// When unspecified or empty string, core API group is inferred.
					group!: strings.MaxRunes(
						253) & =~"^$|^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

					// Kind is kind of the referent. For example "HTTPRoute" or
					// "Service".
					kind!: strings.MaxRunes(
						63) & strings.MinRunes(
						1) & =~"^[a-zA-Z]([-a-zA-Z0-9]*[a-zA-Z0-9])?$"

					// Name is the name of the referent.
					name!: strings.MaxRunes(
						253) & strings.MinRunes(
						1)
				}

				// RequestHeaderModifier defines a schema for a filter that
				// modifies request
				// headers.
				//
				// Support: Core
				requestHeaderModifier?: {
					// Add adds the given header(s) (name, value) to the request
					// before the action. It appends to any existing values associated
					// with the header name.
					//
					// Input:
					// GET /foo HTTP/1.1
					// my-header: foo
					//
					// Config:
					// add:
					// - name: "my-header"
					// value: "bar,baz"
					//
					// Output:
					// GET /foo HTTP/1.1
					// my-header: foo,bar,baz
					add?: list.MaxItems(16) & [...{
						// Name is the name of the HTTP Header to be matched. Name
						// matching MUST be
						// case-insensitive. (See
						// https://tools.ietf.org/html/rfc7230#section-3.2).
						//
						// If multiple entries specify equivalent header names, the first
						// entry with
						// an equivalent name MUST be considered for a match. Subsequent
						// entries
						// with an equivalent header name MUST be ignored. Due to the
						// case-insensitivity of header names, "foo" and "Foo" are
						// considered
						// equivalent.
						name!: strings.MaxRunes(
							256) & strings.MinRunes(
							1) & =~"^[A-Za-z0-9!#$%&'*+\\-.^_\\x60|~]+$"

						// Value is the value of HTTP Header to be matched.
						value!: strings.MaxRunes(
							4096) & strings.MinRunes(
							1)
					}]

					// Remove the given header(s) from the HTTP request before the
					// action. The
					// value of Remove is a list of HTTP header names. Note that the
					// header
					// names are case-insensitive (see
					// https://datatracker.ietf.org/doc/html/rfc2616#section-4.2).
					//
					// Input:
					// GET /foo HTTP/1.1
					// my-header1: foo
					// my-header2: bar
					// my-header3: baz
					//
					// Config:
					// remove: ["my-header1", "my-header3"]
					//
					// Output:
					// GET /foo HTTP/1.1
					// my-header2: bar
					remove?: list.MaxItems(16) & [...string]

					// Set overwrites the request with the given header (name, value)
					// before the action.
					//
					// Input:
					// GET /foo HTTP/1.1
					// my-header: foo
					//
					// Config:
					// set:
					// - name: "my-header"
					// value: "bar"
					//
					// Output:
					// GET /foo HTTP/1.1
					// my-header: bar
					set?: list.MaxItems(16) & [...{
						// Name is the name of the HTTP Header to be matched. Name
						// matching MUST be
						// case-insensitive. (See
						// https://tools.ietf.org/html/rfc7230#section-3.2).
						//
						// If multiple entries specify equivalent header names, the first
						// entry with
						// an equivalent name MUST be considered for a match. Subsequent
						// entries
						// with an equivalent header name MUST be ignored. Due to the
						// case-insensitivity of header names, "foo" and "Foo" are
						// considered
						// equivalent.
						name!: strings.MaxRunes(
							256) & strings.MinRunes(
							1) & =~"^[A-Za-z0-9!#$%&'*+\\-.^_\\x60|~]+$"

						// Value is the value of HTTP Header to be matched.
						value!: strings.MaxRunes(
							4096) & strings.MinRunes(
							1)
					}]
				}

				// RequestMirror defines a schema for a filter that mirrors
				// requests.
				// Requests are sent to the specified destination, but responses
				// from
				// that destination are ignored.
				//
				// This filter can be used multiple times within the same rule.
				// Note that
				// not all implementations will be able to support mirroring to
				// multiple
				// backends.
				//
				// Support: Extended
				requestMirror?: {
					// BackendRef references a resource where mirrored requests are
					// sent.
					//
					// Mirrored requests must be sent only to a single destination
					// endpoint
					// within this BackendRef, irrespective of how many endpoints are
					// present
					// within this BackendRef.
					//
					// If the referent cannot be found, this BackendRef is invalid and
					// must be
					// dropped from the Gateway. The controller must ensure the
					// "ResolvedRefs"
					// condition on the Route status is set to `status: False` and not
					// configure
					// this backend in the underlying implementation.
					//
					// If there is a cross-namespace reference to an *existing* object
					// that is not allowed by a ReferenceGrant, the controller must
					// ensure the
					// "ResolvedRefs" condition on the Route is set to `status:
					// False`,
					// with the "RefNotPermitted" reason and not configure this
					// backend in the
					// underlying implementation.
					//
					// In either error case, the Message of the `ResolvedRefs`
					// Condition
					// should be used to provide more detail about the problem.
					//
					// Support: Extended for Kubernetes Service
					//
					// Support: Implementation-specific for any other resource
					backendRef!: {
						// Group is the group of the referent. For example,
						// "gateway.networking.k8s.io".
						// When unspecified or empty string, core API group is inferred.
						group?: strings.MaxRunes(
							253) & =~"^$|^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

						// Kind is the Kubernetes resource kind of the referent. For
						// example
						// "Service".
						//
						// Defaults to "Service" when not specified.
						//
						// ExternalName services can refer to CNAME DNS records that may
						// live
						// outside of the cluster and as such are difficult to reason
						// about in
						// terms of conformance. They also may not be safe to forward to
						// (see
						// CVE-2021-25740 for more information). Implementations SHOULD
						// NOT
						// support ExternalName Services.
						//
						// Support: Core (Services with a type other than ExternalName)
						//
						// Support: Implementation-specific (Services with type
						// ExternalName)
						kind?: strings.MaxRunes(
							63) & strings.MinRunes(
							1) & =~"^[a-zA-Z]([-a-zA-Z0-9]*[a-zA-Z0-9])?$"

						// Name is the name of the referent.
						name!: strings.MaxRunes(
							253) & strings.MinRunes(
							1)

						// Namespace is the namespace of the backend. When unspecified,
						// the local
						// namespace is inferred.
						//
						// Note that when a namespace different than the local namespace
						// is specified,
						// a ReferenceGrant object is required in the referent namespace
						// to allow that
						// namespace's owner to accept the reference. See the
						// ReferenceGrant
						// documentation for details.
						//
						// Support: Core
						namespace?: strings.MaxRunes(
								63) & strings.MinRunes(
								1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"

						// Port specifies the destination port number to use for this
						// resource.
						// Port is required when the referent is a Kubernetes Service. In
						// this
						// case, the port number is the service port number, not the
						// target port.
						// For other resources, destination port might be derived from the
						// referent
						// resource or this field.
						port?: int32 & int & <=65535 & >=1
					}

					// Fraction represents the fraction of requests that should be
					// mirrored to BackendRef.
					//
					// Only one of Fraction or Percent may be specified. If neither
					// field
					// is specified, 100% of requests will be mirrored.
					fraction?: {
						denominator?: int32 & int & >=1
						numerator!:   int32 & int & >=0
					}

					// Percent represents the percentage of requests that should be
					// mirrored to BackendRef. Its minimum value is 0 (indicating 0%
					// of
					// requests) and its maximum value is 100 (indicating 100% of
					// requests).
					//
					// Only one of Fraction or Percent may be specified. If neither
					// field
					// is specified, 100% of requests will be mirrored.
					percent?: int32 & int & <=100 & >=0
				}

				// RequestRedirect defines a schema for a filter that responds to
				// the
				// request with an HTTP redirection.
				//
				// Support: Core
				requestRedirect?: {
					// Hostname is the hostname to be used in the value of the
					// `Location`
					// header in the response.
					// When empty, the hostname in the `Host` header of the request is
					// used.
					//
					// Support: Core
					hostname?: strings.MaxRunes(
							253) & strings.MinRunes(
							1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

					// Path defines parameters used to modify the path of the incoming
					// request.
					// The modified path is then used to construct the `Location`
					// header. When
					// empty, the request path is used as-is.
					//
					// Support: Extended
					path?: {
						// ReplaceFullPath specifies the value with which to replace the
						// full path
						// of a request during a rewrite or redirect.
						replaceFullPath?: strings.MaxRunes(
									1024)

						// ReplacePrefixMatch specifies the value with which to replace
						// the prefix
						// match of a request during a rewrite or redirect. For example, a
						// request
						// to "/foo/bar" with a prefix match of "/foo" and a
						// ReplacePrefixMatch
						// of "/xyz" would be modified to "/xyz/bar".
						//
						// Note that this matches the behavior of the PathPrefix match
						// type. This
						// matches full path elements. A path element refers to the list
						// of labels
						// in the path split by the `/` separator. When specified, a
						// trailing `/` is
						// ignored. For example, the paths `/abc`, `/abc/`, and `/abc/def`
						// would all
						// match the prefix `/abc`, but the path `/abcd` would not.
						//
						// ReplacePrefixMatch is only compatible with a `PathPrefix`
						// HTTPRouteMatch.
						// Using any other HTTPRouteMatch type on the same HTTPRouteRule
						// will result in
						// the implementation setting the Accepted Condition for the Route
						// to `status: False`.
						//
						// Request Path | Prefix Match | Replace Prefix | Modified Path
						replacePrefixMatch?: strings.MaxRunes(
									1024)

						// Type defines the type of path modifier. Additional types may be
						// added in a future release of the API.
						//
						// Note that values may be added to this enum, implementations
						// must ensure that unknown values will not cause a crash.
						//
						// Unknown values here must result in the implementation setting
						// the
						// Accepted Condition for the Route to `status: False`, with a
						// Reason of `UnsupportedValue`.
						type!: "ReplaceFullPath" | "ReplacePrefixMatch"
					}

					// Port is the port to be used in the value of the `Location`
					// header in the response.
					//
					// If no port is specified, the redirect port MUST be derived
					// using the
					// following rules:
					//
					// * If redirect scheme is not-empty, the redirect port MUST be
					// the well-known
					// port associated with the redirect scheme. Specifically "http"
					// to port 80
					// and "https" to port 443. If the redirect scheme does not have a
					// well-known port, the listener port of the Gateway SHOULD be
					// used.
					// * If redirect scheme is empty, the redirect port MUST be the
					// Gateway
					// Listener port.
					//
					// Implementations SHOULD NOT add the port number in the
					// 'Location'
					// header in the following cases:
					//
					// * A Location header that will use HTTP (whether that is
					// determined via
					// the Listener protocol or the Scheme field) _and_ use port 80.
					// * A Location header that will use HTTPS (whether that is
					// determined via
					// the Listener protocol or the Scheme field) _and_ use port 443.
					//
					// Support: Extended
					port?: int32 & int & <=65535 & >=1

					// Scheme is the scheme to be used in the value of the `Location`
					// header in
					// the response. When empty, the scheme of the request is used.
					//
					// Scheme redirects can affect the port of the redirect, for more
					// information,
					// refer to the documentation for the port field of this filter.
					//
					// Note that values may be added to this enum, implementations
					// must ensure that unknown values will not cause a crash.
					//
					// Unknown values here must result in the implementation setting
					// the
					// Accepted Condition for the Route to `status: False`, with a
					// Reason of `UnsupportedValue`.
					//
					// Support: Extended
					scheme?: "http" | "https"

					// StatusCode is the HTTP status code to be used in response.
					//
					// Note that values may be added to this enum, implementations
					// must ensure that unknown values will not cause a crash.
					//
					// Unknown values here must result in the implementation setting
					// the
					// Accepted Condition for the Route to `status: False`, with a
					// Reason of `UnsupportedValue`.
					//
					// Support: Core
					statusCode?: (301 | 302 | 303 | 307 | 308) & int
				}

				// ResponseHeaderModifier defines a schema for a filter that
				// modifies response
				// headers.
				//
				// Support: Extended
				responseHeaderModifier?: {
					// Add adds the given header(s) (name, value) to the request
					// before the action. It appends to any existing values associated
					// with the header name.
					//
					// Input:
					// GET /foo HTTP/1.1
					// my-header: foo
					//
					// Config:
					// add:
					// - name: "my-header"
					// value: "bar,baz"
					//
					// Output:
					// GET /foo HTTP/1.1
					// my-header: foo,bar,baz
					add?: list.MaxItems(16) & [...{
						// Name is the name of the HTTP Header to be matched. Name
						// matching MUST be
						// case-insensitive. (See
						// https://tools.ietf.org/html/rfc7230#section-3.2).
						//
						// If multiple entries specify equivalent header names, the first
						// entry with
						// an equivalent name MUST be considered for a match. Subsequent
						// entries
						// with an equivalent header name MUST be ignored. Due to the
						// case-insensitivity of header names, "foo" and "Foo" are
						// considered
						// equivalent.
						name!: strings.MaxRunes(
							256) & strings.MinRunes(
							1) & =~"^[A-Za-z0-9!#$%&'*+\\-.^_\\x60|~]+$"

						// Value is the value of HTTP Header to be matched.
						value!: strings.MaxRunes(
							4096) & strings.MinRunes(
							1)
					}]

					// Remove the given header(s) from the HTTP request before the
					// action. The
					// value of Remove is a list of HTTP header names. Note that the
					// header
					// names are case-insensitive (see
					// https://datatracker.ietf.org/doc/html/rfc2616#section-4.2).
					//
					// Input:
					// GET /foo HTTP/1.1
					// my-header1: foo
					// my-header2: bar
					// my-header3: baz
					//
					// Config:
					// remove: ["my-header1", "my-header3"]
					//
					// Output:
					// GET /foo HTTP/1.1
					// my-header2: bar
					remove?: list.MaxItems(16) & [...string]

					// Set overwrites the request with the given header (name, value)
					// before the action.
					//
					// Input:
					// GET /foo HTTP/1.1
					// my-header: foo
					//
					// Config:
					// set:
					// - name: "my-header"
					// value: "bar"
					//
					// Output:
					// GET /foo HTTP/1.1
					// my-header: bar
					set?: list.MaxItems(16) & [...{
						// Name is the name of the HTTP Header to be matched. Name
						// matching MUST be
						// case-insensitive. (See
						// https://tools.ietf.org/html/rfc7230#section-3.2).
						//
						// If multiple entries specify equivalent header names, the first
						// entry with
						// an equivalent name MUST be considered for a match. Subsequent
						// entries
						// with an equivalent header name MUST be ignored. Due to the
						// case-insensitivity of header names, "foo" and "Foo" are
						// considered
						// equivalent.
						name!: strings.MaxRunes(
							256) & strings.MinRunes(
							1) & =~"^[A-Za-z0-9!#$%&'*+\\-.^_\\x60|~]+$"

						// Value is the value of HTTP Header to be matched.
						value!: strings.MaxRunes(
							4096) & strings.MinRunes(
							1)
					}]
				}

				// Type identifies the type of filter to apply. As with other API
				// fields,
				// types are classified into three conformance levels:
				//
				// - Core: Filter types and their corresponding configuration
				// defined by
				// "Support: Core" in this package, e.g. "RequestHeaderModifier".
				// All
				// implementations must support core filters.
				//
				// - Extended: Filter types and their corresponding configuration
				// defined by
				// "Support: Extended" in this package, e.g. "RequestMirror".
				// Implementers
				// are encouraged to support extended filters.
				//
				// - Implementation-specific: Filters that are defined and
				// supported by
				// specific vendors.
				// In the future, filters showing convergence in behavior across
				// multiple
				// implementations will be considered for inclusion in extended or
				// core
				// conformance levels. Filter-specific configuration for such
				// filters
				// is specified using the ExtensionRef field. `Type` should be set
				// to
				// "ExtensionRef" for custom filters.
				//
				// Implementers are encouraged to define custom implementation
				// types to
				// extend the core API with implementation-specific behavior.
				//
				// If a reference to a custom filter type cannot be resolved, the
				// filter
				// MUST NOT be skipped. Instead, requests that would have been
				// processed by
				// that filter MUST receive a HTTP error response.
				//
				// Note that values may be added to this enum, implementations
				// must ensure that unknown values will not cause a crash.
				//
				// Unknown values here must result in the implementation setting
				// the
				// Accepted Condition for the Route to `status: False`, with a
				// Reason of `UnsupportedValue`.
				type!: "RequestHeaderModifier" | "ResponseHeaderModifier" | "RequestMirror" | "RequestRedirect" | "URLRewrite" | "ExtensionRef" | "CORS"

				// URLRewrite defines a schema for a filter that modifies a
				// request during forwarding.
				//
				// Support: Extended
				urlRewrite?: {
					// Hostname is the value to be used to replace the Host header
					// value during
					// forwarding.
					//
					// Support: Extended
					hostname?: strings.MaxRunes(
							253) & strings.MinRunes(
							1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

					// Path defines a path rewrite.
					//
					// Support: Extended
					path?: {
						// ReplaceFullPath specifies the value with which to replace the
						// full path
						// of a request during a rewrite or redirect.
						replaceFullPath?: strings.MaxRunes(
									1024)

						// ReplacePrefixMatch specifies the value with which to replace
						// the prefix
						// match of a request during a rewrite or redirect. For example, a
						// request
						// to "/foo/bar" with a prefix match of "/foo" and a
						// ReplacePrefixMatch
						// of "/xyz" would be modified to "/xyz/bar".
						//
						// Note that this matches the behavior of the PathPrefix match
						// type. This
						// matches full path elements. A path element refers to the list
						// of labels
						// in the path split by the `/` separator. When specified, a
						// trailing `/` is
						// ignored. For example, the paths `/abc`, `/abc/`, and `/abc/def`
						// would all
						// match the prefix `/abc`, but the path `/abcd` would not.
						//
						// ReplacePrefixMatch is only compatible with a `PathPrefix`
						// HTTPRouteMatch.
						// Using any other HTTPRouteMatch type on the same HTTPRouteRule
						// will result in
						// the implementation setting the Accepted Condition for the Route
						// to `status: False`.
						//
						// Request Path | Prefix Match | Replace Prefix | Modified Path
						replacePrefixMatch?: strings.MaxRunes(
									1024)

						// Type defines the type of path modifier. Additional types may be
						// added in a future release of the API.
						//
						// Note that values may be added to this enum, implementations
						// must ensure that unknown values will not cause a crash.
						//
						// Unknown values here must result in the implementation setting
						// the
						// Accepted Condition for the Route to `status: False`, with a
						// Reason of `UnsupportedValue`.
						type!: "ReplaceFullPath" | "ReplacePrefixMatch"
					}
				}
			}]

			// Matches define conditions used for matching the rule against
			// incoming
			// HTTP requests. Each match is independent, i.e. this rule will
			// be matched
			// if **any** one of the matches is satisfied.
			//
			// For example, take the following matches configuration:
			//
			// ```
			// matches:
			// - path:
			// value: "/foo"
			// headers:
			// - name: "version"
			// value: "v2"
			// - path:
			// value: "/v2/foo"
			// ```
			//
			// For a request to match against this rule, a request must
			// satisfy
			// EITHER of the two conditions:
			//
			// - path prefixed with `/foo` AND contains the header `version:
			// v2`
			// - path prefix of `/v2/foo`
			//
			// See the documentation for HTTPRouteMatch on how to specify
			// multiple
			// match conditions that should be ANDed together.
			//
			// If no matches are specified, the default is a prefix
			// path match on "/", which has the effect of matching every
			// HTTP request.
			//
			// Proxy or Load Balancer routing configuration generated from
			// HTTPRoutes
			// MUST prioritize matches based on the following criteria,
			// continuing on
			// ties. Across all rules specified on applicable Routes,
			// precedence must be
			// given to the match having:
			//
			// * "Exact" path match.
			// * "Prefix" path match with largest number of characters.
			// * Method match.
			// * Largest number of header matches.
			// * Largest number of query param matches.
			//
			// Note: The precedence of RegularExpression path matches are
			// implementation-specific.
			//
			// If ties still exist across multiple Routes, matching precedence
			// MUST be
			// determined in order of the following criteria, continuing on
			// ties:
			//
			// * The oldest Route based on creation timestamp.
			// * The Route appearing first in alphabetical order by
			// "{namespace}/{name}".
			//
			// If ties still exist within an HTTPRoute, matching precedence
			// MUST be granted
			// to the FIRST matching rule (in list order) with a match meeting
			// the above
			// criteria.
			//
			// When no rules matching a request have been successfully
			// attached to the
			// parent a request is coming from, a HTTP 404 status code MUST be
			// returned.
			matches?: list.MaxItems(64) & [...{
				// Headers specifies HTTP request header matchers. Multiple match
				// values are
				// ANDed together, meaning, a request must match all the specified
				// headers
				// to select the route.
				headers?: list.MaxItems(16) & [...{
					// Name is the name of the HTTP Header to be matched. Name
					// matching MUST be
					// case-insensitive. (See
					// https://tools.ietf.org/html/rfc7230#section-3.2).
					//
					// If multiple entries specify equivalent header names, only the
					// first
					// entry with an equivalent name MUST be considered for a match.
					// Subsequent
					// entries with an equivalent header name MUST be ignored. Due to
					// the
					// case-insensitivity of header names, "foo" and "Foo" are
					// considered
					// equivalent.
					//
					// When a header is repeated in an HTTP request, it is
					// implementation-specific behavior as to how this is represented.
					// Generally, proxies should follow the guidance from the RFC:
					// https://www.rfc-editor.org/rfc/rfc7230.html#section-3.2.2
					// regarding
					// processing a repeated header, with special handling for
					// "Set-Cookie".
					name!: strings.MaxRunes(
						256) & strings.MinRunes(
						1) & =~"^[A-Za-z0-9!#$%&'*+\\-.^_\\x60|~]+$"

					// Type specifies how to match against the value of the header.
					//
					// Support: Core (Exact)
					//
					// Support: Implementation-specific (RegularExpression)
					//
					// Since RegularExpression HeaderMatchType has
					// implementation-specific
					// conformance, implementations can support POSIX, PCRE or any
					// other dialects
					// of regular expressions. Please read the implementation's
					// documentation to
					// determine the supported dialect.
					type?: "Exact" | "RegularExpression"

					// Value is the value of HTTP Header to be matched.
					value!: strings.MaxRunes(
						4096) & strings.MinRunes(
						1)
				}]

				// Method specifies HTTP method matcher.
				// When specified, this route will be matched only if the request
				// has the
				// specified method.
				//
				// Support: Extended
				method?: "GET" | "HEAD" | "POST" | "PUT" | "DELETE" | "CONNECT" | "OPTIONS" | "TRACE" | "PATCH"

				// Path specifies a HTTP request path matcher. If this field is
				// not
				// specified, a default prefix match on the "/" path is provided.
				path?: {
					// Type specifies how to match against the path Value.
					//
					// Support: Core (Exact, PathPrefix)
					//
					// Support: Implementation-specific (RegularExpression)
					type?: "Exact" | "PathPrefix" | "RegularExpression"

					// Value of the HTTP path to match against.
					value?: strings.MaxRunes(
						1024)
				}

				// QueryParams specifies HTTP query parameter matchers. Multiple
				// match
				// values are ANDed together, meaning, a request must match all
				// the
				// specified query parameters to select the route.
				//
				// Support: Extended
				queryParams?: list.MaxItems(16) & [...{
					// Name is the name of the HTTP query param to be matched. This
					// must be an
					// exact string match. (See
					// https://tools.ietf.org/html/rfc7230#section-2.7.3).
					//
					// If multiple entries specify equivalent query param names, only
					// the first
					// entry with an equivalent name MUST be considered for a match.
					// Subsequent
					// entries with an equivalent query param name MUST be ignored.
					//
					// If a query param is repeated in an HTTP request, the behavior
					// is
					// purposely left undefined, since different data planes have
					// different
					// capabilities. However, it is *recommended* that implementations
					// should
					// match against the first value of the param if the data plane
					// supports it,
					// as this behavior is expected in other load balancing contexts
					// outside of
					// the Gateway API.
					//
					// Users SHOULD NOT route traffic based on repeated query params
					// to guard
					// themselves against potential differences in the
					// implementations.
					name!: strings.MaxRunes(
						256) & strings.MinRunes(
						1) & =~"^[A-Za-z0-9!#$%&'*+\\-.^_\\x60|~]+$"

					// Type specifies how to match against the value of the query
					// parameter.
					//
					// Support: Extended (Exact)
					//
					// Support: Implementation-specific (RegularExpression)
					//
					// Since RegularExpression QueryParamMatchType has
					// Implementation-specific
					// conformance, implementations can support POSIX, PCRE or any
					// other
					// dialects of regular expressions. Please read the
					// implementation's
					// documentation to determine the supported dialect.
					type?: "Exact" | "RegularExpression"

					// Value is the value of HTTP query param to be matched.
					value!: strings.MaxRunes(
						1024) & strings.MinRunes(
						1)
				}]
			}]

			// Name is the name of the route rule. This name MUST be unique
			// within a Route if it is set.
			//
			// Support: Extended
			name?: strings.MaxRunes(
				253) & strings.MinRunes(
				1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

			// Timeouts defines the timeouts that can be configured for an
			// HTTP request.
			//
			// Support: Extended
			timeouts?: {
				// BackendRequest specifies a timeout for an individual request
				// from the gateway
				// to a backend. This covers the time from when the request first
				// starts being
				// sent from the gateway to when the full response has been
				// received from the backend.
				//
				// Setting a timeout to the zero duration (e.g. "0s") SHOULD
				// disable the timeout
				// completely. Implementations that cannot completely disable the
				// timeout MUST
				// instead interpret the zero duration as the longest possible
				// value to which
				// the timeout can be set.
				//
				// An entire client HTTP transaction with a gateway, covered by
				// the Request timeout,
				// may result in more than one call from the gateway to the
				// destination backend,
				// for example, if automatic retries are supported.
				//
				// The value of BackendRequest must be a Gateway API Duration
				// string as defined by
				// GEP-2257. When this field is unspecified, its behavior is
				// implementation-specific;
				// when specified, the value of BackendRequest must be no more
				// than the value of the
				// Request timeout (since the Request timeout encompasses the
				// BackendRequest timeout).
				//
				// Support: Extended
				backendRequest?: =~"^([0-9]{1,5}(h|m|s|ms)){1,4}$"

				// Request specifies the maximum duration for a gateway to respond
				// to an HTTP request.
				// If the gateway has not been able to respond before this
				// deadline is met, the gateway
				// MUST return a timeout error.
				//
				// For example, setting the `rules.timeouts.request` field to the
				// value `10s` in an
				// `HTTPRoute` will cause a timeout if a client request is taking
				// longer than 10 seconds
				// to complete.
				//
				// Setting a timeout to the zero duration (e.g. "0s") SHOULD
				// disable the timeout
				// completely. Implementations that cannot completely disable the
				// timeout MUST
				// instead interpret the zero duration as the longest possible
				// value to which
				// the timeout can be set.
				//
				// This timeout is intended to cover as close to the whole
				// request-response transaction
				// as possible although an implementation MAY choose to start the
				// timeout after the entire
				// request stream has been received instead of immediately after
				// the transaction is
				// initiated by the client.
				//
				// The value of Request is a Gateway API Duration string as
				// defined by GEP-2257. When this
				// field is unspecified, request timeout behavior is
				// implementation-specific.
				//
				// Support: Extended
				request?: =~"^([0-9]{1,5}(h|m|s|ms)){1,4}$"
			}
		}] & [_, ...]
	}

	// Status defines the current state of HTTPRoute.
	status?: {
		// Parents is a list of parent resources (usually Gateways) that
		// are
		// associated with the route, and the status of the route with
		// respect to
		// each parent. When this route attaches to a parent, the
		// controller that
		// manages the parent must add an entry to this list when the
		// controller
		// first sees the route and should update the entry as appropriate
		// when the
		// route or gateway is modified.
		//
		// Note that parent references that cannot be resolved by an
		// implementation
		// of this API will not be added to this list. Implementations of
		// this API
		// can only populate Route status for the Gateways/parent
		// resources they are
		// responsible for.
		//
		// A maximum of 32 Gateways will be represented in this list. An
		// empty list
		// means the route has not been attached to any Gateway.
		parents!: list.MaxItems(32) & [...{
			// Conditions describes the status of the route with respect to
			// the Gateway.
			// Note that the route's availability is also subject to the
			// Gateway's own
			// status conditions and listener status.
			//
			// If the Route's ParentRef specifies an existing Gateway that
			// supports
			// Routes of this kind AND that Gateway's controller has
			// sufficient access,
			// then that Gateway's controller MUST set the "Accepted"
			// condition on the
			// Route, to indicate whether the route has been accepted or
			// rejected by the
			// Gateway, and why.
			//
			// A Route MUST be considered "Accepted" if at least one of the
			// Route's
			// rules is implemented by the Gateway.
			//
			// There are a number of cases where the "Accepted" condition may
			// not be set
			// due to lack of controller visibility, that includes when:
			//
			// * The Route refers to a nonexistent parent.
			// * The Route is of a type that the controller does not support.
			// * The Route is in a namespace to which the controller does not
			// have access.
			conditions!: list.MaxItems(8) & [...{
				// lastTransitionTime is the last time the condition transitioned
				// from one status to another.
				// This should be when the underlying condition changed. If that
				// is not known, then using the time when the API field changed
				// is acceptable.
				lastTransitionTime!: time.Time

				// message is a human readable message indicating details about
				// the transition.
				// This may be an empty string.
				message!: strings.MaxRunes(
						32768)

				// observedGeneration represents the .metadata.generation that the
				// condition was set based upon.
				// For instance, if .metadata.generation is currently 12, but the
				// .status.conditions[x].observedGeneration is 9, the condition
				// is out of date
				// with respect to the current state of the instance.
				observedGeneration?: int64 & int & >=0

				// reason contains a programmatic identifier indicating the reason
				// for the condition's last transition.
				// Producers of specific condition types may define expected
				// values and meanings for this field,
				// and whether the values are considered a guaranteed API.
				// The value should be a CamelCase string.
				// This field may not be empty.
				reason!: strings.MaxRunes(
						1024) & strings.MinRunes(
						1) & =~"^[A-Za-z]([A-Za-z0-9_,:]*[A-Za-z0-9_])?$"

				// status of the condition, one of True, False, Unknown.
				status!: "True" | "False" | "Unknown"

				// type of condition in CamelCase or in foo.example.com/CamelCase.
				type!: strings.MaxRunes(
					316) & =~"^([a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*/)?(([A-Za-z0-9][-A-Za-z0-9_.]*)?[A-Za-z0-9])$"
			}] & [_, ...]

			// ControllerName is a domain/path string that indicates the name
			// of the
			// controller that wrote this status. This corresponds with the
			// controllerName field on GatewayClass.
			//
			// Example: "example.net/gateway-controller".
			//
			// The format of this field is DOMAIN "/" PATH, where DOMAIN and
			// PATH are
			// valid Kubernetes names
			// (https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names).
			//
			// Controllers MUST populate this field when writing status.
			// Controllers should ensure that
			// entries to status populated with their ControllerName are
			// cleaned up when they are no
			// longer necessary.
			controllerName!: strings.MaxRunes(
						253) & strings.MinRunes(
						1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*\\/[A-Za-z0-9\\/\\-._~%!$&'()*+,;=:]+$"

			// ParentRef corresponds with a ParentRef in the spec that this
			// RouteParentStatus struct describes the status of.
			parentRef!: {
				// Group is the group of the referent.
				// When unspecified, "gateway.networking.k8s.io" is inferred.
				// To set the core API group (such as for a "Service" kind
				// referent),
				// Group must be explicitly set to "" (empty string).
				//
				// Support: Core
				group?: strings.MaxRunes(
					253) & =~"^$|^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

				// Kind is kind of the referent.
				//
				// There are two kinds of parent resources with "Core" support:
				//
				// * Gateway (Gateway conformance profile)
				// * Service (Mesh conformance profile, ClusterIP Services only)
				//
				// Support for other resources is Implementation-Specific.
				kind?: strings.MaxRunes(
					63) & strings.MinRunes(
					1) & =~"^[a-zA-Z]([-a-zA-Z0-9]*[a-zA-Z0-9])?$"

				// Name is the name of the referent.
				//
				// Support: Core
				name!: strings.MaxRunes(
					253) & strings.MinRunes(
					1)

				// Namespace is the namespace of the referent. When unspecified,
				// this refers
				// to the local namespace of the Route.
				//
				// Note that there are specific rules for ParentRefs which cross
				// namespace
				// boundaries. Cross-namespace references are only valid if they
				// are explicitly
				// allowed by something in the namespace they are referring to.
				// For example:
				// Gateway has the AllowedRoutes field, and ReferenceGrant
				// provides a
				// generic way to enable any other kind of cross-namespace
				// reference.
				//
				// Support: Core
				namespace?: strings.MaxRunes(
						63) & strings.MinRunes(
						1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"

				// Port is the network port this Route targets. It can be
				// interpreted
				// differently based on the type of parent resource.
				//
				// When the parent resource is a Gateway, this targets all
				// listeners
				// listening on the specified port that also support this kind of
				// Route(and
				// select this Route). It's not recommended to set `Port` unless
				// the
				// networking behaviors specified in a Route must apply to a
				// specific port
				// as opposed to a listener(s) whose port(s) may be changed. When
				// both Port
				// and SectionName are specified, the name and port of the
				// selected listener
				// must match both specified values.
				//
				// Implementations MAY choose to support other parent resources.
				// Implementations supporting other types of parent resources MUST
				// clearly
				// document how/if Port is interpreted.
				//
				// For the purpose of status, an attachment is considered
				// successful as
				// long as the parent resource accepts it partially. For example,
				// Gateway
				// listeners can restrict which Routes can attach to them by Route
				// kind,
				// namespace, or hostname. If 1 of 2 Gateway listeners accept
				// attachment
				// from the referencing Route, the Route MUST be considered
				// successfully
				// attached. If no Gateway listeners accept attachment from this
				// Route,
				// the Route MUST be considered detached from the Gateway.
				//
				// Support: Extended
				port?: int32 & int & <=65535 & >=1

				// SectionName is the name of a section within the target
				// resource. In the
				// following resources, SectionName is interpreted as the
				// following:
				//
				// * Gateway: Listener name. When both Port (experimental) and
				// SectionName
				// are specified, the name and port of the selected listener must
				// match
				// both specified values.
				// * Service: Port name. When both Port (experimental) and
				// SectionName
				// are specified, the name and port of the selected listener must
				// match
				// both specified values.
				//
				// Implementations MAY choose to support attaching Routes to other
				// resources.
				// If that is the case, they MUST clearly document how SectionName
				// is
				// interpreted.
				//
				// When unspecified (empty string), this will reference the entire
				// resource.
				// For the purpose of status, an attachment is considered
				// successful if at
				// least one section in the parent resource accepts it. For
				// example, Gateway
				// listeners can restrict which Routes can attach to them by Route
				// kind,
				// namespace, or hostname. If 1 of 2 Gateway listeners accept
				// attachment from
				// the referencing Route, the Route MUST be considered
				// successfully
				// attached. If no Gateway listeners accept attachment from this
				// Route, the
				// Route MUST be considered detached from the Gateway.
				//
				// Support: Core
				sectionName?: strings.MaxRunes(
						253) & strings.MinRunes(
						1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
			}
		}]
	}

	_embeddedResource: {
		apiVersion!: string
		kind!:       string
		metadata?: {
			...
		}
	}
	apiVersion: "gateway.networking.k8s.io/v1beta1"
	kind:       "HTTPRoute"
	metadata!: {
		name!:      string
		namespace!: string
		labels?: [string]: string
		annotations?: [string]: string
		...
	}
}
