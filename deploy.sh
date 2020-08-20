docker build -t hsaad123/multi-client:latest -t hsaad123/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t hsaad123/multi-server:latest -t hsaad123/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t hsaad123/multi-worker:latest -t hsaad123/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push hsaad123/multi-client:latest
docker push hsaad123/multi-server:latest
docker push hsaad123/multi-worker:latest

docker push hsaad123/multi-client:$SHA
docker push hsaad123/multi-server:$SHA
docker push hsaad123/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=hsaad123/multi-server:$SHA
kubectl set image deployments/client-deployment client=hsaad123/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=hsaad123/multi-worker:$SHA