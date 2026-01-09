Chart that is implementing an as IaC-friendly as possible way of deploying openHAB.


# Password
The parameters of the hashes and salts of openHAB are not that easy to find, so for interested readers:
Algorithm: PBKDF2WithHmacSHA512
Iterations: 10.000
Salt Length: 128 Bit (16 Bytes)
Hash Length: 512 Bit (64 Bytes)
Encoding: Base64 (with all special characters unicode escaped)

The password can be generated with this small snippet:
docker run --rm python:3.11-slim python3 -c '
import hashlib, binascii, os
password = b"YOUR_PASSWORD"
salt = os.urandom(16)
hash = hashlib.pbkdf2_hmac("sha512", password, salt, 10000)
print(f"\nSalt: {binascii.b2a_base64(salt).decode().strip()}")
print(f"Hash: {binascii.b2a_base64(hash).decode().strip()}\n")
'
