.PHONY: test

PACKAGE_FOLDER=pymuplot

check: test todo flake lint-e

test:
	@nose2 -vvv --with-coverage

todo:
	@rgrep "TODO" --include="*py" --exclude-dir="env" || true
	@rgrep "# REF" --include="*py" || true

flake:
	flake8 $(PACKAGE_FOLDER)

lint-e:
	pylint --disable=R,C,W $(PACKAGE_FOLDER) || true

cover:
	@nose2 --with-coverage --coverage-report=html

upload:
	python3 setup.py sdist
	python3 -m twine upload --repository pypi dist/*
