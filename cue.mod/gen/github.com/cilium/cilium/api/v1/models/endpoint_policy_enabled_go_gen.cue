// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/cilium/cilium/api/v1/models

package models

// EndpointPolicyEnabled Whether policy enforcement is enabled (ingress, egress, both or none)
//
// swagger:model EndpointPolicyEnabled
#EndpointPolicyEnabled: string // #enumEndpointPolicyEnabled

#enumEndpointPolicyEnabled:
	#EndpointPolicyEnabledNone |
	#EndpointPolicyEnabledIngress |
	#EndpointPolicyEnabledEgress |
	#EndpointPolicyEnabledBoth |
	#EndpointPolicyEnabledAuditDashIngress |
	#EndpointPolicyEnabledAuditDashEgress |
	#EndpointPolicyEnabledAuditDashBoth

// EndpointPolicyEnabledNone captures enum value "none"
#EndpointPolicyEnabledNone: #EndpointPolicyEnabled & "none"

// EndpointPolicyEnabledIngress captures enum value "ingress"
#EndpointPolicyEnabledIngress: #EndpointPolicyEnabled & "ingress"

// EndpointPolicyEnabledEgress captures enum value "egress"
#EndpointPolicyEnabledEgress: #EndpointPolicyEnabled & "egress"

// EndpointPolicyEnabledBoth captures enum value "both"
#EndpointPolicyEnabledBoth: #EndpointPolicyEnabled & "both"

// EndpointPolicyEnabledAuditDashIngress captures enum value "audit-ingress"
#EndpointPolicyEnabledAuditDashIngress: #EndpointPolicyEnabled & "audit-ingress"

// EndpointPolicyEnabledAuditDashEgress captures enum value "audit-egress"
#EndpointPolicyEnabledAuditDashEgress: #EndpointPolicyEnabled & "audit-egress"

// EndpointPolicyEnabledAuditDashBoth captures enum value "audit-both"
#EndpointPolicyEnabledAuditDashBoth: #EndpointPolicyEnabled & "audit-both"