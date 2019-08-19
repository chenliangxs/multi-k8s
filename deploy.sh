docker build -t chenliangxs/multi-client:latest -t chenliangxs/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t chenliangxs/multi-server:latest -t chenliangxs/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t chenliangxs/multi-worker:latest -t chenliangxs/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push chenliangxs/multi-client:latest
docker push chenliangxs/multi-server:latest
docker push chenliangxs/multi-worker:latest

docker push chenliangxs/multi-client:$SHA
docker push chenliangxs/multi-server:$SHA
docker push chenliangxs/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=chenliangxs/multi-server:$SHA
kubectl set image deployments/client-deployment client=chenliangxs/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=chenliangxs/multi-worker:$SHA
