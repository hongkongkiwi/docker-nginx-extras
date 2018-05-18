#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

command -v renderizer >/dev/null 2>&1 || { echo >&2 "I require renderizer but it's not installed.  Aborting."; echo "Install using go get github.com/gomatic/renderizer"; exit 1; }

DOCKERFILE_TEMPLATE="Dockerfile.template"
TEMPLATES_DIR="${DIR}/templates"
DOCKERFILE_OUTPUT_DIR="${DIR}/dockerfiles"

TEMPLATES_TO_GENERATE=(
  "nginx-stable/base"
  "nginx-stable/node-latest"
  "nginx-stable/node-9.11.1"
  "nginx-stable/node-8.11.2"
  "nginx-stable-le/base"
  "nginx-stable-le/node-latest"
  "nginx-stable-le/node-9.11.1"
  "nginx-stable-le/node-8.11.2"
  "nginx-stable-ldap/base"
  "nginx-stable-ldap/node-latest"
  "nginx-stable-ldap/node-9.11.1"
  "nginx-stable-ldap/node-8.11.2"
  "nginx-stable-ldap-le/base"
  "nginx-stable-ldap-le/node-latest"
  "nginx-stable-ldap-le/node-9.11.1"
  "nginx-stable-ldap-le/node-8.11.2"
  "nginx-mainline/base"
  "nginx-mainline/node-latest"
  "nginx-mainline/node-9.11.1"
  "nginx-mainline/node-8.11.2"
  "nginx-mainline-le/base"
  "nginx-mainline-le/node-latest"
  "nginx-mainline-le/node-9.11.1"
  "nginx-mainline-le/node-8.11.2"
  "nginx-mainline-ldap/base"
  "nginx-mainline-ldap/node-latest"
  "nginx-mainline-ldap/node-9.11.1"
  "nginx-mainline-ldap/node-8.11.2"
  "nginx-mainline-ldap-le/base"
  "nginx-mainline-ldap-le/node-latest"
  "nginx-mainline-ldap-le/node-9.11.1"
  "nginx-mainline-ldap-le/node-8.11.2"
)

[ -d "${DOCKERFILE_OUTPUT_DIR}" ] && rm -Rf "${DOCKERFILE_OUTPUT_DIR}"

for TEMPLATE_FILE in "${TEMPLATES_TO_GENERATE[@]}"
do
  :
  VAR_FILE="${TEMPLATES_DIR}/`echo "${TEMPLATE_FILE}.yml" | sed 's#/#-#g'`"
  [ -f "${VAR_FILE}" ] || { echo "Var file does not exist!"; echo "${VAR_FILE}"; continue; }
  TEMPLATE_NAME=`basename "$TEMPLATE_FILE"`
  TEMPLATE_DIR=`dirname "$TEMPLATE_FILE"`
  # echo "[ -d \"${DIR}/${TEMPLATE_DIR}\" ] && rm -d \"${DIR}/${TEMPLATE_DIR}/\"*"
  # continue
  mkdir -p "${DOCKERFILE_OUTPUT_DIR}/${TEMPLATE_DIR}"
  cp "${DIR}/files/"* "${DOCKERFILE_OUTPUT_DIR}/${TEMPLATE_DIR}"
  renderizer -S=${VAR_FILE} ${DOCKERFILE_TEMPLATE} > "${DOCKERFILE_OUTPUT_DIR}/${TEMPLATE_DIR}/Dockerfile-${TEMPLATE_NAME}"
done

#renderizer -S=renderizer.yaml Dockerfile.template > Dockerfile
#renderizer -S=renderizer.yaml Dockerfile.template > Dockerfile
#renderizer -S=renderizer.yaml Dockerfile.template > Dockerfile
