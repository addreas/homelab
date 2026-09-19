package talos

import (
	"github.com/siderolabs/talos/pkg/machinery/config/types/block"
	"github.com/siderolabs/talos/pkg/machinery/config/types/cluster"
	"github.com/siderolabs/talos/pkg/machinery/config/types/container"
	"github.com/siderolabs/talos/pkg/machinery/config/types/cri"
	"github.com/siderolabs/talos/pkg/machinery/config/types/hardware"
	"github.com/siderolabs/talos/pkg/machinery/config/types/k8s"
	"github.com/siderolabs/talos/pkg/machinery/config/types/network"
	"github.com/siderolabs/talos/pkg/machinery/config/types/runtime"
	"github.com/siderolabs/talos/pkg/machinery/config/types/runtime/extensions"
	"github.com/siderolabs/talos/pkg/machinery/config/types/security"
	"github.com/siderolabs/talos/pkg/machinery/config/types/siderolink"
	"github.com/siderolabs/talos/pkg/machinery/config/types/storage"
	"github.com/siderolabs/talos/pkg/machinery/config/types/v1alpha1"
)

// every talos multi-doc config document type: every generated def embedding
// meta.#Meta — regenerate when upstream adds kinds:
//
//	grep -rB1 'meta.#Meta$' cue.mod/gen/github.com/siderolabs/talos/pkg/machinery/config/types
#Patch: or([
	v1alpha1.#Config,
	block.#ExistingVolumeConfigV1Alpha1,
	block.#ExternalVolumeConfigV1Alpha1,
	block.#FilesystemScrubConfigV1Alpha1,
	block.#FilesystemTrimConfigV1Alpha1,
	block.#RawVolumeConfigV1Alpha1,
	block.#SwapVolumeConfigV1Alpha1,
	block.#UserVolumeConfigV1Alpha1,
	block.#VolumeConfigV1Alpha1,
	block.#ZswapConfigV1Alpha1,

	cluster.#DiscoveryIdentityConfigV1Alpha1,
	cluster.#DiscoveryServiceConfigV1Alpha1,

	container.#ContainerConfigV1Alpha1,

	cri.#CRIBaseRuntimeSpecConfigV1Alpha1,
	cri.#CRICustomizationConfigV1Alpha1,
	cri.#ImageCacheConfigV1Alpha1,
	cri.#RegistryAuthConfigV1Alpha1,
	cri.#RegistryMirrorConfigV1Alpha1,
	cri.#RegistryTLSConfigV1Alpha1,

	extensions.#ServiceConfigV1Alpha1,

	hardware.#PCIDriverRebindConfigV1Alpha1,

	k8s.#KubeAPIServerCAConfigV1Alpha1,
	k8s.#KubeAPIServerConfigV1Alpha1,
	k8s.#KubeAdmissionControlConfigV1Alpha1,
	k8s.#KubeAggregatorCAConfigV1Alpha1,
	k8s.#KubeAuditPolicyConfigV1Alpha1,
	k8s.#KubeAuthenticationConfigV1Alpha1,
	k8s.#KubeAuthorizerConfigV1Alpha1,
	k8s.#KubeClusterConfigV1Alpha1,
	k8s.#KubeControllerManagerConfigV1Alpha1,
	k8s.#KubeCoreDNSConfigV1Alpha1,
	k8s.#KubeCredentialProviderConfigV1Alpha1,
	k8s.#KubeEtcdEncryptionConfigV1Alpha1,
	k8s.#KubeExternalManifestConfigV1Alpha1,
	k8s.#KubeFlannelCNIConfigV1Alpha1,
	k8s.#KubeInlineManifestConfigV1Alpha1,
	k8s.#KubeNetworkConfigV1Alpha1,
	k8s.#KubeNodeConfigV1Alpha1,
	k8s.#KubePrismConfigV1Alpha1,
	k8s.#KubeProxyConfigV1Alpha1,
	k8s.#KubeSchedulerConfigV1Alpha1,
	k8s.#KubeServiceAccountConfigV1Alpha1,
	k8s.#KubeStaticPodConfigV1Alpha1,
	k8s.#KubeTalosAPIAccessConfigV1Alpha1,
	k8s.#KubeletConfigV1Alpha1,

	network.#BGPInstanceConfigV1Alpha1,
	network.#BlackholeRouteConfigV1Alpha1,
	network.#BondConfigV1Alpha1,
	network.#BridgeConfigV1Alpha1,
	network.#DHCPv4ConfigV1Alpha1,
	network.#DHCPv6ConfigV1Alpha1,
	network.#DefaultActionConfigV1Alpha1,
	network.#DummyLinkConfigV1Alpha1,
	network.#EthernetConfigV1Alpha1,
	network.#HCloudVIPConfigV1Alpha1,
	network.#HTTPProbeConfigV1Alpha1,
	network.#HostnameConfigV1Alpha1,
	network.#KubeSpanConfigV1Alpha1,
	network.#KubespanEndpointsConfigV1Alpha1,
	network.#Layer2VIPConfigV1Alpha1,
	network.#LinkAliasConfigV1Alpha1,
	network.#LinkConfigV1Alpha1,
	network.#ResolverConfigV1Alpha1,
	network.#RoutingRuleConfigV1Alpha1,
	network.#RuleConfigV1Alpha1,
	network.#StaticHostConfigV1Alpha1,
	network.#TCPProbeConfigV1Alpha1,
	network.#TimeSyncConfigV1Alpha1,
	network.#VLANConfigV1Alpha1,
	network.#VRFConfigV1Alpha1,
	network.#VethConfigV1Alpha1,
	network.#WireguardConfigV1Alpha1,

	runtime.#EnvironmentV1Alpha1,
	runtime.#EtcFileConfigV1Alpha1,
	runtime.#EventSinkV1Alpha1,
	runtime.#KernelModuleConfigV1Alpha1,
	runtime.#KmsgLogV1Alpha1,
	runtime.#OOMV1Alpha1,
	runtime.#SecurityProfileConfigV1Alpha1,
	runtime.#SysctlConfigV1Alpha1,
	runtime.#SysfsConfigV1Alpha1,
	runtime.#UdevRulesConfigV1Alpha1,
	runtime.#UnattendedInstallConfigV1Alpha1,
	runtime.#WatchdogTimerV1Alpha1,

	security.#ImageVerificationConfigV1Alpha1,
	security.#TrustedRootsConfigV1Alpha1,

	siderolink.#ConfigV1Alpha1,

	storage.#LVMLogicalVolumeConfigV1Alpha1,
	storage.#LVMVolumeGroupConfigV1Alpha1,
	storage.#RAIDArrayConfigV1Alpha1,
])
