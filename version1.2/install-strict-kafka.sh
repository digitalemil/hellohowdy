#!/bin/bash
export KAFKA=kafka
#In case you deploy under /prod/kafka this should be prod%252Fkafka

dcos package install --yes --cli dcos-enterprise-cli
dcos package install --yes --cli kafka
curl -k -v $(dcos config show core.dcos_url)/ca/dcos-ca.crt -o dcos-ca.crt

dcos security org service-accounts keypair private-key-kafka.pem public-key-kafka.pem
dcos security org service-accounts create -p public-key-kafka.pem -d "Kafka service account" kafka-principal 
dcos security org service-accounts show kafka-principal
dcos security secrets create-sa-secret --strict private-key-kafka.pem kafka-principal kafka/kafka-key


curl -X PUT --cacert dcos-ca.crt \
-H "Authorization: token=$(dcos config show core.dcos_acs_token)" $(dcos config show core.dcos_url)/acs/api/v1/acls/dcos:mesos:master:framework:role:$KAFKA-role \
-d '{"description":"Controls the ability of $KAFKA-role to register as a framework with the Mesos master"}' \
-H 'Content-Type: application/json'
curl -X PUT --cacert dcos-ca.crt \
-H "Authorization: token=$(dcos config show core.dcos_acs_token)" $(dcos config show core.dcos_url)/acs/api/v1/acls/dcos:mesos:master:reservation:role:$KAFKA-role \
-d '{"description":"Controls the ability of $KAFKA-role to reserve resources"}' \
-H 'Content-Type: application/json'
curl -X PUT --cacert dcos-ca.crt \
-H "Authorization: token=$(dcos config show core.dcos_acs_token)" $(dcos config show core.dcos_url)/acs/api/v1/acls/dcos:mesos:master:volume:role:$KAFKA-role \
-d '{"description":"Controls the ability of $KAFKA-role to access volumes"}' \
-H 'Content-Type: application/json'
curl -X PUT --cacert dcos-ca.crt \
-H "Authorization: token=$(dcos config show core.dcos_acs_token)" $(dcos config show core.dcos_url)/acs/api/v1/acls/dcos:mesos:master:reservation:principal:kafka-principal \
-d '{"description":"Controls the ability of kafka-principal to reserve resources"}' \
-H 'Content-Type: application/json'
curl -X PUT --cacert dcos-ca.crt \
-H "Authorization: token=$(dcos config show core.dcos_acs_token)" $(dcos config show core.dcos_url)/acs/api/v1/acls/dcos:mesos:master:volume:principal:kafka-principal \
-d '{"description":"Controls the ability of kafka-principal to access volumes"}' \
-H 'Content-Type: application/json'

curl -X PUT --cacert dcos-ca.crt \
-H "Authorization: token=$(dcos config show core.dcos_acs_token)" $(dcos config show core.dcos_url)/acs/api/v1/acls/dcos:mesos:master:framework:role:$KAFKA-role/users/kafka-principal/create
curl -X PUT --cacert dcos-ca.crt \
-H "Authorization: token=$(dcos config show core.dcos_acs_token)" $(dcos config show core.dcos_url)/acs/api/v1/acls/dcos:mesos:master:reservation:role:$KAFKA-role/users/kafka-principal/create
curl -X PUT --cacert dcos-ca.crt \
-H "Authorization: token=$(dcos config show core.dcos_acs_token)" $(dcos config show core.dcos_url)/acs/api/v1/acls/dcos:mesos:master:volume:role:$KAFKA-role/users/kafka-principal/create
curl -X PUT --cacert dcos-ca.crt \
-H "Authorization: token=$(dcos config show core.dcos_acs_token)" $(dcos config show core.dcos_url)/acs/api/v1/acls/dcos:mesos:master:task:user:nobody/users/kafka-principal/create
curl -X PUT --cacert dcos-ca.crt \
-H "Authorization: token=$(dcos config show core.dcos_acs_token)" $(dcos config show core.dcos_url)/acs/api/v1/acls/dcos:mesos:master:reservation:principal:kafka-principal/users/kafka-principal/delete
curl -X PUT --cacert dcos-ca.crt \
-H "Authorization: token=$(dcos config show core.dcos_acs_token)" $(dcos config show core.dcos_url)/acs/api/v1/acls/dcos:mesos:master:volume:principal:kafka-principal/users/kafka-principal/delete



dcos package install --options=kafka-options.json kafka
