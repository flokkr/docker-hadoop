

## Versioning policy

  The _latest_ tag points to the latest configuration loading and the latest stable apache version.

  If there is plain version tag without prefix it is synchronized with the version of the original apache software.

  It there is a prefix (eg. HDP) it includes a specific version from a specific vendor distribution.

  As the configuration loading in the base image is constantly evolving even the tags of older releases may be refreshed over the time.

  Images are build with travis with matrix parameters and uploaded to the docker hub from travis.
