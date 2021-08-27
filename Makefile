deploy-%:
	chalice deploy --profile $* --stage $*

delete-%:
	chalice delete --profile $* --stage $*

deps:
	pip install chalice
