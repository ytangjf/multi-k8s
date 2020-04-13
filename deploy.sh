docker build -t yingying111/multi-client:latest -t yingying111/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t yingying111/multi-server:latest -t yingying111/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t yingying111/multi-worker:latest -t yingying111/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push yingying111/multi-client:latest
docker push yingying111/multi-server:latest
docker push yingying111/multi-worker:latest

docker push yingying111/multi-client:$SHA
docker push yingying111/multi-server:$SHA
docker push yingying111/multi-worker:$SHA

kubectl apply -f k8s 
kubectl set image deployments/server-deployment server=yingying111/multi-server:$SHA
kubectl set image deployments/client-deployment client=yingying111/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=yingying111/multi-worker:$SHA
