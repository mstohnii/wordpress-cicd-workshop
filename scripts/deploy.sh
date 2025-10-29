#!/usr/bin/env bash

set -euo pipefail

# Defaults
NAMESPACE=${NAMESPACE:-wordpress}
RELEASE_NAME=${RELEASE_NAME:-wordpress}
CHART_PATH=${CHART_PATH:-./helm/wordpress}
TIMEOUT=${TIMEOUT:-10m}

echo "Creating namespace if it doesn't exist: ${NAMESPACE}"
kubectl create namespace "${NAMESPACE}" --dry-run=client -o yaml | kubectl apply -f -

echo "Deploying Helm release '${RELEASE_NAME}' to namespace '${NAMESPACE}' from chart '${CHART_PATH}'"
helm upgrade --install "${RELEASE_NAME}" "${CHART_PATH}" \
  --namespace "${NAMESPACE}" \
  --create-namespace \
  --wait \
  --timeout "${TIMEOUT}"

echo "Deployment objects:"
kubectl get all -n "${NAMESPACE}"

echo "Services:"
kubectl get svc -n "${NAMESPACE}"

echo "Deployment finished."


