*** Settings ***
### Global ###
Resource    ../../../resources/global_lib.resource
Resource    ../../../resources/global_var.resource
Resource    ../../../resources/global_keyword.resource
### Keyword for Common/Reuse ###
Resource    ../../../keywords/web/common/common_web_keywords.resource
Resource    ../../../keywords/api/common/common_api_keywords.resource
Resource    ../../../keywords/database/common/common_db_keywords.resource
Resource    ../../../keywords/web/thirdparty/common_ep_invoice_link_keywords.resource
Resource    ../../../keywords/web/thirdparty/common_ep_login_keywords.resource
Resource    ../../../keywords/web/common/buyer_menu_keywords.resource
Resource    ../../../keywords/web/common/invoice_menu_keywords.resource
Variables   ../../../resources/locators/common/invoice_menu_locator.yaml
### Page keyword releted ###
Resource    ../../../keywords/web/cn_dn/cndn_edit_keywords.resource
Resource    ../../../keywords/web/cn_dn/cndn_approve_keywords.resource
Resource    ../../../keywords/web/cn_dn/approval_view_cndn_keywords.resource
Resource    ../../../keywords/database/cndn/cndn_db_keywords.resource
### Test Suite Data ###
Variables   ../../../resources/testdata/${env}/thirdparty/buyer_manage_invoice.yaml
Variables   ../../../resources/testdata/${env}/cn_dn/approve_cndn.yaml

Suite Setup     Go to einvoice website from EP via "${TRUE_EP_WEB}" site with "${TRUE_VERIFY_03}" and "${TRUE_PASSWORD}" and go to cndn approve list   
Suite Teardown     Run Keywords    Delete All Cookies
                            ...    Close All browsers
Test Teardown   Reload Page
*** Test Cases ***
Verify user can access edit cndn page in case click edit action on approval list page 
    [Tags]   regression     medium    web    DB     Ready
    [Documentation]  Verify new page is implemented and pass data to display on that page  
                ...  as a buyer who has permission [idp] i can access edit page via action button cn/dn status awaiting
                ...  header data section ,detail data section and invoice data section display correctly 
                ...  payment location ddl , due date selection displayed and show data correctly         
    When Go to 'Edit CN/DN page' of CN/DN Number "TRUEH-DN20191125-001" via action button
    Then Verify page 'Edit CN/DN' display
    and Message for Header section display all expected "${APPROVAL_MESSAGE_HEADER_SECTION}" correctly          
    and Message for Credit/Debit note section display all expected "${APPROVAL_MESSAGE_CNDN_SECTION}" correctly          
    and Message for Invoice section display all expected "${MESSAGE_INVOICE_SECTION}" correctly                 
    and Edit CN/DN detail page of CN/DN Number "TRUEH-DN20191125-001" Type "Verify Document" should match with DB     
    and Due date selection visible and display correctly                                                                     
    and Payment location ddl visible and display correctly 

Verify user can access edit cndn page in case click edit action on view cndn page 
    [Tags]   regression     medium    web   Ready
    [Documentation]  Verify new page is implemented
                ...  as a buyer i can access edit page via view cn/dn top bar action
    Given Go to 'View CN/DN detail page' of CN/DN Number "TRUEH-DN20191125-001"                                        
    When Click menu "Edit" at top right corner
    Then Verify page 'Edit CN/DN' display

Verify user can access edit cndn page in case click approve button on view cndn page 
    [Tags]   regression     medium    web   Ready
    [Documentation]  Verify new page is implemented
                ...  as a buyer i can access edit page via approve button
    Given Go to 'View CN/DN detail page' of CN/DN Number "TRUEH-DN20191125-001"
    When Click approve button
    Then Verify page 'Edit CN/DN' display

"Due Date​" ,"Payment Location" and "Note to Buyer​" should hide if data in database is NULL on 'Edit CN/DN' Page 
    [Tags]   regression     medium    web   Ready
    [Documentation]  Verify new page is implemented and pass data to display on that page  
    ...  payment location ddl , due date selection displayed and show data correctly (no data/default data display on ddl)          
    Given Go to 'View CN/DN detail page' of CN/DN Number "dontusemy26122019004"        
    When Click approve button
    Then Verify page 'Edit CN/DN' display
    and "Due Date", "Payment Location" and "Note to Buyer" is hidden

Modal "GR Details" display over "Edit Credit/ Debit note" page shoud display data properly when click each row from "Invoice number"
    [Tags]   regression      high    web    Ready
    [Documentation]  Verify new modal is implemented and pass data to display on that page
    Given Go to 'View CN/DN detail page' of CN/DN Number "TRUEH-DN20191125-001"
    and Click approve button
    and Verify page 'Edit CN/DN' display
    and Get target Invoice No. at column "${TEXT.INVOICE_NUMBER}" at row "${FIRST_ROW}" 
    When Click first row of Invoice at column "${TEXT.INVOICE_NUMBER}" to see GR detail
    Then GR detail on modal should match with DB
    and Click 'X' mark to close 'View GR Detail' modal

Leave "Edit CN/DN Page" in case click 'Leave' on Modal 'Leave Without Approve'
    [Tags]   regression      high    web    Ready
    [Documentation]  Verify modal is implemented and Leave button work fine
    Given Go to 'View CN/DN detail page' of CN/DN Number "TRUEH-DN20191125-001"     
    and Click approve button
    and Verify page 'Edit CN/DN' display
    When Click 'X' mark to close 'Edit CN/DN page'
    and Click 'Leave' on Modal 'Leave Without Approve'
    Then Verify page 'Approve CN/DN' display                        

Stay on "Edit CN/DN Page" in case click 'Stay on this Page' on Modal 'Leave Without Approve'
    [Tags]   regression      high    web    Ready
    [Documentation]  Verify modal is implemented and 'Stay on this Page' button work fine
    Given Go to 'View CN/DN detail page' of CN/DN Number "TRUEH-DN20191125-001"         
    and Click approve button
    and Verify page 'Edit CN/DN' display
    When Click 'X' mark to close 'Edit CN/DN page'
    and Click 'Stay on this Page' on Modal 'Leave Without Approve'
    Then Verify page 'Edit CN/DN' display