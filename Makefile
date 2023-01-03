install:
	#install commands
	pip install --upgrade pip &&\
		pip install -r requirements.txt
format:
	#format code
	black *.py mylib/*.py
lint:
	#flake6 or pylint
	pylint --disable=R,C *.py mylib/*.py tests/*.py
test:
	python -m pytest -vv --cov=mylib --cov=main tests
build:
	#build container
	docker build -t deploy-fastapi .
run:
	#run docker
	#docker run -p 127.0.0.1:8080:8080 d74b37fcdb43
deploy:
	#deploy
all: install lint test deploy