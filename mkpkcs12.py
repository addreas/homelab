from base64 import b64decode

from kubernetes import client, config

from cryptography.x509 import load_pem_x509_certificate
from cryptography.hazmat.primitives.serialization import load_pem_private_key
from cryptography.hazmat.primitives.serialization.pkcs12 import serialize_key_and_certificates
from cryptography.hazmat.primitives.serialization import BestAvailableEncryption


config.load_kube_config()
v1 = client.CoreV1Api()

name = input('secret name: ')
namespace = input('secret namespace(default): ') or 'default'
filename = input('bundle filename(bundle.p12): ') or 'bundle.p12' 
password = input('bundle password: ')



sec = v1.read_namespaced_secret(name, namespace)

ca = load_pem_x509_certificate(b64decode(sec.data['ca.crt']))
tlscrt = load_pem_x509_certificate(b64decode(sec.data['tls.crt']))
tlskey = load_pem_private_key(b64decode(sec.data['tls.key']), None)

with open(filename, 'wb') as f:
    password = BestAvailableEncryption(password.encode())
    f.write(serialize_key_and_certificates(name.encode(), tlskey, tlscrt, [ca], password))
