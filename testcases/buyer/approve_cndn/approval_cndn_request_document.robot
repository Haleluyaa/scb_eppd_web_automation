*** Settings ***
### Global ###
Resource    ../../../resources/global_lib.resource
Resource    ../../../resources/global_var.resource
Resource    ../../../resources/global_keyword.resource
### Keyword for Common/Reuse ###
Resource    ../../../keywords/web/common/common_web_keywords.resource
Resource    ../../../keywords/api/common/common_api_keywords.resource
Resource    ../../../keywords/database/common/common_db_keywords.resource
### Keyword for thirdparty ###
Resource    ../../../keywords/web/thirdparty/common_ep_login_keywords.resource
Resource    ../../../keywords/web/common/invoice_menu_keywords.resource
Resource    ../../../keywords/web/thirdparty/common_ep_invoice_link_keywords.resource
Resource    ../../../keywords/database/common/common_db_keywords.resource
### Page keyword releted ###
Resource    ../../../keywords/web/cn_dn/buyer_create_cndn_keywords.resource
Resource    ../../../keywords/web/cn_dn/manage_cndn_keywords.resource
Resource    ../../../keywords/database/cndn/cndn_db_keywords.resource
Resource    ../../../keywords/web/cn_dn/approval_view_cndn_keywords.resource
Resource    ../../../keywords/web/cn_dn/cndn_approve_keywords.resource
### Test Suite Data ###
Variables   ../../../resources/testdata/${env}/cn_dn/cndn.yaml
Variables   ../../../resources/testdata/${env}/thirdparty/buyer_manage_invoice.yaml
### Setup ###
Suite setup     Go to einvoice website from EP via "${TRUE_EP_WEB}" site with "${TRUE_APP_TYPE_1}" and "${TRUE_PASSWORD}" and go to cndn approve list       
Suite Teardown     Run Keywords    Delete All Cookies
                            ...    Close All browsers

***Test Cases***
Success bar is shown when request information process is complete and success
    [Documentation]    To verify if Success bar is shown when request information process is complete and success 
    [Tags]      CNDN    Ready    RequestDocument    Buyer    Web
    Given create online CNDN for use with request document and set to 'CNDN_NUMBER_TO_REQUEST_DOCUMENT' 
    and Click menu cn/dn
    and Go to menu Approve CN/DN    
    and user search CNDN "${CNDN_NUMBER_TO_REQUEST_DOCUMENT}" 
    and user select CNDN
    and user click request document
    When user write reason in request textbox
    and user click confirm button
    Then Success bar is shown "${REQUEST_DOCUMENT_SUCCESS_TEXT.EN}" with CNDNNumber '${CNDN_NUMBER_TO_REQUEST_DOCUMENT}'
    and CNDNNumber '${CNDN_NUMBER_TO_REQUEST_DOCUMENT}' Request document information is save to database

    [Teardown]  Set CNDN ${CNDN_NUMBER_TO_REQUEST_DOCUMENT} back to offline CNDN