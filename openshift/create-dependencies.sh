#!/bin/bash

# ===================================================================================
# Creating project depenencies
# ===================================================================================



echo "Creating Jenkins persistent resources ..."
oc process -f ./templates/jenkins-persistent-template.json | oc create -f -
echo ""

echo "Creating Jenkins Node12 agent resources ..."
oc process -f ./templates/jenkins-agent-node12-template.json | oc create -f -
echo ""

echo "Creating Nginx application resources ..."
oc process -f ./templates/deployment-config-template.json | oc create -f -
echo ""

echo "Done creating project resources"