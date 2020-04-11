docker build -t satya323/multi-client:latest -t satya323/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t satya323/multi-server:latest -t satya323/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t satya323/multi-worker:latest -t satya323/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push satya323/multi-client:latest
docker push satya323/multi-server:latest
docker push satya323/multi-worker:latest

docker push satya323/multi-client:$SHA
docker push satya323/multi-server:$SHA
docker push satya323/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=satya323/multi-server:$SHA
kubectl set image deployments/client-deployment client=satya323/multi-client:$SHA
kubectl set image deployment/worker-deployment worker=satya323/multi-worker:$SHA