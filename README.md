Docker Monitoring
=================

This stack provides a dashboard to monitor docker containers. This is composed from:

- [cadvisor (Container Advisor)][0]: A systems and service monitoring system.
- [prometheus][1]: It provides container users an understanding of the resource usage and performance characteristics of their running containers.
- [alertmanager][2]: It handles alerts sent by client applications such as the Prometheus server.
- [grafana][3]: A rich feature metrics dashboard and graph editor for Graphite, Elasticsearch, OpenTSDB, Prometheus and InfluxDB.

Installation
------------

1. Install [Docker](https://docs.docker.com/engine/installation/linux/docker-ce/ubuntu/)
2. Install [Docker Compose](https://docs.docker.com/engine/installation/linux/docker-ce/ubuntu/)

Run on the project root folder:

```bash
make docker-start
```

to stop it, simply run:

```bash
make docker-stop
```

The Dashboard of monitoring is accessible through '<http://<Host IP>:9007>'

    username - admin
    password - check `/docker/grafana/config.env` env file

Documentation
-------------

## Alert rules

Prometheus is used to define alerting rules under `docker/prometheus`, 3 Alert Rules has been defined:

- `docker/prometheus/containers.rules`: Reports down containers
- `docker/prometheus/host.rules`: Reports high memory and cpu load
- `docker/prometheus/targets.rules`: Reports down monitor's service

To view Prometheus alerts, go to <http://<Host IP>:9006>/alerts

For more informations, click [here][7]

## Alerting

AlertManager is configured to report alerts under Slack, the configuration is available under: `docker/alertmanager/config.yml`

Custom integration with Slack has been added (https://api.slack.com/incoming-webhooks) that points to default channel #lab_uat_monitoring

To view AlertManager, you can go to <http://<Host IP>:9008>

For more informations, click [here][6]

## Dashboard

Grafana dashboad is ais the responsible of dashboard displaying:

- The configured datasources is provisioned from `docker/grafana/datasource.yaml`, its configured to communicate with prometheus datasource.
- The defined dashboard is defined under `docker/grafana/dashboards`, it was imported from [here][4].

For more informations, click [here][5]

License
-------

This tool is under the MIT license:

```
    LICENSE
```

Contributors
------------


[0]: https://github.com/google/cadvisor
[1]: https://github.com/prometheus/prometheus
[2]: https://github.com/prometheus/alertmanager
[3]: https://github.com/grafana/grafana
[4]: https://grafana.com/dashboards/193
[5]: https://grafana.com/docs/administration/provisioning/
[6]: https://prometheus.io/docs/alerting/configuration/
[7]: https://prometheus.io/docs/prometheus/latest/configuration/alerting_rules/