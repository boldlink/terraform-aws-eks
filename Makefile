CURRENT_DIR = $(shell pwd)
EXAMPLES_PATH = $(CURRENT_DIR)/examples/*
MODULES_PATH = $(CURRENT_DIR)/modules/*
SUPPORTING_PATH := $(CURRENT_DIR)/tests/supportingResources
SUBDIRS := $(shell find $(EXAMPLES_PATH) -maxdepth 0 -type d)
MODULEDIRS := $(shell find $(MODULES_PATH)/ -maxdepth 0 -type d)

.PHONY: all

tfinit:
	@if [ -d $(SUPPORTING_PATH) ]; then \
		echo "=====================================================================================================" ;\
		echo "[info]: Initialising the $(SUPPORTING_PATH) resources" ;\
		echo "=====================================================================================================" ;\
		cd $(SUPPORTING_PATH) ;\
		terraform init ;\
	fi
	@for folder in $(SUBDIRS) ; do \
		echo "=====================================================================================================" ;\
		echo "[info]: Initialising $$folder stack" ;\
		echo "=====================================================================================================" ;\
		cd $$folder ;\
		terraform init ;\
	done

tfplan:
	@if [ -d $(SUPPORTING_PATH) ]; then \
		echo "=====================================================================================================" ;\
		echo "[info]: Initialising the $(SUPPORTING_PATH) resources" ;\
		echo "=====================================================================================================" ;\
		cd $(SUPPORTING_PATH) ;\
		terraform plan ;\
	fi
	@for folder in $(SUBDIRS) ; do \
		echo "=====================================================================================================" ;\
		echo "[info]: Plan for $$folder stack" ;\
		echo "=====================================================================================================" ;\
		cd $$folder ;\
		terraform plan ;\
	done

tfapply:
	@if [ -d $(SUPPORTING_PATH) ]; then \
		echo "=====================================================================================================" ;\
		echo "[info]: Creating/Updating the $(SUPPORTING_PATH) resources" ;\
		echo "=====================================================================================================" ;\
		cd $(SUPPORTING_PATH) ;\
		terraform plan --out=plan.tmp ;\
		terraform apply plan.tmp ;\
		rm plan.tmp ;\
	fi
	@for folder in $(SUBDIRS) ; do \
		echo "=====================================================================================================" ;\
		echo "[info]: Creating/Updating $$folder stack" ;\
		echo "=====================================================================================================" ;\
		cd $$folder ;\
		terraform plan --out=plan.tmp ;\
		terraform apply plan.tmp ;\
		rm plan.tmp ;\
	done

tfdestroy:
	@for folder in $(SUBDIRS) ; do \
		echo "=====================================================================================================" ;\
		echo "[info]: Removing $$folder stack" ;\
		echo "=====================================================================================================" ;\
		cd $$folder ;\
		terraform destroy --auto-approve ;\
	done

tfexampleclean:
	@for folder in $(SUBDIRS) ; do \
		echo "=====================================================================================================" ;\
		echo "[info]: Cleaning $$folder tests" ;\
		echo "=====================================================================================================" ;\
		rm -rf $$folder/.terraform* ;\
	done

tfmoduleclean:
	@if [ -d $(SUPPORTING_PATH) ]; then \
		echo "=====================================================================================================" ;\
		echo "[info]: Creating/Updating the $(SUPPORTING_PATH) resources" ;\
		echo "=====================================================================================================" ;\
		cd $(SUPPORTING_PATH) ;\
		rm -rf .terraform* ;\
	fi
	@for folder in $(MODULEDIRS) ; do \
		echo "=====================================================================================================" ;\
		echo "[info]: Cleaning $$folder terraform files" ;\
		echo "=====================================================================================================" ;\
		rm -rf $$folder/.terraform* .terraform* ;\
	done

cleansupporting:
	@if [ -d $(SUPPORTING_PATH) ]; then \
		echo "=====================================================================================================" ;\
		echo "[info]: destroying the $(SUPPORTING_PATH) resources" ;\
		echo "=====================================================================================================" ;\
		cd $(SUPPORTING_PATH) ;\
		terraform init ;\
		terraform destroy --auto-approve ;\
	fi

cleanstatefiles:
	@if [ -d $(SUPPORTING_PATH) ]; then \
		echo "=====================================================================================================" ;\
		echo "[info]: Deleting the state files for $(SUPPORTING_PATH)" ;\
		echo "=====================================================================================================" ;\
		cd $(SUPPORTING_PATH) ;\
		rm -rf terraform.tfstate* ;\
	fi
	@for folder in $(SUBDIRS) ; do \
		echo "=====================================================================================================" ;\
		echo "[info]: Deleting the state files for $$folder" ;\
		echo "=====================================================================================================" ;\
		cd $$folder ;\
		rm -rf terraform.tfstate* ;\
	done

tests: tfinit tfapply

clean: tfdestroy tfexampleclean tfmoduleclean
