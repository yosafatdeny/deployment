#! /bin/bash

sed "s/tagVersion/$1/g" deployment.yml > config.k8s.yaml