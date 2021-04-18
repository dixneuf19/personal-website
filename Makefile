.PHONY: build push release deploy force-reload

DOCKER_REPOSITERY="dixneuf19"
IMAGE_NAME="personal-website"
IMAGE_TAG="v1.1"
DOCKER_IMAGE_PATH="$(DOCKER_REPOSITERY)/$(IMAGE_NAME):$(IMAGE_TAG)"
APP_NAME="personal-website"

build:
	docker buildx build -t $(DOCKER_IMAGE_PATH) --platform linux/amd64,linux/arm64,linux/386,linux/arm/v7 .

push:
	docker buildx build -t $(DOCKER_IMAGE_PATH) --platform linux/amd64,linux/arm64,linux/386,linux/arm/v7 --push .

release: build push

deploy:
	kubectl apply -f manifests/

delete:
	kubectl delete -f manifests/

force-reload:
	kubectl rollout restart deployment ${APP_NAME}
