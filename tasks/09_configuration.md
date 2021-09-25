# Configuration

1. Create pod with config map and secret

    ```sh
      kubectl create ns pod-config-app

      kubectl apply -n pod-config-app -f 09_configuration.yaml

      # connect to pod
      kubectl exec -it configuration-sample -n pod-config-app nginx -- /bin/sh

      # get env-vars
      printenv | grep SAMPLE_ENV

      # get mounted volumes.
      ls -la /sample_app/

      # Note, directories with two dots in names (..data, ..2021_*) and links to them. Date indicates time when content was loaded
      ls -la /sample_app/podinfo
      ls -la /sample_app/config-volume
      ls -la /sample_app/secret-volume

      # get files content
      cat /sample_app/config_sample.config
      cat /sample_app/config-volume/sample.config

      # exit from container
      exit
    ```

2. Update config and check changes

    Make change to `ConfigMap` For example:

    ```yaml
    apiVersion: v1
    kind: ConfigMap
    metadata:
      name: sample-config
    data:
      sample.config: |
        workshop=kubernetes
        duration=2sessions
        update_config=version2
      sample.oneline: "I am one line value [version2]"
    ```

    Apply changes to the cluster and check if it was reflected in volumes and env-vars:

    ```sh
      kubectl apply -n pod-config-app -f 09_configuration.yaml

      # connect to pod
      kubectl exec -it configuration-sample -n pod-config-app nginx -- /bin/sh

      # get env-vars and note that SAMPLE_ENV_CONFIG_ONELINE is not changed
      printenv | grep SAMPLE_ENV

      # Note, config-volume directory has two-dots directory with newer date
      ls -la /sample_app/podinfo
      ls -la /sample_app/config-volume
      ls -la /sample_app/secret-volume

      # get files content. Note, `config_sample.config` is not changed, while `config-volume/sample.config` is updated
      cat /sample_app/config_sample.config
      cat /sample_app/config-volume/sample.config
    ```
