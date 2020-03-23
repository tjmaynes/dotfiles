# Dotfiles

> Personal dotfiles for tmux, vim, emacs, etc.

## Requirements

- [GNU Stow]()

## Usage
To setup `dotfiles`, run the following command:
```bash
make setup
```

To teardown the `dotfiles` setup, run the following command:
```bash
make teardown
```

## Tools

### Emacs
To run `emacs`, make sure you've exported the `EMACS_SECRET_CONFIG`:
```bash
export EMACS_SECRET_CONFIG=<some-secret-config>
```

`Emacs` uses a special json file, whose structure looks similar to below:
```json
{
  "development": {
    "directory": "some-directory",
  },
  "writing": {
    "directory": "some-directory",
    "spellchecker-file": "some-file"
  },
  "theme": {
    "bookmarks-file": "some-file",
    "initial-message": "some-message"
  },
  "chat": {
    "directory": "some-directory",
    "full-name": "some-full-name",
    "nickname": "some-nickname",
    "server": "some-irc-server",
    "port": 8888,
    "userid": "some-user-id",
    "password": "some-password",
    "rooms": [["some-server", "#some-channel"]]
  },
  "mail": {
    "directory": "some-directory",
    "auth-credentials-file": "some-file",
    "provider": "some-email-provider",
    "full-name": "some-filename",
    "address": "some-email-address",
    "signature": "some-signature"
  }
}
```
