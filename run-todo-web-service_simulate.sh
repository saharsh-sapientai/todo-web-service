source ./add-environment-variables.sh

if [ -z "$SERVICE_NAME" ]; then
    echo "Error: SERVICE_NAME is not set."
    echo "Please set it using: export SERVICE_NAME=<your_service_name>"
    exit 1
else
    echo "SERVICE_NAME is set to '$SERVICE_NAME'."
fi

export ENABLE_EXTENSION=true;
export EXTENSION_MODE=simulate;
export GO_SERVER_BASE_URL=https://app.baserock.ai/it/leService;

CURRENT_DIR=$(pwd)

java -javaagent:${CURRENT_DIR}/src/main/resources/opentelemetry-javaagent.jar \
 -Dotel.resource.attributes=service.name=${SERVICE_NAME} \
 -Dotel.javaagent.extensions=${CURRENT_DIR}/src/main/resources/sapient-otel-extension-1.0-all.jar \
 -Dio.opentelemetry.javaagent.slf4j.simpleLogger.defaultLogLevel=off \
 -Dspring.profiles.active=dev \
 -jar ${CURRENT_DIR}/build/libs/todo-web-service-1.0.0.jar

