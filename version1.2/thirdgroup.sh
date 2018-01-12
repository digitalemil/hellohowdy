#!/bin/bash

dcos security org groups create others

URL=$(dcos config show core.dcos_url)

dcos security org users create -d Other -p other other
dcos security org groups add_user others other

curl -X PUT -k -H "Authorization: token=$(dcos config show core.dcos_acs_token)" -H "Content-Type: application/json" -d '{"description":"Give permission to group cattlemen"}' $(dcos config show core.dcos_url)/acs/api/v1/acls/dcos:adminrouter:ops:slave/groups/others/full

curl -X PUT -k -H "Authorization: token=$(dcos config show core.dcos_acs_token)" -H "Content-Type: application/json" -d '{"description":"Give permission to group cattlemen"}' $(dcos config show core.dcos_url)/acs/api/v1/acls/dcos:adminrouter:package/groups/others/full

curl -X PUT -k -H "Authorization: token=$(dcos config show core.dcos_acs_token)" -H "Content-Type: application/json" -d '{"description":"Give permission to group cattlemen"}' $(dcos config show core.dcos_url)/acs/api/v1/acls/dcos:adminrouter:ops:mesos/groups/others/full

curl -X PUT -k -H "Authorization: token=$(dcos config show core.dcos_acs_token)" -H "Content-Type: application/json" -d '{"description":"Create permission to cattlemen"}' $(dcos config show core.dcos_url)/acs/api/v1/acls/dcos:adminrouter:service:howdy
curl -X PUT -k -H "Authorization: token=$(dcos config show core.dcos_acs_token)" -H "Content-Type: application/json" -d '{"description":"Give permission to group cattlemen"}' $(dcos config show core.dcos_url)/acs/api/v1/acls/dcos:adminrouter:service:howdy/groups/others/full

curl -X PUT -k -H "Authorization: token=$(dcos config show core.dcos_acs_token)" -H "Content-Type: application/json" -d '{"description":"Create permission to cattlemen"}' $(dcos config show core.dcos_url)/acs/api/v1/acls/dcos:adminrouter:service:hello
curl -X PUT -k -H "Authorization: token=$(dcos config show core.dcos_acs_token)" -H "Content-Type: application/json" -d '{"description":"Give permission to group cattlemen"}' $(dcos config show core.dcos_url)/acs/api/v1/acls/dcos:adminrouter:service:hello/groups/others/full

