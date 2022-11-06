package kube

// k: HelmRelease: "mimir": spec: {
//  chart: spec: {
//   version: "3.2.0" // TODO: get this into tags.cue
//   chart:   "mimir-distributed"
//   sourceRef: name: "grafana"
//  }
//  values: {
//   mimir: config: {

//   }
//   alertmanager: persistentVolume: enabled:  false
//   ingester: persistentVolume: enabled:      false
//   store_gateway: persistentVolume: enabled: false
//   compactor: persistentVolume: enabled:     false
//   minio: enabled: false
//  }

//  valuesFrom: [{
//   kind:       "Secret"
//   name:       "mimir-s3-secret"
//   valuesKey:  "secretAccessKey"
//   targetPath: "mimir.s3.secretAccessKey"
//  }, {
//   kind:       "Secret"
//   name:       "mimir-s3-secret"
//   valuesKey:  "accessKeyId"
//   targetPath: "mimir.s3.accessKeyId"
//  }]
// }

// k: Secret: "mimir-s3-secret": stringData: {
//  accessKeyId:     "jKrkW4cgT5pebhuc"
//  secretAccessKey: "q8EwZshokT0EOj4icGvee9G0ImYgL3LJ"
// }
