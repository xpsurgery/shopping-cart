IMAGE         := xps/shopping-cart-game
GEMS          := Gemfile.lock
SOURCES       := $(shell find . -name '*.r[bu]')
BUILT_IMAGE   := .made-image
PASSING_TESTS := .made-tests

.PHONY: build run $(IMAGE) clean clobber

build: $(BUILT_IMAGE)

run: build
	docker run $(IMAGE) -p 17171:17171

$(BUILT_IMAGE): Dockerfile $(PASSING_TESTS)
	docker build -t $(IMAGE) .
	@touch $@

$(PASSING_TESTS): $(SOURCES) $(GEMS)
	bundle exec rspec
	@touch $@

$(GEMS): Gemfile
	bundle install

clean:
	rm $(BUILT_IMAGE) $(PASSING_TESTS)

clobber: clean
	rm -f $(GEMS)

