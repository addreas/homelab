// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/grafana-operator/grafana-operator/v4/api/integreatly/v1alpha1

package v1alpha1

import (
	"k8s.io/api/core/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
	"k8s.io/apimachinery/pkg/api/resource"
	appsv1 "k8s.io/api/apps/v1"
	v12 "github.com/openshift/api/route/v1"
)

#StatusPhase: string

#GrafanaSpec: {
	config: #GrafanaConfig @go(Config)
	containers?: [...v1.#Container] @go(Containers,[]v1.Container)
	dashboardLabelSelector?: [...null | metav1.#LabelSelector] @go(DashboardLabelSelector,[]*metav1.LabelSelector)
	ingress?:       null | #GrafanaIngress          @go(Ingress,*GrafanaIngress)
	initResources?: null | v1.#ResourceRequirements @go(InitResources,*v1.ResourceRequirements)
	secrets?: [...string] @go(Secrets,[]string)
	configMaps?: [...string] @go(ConfigMaps,[]string)
	service?:                    null | #GrafanaService          @go(Service,*GrafanaService)
	deployment?:                 null | #GrafanaDeployment       @go(Deployment,*GrafanaDeployment)
	resources?:                  null | v1.#ResourceRequirements @go(Resources,*v1.ResourceRequirements)
	serviceAccount?:             null | #GrafanaServiceAccount   @go(ServiceAccount,*GrafanaServiceAccount)
	client?:                     null | #GrafanaClient           @go(Client,*GrafanaClient)
	dashboardNamespaceSelector?: null | metav1.#LabelSelector    @go(DashboardNamespaceSelector,*metav1.LabelSelector)
	dataStorage?:                null | #GrafanaDataStorage      @go(DataStorage,*GrafanaDataStorage)
	jsonnet?:                    null | #JsonnetConfig           @go(Jsonnet,*JsonnetConfig)
	baseImage?:                  string                          @go(BaseImage)
	initImage?:                  string                          @go(InitImage)
	livenessProbeSpec?:          null | #LivenessProbeSpec       @go(LivenessProbeSpec,*LivenessProbeSpec)
	readinessProbeSpec?:         null | #ReadinessProbeSpec      @go(ReadinessProbeSpec,*ReadinessProbeSpec)
}

#ReadinessProbeSpec: {
	initialDelaySeconds?: int32 @go(InitialDelaySeconds)
	timeoutSeconds?:      int32 @go(TimeOutSeconds)
	periodSeconds?:       int32 @go(PeriodSeconds)
	successThreshold?:    int32 @go(SuccessThreshold)
	failureThreshold?:    int32 @go(FailureThreshold)
}

#LivenessProbeSpec: {
	initialDelaySeconds?: int32 @go(InitialDelaySeconds)
	timeoutSeconds?:      int32 @go(TimeOutSeconds)
	periodSeconds?:       int32 @go(PeriodSeconds)
	successThreshold?:    int32 @go(SuccessThreshold)
	failureThreshold?:    int32 @go(FailureThreshold)
}

#JsonnetConfig: {
	libraryLabelSelector?: null | metav1.#LabelSelector @go(LibraryLabelSelector,*metav1.LabelSelector)
}

// Grafana API client settings
#GrafanaClient: {
	// +nullable
	timeout?: null | int @go(TimeoutSeconds,*int)

	// +nullable
	preferService?: null | bool @go(PreferService,*bool)
}

// GrafanaService provides a means to configure the service
#GrafanaService: {
	name?: string @go(Name)
	annotations?: {[string]: string} @go(Annotations,map[string]string)
	labels?: {[string]: string} @go(Labels,map[string]string)
	type?: v1.#ServiceType @go(Type)
	ports?: [...v1.#ServicePort] @go(Ports,[]v1.ServicePort)
	clusterIP?: string @go(ClusterIP)
}

// GrafanaDataStorage provides a means to configure the grafana data storage
#GrafanaDataStorage: {
	annotations?: {[string]: string} @go(Annotations,map[string]string)
	labels?: {[string]: string} @go(Labels,map[string]string)
	accessModes?: [...v1.#PersistentVolumeAccessMode] @go(AccessModes,[]v1.PersistentVolumeAccessMode)
	size?:  resource.#Quantity @go(Size)
	class?: string             @go(Class)
}

#GrafanaServiceAccount: {
	skip?: null | bool @go(Skip,*bool)
	annotations?: {[string]: string} @go(Annotations,map[string]string)
	labels?: {[string]: string} @go(Labels,map[string]string)
	imagePullSecrets?: [...v1.#LocalObjectReference] @go(ImagePullSecrets,[]v1.LocalObjectReference)
}

// GrafanaDeployment provides a means to configure the deployment
#GrafanaDeployment: {
	annotations?: {[string]: string} @go(Annotations,map[string]string)
	labels?: {[string]: string} @go(Labels,map[string]string)

	// +nullable
	replicas?: null | int32 @go(Replicas,*int32)
	nodeSelector?: {[string]: string} @go(NodeSelector,map[string]string)
	tolerations?: [...v1.#Toleration] @go(Tolerations,[]v1.Toleration)
	affinity?:                      null | v1.#Affinity           @go(Affinity,*v1.Affinity)
	securityContext?:               null | v1.#PodSecurityContext @go(SecurityContext,*v1.PodSecurityContext)
	containerSecurityContext?:      null | v1.#SecurityContext    @go(ContainerSecurityContext,*v1.SecurityContext)
	terminationGracePeriodSeconds?: null | int64                  @go(TerminationGracePeriodSeconds,*int64)
	envFrom?: [...v1.#EnvFromSource] @go(EnvFrom,[]v1.EnvFromSource)
	env?: [...v1.#EnvVar] @go(Env,[]v1.EnvVar)

	// +nullable
	skipCreateAdminAccount?: null | bool @go(SkipCreateAdminAccount,*bool)
	priorityClassName?:      string      @go(PriorityClassName)

	// +nullable
	hostNetwork?: null | bool @go(HostNetwork,*bool)
	extraVolumes?: [...v1.#Volume] @go(ExtraVolumes,[]v1.Volume)
	extraVolumeMounts?: [...v1.#VolumeMount] @go(ExtraVolumeMounts,[]v1.VolumeMount)
	strategy?:  null | appsv1.#DeploymentStrategy @go(Strategy,*appsv1.DeploymentStrategy)
	httpProxy?: null | #GrafanaHttpProxy          @go(HttpProxy,*GrafanaHttpProxy)
}

// GrafanaHttpProxy provides a means to configure the Grafana deployment
// to use a HTTP(S) proxy when making requests and resolving plugins.
#GrafanaHttpProxy: {
	enabled: bool   @go(Enabled)
	url?:    string @go(URL)
}

// GrafanaIngress provides a means to configure the ingress created
#GrafanaIngress: {
	annotations?: {[string]: string} @go(Annotations,map[string]string)
	hostname?: string @go(Hostname)
	labels?: {[string]: string} @go(Labels,map[string]string)
	path?:             string                  @go(Path)
	enabled?:          bool                    @go(Enabled)
	tlsEnabled?:       bool                    @go(TLSEnabled)
	tlsSecretName?:    string                  @go(TLSSecretName)
	targetPort?:       string                  @go(TargetPort)
	termination?:      v12.#TLSTerminationType @go(Termination)
	ingressClassName?: string                  @go(IngressClassName)
	pathType?:         string                  @go(PathType)
}

// GrafanaConfig is the configuration for grafana
#GrafanaConfig: {
	paths?:                               null | #GrafanaConfigPaths                         @go(Paths,*GrafanaConfigPaths)
	server?:                              null | #GrafanaConfigServer                        @go(Server,*GrafanaConfigServer)
	database?:                            null | #GrafanaConfigDatabase                      @go(Database,*GrafanaConfigDatabase)
	remote_cache?:                        null | #GrafanaConfigRemoteCache                   @go(RemoteCache,*GrafanaConfigRemoteCache)
	security?:                            null | #GrafanaConfigSecurity                      @go(Security,*GrafanaConfigSecurity)
	users?:                               null | #GrafanaConfigUsers                         @go(Users,*GrafanaConfigUsers)
	auth?:                                null | #GrafanaConfigAuth                          @go(Auth,*GrafanaConfigAuth)
	"auth.basic"?:                        null | #GrafanaConfigAuthBasic                     @go(AuthBasic,*GrafanaConfigAuthBasic)
	"auth.anonymous"?:                    null | #GrafanaConfigAuthAnonymous                 @go(AuthAnonymous,*GrafanaConfigAuthAnonymous)
	"auth.azuread"?:                      null | #GrafanaConfigAuthAzureAD                   @go(AuthAzureAD,*GrafanaConfigAuthAzureAD)
	"auth.google"?:                       null | #GrafanaConfigAuthGoogle                    @go(AuthGoogle,*GrafanaConfigAuthGoogle)
	"auth.github"?:                       null | #GrafanaConfigAuthGithub                    @go(AuthGithub,*GrafanaConfigAuthGithub)
	"auth.gitlab"?:                       null | #GrafanaConfigAuthGitlab                    @go(AuthGitlab,*GrafanaConfigAuthGitlab)
	"auth.generic_oauth"?:                null | #GrafanaConfigAuthGenericOauth              @go(AuthGenericOauth,*GrafanaConfigAuthGenericOauth)
	"auth.okta"?:                         null | #GrafanaConfigAuthOkta                      @go(AuthOkta,*GrafanaConfigAuthOkta)
	"auth.ldap"?:                         null | #GrafanaConfigAuthLdap                      @go(AuthLdap,*GrafanaConfigAuthLdap)
	"auth.proxy"?:                        null | #GrafanaConfigAuthProxy                     @go(AuthProxy,*GrafanaConfigAuthProxy)
	"auth.saml"?:                         null | #GrafanaConfigAuthSaml                      @go(AuthSaml,*GrafanaConfigAuthSaml)
	dataproxy?:                           null | #GrafanaConfigDataProxy                     @go(DataProxy,*GrafanaConfigDataProxy)
	analytics?:                           null | #GrafanaConfigAnalytics                     @go(Analytics,*GrafanaConfigAnalytics)
	dashboards?:                          null | #GrafanaConfigDashboards                    @go(Dashboards,*GrafanaConfigDashboards)
	smtp?:                                null | #GrafanaConfigSmtp                          @go(Smtp,*GrafanaConfigSmtp)
	live?:                                null | #GrafanaConfigLive                          @go(Live,*GrafanaConfigLive)
	log?:                                 null | #GrafanaConfigLog                           @go(Log,*GrafanaConfigLog)
	"log.console"?:                       null | #GrafanaConfigLogConsole                    @go(LogConsole,*GrafanaConfigLogConsole)
	"log.frontend"?:                      null | #GrafanaConfigLogFrontend                   @go(LogFrontend,*GrafanaConfigLogFrontend)
	metrics?:                             null | #GrafanaConfigMetrics                       @go(Metrics,*GrafanaConfigMetrics)
	"metrics.graphite"?:                  null | #GrafanaConfigMetricsGraphite               @go(MetricsGraphite,*GrafanaConfigMetricsGraphite)
	snapshots?:                           null | #GrafanaConfigSnapshots                     @go(Snapshots,*GrafanaConfigSnapshots)
	external_image_storage?:              null | #GrafanaConfigExternalImageStorage          @go(ExternalImageStorage,*GrafanaConfigExternalImageStorage)
	"external_image_storage.s3"?:         null | #GrafanaConfigExternalImageStorageS3        @go(ExternalImageStorageS3,*GrafanaConfigExternalImageStorageS3)
	"external_image_storage.webdav"?:     null | #GrafanaConfigExternalImageStorageWebdav    @go(ExternalImageStorageWebdav,*GrafanaConfigExternalImageStorageWebdav)
	"external_image_storage.gcs"?:        null | #GrafanaConfigExternalImageStorageGcs       @go(ExternalImageStorageGcs,*GrafanaConfigExternalImageStorageGcs)
	"external_image_storage.azure_blob"?: null | #GrafanaConfigExternalImageStorageAzureBlob @go(ExternalImageStorageAzureBlob,*GrafanaConfigExternalImageStorageAzureBlob)
	alerting?:                            null | #GrafanaConfigAlerting                      @go(Alerting,*GrafanaConfigAlerting)
	panels?:                              null | #GrafanaConfigPanels                        @go(Panels,*GrafanaConfigPanels)
	plugins?:                             null | #GrafanaConfigPlugins                       @go(Plugins,*GrafanaConfigPlugins)
	rendering?:                           null | #GrafanaConfigRendering                     @go(Rendering,*GrafanaConfigRendering)
	feature_toggles?:                     null | #GrafanaConfigFeatureToggles                @go(FeatureToggles,*GrafanaConfigFeatureToggles)
}

#GrafanaConfigPaths: {
	temp_data_lifetime?: string @go(TempDataLifetime)
}

#GrafanaConfigServer: {
	http_addr?: string @go(HttpAddr)
	http_port?: string @go(HttpPort)
	protocol?:  string @go(Protocol)
	socket?:    string @go(Socket)
	domain?:    string @go(Domain)

	// +nullable
	enforce_domain?: null | bool @go(EnforceDomain,*bool)
	root_url?:       string      @go(RootUrl)

	// +nullable
	serve_from_sub_path?: null | bool @go(ServeFromSubPath,*bool)
	static_root_path?:    string      @go(StaticRootPath)

	// +nullable
	enable_gzip?: null | bool @go(EnableGzip,*bool)
	cert_file?:   string      @go(CertFile)
	cert_key?:    string      @go(CertKey)

	// +nullable
	router_logging?: null | bool @go(RouterLogging,*bool)
}

#GrafanaConfigDatabase: {
	url?:              string @go(Url)
	type?:             string @go(Type)
	path?:             string @go(Path)
	host?:             string @go(Host)
	name?:             string @go(Name)
	user?:             string @go(User)
	password?:         string @go(Password)
	ssl_mode?:         string @go(SslMode)
	ca_cert_path?:     string @go(CaCertPath)
	client_key_path?:  string @go(ClientKeyPath)
	client_cert_path?: string @go(ClientCertPath)
	server_cert_name?: string @go(ServerCertName)

	// +nullable
	max_idle_conn?: null | int @go(MaxIdleConn,*int)

	// +nullable
	max_open_conn?: null | int @go(MaxOpenConn,*int)

	// +nullable
	conn_max_lifetime?: null | int @go(ConnMaxLifetime,*int)

	// +nullable
	log_queries?: null | bool @go(LogQueries,*bool)
	cache_mode?:  string      @go(CacheMode)
}

#GrafanaConfigRemoteCache: {
	type?:    string @go(Type)
	connstr?: string @go(ConnStr)
}

#GrafanaConfigSecurity: {
	admin_user?:     string @go(AdminUser)
	admin_password?: string @go(AdminPassword)

	// +nullable
	login_remember_days?: null | int @go(LoginRememberDays,*int)
	secret_key?:          string     @go(SecretKey)

	// +nullable
	disable_gravatar?:            null | bool @go(DisableGravatar,*bool)
	data_source_proxy_whitelist?: string      @go(DataSourceProxyWhitelist)

	// +nullable
	cookie_secure?:   null | bool @go(CookieSecure,*bool)
	cookie_samesite?: string      @go(CookieSamesite)

	// +nullable
	allow_embedding?: null | bool @go(AllowEmbedding,*bool)

	// +nullable
	strict_transport_security?: null | bool @go(StrictTransportSecurity,*bool)

	// +nullable
	strict_transport_security_max_age_seconds?: null | int @go(StrictTransportSecurityMaxAgeSeconds,*int)

	// +nullable
	strict_transport_security_preload?: null | bool @go(StrictTransportSecurityPreload,*bool)

	// +nullable
	strict_transport_security_subdomains?: null | bool @go(StrictTransportSecuritySubdomains,*bool)

	// +nullable
	x_content_type_options?: null | bool @go(XContentTypeOptions,*bool)

	// +nullable
	x_xss_protection?: null | bool @go(XXssProtection,*bool)
}

#GrafanaConfigUsers: {
	// +nullable
	allow_sign_up?: null | bool @go(AllowSignUp,*bool)

	// +nullable
	allow_org_create?: null | bool @go(AllowOrgCreate,*bool)

	// +nullable
	auto_assign_org?:      null | bool @go(AutoAssignOrg,*bool)
	auto_assign_org_id?:   string      @go(AutoAssignOrgId)
	auto_assign_org_role?: string      @go(AutoAssignOrgRole)

	// +nullable
	viewers_can_edit?: null | bool @go(ViewersCanEdit,*bool)

	// +nullable
	editors_can_admin?: null | bool @go(EditorsCanAdmin,*bool)
	login_hint?:        string      @go(LoginHint)
	password_hint?:     string      @go(PasswordHint)
	default_theme?:     string      @go(DefaultTheme)
}

#GrafanaConfigAuth: {
	login_cookie_name?: string @go(LoginCookieName)

	// +nullable
	login_maximum_inactive_lifetime_days?:     null | int @go(LoginMaximumInactiveLifetimeDays,*int)
	login_maximum_inactive_lifetime_duration?: string     @go(LoginMaximumInactiveLifetimeDuration)

	// +nullable
	login_maximum_lifetime_days?:     null | int @go(LoginMaximumLifetimeDays,*int)
	login_maximum_lifetime_duration?: string     @go(LoginMaximumLifetimeDuration)

	// +nullable
	token_rotation_interval_minutes?: null | int @go(TokenRotationIntervalMinutes,*int)

	// +nullable
	disable_login_form?: null | bool @go(DisableLoginForm,*bool)

	// +nullable
	disable_signout_menu?: null | bool @go(DisableSignoutMenu,*bool)

	// +nullable
	sigv4_auth_enabled?:   null | bool @go(SigV4AuthEnabled,*bool)
	signout_redirect_url?: string      @go(SignoutRedirectUrl)

	// +nullable
	oauth_auto_login?: null | bool @go(OauthAutoLogin,*bool)
}

#GrafanaConfigAuthBasic: {
	// +nullable
	enabled?: null | bool @go(Enabled,*bool)
}

#GrafanaConfigAuthAnonymous: {
	// +nullable
	enabled?:  null | bool @go(Enabled,*bool)
	org_name?: string      @go(OrgName)
	org_role?: string      @go(OrgRole)
}

#GrafanaConfigAuthSaml: {
	// +nullable
	enabled?: null | bool @go(Enabled,*bool)

	// +nullable
	single_logout?: null | bool @go(SingleLogout,*bool)

	// +nullable
	allow_idp_initiated?:        null | bool @go(AllowIdpInitiated,*bool)
	certificate_path?:           string      @go(CertificatePath)
	private_key_path?:           string      @go(KeyPath)
	signature_algorithm?:        string      @go(SignatureAlgorithm)
	idp_metadata_url?:           string      @go(IdpUrl)
	max_issue_delay?:            string      @go(MaxIssueDelay)
	metadata_valid_duration?:    string      @go(MetadataValidDuration)
	relay_state?:                string      @go(RelayState)
	assertion_attribute_name?:   string      @go(AssertionAttributeName)
	assertion_attribute_login?:  string      @go(AssertionAttributeLogin)
	assertion_attribute_email?:  string      @go(AssertionAttributeEmail)
	assertion_attribute_groups?: string      @go(AssertionAttributeGroups)
	assertion_attribute_role?:   string      @go(AssertionAttributeRole)
	assertion_attribute_org?:    string      @go(AssertionAttributeOrg)
	allowed_organizations?:      string      @go(AllowedOrganizations)
	org_mapping?:                string      @go(OrgMapping)
	role_values_editor?:         string      @go(RoleValuesEditor)
	role_values_admin?:          string      @go(RoleValuesAdmin)
	role_values_grafana_admin?:  string      @go(RoleValuesGrafanaAdmin)
}

#GrafanaConfigAuthAzureAD: {
	// +nullable
	enabled?: null | bool @go(Enabled,*bool)

	// +nullable
	allow_sign_up?:   null | bool @go(AllowSignUp,*bool)
	client_id?:       string      @go(ClientId)
	client_secret?:   string      @go(ClientSecret)
	scopes?:          string      @go(Scopes)
	auth_url?:        string      @go(AuthUrl)
	token_url?:       string      @go(TokenUrl)
	allowed_domains?: string      @go(AllowedDomains)
	allowed_groups?:  string      @go(AllowedGroups)
}

#GrafanaConfigAuthGoogle: {
	// +nullable
	enabled?:         null | bool @go(Enabled,*bool)
	client_id?:       string      @go(ClientId)
	client_secret?:   string      @go(ClientSecret)
	scopes?:          string      @go(Scopes)
	auth_url?:        string      @go(AuthUrl)
	token_url?:       string      @go(TokenUrl)
	allowed_domains?: string      @go(AllowedDomains)
	allow_sign_up?:   null | bool @go(AllowSignUp,*bool)
}

#GrafanaConfigAuthGithub: {
	// +nullable
	enabled?: null | bool @go(Enabled,*bool)

	// +nullable
	allow_sign_up?:         null | bool @go(AllowSignUp,*bool)
	client_id?:             string      @go(ClientId)
	client_secret?:         string      @go(ClientSecret)
	scopes?:                string      @go(Scopes)
	auth_url?:              string      @go(AuthUrl)
	token_url?:             string      @go(TokenUrl)
	api_url?:               string      @go(ApiUrl)
	team_ids?:              string      @go(TeamIds)
	allowed_organizations?: string      @go(AllowedOrganizations)
}

#GrafanaConfigAuthGitlab: {
	// +nullable
	enabled?: null | bool @go(Enabled,*bool)

	// +nullable
	allow_sign_up?:  null | bool @go(AllowSignUp,*bool)
	client_id?:      string      @go(ClientId)
	client_secret?:  string      @go(ClientSecret)
	scopes?:         string      @go(Scopes)
	auth_url?:       string      @go(AuthUrl)
	token_url?:      string      @go(TokenUrl)
	api_url?:        string      @go(ApiUrl)
	allowed_groups?: string      @go(AllowedGroups)
}

#GrafanaConfigAuthGenericOauth: {
	// +nullable
	enabled?: null | bool @go(Enabled,*bool)

	// +nullable
	allow_sign_up?:       null | bool @go(AllowSignUp,*bool)
	client_id?:           string      @go(ClientId)
	client_secret?:       string      @go(ClientSecret)
	scopes?:              string      @go(Scopes)
	auth_url?:            string      @go(AuthUrl)
	token_url?:           string      @go(TokenUrl)
	api_url?:             string      @go(ApiUrl)
	allowed_domains?:     string      @go(AllowedDomains)
	role_attribute_path?: string      @go(RoleAttributePath)

	// +nullable
	role_attribute_strict?: null | bool @go(RoleAttributeStrict,*bool)
	email_attribute_path?:  string      @go(EmailAttributePath)

	// +nullable
	tls_skip_verify_insecure?: null | bool @go(TLSSkipVerifyInsecure,*bool)
	tls_client_cert?:          string      @go(TLSClientCert)
	tls_client_key?:           string      @go(TLSClientKey)
	tls_client_ca?:            string      @go(TLSClientCa)
}

#GrafanaConfigAuthOkta: {
	// +nullable
	enabled?: null | bool @go(Enabled,*bool)
	name?:    string      @go(Name)

	// +nullable
	allow_sign_up?:       null | bool @go(AllowSignUp,*bool)
	client_id?:           string      @go(ClientId)
	client_secret?:       string      @go(ClientSecret)
	scopes?:              string      @go(Scopes)
	auth_url?:            string      @go(AuthUrl)
	token_url?:           string      @go(TokenUrl)
	api_url?:             string      @go(ApiUrl)
	allowed_domains?:     string      @go(AllowedDomains)
	allowed_groups?:      string      @go(AllowedGroups)
	role_attribute_path?: string      @go(RoleAttributePath)

	// +nullable
	role_attribute_strict?: null | bool @go(RoleAttributeStrict,*bool)
}

#GrafanaConfigAuthLdap: {
	// +nullable
	enabled?: null | bool @go(Enabled,*bool)

	// +nullable
	allow_sign_up?: null | bool @go(AllowSignUp,*bool)
	config_file?:   string      @go(ConfigFile)
}

#GrafanaConfigAuthProxy: {
	// +nullable
	enabled?:         null | bool @go(Enabled,*bool)
	header_name?:     string      @go(HeaderName)
	header_property?: string      @go(HeaderProperty)

	// +nullable
	auto_sign_up?:  null | bool @go(AutoSignUp,*bool)
	ldap_sync_ttl?: string      @go(LdapSyncTtl)
	whitelist?:     string      @go(Whitelist)
	headers?:       string      @go(Headers)

	// +nullable
	enable_login_token?: null | bool @go(EnableLoginToken,*bool)
}

#GrafanaConfigDataProxy: {
	// +nullable
	logging?: null | bool @go(Logging,*bool)

	// +nullable
	timeout?: null | int @go(Timeout,*int)

	// +nullable
	send_user_header?: null | bool @go(SendUserHeader,*bool)
}

#GrafanaConfigAnalytics: {
	// +nullable
	reporting_enabled?:      null | bool @go(ReportingEnabled,*bool)
	google_analytics_ua_id?: string      @go(GoogleAnalyticsUaId)

	// +nullable
	check_for_updates?: null | bool @go(CheckForUpdates,*bool)
}

#GrafanaConfigDashboards: {
	// +nullable
	versions_to_keep?: null | int @go(VersionsToKeep,*int)
}

#GrafanaConfigSmtp: {
	// +nullable
	enabled?:   null | bool @go(Enabled,*bool)
	host?:      string      @go(Host)
	user?:      string      @go(User)
	password?:  string      @go(Password)
	cert_file?: string      @go(CertFile)
	key_file?:  string      @go(KeyFile)

	// +nullable
	skip_verify?:   null | bool @go(SkipVerify,*bool)
	from_address?:  string      @go(FromAddress)
	from_name?:     string      @go(FromName)
	ehlo_identity?: string      @go(EhloIdentity)
}

#GrafanaConfigLive: {
	// +nullable
	max_connections?: null | int @go(MaxConnections,*int)
	allowed_origins?: string     @go(AllowedOrigins)
}

#GrafanaConfigLog: {
	mode?:    string @go(Mode)
	level?:   string @go(Level)
	filters?: string @go(Filters)
}

#GrafanaConfigLogFrontend: {
	// +nullable
	enabled?:         null | bool @go(Enabled,*bool)
	sentry_dsn?:      string      @go(SentryDsn)
	custom_endpoint?: string      @go(CustomEndpoint)
	sample_rate?:     string      @go(SampleRate)

	// +nullable
	log_endpoint_requests_per_second_limit?: null | int @go(LogEndpointRequestsPerSecondLimit,*int)

	// +nullable
	log_endpoint_burst_limit?: null | int @go(LogEndpointBurstLimit,*int)
}

#GrafanaConfigLogConsole: {
	level?:  string @go(Level)
	format?: string @go(Format)
}

#GrafanaConfigMetrics: {
	// +nullable
	enabled?:             null | bool @go(Enabled,*bool)
	basic_auth_username?: string      @go(BasicAuthUsername)
	basic_auth_password?: string      @go(BasicAuthPassword)

	// +nullable
	interval_seconds?: null | int @go(IntervalSeconds,*int)
}

#GrafanaConfigMetricsGraphite: {
	address?: string @go(Address)
	prefix?:  string @go(Prefix)
}

#GrafanaConfigSnapshots: {
	// +nullable
	external_enabled?:       null | bool @go(ExternalEnabled,*bool)
	external_snapshot_url?:  string      @go(ExternalSnapshotUrl)
	external_snapshot_name?: string      @go(ExternalSnapshotName)

	// +nullable
	snapshot_remove_expired?: null | bool @go(SnapshotRemoveExpired,*bool)
}

#GrafanaConfigExternalImageStorage: {
	provider?: string @go(Provider)
}

#GrafanaConfigExternalImageStorageS3: {
	bucket?:     string @go(Bucket)
	region?:     string @go(Region)
	path?:       string @go(Path)
	bucket_url?: string @go(BucketUrl)
	access_key?: string @go(AccessKey)
	secret_key?: string @go(SecretKey)
}

#GrafanaConfigExternalImageStorageWebdav: {
	url?:        string @go(Url)
	public_url?: string @go(PublicUrl)
	username?:   string @go(Username)
	password?:   string @go(Password)
}

#GrafanaConfigExternalImageStorageGcs: {
	key_file?: string @go(KeyFile)
	bucket?:   string @go(Bucket)
	path?:     string @go(Path)
}

#GrafanaConfigExternalImageStorageAzureBlob: {
	account_name?:   string @go(AccountName)
	account_key?:    string @go(AccountKey)
	container_name?: string @go(ContainerName)
}

#GrafanaConfigAlerting: {
	// +nullable
	enabled?: null | bool @go(Enabled,*bool)

	// +nullable
	execute_alerts?:       null | bool @go(ExecuteAlerts,*bool)
	error_or_timeout?:     string      @go(ErrorOrTimeout)
	nodata_or_nullvalues?: string      @go(NodataOrNullvalues)

	// +nullable
	concurrent_render_limit?: null | int @go(ConcurrentRenderLimit,*int)

	// +nullable
	evaluation_timeout_seconds?: null | int @go(EvaluationTimeoutSeconds,*int)

	// +nullable
	notification_timeout_seconds?: null | int @go(NotificationTimeoutSeconds,*int)

	// +nullable
	max_attempts?: null | int @go(MaxAttempts,*int)
}

#GrafanaConfigPanels: {
	// +nullable
	disable_sanitize_html?: null | bool @go(DisableSanitizeHtml,*bool)
}

#GrafanaConfigPlugins: {
	// +nullable
	enable_alpha?: null | bool @go(EnableAlpha,*bool)
}

#GrafanaConfigRendering: {
	server_url?:   string @go(ServerURL)
	callback_url?: string @go(CallbackURL)

	// +nullable
	concurrent_render_request_limit?: null | int @go(ConcurrentRenderRequestLimit,*int)
}

#GrafanaConfigFeatureToggles: {
	enable?: string @go(Enable)
}

// GrafanaStatus defines the observed state of Grafana
#GrafanaStatus: {
	phase?:               #StatusPhase @go(Phase)
	previousServiceName?: string       @go(PreviousServiceName)
	message?:             string       @go(Message)

	// +nullable
	dashboards?: [...null | #GrafanaDashboardRef] @go(InstalledDashboards,[]*GrafanaDashboardRef)

	// +nullable
	installedPlugins?: #PluginList @go(InstalledPlugins)

	// +nullable
	failedPlugins?: #PluginList @go(FailedPlugins)
}

// GrafanaPlugin contains information about a single plugin
// +k8s:openapi-gen=true
#GrafanaPlugin: {
	// +kubebuilder:validation:Required
	name: string @go(Name)

	// +kubebuilder:validation:Required
	version: string @go(Version)
}

// Grafana is the Schema for the grafanas API
// +kubebuilder:object:root=true
// +kubebuilder:subresource:status
#Grafana: {
	metav1.#TypeMeta
	metadata?: metav1.#ObjectMeta @go(ObjectMeta)
	spec?:     #GrafanaSpec       @go(Spec)
	status?:   #GrafanaStatus     @go(Status)
}

// GrafanaList contains a list of Grafana
// +kubebuilder:object:root=true
#GrafanaList: {
	metav1.#TypeMeta
	metadata?: metav1.#ListMeta @go(ListMeta)
	items: [...#Grafana] @go(Items,[]Grafana)
}