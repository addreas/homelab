// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go k8s.io/client-go/rest

package rest

import (
	"k8s.io/apimachinery/pkg/runtime/schema"
	"k8s.io/apimachinery/pkg/runtime"
)

// Environment variables: Note that the duration should be long enough that the backoff
// persists for some reasonable time (i.e. 120 seconds).  The typical base might be "1".
_#envBackoffBase:     "KUBE_CLIENT_BACKOFF_BASE"
_#envBackoffDuration: "KUBE_CLIENT_BACKOFF_DURATION"

// Interface captures the set of operations for generically interacting with Kubernetes REST apis.
#Interface: _

// ClientContentConfig controls how RESTClient communicates with the server.
//
// TODO: ContentConfig will be updated to accept a Negotiator instead of a
//
//	NegotiatedSerializer and NegotiatedSerializer will be removed.
#ClientContentConfig: {
	// AcceptContentTypes specifies the types the client will accept and is optional.
	// If not set, ContentType will be used to define the Accept header
	AcceptContentTypes: string

	// ContentType specifies the wire format used to communicate with the server.
	// This value will be set as the Accept header on requests made to the server if
	// AcceptContentTypes is not set, and as the default content type on any object
	// sent to the server. If not set, "application/json" is used.
	ContentType: string

	// GroupVersion is the API version to talk to. Must be provided when initializing
	// a RESTClient directly. When initializing a Client, will be set with the default
	// code version. This is used as the default group version for VersionedParams.
	GroupVersion: schema.#GroupVersion

	// Negotiator is used for obtaining encoders and decoders for multiple
	// supported media types.
	Negotiator: runtime.#ClientNegotiator
}

// RESTClient imposes common Kubernetes API conventions on a set of resource paths.
// The baseURL is expected to point to an HTTP or HTTPS path that is the parent
// of one or more resources.  The server should return a decodable API resource
// object, or an api.Status object which contains information about the reason for
// any failure.
//
// Most consumers should use client.New() to get a Kubernetes API client.
#RESTClient: {
}