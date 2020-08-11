#!/bin/bash

# ===================================================================================
# Creating project resources
# ===================================================================================

echo "Creating Jenkins persistent resources ..."
oc process -f ./templates/jenkins-persistent-template.json | oc create -f -
echo ""

echo "Creating Jenkins Node12 agent resources ..."
oc process -f ./templates/jenkins-agent-node12-template.json | oc create -f -
echo ""

echo "Creating Nginx application resources ..."
oc process -f ./templates/nginx-runtime-template.json | oc create -f -
echo ""

echo "Creating Nginx build pipeline resource ..."
oc process -f ./templates/jenkins-build-pipeline-template.json | oc create -f -

echo "Done creating project resources"