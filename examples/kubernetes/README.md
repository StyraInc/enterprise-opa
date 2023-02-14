# Kubernetes Deployment

Example code for [deployment](https://docs.styra.com/load/installation/deployment) of Styra Load in a Kubernetes cluster.

To run the example code in a local [kind](https://kind.sigs.k8s.io) cluster, follow the steps outlined below.

First, create a new cluster with the provided configuration file.

```shell
$ kind create cluster --config kind-config.yaml
```

Edit the `manifests.yaml` file and add your license key in the `styra-load-license` secret manifest.

Next, deploy the resource manifests:

```shell
$ kubectl apply -f manifests.yaml
```

Last, deploy the Nginx ingress controller in order to make the deployment accessible from your machine:

```shell
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/kind/deploy.yaml
```

Your Styra Load instance should now be reachable on `localhost:8181/load`.
