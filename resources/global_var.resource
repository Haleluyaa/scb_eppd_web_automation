*** Settings ***
Documentation    Only variables that are not dependency to business, test cases are allowed
Variables   testdata/${env}/common/login.yaml
Variables   configs/${env}/service_endpoint.yaml

# ***Variables***
# ${TIMEOUT}    30s