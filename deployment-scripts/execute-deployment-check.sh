#!/bin/sh
# log: start

# function calline the Assertible test service
execute_assertible_test()
{
  local TOKEN=$1
  local SERVICE_ID=$2
  local ENV=$3
  local TEST_REQUEST_PAYLOAD='{ "service": "'$SERVICE_ID'", "environment": "'$ENV'", "version": "v1", "wait": true }'
  echo 'TEST_REQUEST_PAYLOAD = '$TEST_REQUEST_PAYLOAD
  TEST_RESULT=`curl -u $TOKEN: "https://assertible.com/deployments" -d "${TEST_REQUEST_PAYLOAD}" | jq -r '.testRun.status'`
  #echo $RESULT
}

echo 'execute-deployment-check.sh: started'
ASSERTIBLE_ENV=$1
echo 'ASSERTIBLE_ENV = '$ASSERTIBLE_ENV
ASSERTIBLE_TOKEN=$2
echo 'ASSERTIBLE_TOKEN = '$ASSERTIBLE_TOKEN
ASSERTIBLE_SERVICE_ID=$3
echo 'ASSERTIBLE_SERVICE_ID = '$ASSERTIBLE_SERVICE_ID

# execute test
execute_assertible_test $ASSERTIBLE_TOKEN $ASSERTIBLE_SERVICE_ID $ASSERTIBLE_ENV
echo 'execute-deployment-check.sh: Test result: '$TEST_RESULT

# check the test results
if [ "$TEST_RESULT" = "TestRunPassed" ] ; then
    # tests passed successfully
    echo 'execute-deployment-check.sh: tests passed' 
  else
    # tests failed - throw an exception	  
    echo 'execute-deployment-check.sh: tests failed'
    exit 1
fi	

#log: successful finish
echo 'execute-deployment-check.sh: completed successfully'
