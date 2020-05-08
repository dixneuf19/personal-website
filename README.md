# dankPerso

Just a dank personal website

## Deployment

Now deployed on Kubernetes. Climbing my way up from simple deployments to Helm chart and Terraform hopefully.

### Apply a plain YAML deployment file

In this first approach, I just use a simple [`personal-website.yaml`](./personal-website.yaml) file with the `kubectl apply -f` command.

There is on this single file :

- A *Deployment*, which use the image from the `Dockerfile` in this folder. It's can be built and pushed with `make release`. It also exposes the HTTP port and mount a config file from a ConfigMap.
- a *Service* which exposes the pod to the rest of the cluster
- an *Ingress* rule, which exposes this service to the World Wide Web. There is an automatic TLS certificate creation with [Traefik and CertBot](https://opensource.com/article/20/3/ssl-letsencrypt-k3s).
- a *ConfigMap*, in which I store the *Apache* config file `httpd.conf` in plain text. It is quite long but still below the [1MB limit](https://github.com/kubernetes/kubernetes/issues/19781). To get the default `httpd.conf`, simply run `docker run --rm httpd:2.4 cat /usr/local/apache2/conf/httpd.conf > my-httpd.conf`.

I can deploy this on my cluster with `make deploy`.

However, if I change the *ConfigMap*, it won't trigger a redeployment. Indeed, *Kubernetes* will only update the mounted file in every pods, but the Apache server doesn't live reload. A quick way to force the update is to kill all the pods for this deployment. A dirty but efficient way implemented with `make force-reload`.

## Usage

Use the provided **Makefile**.

