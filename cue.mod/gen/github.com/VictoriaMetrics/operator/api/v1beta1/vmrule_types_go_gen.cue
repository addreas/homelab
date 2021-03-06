// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/VictoriaMetrics/operator/api/v1beta1

package v1beta1

import (
	"k8s.io/apimachinery/pkg/util/intstr"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

// VMRuleSpec defines the desired state of VMRule
#VMRuleSpec: {
	// Groups list of group rules
	groups: [...#RuleGroup] @go(Groups,[]RuleGroup)
}

// RuleGroup is a list of sequentially evaluated recording and alerting rules.
// +k8s:openapi-gen=true
#RuleGroup: {
	// Name of group
	name: string @go(Name)

	// evaluation interval for group
	// +optional
	interval?: string @go(Interval)

	// Rules list of alert rules
	rules: [...#Rule] @go(Rules,[]Rule)

	// Concurrency defines how many rules execute at once.
	// +optional
	concurrency?: int @go(Concurrency)
}

// Rule describes an alerting or recording rule.
// +k8s:openapi-gen=true
#Rule: {
	// Record represents a query, that will be recorded to dataSource
	// +optional
	record?: string @go(Record)

	// Alert is a name for alert
	// +optional
	alert?: string @go(Alert)

	// Expr is query, that will be evaluated at dataSource
	// +optional
	expr: intstr.#IntOrString @go(Expr)

	// For evaluation interval in time.Duration format
	// 30s, 1m, 1h  or nanoseconds
	// +optional
	for?: string @go(For)

	// Labels will be added to rule configuration
	// +optional
	labels?: {[string]: string} @go(Labels,map[string]string)

	// Annotations will be added to rule configuration
	// +optional
	annotations?: {[string]: string} @go(Annotations,map[string]string)
}

// VMRuleStatus defines the observed state of VMRule
#VMRuleStatus: {
}

// VMRule defines rule records for vmalert application
// +operator-sdk:gen-csv:customresourcedefinitions.displayName="VMRule"
// +kubebuilder:subresource:status
// +kubebuilder:resource:path=vmrules,scope=Namespaced
// +genclient
// +k8s:deepcopy-gen:interfaces=k8s.io/apimachinery/pkg/runtime.Object
#VMRule: {
	metav1.#TypeMeta
	metadata?: metav1.#ObjectMeta @go(ObjectMeta)
	spec:      #VMRuleSpec        @go(Spec)

	// +optional
	status?: #VMRuleStatus @go(Status)
}

// VMRuleList contains a list of VMRule
#VMRuleList: {
	metav1.#TypeMeta

	// +optional
	metadata?: metav1.#ListMeta @go(ListMeta)

	// Items list of VMRule
	items: [...null | #VMRule] @go(Items,[]*VMRule)
}
