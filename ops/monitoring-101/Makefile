monitoring.setup:
	@bash setup

monitoring.destroy:
	@kubectl delete -f namespace.yml

prom.serve:
	@kubectl -n monitoring port-forward deploy/prometheus-pod 9090:9090

grafana.serve:
	@kubectl -n monitoring port-forward deploy/grafana-pod 3000:3000

kube-state-metrics.serve:
	@kubectl -n kube-system port-forward deploy/kube-state-metrics-pod 8080:8080

app.serve:
	@kubectl port-forward deploy/nginx-pod 8080:80
