#!/bin/bash
#
# Entrypoint script for Load Generator Docker Image
set -e

case "${RUN}" in
  stress)
    if [[ "${STRESS_CPU}" ]]; then STRESS_CPU="--cpu ${STRESS_CPU}"; fi
    if [[ "${STRESS_TIME}" ]]; then STRESS_TIME="--timeout ${STRESS_TIME}"; fi
    exec stress ${STRESS_CPU} ${STRESS_TIME}
    ;;
  jmeter)
    [[ "${ROUTER_IP}" ]] && echo "${ROUTER_IP} ${TARGET_IP}" >> /etc/hosts
    exec jmeter -n -t test.jmx -Jipaddr=${TARGET_IP} -Jport=${TARGET_PORT}
    ;;
  *)
    echo "Need to specify what to run."
    ;;
esac

