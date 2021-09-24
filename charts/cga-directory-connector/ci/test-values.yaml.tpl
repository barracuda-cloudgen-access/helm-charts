# Variables are replaced by the CI when testing
enrollmentToken:
  newSecret:
    value: "$DIRECTORY_CONNECTOR_ENROLLMENT_TOKEN"
authToken:
  type: "$DIRECTORY_CONNECTOR_AUTH_TYPE"
  newSecret:
    value: "$DIRECTORY_CONNECTOR_AUTH_TOKEN"
