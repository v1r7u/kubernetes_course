# StatefulSet

1. Create stateful-set with Delete policy

    ```sh
      kubectl create ns state-app-task1

      # in [2] terminals watch 1-by-1 creation process
      kubectl get pods -n state-app-task1 -o wide -w

      # create stateful application
      kubectl apply -n state-app-task1 -f 05_statefulset.yaml

      # Get service, pod, pvs
      kubectl get -n state-app-task1 svc,pvc,pods

      # Get PV without namespace, note reclaim-policy delete
      kubectl get pv

      # delete stateful-set and check that PVC and PV survive
      kubectl delete -n state-app-task1 -f 05_statefulset.yaml

      kubectl get -n state-app-task1 pvc
      kubectl get pv

      # delete PVC and check PV deleted too
      kubectl delete -n state-app-task1  pvc www-web-0
      kubectl get pv

      # delete ns and check PV deleted too
      kubectl delete ns state-app-task1
      kubectl get pv
    ```

2. Create stateful-set with Retain policy

    ```sh
      kubectl create ns state-app-task2

      kubectl apply -n state-app-task2 -f 05_statefulset_reclaim.yaml

      # Get service, pod, pvs
      kubectl get -n state-app-task2 svc,pvc,pods

      # Get PV without namespace, note reclaim-policy Retain
      kubectl get pv

      # delete NAMESPACE
      kubectl delete ns state-app-task2

      # check PV survived
      kubectl get pv

      # NOTE, even if PV survived, they wouldn't be picked up if you just re-create the same stateful-set
      kubectl create ns state-app-task2
      kubectl apply -n state-app-task2 -f 05_statefulset_reclaim.yaml

      # if you want to re-attach old PPs, you have to:
      # 1. Create new PersistentVolumeClaim with parameters that satisfy PV
      # 2. Update PV object to reference PVC from the clause 1 (including correct uid)
    ```

3. Follow [Kubernetes.io StatefulSet tutorial](https://kubernetes.io/docs/tutorials/stateful-application/basic-stateful-set/) for a detailed StatefulSet course.
