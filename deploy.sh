docker build -t asawin11/multi-client:latest -t asawin11/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t asawin11/multi-server:latest -t asawin11/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t asawin11/multi-worker:latest -t asawin11/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push asawin11/multi-client:latest
docker push asawin11/multi-server:latest
docker push asawin11/multi-worker:latest
docker push asawin11/multi-client:$SHA
docker push asawin11/multi-server:$SHA
docker push asawin11/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=asawin11/multi-server:$SHA
kubectl set image deployments/client-deployment client=asawin11/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=asawin11/multi-worker:$SHA
