# NOTES

Package a Helm chart, e.g. `helloworld` (creates `helloworld-VERSION.tgz`):

    helm package --dependency-update helloworld/

Regenerate index for Help repo:

    helm repo index .

