export LE_SERVICE_URL=https://app.baserock.ai/it/leService
export SERVICE_UNDER_TEST_URL=http://localhost:8080
export PROTOCOL=rest
export SERVICE_NAME=todo-service-dev-testing;

# Check if SERVICE_NAME is set
if [ -z "$SERVICE_NAME" ]; then
    echo "Error: SERVICE_NAME is not set."
    echo "Please set it using: export SERVICE_NAME=<your_service_name>"
    exit 1
else
    echo "SERVICE_NAME is set to '$SERVICE_NAME'."
fi

# Run API automation and wait for it to finish
echo "Running API automation..."
./api_automation_binary "${SERVICE_NAME}" ""
API_AUTOMATION_STATUS=$?

if [ $API_AUTOMATION_STATUS -ne 0 ]; then
    echo "Error: API automation failed with status $API_AUTOMATION_STATUS"
    exit 1
fi

# Stop the running simulation
echo "Stopping the simulation..."
pkill -f run-do-do-web-service_simulation.sh

# Generate JaCoCo coverage report
echo "Generating JaCoCo coverage report..."
java -jar src/main/resources/jacococli.jar report jacoco.exec \
 --classfiles build/classes/java/main \
 --html jacoco-report

echo "JaCoCo report generated successfully!"
