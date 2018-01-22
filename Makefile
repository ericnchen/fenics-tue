.PHONY: help builder

help:
	@echo "Usage: make [target]"
	@echo "Target:"
	@echo "  builder            Build the Docker \"builder\" image."
	@echo "  help               Show this help menu."

builder:
	docker build -t fenics-tue:builder --force-rm docker/builder
