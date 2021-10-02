docker build -t alverta/multi-client:latest -t alverta/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t alverta/multi-server:latest -t alverta/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t alverta/multi-worker:latest -t alverta/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push alverta/multi-client:latest
docker push alverta/multi-server:latest
docker push alverta/multi-worker:latest

docker push alverta/multi-client:$SHA
docker push alverta/multi-server:$SHA
docker push alverta/multi-worker:$SHA

kubectl apply -f k8s/
kubectl set image deployments/server-deployment server=alverta/multi-server:$SHA
kubectl set image deployments/client-deployment client=alverta/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=alverta/multi-worker:$SHA
