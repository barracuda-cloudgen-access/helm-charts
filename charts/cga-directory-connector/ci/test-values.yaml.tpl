# Variables are replaced by the CI when testing

customEnv:
  - name: FYDE_GROUPS_INCLUDED
    value: "cga-"

enrollmentToken:
  newSecret:
    value: "$DIRECTORY_CONNECTOR_ENROLLMENT_TOKEN"
