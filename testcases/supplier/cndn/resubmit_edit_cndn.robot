*** Settings ***
### Global ###
Resource    ../../../resources/global_lib.resource
Resource    ../../../resources/global_var.resource
Resource    ../../../resources/global_keyword.resource
### Keyword for Common/Reuse ###
Resource    ../../../keywords/web/common/common_web_keywords.resource
Resource    ../../../keywords/api/common/common_api_keywords.resource
Resource    ../../../keywords/database/common/common_db_keywords.resource
### Page keyword releted ###
Resource    ../../../keywords/web/cn_dn/cndn_status_keywords.resource
Resource    ../../../keywords/web/cn_dn/view_cndn_keywords.resource
Resource    ../../../keywords/database/cndn/cndn_db_keywords.resource
Resource    ../../../keywords/web/cn_dn/edit_cndn_keywords.resource
### Test Suite Data ###
Variables   ../../../resources/testdata/${env}/cn_dn/cndn.yaml

### Setup ###
Suite Setup    Run Keywords    Open setup browser with ${EINVOICE_URL_WEB} and ${BROWSER} and go to invoice supplier
                            ...    Go to menu CN/DN

Suite Teardown    Run Keywords    Delete All Cookies
                            ...    Close All browsers

*** Test Cases ***
Online CNDN status change to "Awaiting Approval" after resubmit is complete and success
    [Tags]  Ready
    Given User search CNDN "${CNDN_NUMBER_TO_RESUBMIT}" which needed to resubmit
    and User select CNDN "${CNDN_NUMBER_TO_RESUBMIT}" 
    and Click menu "Edit" at top right corner
    When User upload document successfully
    and User click resubmit cndn
    Then Success bar is shown "${RESUBMIT_SUCCESS_TEXT.EN}" with CNDNNumber '${CNDN_NUMBER_TO_RESUBMIT}'
    and CNDN "${CNDN_NUMBER_TO_RESUBMIT}" status is "Awaiting Approval"

    [Teardown]      Run Keywords    Set CNDN "${CNDN_NUMBER_TO_RESUBMIT}" to status Pending 
                    ...             Delete CNDN attachment CNDNNumber "${CNDN_NUMBER_TO_RESUBMIT}"
