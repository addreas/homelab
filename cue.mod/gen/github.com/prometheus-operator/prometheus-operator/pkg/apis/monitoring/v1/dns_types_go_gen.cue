// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/prometheus-operator/prometheus-operator/pkg/apis/monitoring/v1

// Copyright 2024 The prometheus-operator Authors
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//	http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
package v1

// PodDNSConfig defines the DNS parameters of a pod in addition to
// those generated from DNSPolicy.
#PodDNSConfig: {
	// A list of DNS name server IP addresses.
	// This will be appended to the base nameservers generated from DNSPolicy.
	// +kubebuilder:validation:Optional
	// +listType:=set
	// +kubebuilder:validation:items:MinLength:=1
	nameservers?: [...string] @go(Nameservers,[]string)

	// A list of DNS search domains for host-name lookup.
	// This will be appended to the base search paths generated from DNSPolicy.
	// +kubebuilder:validation:Optional
	// +listType:=set
	// +kubebuilder:validation:items:MinLength:=1
	searches?: [...string] @go(Searches,[]string)

	// A list of DNS resolver options.
	// This will be merged with the base options generated from DNSPolicy.
	// Resolution options given in Options
	// will override those that appear in the base DNSPolicy.
	// +kubebuilder:validation:Optional
	// +listType=map
	// +listMapKey=name
	options?: [...#PodDNSConfigOption] @go(Options,[]PodDNSConfigOption)
}

// PodDNSConfigOption defines DNS resolver options of a pod.
#PodDNSConfigOption: {
	// Name is required and must be unique.
	// +kubebuilder:validation:MinLength=1
	name: string @go(Name)

	// Value is optional.
	// +kubebuilder:validation:Optional
	value?: null | string @go(Value,*string)
}

// DNSPolicy specifies the DNS policy for the pod.
// +kubebuilder:validation:Enum=ClusterFirstWithHostNet;ClusterFirst;Default;None
#DNSPolicy: string // #enumDNSPolicy

#enumDNSPolicy:
	#DNSClusterFirstWithHostNet |
	#DNSClusterFirst |
	#DNSDefault |
	#DNSNone

// DNSClusterFirstWithHostNet indicates that the pod should use cluster DNS
// first, if it is available, then fall back on the default
// (as determined by kubelet) DNS settings.
#DNSClusterFirstWithHostNet: #DNSPolicy & "ClusterFirstWithHostNet"

// DNSClusterFirst indicates that the pod should use cluster DNS
// first unless hostNetwork is true, if it is available, then
// fall back on the default (as determined by kubelet) DNS settings.
#DNSClusterFirst: #DNSPolicy & "ClusterFirst"

// DNSDefault indicates that the pod should use the default (as
// determined by kubelet) DNS settings.
#DNSDefault: #DNSPolicy & "Default"

// DNSNone indicates that the pod should use empty DNS settings. DNS
// parameters such as nameservers and search paths should be defined via
// DNSConfig.
#DNSNone: #DNSPolicy & "None"