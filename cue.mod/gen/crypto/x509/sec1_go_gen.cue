// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go crypto/x509

package x509

import "encoding/asn1"

_#ecPrivKeyVersion: 1

// ecPrivateKey reflects an ASN.1 Elliptic Curve Private Key Structure.
// References:
//
//	RFC 5915
//	SEC1 - http://www.secg.org/sec1-v2.pdf
//
// Per RFC 5915 the NamedCurveOID is marked as ASN.1 OPTIONAL, however in
// most cases it is not.
_#ecPrivateKey: {
	Version:       int
	PrivateKey:    bytes @go(,[]byte)
	NamedCurveOID: asn1.#ObjectIdentifier
	PublicKey:     asn1.#BitString
}