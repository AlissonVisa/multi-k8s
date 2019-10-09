docker build -t alissonvisa/multi-client:latest -t alissonvisa/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t alissonvisa/multi-server:latest -t alissonvisa/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t alissonvisa/multi-worker:latest -t alissonvisa/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push alissonvisa/multi-client
docker push alissonvisa/multi-server
docker push alissonvisa/multi-worker
docker push alissonvisa/multi-client:$SHA
docker push alissonvisa/multi-server:$SHA
docker push alissonvisa/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=alissonvisa/multi-server:$SHA
kubectl set image deployments/client-deployment client=alissonvisa/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=alissonvisa/multi-worker:$SHA