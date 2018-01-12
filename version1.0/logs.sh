FRAMEWORK_NAME="marathon"
APP_ID="west/howdy"

# get the mesos task state json
MESOS_STATE="$(curl -k -H "Authorization: token=${DCOS_AUTH_TOKEN}" ${DCOS_URL}/mesos/state)"
TASK_STATE="$(echo "${MESOS_STATE}" | jq ".frameworks[] | select(.name == \"${FRAMEWORK_NAME}\") | .tasks[] | select(.name == \"${APP_ID}\")")"

# extract values from the task json
AGENT_ID="$(echo "${TASK_STATE}" | jq -r '.slave_id')"
TASK_ID="$(echo "${TASK_STATE}" | jq -r '.id')"
FRAMEWORK_ID="$(echo "${TASK_STATE}" | jq -r '.framework_id')"
EXECUTOR_ID="$(echo "${TASK_STATE}" | jq -r '.executor_id')"
CONTAINER_ID="$(echo "${TASK_STATE}" | jq -r '.statuses[0].container_status.container_id.value')"

# default to container ID when executor ID is empty
EXECUTOR_ID="${EXECUTOR_ID:-${TASK_ID}}"

# get container/task logs
curl -k -H "Authorization: token=${DCOS_AUTH_TOKEN}" "${DCOS_URL}/system/v1/agent/${AGENT_ID}/logs/v1/range/framework/${FRAMEWORK_ID}/executor/${EXECUTOR_ID}/container/${CONTAINER_ID}?skip_prev=100"
