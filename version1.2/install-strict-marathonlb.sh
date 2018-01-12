#!/bin/bash

dcos package install --yes --cli dcos-enterprise-cli
curl -k -v $(dcos config show core.dcos_url)/ca/dcos-ca.crt -o dcos-ca.crt
dcos security org service-accounts keypair private-key-mlb.pem public-key-mlb.pem
dcos security org service-accounts create -p public-key-mlb.pem -d "Marathon-LB service account" mlb-principal 
dcos security org service-accounts show mlb-principal
dcos security secrets create-sa-secret --strict private-key-mlb.pem mlb-principal marathon-lb/mlb-key


curl -X PUT --cacert dcos-ca.crt \
-H 'Content-Type: application/json' \
-H "Authorization: token=$(dcos config show core.dcos_acs_token)" $(dcos config show core.dcos_url)/acs/api/v1/acls/dcos:service:marathon:marathon:services:%252F \
-d '{"description":"Allows access to any service launched by the native Marathon instance"}' 

curl -X PUT --cacert dcos-ca.crt \
-H 'Content-Type: application/json' \
-H "Authorization: token=$(dcos config show core.dcos_acs_token)" $(dcos config show core.dcos_url)/acs/api/v1/acls/dcos:service:marathon:marathon:admin:events \
-d '{"description":"Allows access to Marathon events"}' 



curl -X PUT --cacert dcos-ca.crt \
-H "Authorization: token=$(dcos config show core.dcos_acs_token)" $(dcos config show core.dcos_url)/acs/api/v1/acls/dcos:service:marathon:marathon:services:%252F/users/mlb-principal/read
curl -X PUT --cacert dcos-ca.crt \
-H "Authorization: token=$(dcos config show core.dcos_acs_token)" $(dcos config show core.dcos_url)/acs/api/v1/acls/dcos:service:marathon:marathon:admin:events/users/mlb-principal/read

dcos package install --options=mlb-options.json marathon-lb
