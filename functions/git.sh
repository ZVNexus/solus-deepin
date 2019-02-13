################################################################################
# __upgrade [package] [version]
#
# Commits an upgrade to a given package with a given version.
#
################################################################################

__upgrade() {
    __package="${1}"
    __version="${2}"
    git add "${__package}/"
    git commit -m "${__package}: Upgrade to ${__version}, bump, rebuild."
}

################################################################################
# __rebuild [package]
#
# Commits a rebuild for a given package.
#
################################################################################

__rebuild() {
    __package="${1}"
    git add "${__package}/"
    git commit -m "${__package}: Rebuild."
}

################################################################################
# __bump [package]
#
# Commits a bump and rebuild for a given package.
#
################################################################################

__bump() {
    __package="${1}"
    git add "${__package}/"
    git commit -m "${__package}: Bump and rebuild."
}

################################################################################
# __version_fetch [package]
#
# Fetches the actual package version for a given package.
#
################################################################################

__version_fetch() {
    __package="${1}"
    __yaml2json < "./${__package%-devel}/package.yml" | __jq '.version' | sed 's/.*"\([^ ]*\)".*/\1/g'
}
