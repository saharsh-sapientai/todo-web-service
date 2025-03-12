export LE_SERVICE_URL=https://app.baserock.ai/it/leService
export SERVICE_UNDER_TEST_URL=http://localhost:8080
export PROTOCOL=rest

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
sleep 10
echo "Stopping the simulation..."
PID=$(pgrep -f run-do-do-web-service_simulation.sh)
if [ -n "$PID" ]; then
    echo "Process found with PID: $PID"
    pkill -f run-do-do-web-service_simulation.sh
    echo "Process killed."
else
    echo "No matching process found."
fi


sleep 10
PID=$(pgrep -f 'java .*todo-web-service-1.0.0.jar' | head -n 1)

if [ -n "$PID" ]; then
    echo "Dumping JaCoCo execution data..."
    jcmd "$PID" JaCoCo.dump
    sleep 5  # Give some time for the dump to complete

    echo "Killing process with PID: $PID"
    kill -15 "$PID"
else
    echo "No matching process found to kill."
fi

sleep 10
# Generate JaCoCo coverage report
echo "Generating JaCoCo coverage report..."
java -jar src/main/resources/jacococli.jar report jacoco.exec \
 --classfiles build/classes/java/main \
 --html jacoco-report

echo "JaCoCo report generated successfully!"
