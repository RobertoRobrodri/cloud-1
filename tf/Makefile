TF_REPO := "https://github.com/tfutils/tfenv.git"
TF_ENV_PATH := "$(HOME)/.tfenv"
TF_VERSION := $(file < .terraform_version)
TF_PATH := $(TF_ENV_PATH)/versions/$(TF_VERSION)

usage:
	@echo "Setup: Install tfenv"
	@echo "Install: Install tf version"
	@echo "Uninstall: Uninstall tf version"
	@echo "Init: Terraform init"
	@echo "Plan: Terraform plan"
	@echo "Apply: Terraform apply"
	@echo "Destroy: Terraform destroy"

setup:
	@if [ ! -d $(TF_ENV_PATH) ]; then \
		git clone --depth=1 $(TF_REPO) ~/.tfenv; \
	fi

install: setup
	@$(TF_ENV_PATH)/bin/tfenv install $(TF_VERSION) && $(TF_ENV_PATH)/bin/tfenv use $(TF_VERSION)

uninstall:
	@$(TF_ENV_PATH)/bin/tfenv uninstall $(TF_VERSION)

init: install
	@$(TF_PATH)/terraform init

plan: init
	@$(TF_PATH)/terraform plan

appy: init
	@$(TF_PATH)/terraform apply

destroy: init
	@$(TF_PATH)/terraform destroy