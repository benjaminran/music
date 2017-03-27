.PHONY: test
test:
	bats test/pdftext.bats
	bats test/lib.bats

docker:
	docker build -t benjaminran/music .

container: docker
	docker run --rm -it benjaminran/music bash
