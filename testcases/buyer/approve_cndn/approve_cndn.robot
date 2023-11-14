*** Settings ***
### Global ###
Resource    ../../../resources/global_lib.resource
Resource    ../../../resources/global_var.resource
Resource    ../../../resources/global_keyword.resource
### Keyword for Common/Reuse ###
Resource    ../../../keywords/web/common/common_web_keywords.resource
Resource    ../../../keywords/api/common/common_api_keywords.resource
Resource    ../../../keywords/database/common/common_db_keywords.resource
Resource    ../../../keywords/database/common/common_buyer_info_db_keywords.resource
Resource    ../../../keywords/web/thirdparty/common_ep_invoice_link_keywords.resource
Resource    ../../../keywords/web/thirdparty/common_ep_login_keywords.resource
Resource    ../../../keywords/web/common/buyer_menu_keywords.resource
Resource    ../../../keywords/web/common/invoice_menu_keywords.resource
Variables   ../../../resources/locators/common/invoice_menu_locator.yaml
### Page keyword releted ###
Resource    ../../../keywords/web/cn_dn/cndn_edit_keywords.resource
Resource    ../../../keywords/web/cn_dn/cndn_approve_keywords.resource
Resource    ../../../keywords/web/cn_dn/approve_cndn_keywords.resource
Resource    ../../../keywords/web/cn_dn/approval_view_cndn_keywords.resource
Resource    ../../../keywords/database/cndn/cndn_db_keywords.resource
Resource    ../../../keywords/database/cndn/approve_cndn_db_keywords.resource
Resource    ../../../keywords/api/create_cndn/create_cndn_keywords.resource
Variables    ../../../resources/testdata/uat/cn_dn/approve_cndn.yaml
Variables    ../../../resources/testdata/uat/cn_dn/create_cndn_controller.yaml

### Test Suite Data ###
Variables   ../../../resources/testdata/${env}/thirdparty/buyer_manage_invoice.yaml
Variables   ../../../resources/testdata/${env}/cn_dn/approve_cndn.yaml

Suite Setup     Open setup browser with ${EINVOICE_URL_WEB} and ${browser} and go to invoice supplier with user TT00100
Suite Teardown     Run Keywords    Delete All Cookies
                            ...    Close All browsers

*** Test Cases ***
Verify successfully approved credit or debit note
    [Tags]    BuyerCNDN    Ready    ApprovedCNDN    Web    Buyer
    [Documentation]    Verify approver can successfully approve credit or debit not
                ...    Then the system insert/update data is correct
                ...    and generate approval flow correctly, if any


    ####Prepare setup credit/debit note on supplier site then closed browser
    #####Insert data to database
    #####Insert data to elastic
    Prepare post request data to "${EINVOICE_URL_WEB}" at uri "${CREATE_CNDN_SUPPLIER_URI}" via "${CREATE_CNDN_1PO_TEMPLATE}" with "${SUPPLIER_CNDN_1PO}"
    Prepare post request data for elastic to "${EINVOICE_URL_WEB}" at uri "${CREATE_CNDN_ELASTIC_URI}" via "${CREATE_ELASTIC_1PO_TEMPLATE}" with "${SUPPLIER_ELASTIC_1PO}"
    Clear prepare cndn data session

    ####Activity on buyer site for approved credit/debit note
    Go to einvoice website from EP via "${TRUE_EP_WEB}" site with "invoice_01" and "${TRUE_PASSWORD}" and go to cndn approve list 
    Given Go to 'View CN/DN detail page' of CN/DN Number "${preparecndn_num}"   
    AND Click menu "Edit" at top right corner 
    When Select due date to within date 
    And Select payment location to "โอนเงินเข้าบัญชีธนาคาร"     
    And Get buyer data from token  
    And Select approve credit/debit note
    And Click approve cndn on approved modal with note "Approve By Robot Framework"
    Then Approve staus cndn "${preparecndn_num}" update to "Approved"
    And Approve approver name for cndn "${preparecndn_num}" should be "Invoice_01"
    And Approve note for cndn "${preparecndn_num}" should be "Approve By Robot Framework"
    And Verify correctly insert history logs should be had "1" rows
    And Verify correctly update credit/debit note same as "Completed"
