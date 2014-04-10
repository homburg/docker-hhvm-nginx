IMAGE = hhvm-nginx

build:
	docker build --rm -t $(IMAGE) .

run: build
	docker run -d -p 8080:80 $(IMAGE)

run_volume: build
	docker run -d -p 8080:80 -v $(PWD)/www:/srv/www:ro $(IMAGE)

hhvm_version: build
	docker run $(IMAGE) hhvm --version
