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
Resource    ../../../keywords/web/thirdparty/common_ep_invoice_link_keywords.resource

### Page keyword releted ###
Resource    ../../../keywords/web/invoice/buyer_approve_invoice_list_keywords.resource
Resource    ../../../keywords/web/cn_dn/buyer_create_cndn_keywords.resource
Resource    ../../../keywords/web/cn_dn/manage_cndn_keywords.resource
Resource    ../../../keywords/web/cn_dn/approval_view_cndn_keywords.resource
Resource    ../../../keywords/web/cn_dn/cndn_approve_keywords.resource
Resource    ../../../keywords/web/cn_dn/approval_cndn_keywords.resource
Resource    ../../../keywords/web/cn_dn/closed_creditdebit_note_keywords.resource

### Database keyword ###
Resource    ../../../keywords/database/cndn/cndn_db_keywords.resource
Resource    ../../../keywords/database/cndn/close_creditdebit_note_db_keywords.resource

### Test Suite Data ###
Variables   ../../../resources/testdata/${env}/cn_dn/cndn.yaml
Variables   ../../../resources/testdata/${env}/common/message.yaml
Variables   ../../../resources/testdata/${env}/cn_dn/closed_creditdebit_note.yaml

### Setup ### 
Suite Setup      Go to einvoice website from EP via "${TRUE_EP_WEB}" site with "${TRUE_APP_TYPE_1}" and "${TRUE_PASSWORD}"
Suite Teardown     Run Keywords    Delete All Cookies
                            ...    Close All browsers

*** Test Cases ***
Verify the required field for default field for "Close Credit/Debit Note" when access from Approve CN/DN List
    [Documentation]     Verify the required field for the default fields.
                ...     Default field on required field both Due Date and Payment Location
    [Tags]    Ready    CloseCNDN     Buyer    Web    CNDN       

    Given Go to "Approve CNDN" via URL on "${EINVOICE_URL_WEB}" and "${BUYER_APPROVE_CNDN_URI}" 
    When Click menu Close CN/DN on "CNDN-SUP-202008-001"    #${VIEW_CLOSED_CNDN_NO}
    And Confirm Close CN/DN  
    Then Verify default required field on duedate "${REQUIRED_FIELD_MESSAGE}" 
    And Verify default required field payment location "${REQUIRED_FIELD_MESSAGE}" 

    [Teardown]    Closed modal "Close Credit/Debit Note"


Verify the arrangement default field on the screen correctly when access from View CN/DN Detail Page
    [Documentation]    Verify arrangement on screen that order by 
                ...    Deu Date, Payment Location and Note is the last sequence of all
    [Tags]    Ready    CloseCNDN     Buyer    Web    CNDN 

    Given Go to "Approve CNDN" via URL on "${EINVOICE_URL_WEB}" and "${BUYER_APPROVE_CNDN_URI}"  
    And Go to 'View CN/DN detail page' of CN/DN Number "CNDN-SUP-202008-001"
    When Click button Close CN/DN on View Credit/Debit Note
    Then Verify arrangement default field on the modal    

    [Teardown]    Closed modal "Close Credit/Debit Note"         


Verify "Due Date" from input within date modal "Close Credit/Debit Note"
    [Documentation]    Verify due date : within date
    [Tags]    Ready    CloseCNDN     Buyer    Web    CNDN 

    Given Go to "Approve CNDN" via URL on "${EINVOICE_URL_WEB}" and "${BUYER_APPROVE_CNDN_URI}" 
    And Click menu Close CN/DN on "CNDN-SUP-202008-001"
    When Input data "${WITHIN_DATE}" into within date
    Then Verify within date accept only number and 3 digits of number

    [Teardown]    Closed modal "Close Credit/Debit Note"


Verify "Payment Location" data modal "Closed Credit/Debit Note"   
    [Documentation]    Verify the data of Payment Location 
    [Tags]    Ready    CloseCNDN     Buyer    Web    CNDN 

    Given Go to "Approve CNDN" via URL on "${EINVOICE_URL_WEB}" and "${BUYER_APPROVE_CNDN_URI}" 
    And Click menu Close CN/DN on "CNDN-SUP-202008-001"
    When Click on dropdown list payment location
    Then Verify payment location same with database

    [Teardown]    Closed modal "Close Credit/Debit Note"

#
# Configuration Field
#  
Verify configuration Closed invoice field displayed correct
    [Tags]    Ready     CloseCNDN     Buyer    Web    CNDN 
    [Documentation]    Verify configuration field that display on UI

    Given Go to "Approve CNDN" via URL on "${EINVOICE_URL_WEB}" and "${BUYER_APPROVE_CNDN_URI}" 
    When Search Approval CN/DN with status "Awaiting"
    and Click menu Close CN/DN on "CNDN-SUP-202008-001"
    and Confirm Close CN/DN
    Then Verify configuration Close CN/DN required fields show error "This field is required"
    And Verify arrangement for configuration Close CN/DN correct
    And Verify configuration Close CN/DN dropdown list value
    
    [Teardown]    Closed modal "Close Credit/Debit Note"
##
# SAP Interface 
# Validated only Update Data , CNDNHistory, CNDN Status, CNDN Approve Status
#    
Verify correct update data when successfully Close CN/DN when closed by approver
    [Tags]    Ready    CloseCNDN     Buyer    Web    CNDN
    [Documentation]    Verify data in database that close invoice

    #Given create offline cndn for use with close cndn and set to 'CNDN_NUMBER_TO_CLOSE_CNDN_LV1'
    Given create offline cndn for use with close cndn and set to 'CNDN_NUMBER_TO_CLOSE_CNDN_LV1' via buyer
    And Go to "Approve CNDN" via URL on "${EINVOICE_URL_WEB}" and "${BUYER_APPROVE_CNDN_URI}" 
    When Search Approval CN/DN with status "Awaiting"
    And Click menu Close CN/DN on "${CNDN_NUMBER_TO_CLOSE_CNDN_LV1}"
    And Input data into default field current date and Payment Location "${PAYMENT_LOCATION_NAME}" and Note "${NOTE}"
    And Input data in to configuration field with text "${CONFIG_DATA}" and select next day and first value in dropdown list
    And Confirm Close CN/DN
    Then Verify Close CN/DN data in database correctly at CN/DN Number "${CNDN_NUMBER_TO_CLOSE_CNDN_LV1}" and user "${TRUE_APP_TYPE_1}"
    And Verify Close CN/DN at View CN/DN detail correctly at CN/DN Number "${CNDN_NUMBER_TO_CLOSE_CNDN_LV1}" on Payment Location "${PAYMENT_LOCATION_NAME}"


# Verify correct update data when successfully Close CN/DN when closed by approver level 2
#     [Tags]    Keep    CloseCNDN
#     [Documentation]    Verify data in database that close invoice    
#                 ...    Must login with others user, Please login wint user "invoice_01" or "invoice_02"  

#     Given Go to einvoice website from EP via "${TRUE_EP_WEB}" site with "${TRUE_APP_TYPE_1}" and "${TRUE_PASSWORD}"
#     And Go to "Approve CNDN" via URL on "${EINVOICE_URL_WEB}" and "${BUYER_APPROVE_CNDN_URI}" 
#     When Click menu Close CN/DN on "${CNDN_NUM}"
#     And Input data into default field Within Date "${WITHIN}" and Payment Location "${PAYMENT_LOCATION}" and Note "${NOTE}"
#     And Input data in to configuration field with text "123456789" and selecte next day and first value in dropdown list
#     And Confirm Close CN/DN
#     Then Verify Close CN/DN data in database correctly at CN/DN Number "${CNDN_NUM}"
#     And Verify Close CN/DN at View CN/DN detail correctly at CN/DN Number "${CNDN_NUM}" on Payment Location "${PAYMENT_LOCATION}"

    


















                