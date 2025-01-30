./add-environment-variables.sh

export ENABLE_EXTENSION=true;
export EXTENSION_MODE=simulate;
export GO_SERVER_BASE_URL=https://app.baserock.ai/it/leService;


java -javaagent:/Users/saharshbasal/Development/git_main/testing/todo-web-service/src/main/resources/opentelemetry-javaagent.jar \
 -Dotel.resource.attributes=service.name=${SERVICE_NAME} \
 -Dotel.javaagent.extensions=/Users/saharshbasal/Development/git_main/testing/todo-web-service/src/main/resources/sapient-otel-extension-1.0-all.jar \
 -Dio.opentelemetry.javaagent.slf4j.simpleLogger.defaultLogLevel=off \
 -Dspring.profiles.active=dev \
 -jar /Users/saharshbasal/Development/git_main/testing/todo-web-service/build/libs/todo-web-service-1.0.0.jar

