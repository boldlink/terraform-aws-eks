CURRENT_DIR = $(shell pwd)
EXAMPLES_PATH = $(CURRENT_DIR)/examples/*
MODULES_PATH = $(CURRENT_DIR)/modules/*
SUPPORTING_PATH := $(CURRENT_DIR)/tests/supportingResources
SUBDIRS := $(shell find $(EXAMPLES_PATH) -maxdepth 0 -type d)
MODULEDIRS := $(shell find $(MODULES_PATH)/ -maxdepth 0 -type d)

.PHONY: all

tfinit:
	if [ -d $(SUPPORTING_PATH) ]; then \
		echo "[info]: Initialising the $(SUPPORTING_PATH) resources" ;\
		cd $(SUPPORTING_PATH) ;\
		terraform init ;\
	fi
	for folder in $(SUBDIRS) ; do \
		echo "[info]: Initialising $$folder stack" ;\
		cd $$folder ;\
		terraform init ;\
	done

tfplan:
	if [ -d $(SUPPORTING_PATH) ]; then \
		echo "[info]: Initialising the $(SUPPORTING_PATH) resources" ;\
		cd $(SUPPORTING_PATH) ;\
		terraform plan ;\
	fi
	for folder in $(SUBDIRS) ; do \
		echo "[info]: Plan for $$folder stack" ;\
		cd $$folder ;\
		terraform plan ;\
	done

tfapply:
	if [ -d $(SUPPORTING_PATH) ]; then \
		echo "[info]: Creating/Updating the $(SUPPORTING_PATH) resources" ;\
		cd $(SUPPORTING_PATH) ;\
		terraform plan --out=plan.tmp ;\
		terraform apply plan.tmp ;\
		rm plan.tmp ;\
	fi
	for folder in $(SUBDIRS) ; do \
		echo "[info]: Creating/Updating $$folder stack" ;\
		cd $$folder ;\
		terraform plan --out=plan.tmp ;\
		terraform apply plan.tmp ;\
		rm plan.tmp ;\
	done

tfdestroy:
	for folder in $(SUBDIRS) ; do \
		echo "[info]: Removing $$folder stack" ;\
		cd $$folder ;\
		terraform destroy --auto-approve ;\
	done

tfexampleclean:
	for folder in $(SUBDIRS) ; do \
		echo "[info]: Cleaning $$folder tests" ;\
		rm -rf $$folder/.terraform* ;\
	done

tfmoduleclean:
	if [ -d $(SUPPORTING_PATH) ]; then \
		echo "[info]: Creating/Updating the $(SUPPORTING_PATH) resources" ;\
		cd $(SUPPORTING_PATH) ;\
		rm -rf .terraform* ;\
	fi
	for folder in $(MODULEDIRS) ; do \
		echo "[info]: Cleaning $$folder terraform files" ;\
		rm -rf $$folder/.terraform* .terraform* ;\
	done

tests: tfinit tfapply

clean: tfdestroy tfexampleclean tfmoduleclean

cleansupporting:
	if [ -d $(SUPPORTING_PATH) ]; then \
		echo "[info]: destroying the $(SUPPORTING_PATH) resources" ;\
		cd $(SUPPORTING_PATH) ;\
		terraform init ;\
		terraform destroy --auto-approve ;\
	fi

cleanstatefiles:
	if [ -d $(SUPPORTING_PATH) ]; then \
		echo "[info]: Deleting the state files for $(SUPPORTING_PATH)" ;\
		cd $(SUPPORTING_PATH) ;\
		rm -rf terraform.tfstate* ;\
	fi
	for folder in $(SUBDIRS) ; do \
		echo "[info]: Deleting the state files for $$folder" ;\
		cd $$folder ;\
		rm -rf terraform.tfstate* ;\
	done
