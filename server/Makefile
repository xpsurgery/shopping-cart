IMAGE         := xps/shopping-cart-game
GEMS          := Gemfile.lock
SOURCES       := $(shell find . -name '*.r[bu]')
BUILT_IMAGE   := .made-image
PASSING_TESTS := .made-tests
TMPDIR        := ./tmp
PIDFILE       := $(TMPDIR)/container.PID

.PHONY: build start logs stop $(IMAGE) clean clobber

build: $(BUILT_IMAGE)

start: build $(PIDFILE)

$(PIDFILE): $(TMPDIR)
	docker run --rm --detach -v `pwd`/../public:/opt/app/public -p 17171:17171 $(IMAGE) > $@

logs:
	docker logs `cat $(PIDFILE)`

stop:
	-docker kill `cat $(PIDFILE)`
	rm -f $(PIDFILE)

$(TMPDIR):
	mkdir -p $@

$(BUILT_IMAGE): Dockerfile $(PASSING_TESTS)
	docker build --rm -t $(IMAGE) .
	@touch $@

$(PASSING_TESTS): $(SOURCES) $(GEMS)
	bundle exec rspec
	@touch $@

$(GEMS): Gemfile
	bundle install

clean:
	rm -f $(BUILT_IMAGE) $(PASSING_TESTS)

clobber: clean
	rm -f $(GEMS) $(PIDFILE)

