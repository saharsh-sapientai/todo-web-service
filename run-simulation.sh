export LE_SERVICE_URL=https://app.baserock.ai/it/leService
export SERVICE_UNDER_TEST_URL=http://localhost:8080
export SERVICE_NAME=todo-web-service

./api_automation_binary ${SERVICE_NAME} ""
