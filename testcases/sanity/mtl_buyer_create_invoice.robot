*** Settings ***
### Global ###
Resource    ../../resources/global_lib.resource
Resource    ../../resources/global_var.resource
Resource    ../../resources/global_keyword.resource
### Keyword for Common/Reuse ###
Resource    ../../keywords/api/common/common_api_keywords.resource
Resource    ../../keywords/web/common/common_web_keywords.resource
### Keyword for thirdparty ###
Resource    ../../keywords/web/thirdparty/common_ep_login_keywords.resource
Resource    ../../keywords/web/common/buyer_menu_keywords.resource
Resource    ../../keywords/web/thirdparty/common_ep_invoice_link_keywords.resource
Resource    ../../keywords/database/common/common_db_keywords.resource

### Page keyword releted ###
Resource    ../../keywords/web/invoice/buyer_create_invoice_keywords.resource
Resource    ../../keywords/web/invoice/manage_invoice.resource
Resource    ../../keywords/database/common/common_db_keywords.resource
Resource    ../../keywords/database/invoice/create_invoice.resource
### Test Suite Data ###
Variables   ../../resources/testdata/${env}/thirdparty/buyer_manage_invoice.yaml
Variables   ../../resources/testdata/${env}/invoice/create_invoice.yaml
Variables   ../../resources/testdata/${env}/sanity.yaml
Suite Setup     Open browser with about:blank and ${browser}
#Suite Teardown     Run Keywords     Logout from eInvoice 
#                             ...    Delete All Cookies
#                             ...    Close All browsers
Suite Teardown    Run Keywords    Delete All Cookies
                           ...    Close All browsers

*** Test Cases ***
Create invoice offline for buyer MTL
    [Documentation]     Create Invoice
                    ...     tc01 search buyer
                    ...     tc02 po list initial data , pagination
                    ...     tc03 search PO/GR
                    ...     tc04 expand PO list
                    ...     tc05 validate required field
                    ...     tc08 adjust VAT
                    ...     tc06 delete po/gr from invoice (select PO/GR and then remove)  # temp remove
    [Tags]  Sanity
    [Setup]         Run Keywords    Open einvoice website from EP via "${MTL_EP_WEB}" site with "${MTL_VERIFY}" and "${MTL_PASSWORD}"
                    ...   Go to Manage invoice page by url
                    ...   Change language 'EN'
    [Teardown]      Logout from eInvoice    

    User create Invoice with buyer "${BUYER_NAME_TH_MTL}" supplier "${SUPPLIER_NAME_TH_PTVN}" currency "${ALL_CURRENCY_EN}"
    On create invoice step1 system show initial data ,buyer "${BUYER_NAME_TH_MTL}" ,supplier "${SUPPLIER_NAME_TH_PTVN}" and currency "${THB_CURRENCY_DISPLAY}"
    and user can change page size to "20","50","100"
    and user can change pagination to "Next page" ,"Previous page" , "First page" and "Last page"
    and user can search PO/GR by search filter
    and user can expand po list
    then user select a po/gr to create an invoice then click "Next" button to summary PO of Invoice
    MTL on create invoice step2 when user submit invoice system show warning message correctly 
    and user adjust VAT then VAT Base Amount ,Invoice amount calculate correctly
    # and user can delete a po/gr that selected from step1  # remove cause MTL has only 1 PO/GR

During create invoice offline can cancel invoice at create page
    [Documentation]     Create Invoice
                    ...     tc07 delete po/gr from invoice (select PO/GR and then remove)
    [Tags]  Sanity
    [Setup]         Run Keywords    Open einvoice website from EP via "${MTL_EP_WEB}" site with "${MTL_VERIFY}" and "${MTL_PASSWORD}"
                    ...   Go to Manage invoice page by url
                    ...   Change language 'EN'
    [Teardown]      Logout from eInvoice
    User create Invoice with buyer "${BUYER_NAME_TH_MTL}" supplier "${SUPPLIER_NAME_TH_PTVN}" currency "${ALL_CURRENCY_EN}"
    user select a po/gr to create an invoice then click "Next" button to summary PO of Invoice
    User can delete selected invoice at create invoice
  

Create invoice offline and adjust partial invoice
    [Documentation]     Create Invoice
                    ...     tc09 adjust partial invoice
    [Tags]  Sanity      
    [Setup]         Run Keywords    Open einvoice website from EP via "${MTL_EP_WEB}" site with "${MTL_VERIFY}" and "${MTL_PASSWORD}"
                    ...   Go to Manage invoice page by url
                    ...   Change language 'EN'
    [Teardown]      Logout from eInvoice
    User create Invoice with buyer "${BUYER_NAME_TH_MTL}" supplier "${SUPPLIER_NAME_TH_PTVN}" currency "${ALL_CURRENCY_EN}"
    and user select a po/gr to create an invoice then click "Next" button to summary PO of Invoice
    and Get "GR number" "PO number" "${BUYER_NAME_TH_MTL}" "Invoice Amount" "${THB_CURRENCY_DISPLAY}" from create invoice step 2 
    and Click first row of PO to drew down to "Invoice Details"    
    and Verify "Invoice Details" show correct data from create invoice step 2
    and Modify data "Invoice amount" "Retention" all items
    then Verify "Invoice Amount" show correctly on "Invoice Details" page and save
    and "Invoice Amount" "Retention Amount" show correctly on create invoice step 2
