export ENABLE_EXTENSION=true;
export EXTENSION_MODE=capture;
export GO_SERVER_BASE_URL=https://app.baserock.ai/it/leService;
export PUBLISHER_MODE=RabbitMQ;
export SERVICE_NAME=todo-web-service;
export MQ_HOST=localhost;
export MQ_PORT=5673;
export MQ_QUEUE=learning_engine_test_queue;
export MQ_USER=user;
export MQ_PASSWORD=<password>


java -javaagent:/Users/saharshbasal/Development/git_main/testing/todo-web-service/src/main/resources/opentelemetry-javaagent.jar \
 -Dotel.resource.attributes=service.name=${SERVICE_NAME} \
 -Dotel.javaagent.extensions=/Users/saharshbasal/Development/git_main/testing/todo-web-service/src/main/resources/sapient-otel-extension-1.0-all.jar \
 -Dio.opentelemetry.javaagent.slf4j.simpleLogger.defaultLogLevel=off \
 -Dspring.profiles.active=dev \
 -jar /Users/saharshbasal/Development/git_main/testing/todo-web-service/build/libs/todo-web-service-1.0.0.jar

