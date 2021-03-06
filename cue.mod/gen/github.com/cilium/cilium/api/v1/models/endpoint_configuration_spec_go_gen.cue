// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/cilium/cilium/api/v1/models

package models

// EndpointConfigurationSpec An endpoint's configuration
//
// swagger:model EndpointConfigurationSpec
#EndpointConfigurationSpec: {
	// the endpoint's labels
	"label-configuration"?: null | #LabelConfigurationSpec @go(LabelConfiguration,*LabelConfigurationSpec)

	// Changeable configuration
	options?: #ConfigurationMap @go(Options)
}
