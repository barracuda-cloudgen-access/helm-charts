#!/usr/bin/env bash
#
# Copyright © 2021 Barracuda Networks, Inc. All rights reserved.
#

# Set error handling
set -euo pipefail

function pre_install {
    if [[ "$(kind get clusters)" =~ cga-test ]]; then
        kubectl config use-context kind-cga-test
    else
        kind create cluster --name=cga-test
    fi
}

function post_install {
    sleep 5
    kubectl get pods
    echo -e "\nCleanup with:\nmake helm-test-clean"
}

case ${1:?"Needs chart name"} in

    cga-proxy)
        pre_install
        helm upgrade -i cga-proxy-test ./charts/cga-proxy \
            --set=http-test.enabled=true \
            --set=orchestrator.enrollmentToken.newSecret.value="${2:?"Needs enrollment token"}"
        post_install
        ;;

    cga-directory-connector)
        pre_install
        helm upgrade -i cga-directory-connector-test ./charts/cga-directory-connector \
            --set=logLevel=debug \
            --set=enrollmentToken.newSecret.value="${2:?"Needs enrollment token"}" \
            --set=authToken.type="${3:?"Needs auth token type"}" \
            --set=authToken.newSecret.value="${4:?"Needs auth token"}"
        post_install
        ;;

    clean)
        kind delete cluster --name=cga-test
        ;;

    ci)
        find ./charts/*/ci/test-values.yaml.tpl -type f -print0 \
            -exec sh -c 'envsubst < "${1}" > "${1%.tpl}"' _ {} \;
        ;;

    *)
        echo "Unknown action: $1"
        exit 1
        ;;

esac
