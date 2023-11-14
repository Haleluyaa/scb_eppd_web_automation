*** Settings ***
Documentation 

### Global ###
Resource    ../../resources/global_lib.resource
Resource    ../../resources/global_var.resource
Resource    ../../resources/global_keyword.resource

### Keyword for Common/Reuse ###
Resource    ../../keywords/web/common/common_web_keywords.resource
Resource    ../../keywords/api/common/common_api_keywords.resource
Resource    ../../keywords/database/common/common_db_keywords.resource
Resource    ../../keywords/web/common/buyer_menu_keywords.resource
Resource    ../../keywords/web/cn_dn/cndn_history_keywords.resource

### Keyword Relate Page ###
Resource    ../../keywords/web/cn_dn/manage_cndn_keywords.resource
Resource    ../../keywords/web/cn_dn/manage_view_cndn_keywords.resource

### Keyword for thirdparty ###S
Resource    ../../keywords/web/thirdparty/common_ep_login_keywords.resource
Resource    ../../keywords/web/thirdparty/common_ep_invoice_link_keywords.resource


### Setup ### 
Suite Setup     Go to einvoice website from EP via "${TRUE_EP_WEB}" site with "${TRUE_VIEW_1}" and "${TRUE_PASSWORD}"
Suite Teardown     Run Keywords    Logout from eInvoice
                            ...    Delete All Cookies
                            ...    Close browser

Metadata    Version    1.0
Metadata    EXECUTE_AT    %{COMPUTERNAME}%

***Test Cases***
Buyer view manage credit/debit note history on invoice list
    [Tags]    Sanity    Ready    ViewHistory    CNDN
    Given Go to "Manage Credit/Debit Note" list via ${EINVOICE_URL_WEB} and path uri ${BUYER_MANAGE_CNDN_URI}
    User get credit/debit note data for validate from invoice list invoice on row "1" 
    User clicked action three dot button on row "1" 
    User choose cndn options "history" at row "1"
    CNDN history be show correctly on header with invoice number "${TV_cndn_num}" and "${TV_buyer_name}" and "${TV_cndn_create_date}"
    CNDN history be show correctly on detail on buyer 

Buyer view manage credit/debit note history on view invoice detail 
    [Tags]    Sanity    Ready    ViewHistory    CNDN
    Given Go to "Manage Credit/Debit Note" list via ${EINVOICE_URL_WEB} and path uri ${BUYER_MANAGE_CNDN_URI}
    User get credit/debit note data for validate from invoice list invoice on row "1" 
    User click on specificed cndn row "1" at column "4"
    Click menu "History" at top right corner
    CNDN history be show correctly on header with invoice number "${TV_cndn_num}" and "${TV_buyer_name}" and "${TV_cndn_create_date}"
    CNDN history be show correctly on detail on buyer 

