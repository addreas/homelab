package kube

// k: HelmRelease: "grafana-loki": spec: {
//  chart: spec: {
//   version: "1.8.11" // TODO: get this into tags.cue
//   chart:   "loki-simple-scalable"
//   sourceRef: name: "grafana"
//  }
//  values: {
//   loki: {
//    storage: {
//     s3: {
//      endpoint:         "http://sergio.localdomain:9000/"
//      s3ForcePathStyle: true
//     }
// grafana-operator: enabled: false
//     bucketNames: {
//      chunks: "loki-chunks"
//      ruler:  "loki-ruler"
//      admin:  "loki-admin"
//     }
//    }
//   }
//   gateway: enabled: false
//  }
//  valuesFrom: [{
//   kind:       "Secret"
//   name:       "loki-s3-secret"
//   valuesKey:  "secretAccessKey"
//   targetPath: "loki.s3.secretAccessKey"
//  }, {
//   kind:       "Secret"
//   name:       "loki-s3-secret"
//   valuesKey:  "accessKeyId"
//   targetPath: "loki.s3.accessKeyId"
//  }]
// }

// k: Secret: "loki-s3-secret": stringData: {
//  accessKeyId:     "QH6JGdM15KF1Vnss"
//  secretAccessKey: "zZK8xDGP2xBY0yJFUC527DbvU8QoXQq1"
// }
