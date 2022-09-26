export PATH := $(HOME)/.local/bin:$(PATH)

.PHONY: cert
cert: ## Install certificates
	./cert/certgen.zsh