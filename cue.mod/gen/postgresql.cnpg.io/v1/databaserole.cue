package v1

import (
	"time"
	"strings"
)

#DatabaseRole: {
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
	metadata!: {}

	// Specification of the desired DatabaseRole.
	// More info:
	// https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#spec-and-status
	spec!: {
		// Whether a role bypasses every row-level security (RLS) policy.
		// Default is `false`.
		bypassrls?: bool

		// ClientCertificate configures the operator to generate and renew a TLS client
		// certificate for this role, signed by the cluster's client CA. The certificate
		// is stored in a Secret named `<databaserole-name>-client-cert`.
		// Requires login to be true.
		clientCertificate?: {
			// Enabled turns on client certificate issuance for this role. When true,
			// the role must have login enabled. Defaults to true when the block is present.
			enabled?: bool
		}

		// The corresponding cluster
		cluster!: {
			// Name of the referent.
			// This field is effectively required, but due to backwards compatibility is
			// allowed to be empty. Instances of this type with an empty value here are
			// almost certainly wrong.
			// More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
			name?: string
		}

		// Description of the role
		comment?: string

		// If the role can log in, this specifies how many concurrent
		// connections the role can make. `-1` (the default) means no limit.
		connectionLimit?: int64 & int

		// When set to `true`, the role being defined will be allowed to create
		// new databases. Specifying `false` (default) will deny a role the
		// ability to create databases.
		createdb?: bool

		// Whether the role will be permitted to create, alter, drop, comment
		// on, change the security label for, and grant or revoke membership in
		// other roles. Default is `false`.
		createrole?: bool

		// The policy for end-of-life maintenance of this role
		databaseRoleReclaimPolicy?: "delete" | "retain"

		// DisablePassword indicates that a role's password should be set to NULL in Postgres
		disablePassword?: bool

		// Ensure the role is `present` or `absent` - defaults to "present"
		ensure?: "present" | "absent"

		// List of one or more existing roles to which this role will be
		// immediately added as a new member. Default empty.
		// Changes to the list are applied to an existing role through
		// `GRANT` and `REVOKE` statements, not only at role creation.
		inRoles?: [...string]

		// Whether a role "inherits" the privileges of roles it is a member of.
		// Default is `true`.
		inherit?: bool

		// Whether the role is allowed to log in. A role having the `login`
		// attribute can be thought of as a user. Roles without this attribute
		// are useful for managing database privileges, but are not users in
		// the usual sense of the word. Default is `false`.
		login?: bool

		// Name of the role
		name!: string

		// Secret containing the password of the role (if present).
		// If null, the password will be ignored unless DisablePassword is set.
		// When set, the secret must follow the `kubernetes.io/basic-auth` format
		// and contain both a `username` and a `password` field.
		passwordSecret?: {
			// Name of the referent.
			name!: string
		}

		// Whether a role is a replication role. A role must have this
		// attribute (or be a superuser) in order to be able to connect to the
		// server in replication mode (physical or logical replication) and in
		// order to be able to create or drop replication slots. A role having
		// the `replication` attribute is a very highly privileged role, and
		// should only be used on roles actually used for replication. Default
		// is `false`.
		replication?: bool

		// Whether the role is a `superuser` who can override all access
		// restrictions within the database - superuser status is dangerous and
		// should be used only when really needed. You must yourself be a
		// superuser to create a new superuser. Defaults is `false`.
		superuser?: bool

		// Date and time after which the role's password is no longer valid.
		// When omitted, the password will never expire (default).
		validUntil?: time.Time
	}

	// Most recently observed status of the DatabaseRole. This data may not be up
	// to date. Populated by the system. Read-only.
	// More info:
	// https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#spec-and-status
	status?: {
		// Applied is true if the role was reconciled correctly
		applied?: bool

		// ClientCertificate holds the observed state of the generated TLS client
		// certificate, when client certificate issuance is enabled.
		clientCertificate?: {
			// Expiration is the expiration time of the generated client certificate, in RFC3339 format.
			expiration?: string

			// Message contains a human-readable explanation of the current certificate status,
			// such as why issuance was skipped or why an existing Secret was left untouched.
			message?: string
		}

		// Conditions for the DatabaseRole object
		conditions?: [...{
			// lastTransitionTime is the last time the condition transitioned from one status to another.
			// This should be when the underlying condition changed. If that is not known,
			// then using the time when the API field changed is acceptable.
			lastTransitionTime!: time.Time

			// message is a human readable message indicating details about the transition.
			// This may be an empty string.
			message!: strings.MaxRunes(
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
					1) & =~"^[A-Za-z]([A-Za-z0-9_,:]*[A-Za-z0-9_])?$"

			// status of the condition, one of True, False, Unknown.
			status!: "True" | "False" | "Unknown"

			// type of condition in CamelCase or in foo.example.com/CamelCase.
			type!: strings.MaxRunes(
				316) & =~"^([a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*/)?(([A-Za-z0-9][-A-Za-z0-9_.]*)?[A-Za-z0-9])$"
		}]

		// Message is the reconciliation error message
		message?: string

		// A sequence number representing the latest
		// desired state that was synchronized
		observedGeneration?: int64 & int

		// SecretResourceVersion is the resource version of the password secret
		// last applied to the role; a change to it triggers reconciliation.
		secretResourceVersion?: string
	}

	_embeddedResource: {
		apiVersion!: string
		kind!:       string
		metadata?: {
			...
		}
	}
	apiVersion: "postgresql.cnpg.io/v1"
	kind:       "DatabaseRole"
	metadata!: {
		name!:      string
		namespace!: string
		labels?: [string]: string
		annotations?: [string]: string
		...
	}
}
