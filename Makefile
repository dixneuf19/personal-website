.PHONY: build push release deploy force-reload

DOCKER_REPOSITERY="dixneuf19"
IMAGE_NAME="apache"
IMAGE_TAG="arm"
DOCKER_IMAGE_PATH="$(DOCKER_REPOSITERY)/$(IMAGE_NAME):$(IMAGE_TAG)"
APP_NAME="personal-website"

build:
	docker build -t $(DOCKER_IMAGE_PATH) .

push:
	docker push $(DOCKER_IMAGE_PATH)

release: build push

deploy:
	kubectl apply -f personal-website.yaml

force-reload:
	$(eval PODS=$(shell kubectl get pod -l app=$(APP_NAME) -o name))
	kubectl delete $(PODS)