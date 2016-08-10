# alpine-stress
Minimal docker image for cloud deployment and automated load/stress testing based on Alpine Linux.

Other than the base image there are two main applications currently deployed:

- [stress](http://linux.die.net/man/1/stress) to generate synthetic load on hosts
- [jmeter](http://jmeter.apache.org/) for load testing of web services and related web applications.

## stress

In order to run stress, the script is looking for a minimum of three environment variables to be set:
- **RUN**="stress" to switch case to stress execution
- **STRESS_CPU** integer value of N workers spinning on sqrt()
- **STRESS_TIME** integer value of N seconds after which to stop stress


## JMeter

In order to run JMeter, the script is looking for a minimum of three environment variables to be set:
- **RUN**="jmeter" to switch case to jmeter execution
- **TARGET_IP** IPv4 address for which the script will attempt to make requests at
- **TARGET_PORT** integer port that is open for requests
- ROUTER_IP (optional) if we are passing requests through a router before hitting the webservice we
	need to add a hosts entry for the router and the service hostname.
