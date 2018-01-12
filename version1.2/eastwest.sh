#!/bin/bash

dcos package install --yes --cli dcos-enterprise-cli

dcos security org groups create cattlemen
dcos security org groups create banker

URL=$(dcos config show core.dcos_url)

dcos security org users create -d David -p david david
dcos security org users create -d Charles -p charlie charlie

dcos security org groups add_user cattlemen charlie
dcos security org groups add_user banker david

dcos security secrets create --value='%3Cdiv%20id%3D%22secret%22%20style%3D%22font-size%3A%2012px%3B%20font-family%3A%20Courier%20New%2C%20Courier%2C%20monospace%22%3E%3Cpre%3E%20%20%20%20%20%20%20%20%20%20%28___%29%3C%2Fpre%3E%3Cpre%3E%20%20%20%20%20%20%20%20%20%20%28o%20o%29%3C%2Fpre%3E%3Cpre%3E%20%20%20%2F-------%5C%20%2F%3C%2Fpre%3E%3Cpre%3E%20%2F%20%7C%20%20%20%20%20%7C%7CO%3C%2Fpre%3E%3Cpre%3E%2A%20%20%7C%7C%2C---%7C%7C%3C%2Fpre%3E%3Cpre%3E%20%20%20%5E%5E%20%20%20%20%5E%5E%3C%2Fpre%3E%3C%2Fdiv%3E' west/cattlemen-secret
dcos security secrets create --value='%3Cdiv%20id%3D%22secret%22%20style%3D%22font-size%3A%2012px%3B%20font-family%3A%20Courier%20New%2C%20Courier%2C%20monospace%22%3E%3Cpre%3E%5B%CC%B2%CC%85%24%CC%B2%CC%85%28%CC%B2%CC%852%CE%BF%CE%BF%CC%B2%CC%85%29%CC%B2%CC%85%24%CC%B2%CC%85%5D%20%5B%CC%B2%CC%85%24%CC%B2%CC%85%28%CC%B2%CC%85%CE%B9%CE%BF%CE%BF%CC%B2%CC%85%29%CC%B2%CC%85%24%CC%B2%CC%85%5D%20%5B%CC%B2%CC%85%24%CC%B2%CC%85%28%CC%B2%CC%855%CC%B2%CC%85%29%CC%B2%CC%85%24%CC%B2%CC%85%5D%20%5B%CC%B2%CC%85%24%CC%B2%CC%85%28%CC%B2%CC%851%CC%B2%CC%85%29%CC%B2%CC%85%24%CC%B2%CC%85%5D%3C%2Fpre%3E%3C%2Fdiv%3E%0D%0A' east/banker-secret
dcos security secrets create -f secrets/west-file.json west/west-filebasedsecret
dcos security secrets create -f secrets/east-file.json east/east-filebasedsecret


curl -X PUT -k -H "Authorization: token=$(dcos config show core.dcos_acs_token)" -H "Content-Type: application/json" -d '{"description":"Create permission to access cattlemen secret"}' $(dcos config show core.dcos_url)/acs/api/v1/acls/dcos:secrets:default:%252Fwest%252Fcattlemen-secret
curl -X PUT -k -H "Authorization: token=$(dcos config show core.dcos_acs_token)" -H "Content-Type: application/json" -d '{"description":"Give read permission to group cattlemen"}' $(dcos config show core.dcos_url)/acs/api/v1/acls/dcos:secrets:default:%252Fwest%252Fcattlemen-secret/groups/cattlemen/read
curl -X PUT -k -H "Authorization: token=$(dcos config show core.dcos_acs_token)" -H "Content-Type: application/json" -d '{"description":"Create permission to access cattlemen secret"}' $(dcos config show core.dcos_url)/acs/api/v1/acls/dcos:secrets:default:%252Feastwest-secret
curl -X PUT -k -H "Authorization: token=$(dcos config show core.dcos_acs_token)" -H "Content-Type: application/json" -d '{"description":"Give read permission to group cattlemen"}' $(dcos config show core.dcos_url)/acs/api/v1/acls/dcos:secrets:default:%252Feastwest-secret/groups/cattlemen/read


curl -X PUT -k -H "Authorization: token=$(dcos config show core.dcos_acs_token)" -H "Content-Type: application/json" -d '{"description":"Create permission to cattlemen"}' $(dcos config show core.dcos_url)/acs/api/v1/acls/dcos:adminrouter:service:marathon
curl -X PUT -k -H "Authorization: token=$(dcos config show core.dcos_acs_token)" -H "Content-Type: application/json" -d '{"description":"Give permission to group cattlemen"}' $(dcos config show core.dcos_url)/acs/api/v1/acls/dcos:adminrouter:service:marathon/groups/cattlemen/full

curl -X PUT -k -H "Authorization: token=$(dcos config show core.dcos_acs_token)" -H "Content-Type: application/json" -d '{"description":"Create permission to cattlemen"}' $(dcos config show core.dcos_url)/acs/api/v1/acls/dcos:service:marathon:marathon:services:%252Fwest
curl -X PUT -k -H "Authorization: token=$(dcos config show core.dcos_acs_token)" -H "Content-Type: application/json" -d '{"description":"Give permission to group cattlemen"}' $(dcos config show core.dcos_url)/acs/api/v1/acls/dcos:service:marathon:marathon:services:%252Fwest/groups/cattlemen/full

curl -X PUT -k -H "Authorization: token=$(dcos config show core.dcos_acs_token)" -H "Content-Type: application/json" -d '{"description":"Create permission to cattlemen"}' $(dcos config show core.dcos_url)/acs/api/v1/acls/dcos:adminrouter:ops:slave
curl -X PUT -k -H "Authorization: token=$(dcos config show core.dcos_acs_token)" -H "Content-Type: application/json" -d '{"description":"Give permission to group cattlemen"}' $(dcos config show core.dcos_url)/acs/api/v1/acls/dcos:adminrouter:ops:slave/groups/cattlemen/full

curl -X PUT -k -H "Authorization: token=$(dcos config show core.dcos_acs_token)" -H "Content-Type: application/json" -d '{"description":"Create permission to cattlemen"}' $(dcos config show core.dcos_url)/acs/api/v1/acls/dcos:adminrouter:package
curl -X PUT -k -H "Authorization: token=$(dcos config show core.dcos_acs_token)" -H "Content-Type: application/json" -d '{"description":"Give permission to group cattlemen"}' $(dcos config show core.dcos_url)/acs/api/v1/acls/dcos:adminrouter:package/groups/cattlemen/full

curl -X PUT -k -H "Authorization: token=$(dcos config show core.dcos_acs_token)" -H "Content-Type: application/json" -d '{"description":"Create permission to cattlemen"}' $(dcos config show core.dcos_url)/acs/api/v1/acls/dcos:adminrouter:ops:mesos
curl -X PUT -k -H "Authorization: token=$(dcos config show core.dcos_acs_token)" -H "Content-Type: application/json" -d '{"description":"Give permission to group cattlemen"}' $(dcos config show core.dcos_url)/acs/api/v1/acls/dcos:adminrouter:ops:mesos/groups/cattlemen/full

curl -X PUT -k -H "Authorization: token=$(dcos config show core.dcos_acs_token)" -H "Content-Type: application/json" -d '{"description":"Create permission to cattlemen"}' $(dcos config show core.dcos_url)/acs/api/v1/acls/dcos:adminrouter:service:howdy
curl -X PUT -k -H "Authorization: token=$(dcos config show core.dcos_acs_token)" -H "Content-Type: application/json" -d '{"description":"Give permission to group cattlemen"}' $(dcos config show core.dcos_url)/acs/api/v1/acls/dcos:adminrouter:service:howdy/groups/cattlemen/full




curl -X PUT -k -H "Authorization: token=$(dcos config show core.dcos_acs_token)" -H "Content-Type: application/json" -d '{"description":"Create permission to access banker secret"}' $(dcos config show core.dcos_url)/acs/api/v1/acls/dcos:secrets:default:%252Feast%252Fbanker-secret
curl -X PUT -k -H "Authorization: token=$(dcos config show core.dcos_acs_token)" -H "Content-Type: application/json" -d '{"description":"Give read permission to group banker"}' $(dcos config show core.dcos_url)/acs/api/v1/acls/dcos:secrets:default:%252Feast%252Fbanker-secret/groups/banker/read

#curl -X PUT -k -H "Authorization: token=$(dcos config show core.dcos_acs_token)" -H "Content-Type: application/json" -d '{"description":"Create permission to access banker secret"}' $(dcos config show core.dcos_url)/acs/api/v1/acls/dcos:secrets:default:%252Feastwest-secret
curl -X PUT -k -H "Authorization: token=$(dcos config show core.dcos_acs_token)" -H "Content-Type: application/json" -d '{"description":"Give read permission to group banker"}' $(dcos config show core.dcos_url)/acs/api/v1/acls/dcos:secrets:default:%252Feastwest-secret/groups/banker/read

#curl -X PUT -k -H "Authorization: token=$(dcos config show core.dcos_acs_token)" -H "Content-Type: application/json" -d '{"description":"Create permission to banker"}' $(dcos config show core.dcos_url)/acs/api/v1/acls/dcos:adminrouter:service:marathon
curl -X PUT -k -H "Authorization: token=$(dcos config show core.dcos_acs_token)" -H "Content-Type: application/json" -d '{"description":"Give permission to group banker"}' $(dcos config show core.dcos_url)/acs/api/v1/acls/dcos:adminrouter:service:marathon/groups/banker/full

curl -X PUT -k -H "Authorization: token=$(dcos config show core.dcos_acs_token)" -H "Content-Type: application/json" -d '{"description":"Create permission to banker"}' $(dcos config show core.dcos_url)/acs/api/v1/acls/dcos:service:marathon:marathon:services:%252Feast
curl -X PUT -k -H "Authorization: token=$(dcos config show core.dcos_acs_token)" -H "Content-Type: application/json" -d '{"description":"Give permission to group banker"}' $(dcos config show core.dcos_url)/acs/api/v1/acls/dcos:service:marathon:marathon:services:%252Feast/groups/banker/full

#curl -X PUT -k -H "Authorization: token=$(dcos config show core.dcos_acs_token)" -H "Content-Type: application/json" -d '{"description":"Create permission to banker"}' $(dcos config show core.dcos_url)/acs/api/v1/acls/dcos:adminrouter:ops:slave
curl -X PUT -k -H "Authorization: token=$(dcos config show core.dcos_acs_token)" -H "Content-Type: application/json" -d '{"description":"Give permission to group banker"}' $(dcos config show core.dcos_url)/acs/api/v1/acls/dcos:adminrouter:ops:slave/groups/banker/full

#curl -X PUT -k -H "Authorization: token=$(dcos config show core.dcos_acs_token)" -H "Content-Type: application/json" -d '{"description":"Create permission to banker"}' $(dcos config show core.dcos_url)/acs/api/v1/acls/dcos:adminrouter:package
curl -X PUT -k -H "Authorization: token=$(dcos config show core.dcos_acs_token)" -H "Content-Type: application/json" -d '{"description":"Give permission to group banker"}' $(dcos config show core.dcos_url)/acs/api/v1/acls/dcos:adminrouter:package/groups/banker/full

#curl -X PUT -k -H "Authorization: token=$(dcos config show core.dcos_acs_token)" -H "Content-Type: application/json" -d '{"description":"Create permission to banker"}' $(dcos config show core.dcos_url)/acs/api/v1/acls/dcos:adminrouter:ops:mesos
curl -X PUT -k -H "Authorization: token=$(dcos config show core.dcos_acs_token)" -H "Content-Type: application/json" -d '{"description":"Give permission to group banker"}' $(dcos config show core.dcos_url)/acs/api/v1/acls/dcos:adminrouter:ops:mesos/groups/banker/full

curl -X PUT -k -H "Authorization: token=$(dcos config show core.dcos_acs_token)" -H "Content-Type: application/json" -d '{"description":"Create permission to banker"}' $(dcos config show core.dcos_url)/acs/api/v1/acls/dcos:adminrouter:service:hello
curl -X PUT -k -H "Authorization: token=$(dcos config show core.dcos_acs_token)" -H "Content-Type: application/json" -d '{"description":"Give permission to group banker"}' $(dcos config show core.dcos_url)/acs/api/v1/acls/dcos:adminrouter:service:hello/groups/banker/full

dcos marathon app add east.json
dcos marathon app add west.json

echo You can hit both apps under
echo $URL/service/howdy
echo $URL/service/hello
