// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/cilium/cilium/pkg/k8s/apis/cilium.io/v2

package v2

// CustomResourceDefinitionGroup is the name of the third party resource group
#CustomResourceDefinitionGroup: "cilium.io"

// CustomResourceDefinitionVersion is the current version of the resource
#CustomResourceDefinitionVersion: "v2"

// CustomResourceDefinitionSchemaVersion is semver-conformant version of CRD schema
// Used to determine if CRD needs to be updated in cluster
//
// Maintainers: Run ./Documentation/check-crd-compat-table.sh for each release
// Developers: Bump patch for each change in the CRD schema.
#CustomResourceDefinitionSchemaVersion: "1.22.5"

// CustomResourceDefinitionSchemaVersionKey is key to label which holds the CRD schema version
#CustomResourceDefinitionSchemaVersionKey: "io.cilium.k8s.crd.schema.version"

// CNPSingularName is the singular name of Cilium Network Policy
#CNPSingularName: "ciliumnetworkpolicy"

// CNPPluralName is the plural name of Cilium Network Policy
#CNPPluralName: "ciliumnetworkpolicies"

// CNPKindDefinition is the kind name for Cilium Network Policy
#CNPKindDefinition: "CiliumNetworkPolicy"

// CNPName is the full name of Cilium Network Policy
#CNPName: "ciliumnetworkpolicies.cilium.io"

// CCNPSingularName is the singular name of Cilium Cluster wide Network Policy
#CCNPSingularName: "ciliumclusterwidenetworkpolicy"

// CCNPPluralName is the plural name of Cilium Cluster wide Network Policy
#CCNPPluralName: "ciliumclusterwidenetworkpolicies"

// CCNPKindDefinition is the kind name for Cilium Cluster wide Network Policy
#CCNPKindDefinition: "CiliumClusterwideNetworkPolicy"

// CCNPName is the full name of Cilium Cluster wide Network Policy
#CCNPName: "ciliumclusterwidenetworkpolicies.cilium.io"

// CESingularName is the singular name of Cilium Endpoint
#CEPSingularName: "ciliumendpoint"

// CEPluralName is the plural name of Cilium Endpoint
#CEPPluralName: "ciliumendpoints"

// CEKindDefinition is the kind name for Cilium Endpoint
#CEPKindDefinition: "CiliumEndpoint"

// CEPName is the full name of Cilium Endpoint
#CEPName: "ciliumendpoints.cilium.io"

// CNSingularName is the singular name of Cilium Node
#CNSingularName: "ciliumnode"

// CNPluralName is the plural name of Cilium Node
#CNPluralName: "ciliumnodes"

// CNKindDefinition is the kind name for Cilium Node
#CNKindDefinition: "CiliumNode"

// CNName is the full name of Cilium Node
#CNName: "ciliumnodes.cilium.io"

// CIDSingularName is the singular name of Cilium Identity
#CIDSingularName: "ciliumidentity"

// CIDPluralName is the plural name of Cilium Identity
#CIDPluralName: "ciliumidentities"

// CIDKindDefinition is the kind name for Cilium Identity
#CIDKindDefinition: "CiliumIdentity"

// CIDName is the full name of Cilium Identity
#CIDName: "ciliumidentities.cilium.io"

// CLRPSingularName is the singular name of Local Redirect Policy
#CLRPSingularName: "ciliumlocalredirectpolicy"

// CLRPPluralName is the plural name of Local Redirect Policy
#CLRPPluralName: "ciliumlocalredirectpolicies"

// CLRPKindDefinition is the kind name for Local Redirect Policy
#CLRPKindDefinition: "CiliumLocalRedirectPolicy"

// CLRPName is the full name of Local Redirect Policy
#CLRPName: "ciliumlocalredirectpolicies.cilium.io"

// CEWSingularName is the singular name of Cilium External Workload
#CEWSingularName: "ciliumexternalworkload"

// CEWPluralName is the plural name of Cilium External Workload
#CEWPluralName: "ciliumexternalworkloads"

// CEWKindDefinition is the kind name for Cilium External Workload
#CEWKindDefinition: "CiliumExternalWorkload"

// CEWName is the full name of Cilium External Workload
#CEWName: "ciliumexternalworkloads.cilium.io"
