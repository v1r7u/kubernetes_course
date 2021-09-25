# Deployment

1. Create deployment with 2 replicas from yaml

    ```sh
      kubectl create ns deploy-app-task1

      # in [2] terminal watch creation process
      kubectl get pods -n deploy-app-task1 -o wide -w

      kubectl apply -n deploy-app-task1 -f 04_deployment.yaml

      # Get all
      kubectl get -n deploy-app-task1 all

      # Get ReplicaSets
      kubectl get -n deploy-app-task1 rs

      # describe Deployment, note old and new replica-sets at the end
      kubectl describe -n deploy-app-task1 deploy nginx-deployment
    ```

2. Scale deployment to 3 replicas (show replica-set)

    ```sh
      # if namespace is not created in step 1, create it:
      kubectl create ns deploy-app-task1

      # in [2] terminal watch scale process
      kubectl get rs -n deploy-app-task1 -o wide -w

      # in [3] terminal watch pods creation process
      kubectl get pods -n deploy-app-task1 -o wide -w

      # scale deployment
      kubectl scale deployment -n deploy-app-task1 nginx-deployment --replicas=3 --current-replicas=2

      # try to scale with incorrect --current-replicas scale deployment
      kubectl scale deployment -n deploy-app-task1 nginx-deployment --replicas=5 --current-replicas=2

      # stop watchers in [2] and [3] terminals
    ```

3. Update deployment with new image version while watching replica-sets

    ```sh
      # update yaml file to use k8s.gcr.io/nginx-slim:0.7

      # in [2] terminal watch update process
      kubectl get rs -n deploy-app-task1 -o wide -w

      # in [3] terminal watch pods creation process
      kubectl get pods -n deploy-app-task1 -w

      # apply new version:
      kubectl apply -n deploy-app-task1 -f 04_deployment.yaml

      # describe Deployment, note events at the end
      kubectl describe -n deploy-app-task1 deploy nginx-deployment

      # show the same events
      kubectl get events -n deploy-app-task1

      # stop watchers in [2] and [3] terminals
    ```

4. Rollback the last update

    ```sh
      # show help
      kubectl rollout --help

      # get status and history
      kubectl rollout status -n deploy-app-task1 deployment nginx-deployment
      kubectl rollout history -n deploy-app-task1 deployment nginx-deployment

      # in [2] and [3] terminals watch rollback process
      kubectl get rs -n deploy-app-task1 -o wide -w
      kubectl get pods -n deploy-app-task1 -w

      # rollback
      kubectl rollout undo -n deploy-app-task1 deployment nginx-deployment

      # clean up
      kubectl delete ns deploy-app-task1
    ```

    More details about rollback process at [learnk8s blog](https://learnk8s.io/kubernetes-rollbacks).
