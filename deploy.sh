docker build -t seregask/multi-client-k8s:latest -t seregask/multi-client-k8s:$SHA -f ./client/Dockerfile ./client
docker build -t seregask/multi-server-k8s:latest -t seregask/multi-server-k8s:$SHA -f ./server/Dockerfile ./server
docker build -t seregask/multi-worker-k8s:latest -t seregask/multi-worker-k8s:$SHA -f ./worker/Dockerfile ./worker

docker push seregask/multi-client-k8s:latest
docker push seregask/multi-server-k8s:latest
docker push seregask/multi-worker-k8s:latest

docker push seregask/multi-client-k8s:$SHA
docker push seregask/multi-server-k8s:$SHA
docker push seregask/multi-worker-k8s:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment-k8s server=seregask/multi-server-k8s:$SHA
kubectl set image deployments/client-deployment-k8s client=seregask/multi-client-k8s:$SHA
kubectl set image deployments/worker-deployment-k8s worker=seregask/multi-worker-k8s:$SHA