#!/bin/bash

mkdir /home/ue4/githubactions
cd /home/ue4/githubactions

GH_OWNER=$GH_OWNER
GH_TOKEN=$GH_TOKEN

RUNNER_SUFFIX=$(cat /dev/urandom | tr -dc 'a-z0-9' | fold -w 5 | head -n 1)
RUNNER_NAME="dockerNode-${RUNNER_SUFFIX}"

which curl || fatal "curl required.  Please install in PATH with apt-get, brew, etc"
which jq || fatal "jq required.  Please install in PATH with apt-get, brew, etc"

sudo -u ue4 mkdir runner

echo
echo "Generating a registration token..."

RUNNER_TOKEN=$(curl -sX POST -H "Accept: application/vnd.github.v3+json" -H "Authorization: token ${GH_TOKEN}" https://api.github.com/orgs/${GH_OWNER}/actions/runners/registration-token | jq .token --raw-output)

if [ "null" == "$RUNNER_TOKEN" -o -z "$RUNNER_TOKEN" ]; then fatal "Failed to get a token"; fi

echo
echo "Downloading latest runner ..."

latest_version_label=$(curl -s -X GET 'https://api.github.com/repos/actions/runner/releases/latest' | jq -r '.tag_name')
latest_version=$(echo ${latest_version_label:1})
runner_file="actions-runner-linux-x64-${latest_version}.tar.gz"

runner_url="https://github.com/actions/runner/releases/download/${latest_version_label}/${runner_file}"

echo "Downloading ${latest_version_label} for linux ..."
echo $runner_url

curl -O -L ${runner_url}

ls -la *.tar.gz

echo
echo "Extracting ${runner_file} to ./runner"

tar xzf "./${runner_file}" -C runner

# export of pass
sudo chown -R $svc_user ./runner

pushd ./runner

echo
echo "Configuring ${RUNNER_NAME} @ $runner_url"

./config.sh --unattended --url https://github.com/${GH_OWNER} --token ${RUNNER_TOKEN} --name ${RUNNER_NAME}

cleanup() {
    echo "Removing runner..."
    ./config.sh remove --unattended --token ${RUNNER_TOKEN}
}

trap 'cleanup; exit 130' INT
trap 'cleanup; exit 143' TERM

./run.sh & wait $!
