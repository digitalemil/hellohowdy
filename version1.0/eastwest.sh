#!/bin/bash


dcos security org groups create cattlemen
dcos security org groups create banker

URL=$(dcos config show core.dcos_url)
echo You can hit both apps under
echo $URL/service/howdy
echo $URL/service/hello

dcos security org users create -d David -p david david
dcos security org users create -d Charles -p charlie charlie

dcos security org groups add_user cattlemen charlie
dcos security org groups add_user banker david

dcos security secrets create --value="Longhorns, Hereford, Angus " west/cattlemen-secret
dcos security secrets create --value="Dollars, Euros, Pounds" east/banker-secret
dcos security secrets create --value="Shared Secret $ / Cattle" eastwest-secret
#<div id="secret" style="font-size: 12px; font-family: Courier New, Courier, monospace"><pre>          (___)</pre><pre>          (o o)</pre><pre>   /-------\ /</pre><pre> / |     ||O</pre><pre>*  ||,---||</pre><pre>   ^^    ^^</pre></div>
# [̲̅$̲̅(̲̅2οο̲̅)̲̅$̲̅] [̲̅$̲̅(̲̅ιοο̲̅)̲̅$̲̅] [̲̅$̲̅(̲̅5̲̅)̲̅$̲̅] [̲̅$̲̅(̲̅1̲̅)̲̅$̲̅]


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
