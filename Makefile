ENV_FILE := .env
ifneq ("$(wildcard $(ENV_FILE))","")
include ${ENV_FILE}
export $(shell sed 's/=.*//' ${ENV_FILE})
endif

##################################

# DEV - run apps locally for development

.PHONY: dev-dashboard
dev-dashboard:
	./dashboard/install/dev.sh

.PHONY: dev-leaderboard
dev-leaderboard:
	./leaderboard/install/dev.sh


##################################

# BUILD - build images locally using s2i

.PHONY: build-dashboard
build-dashboard:
	./dashboard/install/build.sh
	
.PHONY: build-leaderboard
build-leaderboard:
	./leaderboard/install/build.sh

.PHONY: build
build: build-dashboard build-leaderboard

##################################

# PUSH - push images to repository

.PHONY: push-dashboard
push-dashboard:
	./dashboard/install/push.sh

.PHONY: push-leaderboard
push-leaderboard:
	./leaderboard/install/push.sh

.PHONY: push
push: push-dashboard push-leaderboard

##################################
