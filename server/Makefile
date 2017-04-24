IMAGE         := xps/logichub-activities
GEMS          := Gemfile.lock
SOURCES       := $(shell find . -name '*.rb')
BUILT_IMAGE   := .made-image
PASSING_TESTS := .made-tests

.PHONY: $(IMAGE) clean clobber

all: $(BUILT_IMAGE)

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
