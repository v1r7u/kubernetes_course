# Services and Ingress

1. Create deployment with 3 replicas and service for it
    - stream logs from all pods
    - hit service endpoint several times

    ```sh
        # Create namespace
        kubectl create ns svc-task1

        # Create deployment and service for it
        kubectl apply -n svc-task1 -f 08_svc_task1.yaml

        kubectl get -n svc-task1 svc,pod

        # Run shell in default namespace and hit service multiple times
        kubectl run --rm --restart=Never --image=alpine -i -t test-shell -- ash
        wget -O- --timeout 1 http://nginx.svc-task1.svc.cluster.local:80
        # you can also try to hit service by ip wget -O- --timeout 1 http://{IP_ADDRESS}:80

        # get logs from pods
        kubectl logs -n svc-task1 pod_name

        # alternatively, you can tail logs from all containers with kubectl plugin, for example:
        kubectl krew install tail
        kubectl tail -n svc-task1
    ```

2. Create headless service. Hit each pod by dns name

    ```sh
        # Create namespace
        kubectl create ns svc-task2

        # Create nginx and headless-service for it
        kubectl apply -n svc-task2 -f 08_svc_task2.yaml

        # Check created Service and endpoints
        kubectl get endpoints,svc -n svc-task2

        # Run shell in default namespace and hit service multiple times
        kubectl run --rm --restart=Never --image=alpine -i -t test-shell -- ash
        wget -O- --timeout 1 http://headless-nginx.svc-task2.svc.cluster.local:80
        # ping pods directly
        wget -O- --timeout 1 http://nginx-0.headless-nginx.svc-task2.svc.cluster.local:80

        # get logs from containers
        kubectl logs -n svc-task2 container_name

        # alternatively, you can tail logs from all containers with kubectl plugin, for example:
        kubectl krew install tail
        kubectl tail -n svc-task2
    ```

3. Follow [Ingress tutorial](https://kubernetes.io/docs/tasks/access-application-cluster/ingress-minikube/).
