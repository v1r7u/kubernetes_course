# Kubernetes first steps

The goal of the document is to install kubernetes on a local machine and run first `kubectl` commands.

## Steps

1. Install [kind](https://kind.sigs.k8s.io/docs/user/quick-start/#installation) or [minikube](https://minikube.sigs.k8s.io/docs/start/). Install [kubectl](https://kubernetes.io/docs/tasks/tools/#kubectl).

2. Run local clusters

    ```sh
        # note, minikube creates one control-plane node + two data-plane nodes
        minikube start --nodes=3 --profile first
        # if you have a lot of compute resources, you can run the second cluster at the same time
        minikube start --nodes=2 --profile second

        # check docker images are running
        docker ps
    ```

3. Work with kubectl config:

    ```sh
        kubectl config view
        
        # view available contexts. Note, * marks current context
        kubectl config get-contexts

        # to switch contexts:
        kubectl config use-context first

        # to change current namespace:
        kubectl config set-context --current --namespace=kube-system

        # delete the second minikube cluster, as we do not need it anymore
        minikube delete --profile second
    ```

    To setup autocomplete, follow [cheat sheet](https://kubernetes.io/docs/reference/kubectl/cheatsheet/#kubectl-autocomplete).

4. Create namespace and list namespaces

    ```sh
        # list namespaces
        kubectl get ns

        # get machine-readable namespace description
        kubectl get ns default -o yaml

        # get human-readable namespace description
        kubectl describe ns default

        # create a new namespace
        kubectl create ns tutorial

        # view the full list again
        kubectl get ns

        # switch to new namespace:
        kubectl config set-context --current --namespace=tutorial
    ```

5. Getting help with `kubectl`

    Common command format: `kubectl {command} {object_type} {object_name} {params}`. For example in `kubectl get ns default -o yaml`:

    - `{command}` - `get`
    - `{object_type}` - `ns` (or `namespace`)
    - `{object_name}` - `default`
    - `{params}` - `-o yaml`

    ```sh
        # get help
        kubectl --help
        kubectl config --help
        kubectl get --help

        # get available resource types with shortnames and if resource is cluster-wide or namespaced
        kubectl api-resources

        # get more documentation about exact resource or its part: kubectl explain <type>.<fieldName>[.<fieldName>]
        kubectl explain namespace
        kubectl explain namespace.spec.finalizers
    ```

    More information about `kubectl` at [kubernetes.io docs](https://kubernetes.io/docs/reference/kubectl/). Especially, pay attention to [cheat-sheet](https://kubernetes.io/docs/reference/kubectl/cheatsheet/).

6. Schedule first application to created `tutorial` namespace.

    In one terminal run `kubectl get pods -n tutorial -w` to get updates about any changes with `Pod` objects.

    In the second terminal run:

    ```sh
        # deploy the demo application:
        kubectl apply -f https://gist.githubusercontent.com/v1r7u/19483d1a602645738158377c695c21fe/raw/236c38da273da8549133fe9594e657c01e884a34/sample_deployment.yaml

        # note Pods changes in your first terminal

        # review deployment object. Note, ready/available/up-to-date values
        kubectl get deployment nginx-deployment
        kubectl describe deployment nginx-deployment

        # get pods and note, that they are scattered between available data-plane nodes
        kubectl get pods -o wide

        # to get pods from any other namespace
        kubectl get pods -n kube-system
        kubectl get pods --all-namespaces

        # delete only defined in file resources or delete the entire namespace with all objects in it
        kubectl delete -f https://gist.githubusercontent.com/v1r7u/19483d1a602645738158377c695c21fe/raw/236c38da273da8549133fe9594e657c01e884a34/sample_deployment.yaml

        # delete namespace can also delete everything in it
        kubectl delete ns tutorial
    ```

7. Stop and/or delete minikube cluster

    ```sh
        minikube stop --profile first
        minikube delete --profile first
    ```

## Alternative introduction

[Hello minikube](https://kubernetes.io/docs/tutorials/hello-minikube/) article or [Interactive create-cluster](https://kubernetes.io/docs/tutorials/kubernetes-basics/create-cluster/cluster-intro/).
