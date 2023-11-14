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
Resource    ../../../keywords/database/cndn/cndn_db_keywords.resource
Resource    ../../../keywords/web/invoice/invoice_status_keywords.resource
Resource    ../../../keywords/web/cn_dn/approval_view_cndn_keywords.resource
Resource    ../../../keywords/web/cn_dn/cndn_approve_keywords.resource
### Test Suite Data ###
Variables   ../../../resources/testdata/${env}/attachment/attachment.yaml
### Setup ###  
Suite setup     Go to einvoice website from EP via "${TRUE_EP_WEB}" site with "${TRUE_VERIFY_03}" and "${TRUE_PASSWORD}" and go to cndn approve list       
Suite Teardown     Run Keywords    Delete All Cookies
                            ...    Close All browsers
Test teardown       Run keywords    Click 'X' to close attachment modal     Click 'X' mark to close 'View CNDN' page

*** Test Cases ***
"Credit / Debit Note Attachment​" and "Invoice Attachment" has attachment icon green when there is any attachment in and be able to see and download file
    [Tags]      regression      high    web   DB    TC_eINVOICE_02486    TC_eINVOICE_02490  Ready
    [Documentation]    Verify icon sign and download able
    When Go to 'View CN/DN detail page' of CN/DN Number "TRue-h-cn20191111"
    Then Green attachment icon display for 'CNDN level'
    and Green attachment icon display for 'Invoice level'

    [Teardown]      Click 'X' mark to close 'View CNDN' page

"Credit / Debit Note Attachment​" shows message 'Note' and checked mark 'Send to supplier'
    [Tags]      regression      high    web   DB    TC_eINVOICE_02487   Ready
    [Documentation]    Verify field is display if has value, and hidden if has no value
    When Go to 'View CN/DN detail page' of CN/DN Number "TRue-h-cn20191111"
    and Click attachment icon on 'CNDN level'
    Then Attachment modal display 'Note' as "CNDN note 123"
    and Attachment modal display checked 'Send To Supplier'
    
"Invoice Attachment" shows message 'Note' and checked mark 'Send to supplier'
    [Tags]      regression      high    web   DB    TC_eINVOICE_02491   Ready
    When Go to 'View CN/DN detail page' of CN/DN Number "IsAttachTrue-01"
    and Click attachment icon on 'Invoice level'
    Then Attachment modal display 'Note' as "Is attach on create"
    and Attachment modal display checked 'Send To Supplier'

"Credit / Debit Note Attachment​" hide 'Note' when has no value.
    [Tags]      regression      high    web   DB    TC_eINVOICE_02488   Ready
    [Documentation]    Verify field is display if has value, and hidden if has no value
    When Go to 'View CN/DN detail page' of CN/DN Number "CNDNMate001"   
    and Click attachment icon on 'CNDN level'
    Then Green attachment icon display for 'CNDN level'
    and Attachment modal hide 'Note' field

"Invoice Attachment" hide 'Note' when has no value.
    [Tags]      regression      high    web   DB    TC_eINVOICE_02492   Ready
    [Documentation]    Verify field is display if has value, and hidden if has no value
    When Go to 'View CN/DN detail page' of CN/DN Number "OAT-CNDN2001-003"  
    and Click attachment icon on 'Invoice level'
    Then Green attachment icon display for 'Invoice level'
    and Attachment modal hide 'Note' field

"Credit / Debit Note Attachment​" shows message "There is no attachment for this credit / debit note." when there is NO any attachment in 
    [Tags]      regression      high    web   DB    TC_eINVOICE_02489    Ready
    [Documentation]    Verify message is display
    When Go to 'View CN/DN detail page' of CN/DN Number "AP-1"
    Then Attachment icon display for 'CNDN level' with message "There is no attachment for this credit / debit note."

"Invoice Attachment​" shows message "There is no attachment for this invoice." when there is NO any attachment in 
    [Tags]      regression      high    web   DB    TC_eINVOICE_02493   Ready
    [Documentation]    Verify message is display
    When Go to 'View CN/DN detail page' of CN/DN Number "AP-1"
    Then Attachment icon display for 'Invoice level' with message "There is no attachment for this invoice"