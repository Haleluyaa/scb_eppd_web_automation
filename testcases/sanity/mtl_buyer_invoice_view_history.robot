*** Setting ***
### Global ###
Resource    ../../resources/global_lib.resource
Resource    ../../resources/global_var.resource
Resource    ../../resources/global_keyword.resource
### Keyword for Common/Reuse ###
Resource    ../../keywords/web/common/common_web_keywords.resource
Resource    ../../keywords/api/common/common_api_keywords.resource
Resource    ../../keywords/web/thirdparty/common_ep_login_keywords.resource
Resource    ../../keywords/web/common/invoice_menu_keywords.resource
Resource    ../../keywords/web/thirdparty/common_ep_invoice_link_keywords.resource
Resource    ../../keywords/web/common/buyer_menu_keywords.resource
### Page keyword releted ###
Resource    ../../keywords/web/invoice/buyer_manage_invoice_list_keywords.resource
Resource    ../../keywords/web/invoice/invoice_history_keywords.resource
Resource    ../../keywords/web/invoice/buyer_manage_invoice_view_detail_keywords.resource
### Test Suite Data ###
Variables   ../../resources/testdata/${env}/sanity.yaml
Variables   ../../resources/testdata/${env}/thirdparty/buyer_manage_invoice.yaml

Suite Setup     Run Keywords    Go to einvoice website from EP via "${MTL_EP_WEB}" site with "${MTL_VERIFY}" and "${MTL_PASSWORD}"
                          ...   Go to Manage invoice page by url
                          ...   Change language 'EN'

Suite Teardown     Run Keywords    Logout from eInvoice
                            ...    Delete All Cookies
                            ...    Close browser

*** Test Cases ***
Buyer view manage invoice history on invoice list    
    [Tags]    Sanity    Ready    ViewHistory
   
    User get invoice data for validate from invoice list invoice on row "1"          
    User clicked action button on row 1 
    User choose invoice options "History" at row "1"  
    Invoice history be show correctly on header with invoice number "${TV_invoice_num}" and "${TV_buyer_name}" and "${TV_invoice_create_date}"
    Invoice history be show correctly on detail on buyer 

    [Teardown]    Go to Manage invoice page by url
Buyer view manage invoice history on view invoice detail  
    [Tags]   Sanity    Ready    ViewHistory

    User get invoice data for validate from invoice list invoice on row "1"
    User click on specificed invoice row "1" at column "2" 
    User buyer click button history
    Invoice history be show correctly on header with invoice number "${TV_invoice_num}" and "${TV_buyer_name}" and "${TV_invoice_create_date}"
    Invoice history be show correctly on detail on buyer

    [Teardown]    Go to Manage invoice page by url

