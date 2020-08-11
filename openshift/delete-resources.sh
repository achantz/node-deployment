#!/bin/bash

# ===================================================================================
# Delete project resources
# ===================================================================================

echo "Deleting existing Nginx application resources ..."
oc delete all --selector app=nginx
echo ""

echo "Deleting existing Jenkins persistent resources ..."
oc delete all --selector app=jenkins-persistent 
echo ""

echo "Deleting existing Jenkins Node12 builder resources ..."
oc delete all --selector app=jenkins-agent-node12
echo ""