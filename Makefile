export $(shell sed 's/=.*//' .env.default)

ENV_FILE := .env
ifneq ("$(wildcard $(ENV_FILE))","")
include ${ENV_FILE}
export $(shell sed 's/=.*//' ${ENV_FILE})
endif

##################################

# DEV - run apps locally for development

.PHONY: dev-dashboard-ui
dev-dashboard-ui:
	./dashboard-ui/install/dev.sh

.PHONY: dev-dashboard-ui
dev-dashboard-ui:
	./dashboard-ui/install/dev.sh


##################################

# BUILD - build images locally using s2i

.PHONY: build-dashboard-ui
build-dashboard-ui:
	./dashboard-ui/install/build.sh
	
.PHONY: build-leaderboard-ui
build-leaderboard-ui:
	./leaderboard-ui/install/build.sh

.PHONY: build
build: build-dashboard-ui build-leaderboard-ui

##################################

# PUSH - push images to repository

.PHONY: push-dashboard-ui
push-dashboard-ui:
	./dashboard-ui/install/push.sh

.PHONY: push-leaderboard-ui
push-leaderboard-ui:
	./leaderboard-ui/install/push.sh

.PHONY: push
push: push-dashboard-ui push-leaderboard-ui

##################################
