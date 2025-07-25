prefix = /usr

servicedir = ${prefix}/lib/obs/service

all:

install:
	install -d $(DESTDIR)$(servicedir)
	install -m 0755 format_spec_file $(DESTDIR)$(servicedir)
	install -m 0644 format_spec_file.service $(DESTDIR)$(servicedir)
	install -d $(DESTDIR)$(servicedir)/format_spec_file.files
	install -m 0755 prepare_spec $(DESTDIR)$(servicedir)/format_spec_file.files
	install -m 0644 licenses_changes.txt $(DESTDIR)$(servicedir)/format_spec_file.files
	install -m 0644 licenses_exceptions.txt $(DESTDIR)$(servicedir)/format_spec_file.files

check:
	set -e ;\
	for i in testing/*.spec; do \
	  COPYRIGHT_YEAR=2021 perl -w prepare_spec $$i | \
	  diff -u --label $$i.out --label $$i.actual $$i.out - ;\
	done ;\

format:
	perltidy -pro=.perltidyrc prepare_spec  -b -bext='/'

.PHONY: all install check format
