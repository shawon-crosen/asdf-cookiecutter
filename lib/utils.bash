#!/usr/bin/env bash

set -euo pipefail

# TODO: Ensure this is the correct GitHub homepage where releases can be downloaded for cookiecutter.
GH_REPO="github.com/cookiecutter/cookiecutter"
TOOL_NAME="cookiecutter"
TOOL_TEST="cookiecutter --version"

fail() {
  echo -e "asdf-$TOOL_NAME: $*"
  exit 1
}

curl_opts=(-fsSL)

sort_versions() {
  sed 'h; s/[+-]/./g; s/.p\([[:digit:]]\)/.z\1/; s/$/.z/; G; s/\n/ /' |
    LC_ALL=C sort -t. -k 1,1 -k 2,2n -k 3,3n -k 4,4n -k 5,5n | awk '{print $2}'
}

list_github_tags() {
  git ls-remote --tags --refs "https://$GH_REPO" |
    grep -o 'refs/tags/.*' | cut -d/ -f3- #|
    # sed 's/^v//' # NOTE: You might want to adapt this sed to remove non-version strings from tags
}

list_all_versions() {
  # TODO: Adapt this. By default we simply list the tag names from GitHub releases.
  # Change this function if cookiecutter has other means of determining installable versions.
  list_github_tags
}

download_release() {
  local version filename url
  version="$1"
  filename="$2"

  # TODO: Adapt the release URL convention for cookiecutter
  url="https://codeload.${GH_REPO}/tar.gz/${version}"

  echo "* Downloading $TOOL_NAME release $version..."
  curl "${curl_opts[@]}" -o "$filename" -C - "$url" || fail "Could not download $url"
}

install_version() {

  echo "Installing $TOOL_NAME"

  local install_type="$1"
  local version="$2"
  local install_path="$3"

  if [ "$install_type" != "version" ]; then
    fail "asdf-$TOOL_NAME supports release installs only"
  fi

  local bin_install_path="${install_path}/bin"
  local venv_path="$install_path/venv"

  mkdir -p "${bin_install_path}"

  alias python=$(which python)

  python -m venv $venv_path

  local bin_path="${bin_isntall_path}/cookiecutter"
  echo "Moving cookiecutter from ${ASDF_DOWNLOAD_PATH}"

  mkdir -p "${install_path}/tmp"

  mv "$ASDF_DOWNLOAD_PATH/$TOOL_NAME-$ASDF_INSTALL_VERSION" "${install_path}/tmp"

  source $venv_path/bin/activate

  cd ${install_path}/tmp/cookiecutter

  setup.py install

  cd ${install_path}

  rm -rf ./tmp/

  ln -s ${bin_install_path}/cookiecutter ${venv_path}/bin/cookiecutter

  (
    # TODO: Asert cookiecutter executable exists.
    local tool_cmd
    tool_cmd="$(echo "$TOOL_TEST" | cut -d' ' -f1)"
    test -x "${bin_install_path}/${tool_cmd}" || fail "Expected $install_path/bin/$tool_cmd to be executable."

    echo "$TOOL_NAME $version installation was successful!"
  ) || (
    rm -rf "$install_path"
    fail "An error ocurred while installing $TOOL_NAME $version."
  )
}
