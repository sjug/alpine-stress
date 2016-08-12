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
    IFS=$'\n' 
    NUM="$(echo $TARGET_IP | sed 's/\:/\n/g' | wc -l)"
    TARGET=($(echo $TARGET_IP | sed 's/\:/\n/g'))
    [[ "${ROUTER_IP}" ]] && echo "${ROUTER_IP} ${TARGET_IP}" >> /etc/hosts
    exec jmeter -n -t test.jmx -Jnum=${NUM} -Jipaddr1=${TARGET[0]} -Jipaddr2=${TARGET[1]} \
      -Jipaddr3=${TARGET[2]} -Jipaddr4=${TARGET[3]} -Jipaddr5=${TARGET[4]} -Jport=${TARGET_PORT}
    ;;
  *)
    echo "Need to specify what to run."
    ;;
esac

