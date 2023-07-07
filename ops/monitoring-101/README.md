# Monitoring 101
A journey into the monitoring world using Prometheus + Grafana on Kubernetes

## Environment
A Kubernetes cluster running in a Docker Desktop for Mac, version 4.4.2.

## Batteries included

* Kubernetes
* Prometheus
* cAdvisor
* kube-state-metrics
* node-exporter
* Grafana

## Setup
```bash
$ make monitoring.setup
```

## Prometheus
```bash
$ make prom.serve
$ open localhost:9090
```

## Grafana
```bash
$ make grafana.serve
$ open localhost:3000 (Login: admin | admin)
```

## Destroy
```bash
$ make monitoring.destroy
```
