package kube

k: SealedSecret: "fogis-app-key": spec: encryptedData: "APP_KEY":              "AgCxn1Ggfq47TORP/2/e2Wt8EwCMag+Idl6V9SQul0FOmZpPM9erihrotw8He/jFLwc2CwUqDCsFw46htNCSHi+pCm+0kXEKhTlQgV21sOL84IDm0JVDDC5AuD8J+F+RPNmrboCNbH66GlIJPFpp5zQtZse+tPxy9Szgj5MVmB9paU2NLuC8ppxgoRCzuFCBkNc+GnuNh4X3IQP/vOJoQSS48ZoS+x/y9mOCft+j7tQ7pOmPePIsGflA1G4aP39osULjHisnccY+6TiJWFW6vD4FTWzpaYQWo47ZRFTXX6CFB1AKRRWMWL4O81w0O5gZouPgZODUA92dzm79cdPUptNPE+FV835X8JOosDE5e3AOlcUSLzpAcimchJdQy4d1iCEbhHydIR4sXXkE9zAggzHpC2oNtEvWxm1YiHconDOZdiDaTKoP4/pJzGIHiDFRs5XfPX2l0uBXac8gIEm3P3aPnsam0aiBlCEAOI/R8xc6wp7MF1GhbOvc8WnZ1QnSKqMlhhhmckWeRCMiHrt/61VQQnjr3Ikre3SU8cCgieJPaSB0qQPYybLTBtDUmZegpZox1EoroRl+JfEIMN4d3egsfxGsSZ/Bv3E7deCux+++YtGBcND6Z/QW8g2/wQvqcW46DCHQs9Bj5SK72xjgis55RORbSX28LSDweuqCWKeogYsXUet5oyNZJYPdLFNc68pIRIW4JLwrOlfBi3Gez8iH9gsf433qQpHwXwYc8eWgnA=="
k: SealedSecret: "fogis-google-maps-key": spec: encryptedData: "MAPS_API_KEY": "AgAx0DbAMxOK7Fm3yod6x78Lca62pNLxD73INsvDrfcSNq/CGtfAR+C3kxCMnWIcHACspolTrsISohi7W6ytIgbqPIB0Nxo1kVELkzYxtH96IA1Y9i1chBs1DRqf2X5Yq390DNrRl8sE5PUiPNuLBgciSOtwfkiP3ukHQRVlpi/BYY57q+G3SjgZ6AfAEX1CZVr2Orwn02MHBLlLxzFfxFlYmZS49qABZwTVpgKKzI8ug8THbPKnQ4by42UyurUNWW6xMfpfrVP4IQt2G0tBC7tJND6W0UYZmK9D6GKpD6r/Bdv5bLojDcKLKOjBa2XWd86ORwgKKjETGcj45Y1//JC+OVZYVBJYdvCGTPQGzLWKB4oreGESxv8wuOTq5flX9Nho+FJG7R3huYVaGg9hfNIvFNsTemFJdM75Wo5RpQUseuSf+z1owsFCbY4V6FKKWVfIu12um7hhMbnASRfq+GgYXwuN4+xpDfJurnm8rWiyfhnymO5Gjg+tarM/AmVeC3nGfTdBhkcZXqjmy221+fvjs3QRXIE5u9gkXscEXgrmHR0j6A8zdguJnadlWL/v6ZugCMI4RL/MBILZDWNPXWNM0+LmtHY4seMNvfp9lInEUw2lv9vsAlG4eCaxz4NDsMiipeq/gaR2WYYVPRflb5KO6O1epZgPjyCvKEO97qS5nCRYec7jhUPdCDFruKD8ax0jjPUqfB2lPLSKEKnJhlyEVw/0x2yZZmXHMEA0Sgf4eoKaBN51XJ0="

// {
//   "k": "SealedSecret",
//   "apiVersion": "bitnami.com/v1alpha1",
//   "metadata": {
//     "name": "fogis-app-key",
//     "namespace": "fogis",
//     "creationTimestamp": null
//   },
//   "spec": {
//     "template": {
//       "metadata": {
//         "name": "fogis-app-key",
//         "namespace": "fogis",
//         "creationTimestamp": null
//       }
//     },
//     "encryptedData": {
//       "APP_KEY": "AgCxn1Ggfq47TORP/2/e2Wt8EwCMag+Idl6V9SQul0FOmZpPM9erihrotw8He/jFLwc2CwUqDCsFw46htNCSHi+pCm+0kXEKhTlQgV21sOL84IDm0JVDDC5AuD8J+F+RPNmrboCNbH66GlIJPFpp5zQtZse+tPxy9Szgj5MVmB9paU2NLuC8ppxgoRCzuFCBkNc+GnuNh4X3IQP/vOJoQSS48ZoS+x/y9mOCft+j7tQ7pOmPePIsGflA1G4aP39osULjHisnccY+6TiJWFW6vD4FTWzpaYQWo47ZRFTXX6CFB1AKRRWMWL4O81w0O5gZouPgZODUA92dzm79cdPUptNPE+FV835X8JOosDE5e3AOlcUSLzpAcimchJdQy4d1iCEbhHydIR4sXXkE9zAggzHpC2oNtEvWxm1YiHconDOZdiDaTKoP4/pJzGIHiDFRs5XfPX2l0uBXac8gIEm3P3aPnsam0aiBlCEAOI/R8xc6wp7MF1GhbOvc8WnZ1QnSKqMlhhhmckWeRCMiHrt/61VQQnjr3Ikre3SU8cCgieJPaSB0qQPYybLTBtDUmZegpZox1EoroRl+JfEIMN4d3egsfxGsSZ/Bv3E7deCux+++YtGBcND6Z/QW8g2/wQvqcW46DCHQs9Bj5SK72xjgis55RORbSX28LSDweuqCWKeogYsXUet5oyNZJYPdLFNc68pIRIW4JLwrOlfBi3Gez8iH9gsf433qQpHwXwYc8eWgnA=="
//     }
//   }
// }

// {
//   "kind": "SealedSecret",
//   "apiVersion": "bitnami.com/v1alpha1",
//   "metadata": {
//     "name": "fogis-google-maps-key",
//     "namespace": "fogis",
//     "creationTimestamp": null
//   },
//   "spec": {
//     "template": {
//       "metadata": {
//         "name": "fogis-google-maps-key",
//         "namespace": "fogis",
//         "creationTimestamp": null
//       }
//     },
//     "encryptedData": {
//       "MAPS_API_KEY": "AgAx0DbAMxOK7Fm3yod6x78Lca62pNLxD73INsvDrfcSNq/CGtfAR+C3kxCMnWIcHACspolTrsISohi7W6ytIgbqPIB0Nxo1kVELkzYxtH96IA1Y9i1chBs1DRqf2X5Yq390DNrRl8sE5PUiPNuLBgciSOtwfkiP3ukHQRVlpi/BYY57q+G3SjgZ6AfAEX1CZVr2Orwn02MHBLlLxzFfxFlYmZS49qABZwTVpgKKzI8ug8THbPKnQ4by42UyurUNWW6xMfpfrVP4IQt2G0tBC7tJND6W0UYZmK9D6GKpD6r/Bdv5bLojDcKLKOjBa2XWd86ORwgKKjETGcj45Y1//JC+OVZYVBJYdvCGTPQGzLWKB4oreGESxv8wuOTq5flX9Nho+FJG7R3huYVaGg9hfNIvFNsTemFJdM75Wo5RpQUseuSf+z1owsFCbY4V6FKKWVfIu12um7hhMbnASRfq+GgYXwuN4+xpDfJurnm8rWiyfhnymO5Gjg+tarM/AmVeC3nGfTdBhkcZXqjmy221+fvjs3QRXIE5u9gkXscEXgrmHR0j6A8zdguJnadlWL/v6ZugCMI4RL/MBILZDWNPXWNM0+LmtHY4seMNvfp9lInEUw2lv9vsAlG4eCaxz4NDsMiipeq/gaR2WYYVPRflb5KO6O1epZgPjyCvKEO97qS5nCRYec7jhUPdCDFruKD8ax0jjPUqfB2lPLSKEKnJhlyEVw/0x2yZZmXHMEA0Sgf4eoKaBN51XJ0="
//     }
//   }
// }
