# radar
IcaliaLabs Tech Radar


## Deployment to Kubernetes

### 1. Nginx configuration

We'll load the `nginx.conf` inside a Kubernetes configMap called `radar-config`:

```bash
kubectl create configmap radar-config --from-file nginx.conf
```

After creating the configMap, we can edit it afterwards using the editor
configured to use with `kubectl`:

```bash
kubectl edit configmap radar-config
```

This will be necessary whenever we update the radar.

### 2. Deploy the nginx service

We'll use the file `.kubernetes/deployment.yml` to deploy an Nginx container
with the nginx configuration mounted on it:

```bash
kubectl apply -f .kubernetes/deployment.yml
```