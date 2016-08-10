#!/bin/bash
#
# Entrypoint script for Load Generator Docker Image
set -e

case "${RUN}" in
  stress)
    [[ "${STRESS_CPU}" ]] && STRESS_CPU="--cpu ${STRESS_CPU}"
    [[ "${STRESS_TIME}" ]] && STRESS_TIME="--timeout ${STRESS_TIME}"
    exec stress "${STRESS_CPU}" "${STRESS_TIME}"
    ;;
  jmeter)
    [[ "${ROUTER_IP}" ]] && echo "${ROUTER_IP} ${TARGET_IP}" >> /etc/hosts
    [[ "${TARGET_IP}" ]] && TARGET_IP="-Jipaddr=${TARGET_IP}"
    [[ "${TARGET_PORT}" ]] && TARGET_PORT="-Jport=${TARGET_PORT}"
    exec jmeter -n -t test.jmx "${TARGET_IP}" "${TARGET_PORT}"
    ;;
  *)
    echo "Need to specify what to run."
    ;;
esac

