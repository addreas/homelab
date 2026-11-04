package v1

import (
	"list"
	"strings"
)

#ImageCatalog: {
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

	// Specification of the desired behavior of the ImageCatalog.
	// More info:
	// https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#spec-and-status
	spec!: {
		// ComponentImages is a list of named images for components other than PostgreSQL
		// (e.g. pgbouncer). Keys must be unique within a catalog.
		componentImages?: list.MaxItems(32) & [...{
			// Image is the container image reference.
			image!: string

			// Key is the unique identifier for this image within the catalog.
			key!: strings.MaxRunes(
				63) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
		}]

		// List of CatalogImages available in the catalog
		images!: list.MaxItems(8) & [...{
			// The configuration of the extensions to be added
			extensions?: [...{
				// A list of directories within the image to be appended to the
				// PostgreSQL process's `PATH` environment variable.
				bin_path?: [...string]

				// The list of directories inside the image which should be added to dynamic_library_path.
				// If not defined, defaults to "/lib".
				dynamic_library_path?: [...string]

				// Env is a list of custom environment variables to be set in the
				// PostgreSQL process for this extension. It is the responsibility of the
				// cluster administrator to ensure the variables are correct for the
				// specific extension. Note that changes to these variables require
				// a manual cluster restart to take effect.
				env?: [...{
					// Name of the environment variable to be injected into the
					// PostgreSQL process.
					name!: strings.MinRunes(
						1) & =~"^[a-zA-Z_][a-zA-Z0-9_]*$"

					// Value of the environment variable. CloudNativePG performs a direct
					// replacement of this value, with support for placeholder expansion.
					// The ${`image_root`} placeholder resolves to the absolute mount path
					// of the extension's volume (e.g., `/extensions/my-extension`). This
					// is particularly useful for allowing applications or libraries to
					// locate specific directories within the mounted image.
					// Unrecognized placeholders are rejected. To include a literal ${...}
					// in the value, escape it as $${...}.
					value!: strings.MinRunes(
						1)
				}]

				// The list of directories inside the image which should be added to extension_control_path.
				// If not defined, defaults to "/share".
				extension_control_path?: [...string]

				// The image containing the extension.
				image?: {
					// Policy for pulling OCI objects. Possible values are:
					// Always: the kubelet always attempts to pull the reference. Container creation
					// will fail If the pull fails.
					// Never: the kubelet never pulls the reference and only uses a local image or
					// artifact. Container creation will fail if the reference isn't present.
					// IfNotPresent: the kubelet pulls if the reference isn't already present on
					// disk. Container creation will fail if the reference isn't present and the
					// pull fails.
					// Defaults to Always if :latest tag is specified, or IfNotPresent otherwise.
					pullPolicy?: string

					// Required: Image or artifact reference to be used.
					// Behaves in the same way as pod.spec.containers[*].image.
					// Pull secrets will be assembled in the same way as for the container image by
					// looking up node credentials, SA image pull secrets, and pod spec image pull
					// secrets.
					// More info: https://kubernetes.io/docs/concepts/containers/images
					// This field is optional to allow higher level config management to default or override
					// container images in workload controllers like Deployments and StatefulSets.
					reference?: string
				}

				// The list of directories inside the image which should be added to ld_library_path.
				ld_library_path?: [...string]

				// The name of the extension, required. The limit of 59 characters
				// leaves room for the prefix the operator adds when deriving the
				// extension's Kubernetes Volume name (capped at 63 characters).
				name!: strings.MaxRunes(
					59) & strings.MinRunes(
					1) & =~"^[a-z0-9]([-a-z0-9_]*[a-z0-9])?$"
			}]

			// The image reference
			image!: string

			// The PostgreSQL major version of the image. Must be unique within the catalog.
			major!: int & >=10
		}] & [_, ...]
	}

	_embeddedResource: {
		apiVersion!: string
		kind!:       string
		metadata?: {
			...
		}
	}
	apiVersion: "postgresql.cnpg.io/v1"
	kind:       "ImageCatalog"
	metadata!: {
		name!:      string
		namespace!: string
		labels?: [string]: string
		annotations?: [string]: string
		...
	}
}
