all: build

build:
	mkdir ./data
	mkdir ./data/disks
	vagrant up

rebuild: clean build

clean:
	vagrant halt -f
	vagrant destroy --force
	rm -rf ./.vagarnt
	rm -rf ./data
	rm -rf ./ubuntu-bionic-18.04-cloudimg-console.log

.PHONY: all build rebuild clean
