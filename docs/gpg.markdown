# GPG

## Usage

To generate a gpg key, run the following command:
```bash
gpg --gen-key
```

To export a public key into file public.key, run the following command:
```bash
gpg --export -a "User Name" > public.key
```

To export a private key, run the following command:
```bash
gpg --export-secret-key -a "User Name" > private.key
```

To import a public key, run the following command:
```bash
gpg --import public.key
```

To import a private key, run the following command:
```bash
gpg --allow-secret-key-import --import private.key
```

To delete a public key (from your public key ring), run the following command:
```bash
gpg --delete-key "User Name"
```

To delete an private key (a key on your private key ring), run the following command:
```bash
gpg --delete-secret-key "User Name"
```

To list the keys in your public key ring, run the following command:
```bash
gpg --list-keys
```

To list the keys in your secret key ring, run the following command:
```bash
gpg --list-secret-keys
```
