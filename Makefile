.PHONY: default
default: ;

.PHONY: centos6-rebuild
centos6-rebuild:
	docker build --force-rm -t conda-build-centos6 dockerfiles/centos6
