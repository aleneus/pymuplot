.PHONY: test

PACKAGE_FOLDER=pymuplot

check: test fixme flake lint-e

test:
	@nose2 -vvv --with-coverage

fixme:
	@rgrep "TODO" -n \
		--include="*py" \
		--include="*rst" \
		--include="*md" \
		--exclude-dir=env \
		|| true

	@rgrep "# REF" -n \
		--include="*py" \
		--exclude-dir=env \
		|| true

flake:
	flake8 $(PACKAGE_FOLDER)

lint-e:
	pylint --disable=R,C,W $(PACKAGE_FOLDER) || true

cover:
	@nose2 --with-coverage --coverage-report=html

lint:
	pylint $(PACKAGE_FOLDER) || true

upload:
	python3 setup.py sdist
	python3 -m twine upload --repository pypi dist/*
