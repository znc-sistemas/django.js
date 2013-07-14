BASEDIR=$(CURDIR)
DOCDIR=$(BASEDIR)/doc
DISTDIR=$(BASEDIR)/dist
PACKAGE='djangojs'
suite=$(or $(subst :, ,$(tests)), $(PACKAGE))

help:
	@echo 'Makefile for Django.js                                               '
	@echo '                                                                     '
	@echo 'Usage:                                                               '
	@echo '   make serve            Run the test server                         '
	@echo '   make test             Run the test suite                          '
	@echo '   make pep8             Run the PEP8 report                         '
	@echo '   make doc              Generate the documentation                  '
	@echo '   make dist             Generate a distributable package            '
	@echo '   make release          Bump a version and publish it on PyPI       '
	@echo '   make clean            Remove all temporary and generated artifacts'
	@echo '                                                                     '


serve:
	@echo 'Running test server'
	@python manage.py runserver

test:
	@echo 'Running test suite'
	@./minify.sh
	@python manage.py test $(suite)

pep8:
	@pep8 $(PACKAGE) --max-line-length=120 --ignore=E128,E122,E125 && echo 'PEP8: OK'

doc:
	@echo 'Generating documentation'
	@cd $(DOCDIR) && make html
	@echo 'Done'

dist:
	@echo 'Generating a distributable python package'
	@./minify.sh
	@python setup.py sdist
	@echo 'Done'

release:
	@echo 'Bumping version and publishing it'
	@./minify.sh
	@./release.sh
	@echo 'Done'

clean:
	rm -fr $(DISTDIR)

.PHONY: doc help clean test dist release