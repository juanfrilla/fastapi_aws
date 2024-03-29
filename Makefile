install:
	#install commands
	pip install --upgrade pip &&\
		pip install -r requirements.txt
post-install:
			python -m textblob.download_corpora
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
	#deploy to aws (ECR)
	aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 934134239690.dkr.ecr.us-east-1.amazonaws.com
	docker build -t wiki .
	docker tag wiki:latest 934134239690.dkr.ecr.us-east-1.amazonaws.com/wiki:latest
	docker push 934134239690.dkr.ecr.us-east-1.amazonaws.com/wiki:latest

all: install post-install lint test deploy