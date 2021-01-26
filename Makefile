prefix = /usr

servicedir = ${prefix}/lib/obs/service

all:

install:
	install -d $(DESTDIR)$(servicedir)
	install -m 0755 format_spec_file $(DESTDIR)$(servicedir)
	install -m 0644 format_spec_file.service $(DESTDIR)$(servicedir)
	install -d $(DESTDIR)$(servicedir)/format_spec_file.files
	install -m 0755 prepare_spec patch_license $(DESTDIR)$(servicedir)/format_spec_file.files
	install -m 0644 licenses_changes.txt $(DESTDIR)$(servicedir)/format_spec_file.files
	install -m 0644 licences_exceptions.txt $(DESTDIR)$(servicedir)/format_spec_file.files

check:
	temp=`mktemp` ;\
	for i in testing/*.spec; do \
	  perl prepare_spec $$i > $$temp ;\
	  diff -u $$temp $$i.out ;\
	done ;\
	rm $$temp

.PHONY: all install check
