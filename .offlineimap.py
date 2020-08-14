import subprocess
from os.path import expanduser

def mailpasswd(account):
    path = "%s/.%s-password.gpg" % (expanduser("~"), account)
    return subprocess.check_output([
        "gpg", "--quiet", "--batch", "-d", path
    ]).strip()
