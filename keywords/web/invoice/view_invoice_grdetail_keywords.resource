***Settings***
Variables    ../../../resources/locators/invoice/view_invoice_grdetail_locator.yaml    

***Keywords***
########################################################################################################################
# KEYWORD LEVEL 1 : To Support BDD style
# PLEASE DO
#   1. Passing parameter in keyword's name, then pass it to keyword level 2.
#
# PLEASE DO NOT 
#   1. Access any LOCATOR.
#   2. Access any VARIABLE directly.
########################################################################################################################
Select invoice number is "${invoice_number}"
    Input value to "Keyword Search" text field    ${invoice_number} 
    Click "Search" button
    
Go to invoice status via click on invoice number
    Click on the first row of Invoice Number in invoice list  

Click on gr number is "${gr_number}"
    Click on the first row of PO Detail in view invoice page

Verify gr detail in display modal on "${invoice_num}" and "${gr_num}"
    ${web_grdetail}    Get gr detail from gr details modal
    ${db_grdetail}    Get gr detail on selected invoice number and gr number    ${invoice_num}    ${gr_num}
    List should be equal as    ${web_grdetail}    ${db_grdetail}

Modal view gr detail should be show and display correct data "${gr_detail_format}"
    PO Number on gr detail should be
    GR Number on gr number should be
    Gr item should be not empty    

########################################################################################################################
# KEYWORD LEVEL 2 : Micro keyword
# PLEASE DO
#   1. Always keep it do small action.
#   2. Access LOCATOR.
#   3. Passing parameter by using [Arguments] tag
#
# PLEASE DO NOT 
#   1. Access any VARIABLE directly. (Allow only ${TIMEOUT})
########################################################################################################################
PO Number on gr detail should be
    ${modal_ponumber}    Get Text    ${lbl_po_no} 
    Should Be Equal As Strings    ${TV_PONumber_ViewGR}    ${modal_ponumber} 

GR Number on gr number should be
    ${modal_grnumber}    Get Text    ${lbl_gr_no}
    Should Be Equal As Strings    ${TV_GRNumber_ViewGR}    ${modal_grnumber} 

Gr item should be not empty  
    Wait Until Element Is Visible    ${tbl_gr_item.row_all_row}   ${TIMEOUT}
    ${count}    Get Element Count    ${tbl_gr_item.row_all_row}
    Should Be True    ${count}>0  


Set "GR Detail" to list
    Wait Until Element Is Visible    ${obj_view_invoice_grdetail.modal_gr_detail}    ${TIMEOUT}
    @{list}    Create List 
       
    ${count}=    Get gr details items row count
    Return From Keyword If    ${count}=="Not Found GR Data, This case fail!!"
    ${row_count}=    Evaluate    ${count}+1
    FOR    ${index}    IN RANGE    1    ${row_count}
           ${gr_detail}    Create Dictionary 
           ${item_no}    Get "Item No" at select row index    ${index}
           ${item_name}    Get "Item Name" at select row index    ${index}
           ${unit}    Get "Unit Of Measure" at select row index    ${index}
           ${gr_amount}    Get "GR Amount" at select row index    ${index}
           ${invoice_amt}    Get "Invoice Amount" at select row index    ${index}
           ${retention_amt}    Get "Retention Amount" at select row index    ${index}
           Set To Dictionary    ${gr_detail}    Item_No    ${item_no}
           Set To Dictionary    ${gr_detail}    Item_Name    ${item_name}
           Set To Dictionary    ${gr_detail}    Unit    ${unit}
           Set To Dictionary    ${gr_detail}    GR_Amount    ${gr_amount}
           Set To Dictionary    ${gr_detail}    Invoice_Amount    ${invoice_amt}
           Set To Dictionary    ${gr_detail}    Retention    ${retention_amt}
           Append To List    ${list}    ${gr_detail}   
    END 
    Return From Keyword     ${list}

Get gr detail from gr details modal    
    ${gr_detail}    Set "GR Detail" to list
    [Return]    ${gr_detail}

Get gr details items row count
    Wait Until Element Is Visible    ${obj_view_invoice_grdetail.modal_gr_detail}    ${TIMEOUT}    
    ${count}=    Get Element Count   ${obj_view_invoice_grdetail.item_list_row.row_all_items}    
    Run Keyword If    ${count}==0    Return From Keyword    "Not Found GR Data, This case fail!!"
    ...    ELSE    Return From Keyword    ${count}        

Get "Item No" at select row index
    [Documentation]    Get 'Item No.' from GR Item detail on specifice row

    [Arguments]    ${row_index}
    ${row_index}    Convert To String    ${row_index}
    ${row_retention_value}    Set Variable    ${obj_view_invoice_grdetail.item_column.col_item_no}
    ${row_retention_value}    Replace String    ${row_retention_Value}    REPLACE_ME    ${row_index}
    Wait Until Element Is Visible    ${row_retention_value}
    ${item_no}    Get Text    ${row_retention_value}        
    [Return]    ${item_no}

Get "Item Name" at select row index
    [Documentation]    Get 'Item Name' from GR Item detail on specifice row

    [Arguments]    ${row_index}
    ${row_index}    Convert To String    ${row_index}
    ${row_item_name_value}    Set Variable    ${obj_view_invoice_grdetail.item_column.col_item_name}
    ${row_item_name_value}    Replace String    ${row_item_name_value}    REPLACE_ME    ${row_index}
    Wait Until Element Is Visible    ${row_item_name_value}
    ${item_name}    Get Text    ${row_item_name_value}    
    [Return]    ${item_name}

Get "Unit Of Measure" at select row index
    [Documentation]    Get 'Unti' from GR Item detail on specifice row

    [Arguments]    ${row_index} 
    ${row_index}    Convert To String    ${row_index}
    ${row_unit_value}    Set Variable    ${obj_view_invoice_grdetail.item_column.col_unit}
    ${row_unit_value}    Replace String    ${row_unit_value}    REPLACE_ME    ${row_index}
    Wait Until Element Is Visible    ${row_unit_value}
    ${item_unit}    Get Text    ${row_unit_value}   
    [Return]    ${item_unit}

Get "GR Amount" at select row index
    [Documentation]    Get 'GR Amount' from GR Item detail on specifice row

    [Arguments]    ${row_index}
    ${row_index}    Convert To String    ${row_index}
    ${row_gr_amount_value}    Set Variable    ${obj_view_invoice_grdetail.item_column.col_gr_amount}
    ${row_gr_amount_value}    Replace String    ${row_gr_amount_value}    REPLACE_ME    ${row_index}
    Wait Until Element Is Visible    ${row_gr_amount_value}
    ${gr_amt}    Get Text    ${row_gr_amount_value}   
    [Return]    ${gr_amt}

Get "Invoice Amount" at select row index
    [Documentation]    Get 'Invoice Amount' from GR Item detail on specifice row

    [Arguments]    ${row_index}
    ${row_index}    Convert To String    ${row_index}
    ${row_invoice_amount_value}    Set Variable    ${obj_view_invoice_grdetail.item_column.col_invoice_amount}
    ${row_invoice_amount_value}    Replace String    ${row_invoice_amount_value}    REPLACE_ME    ${row_index}
    Wait Until Element Is Visible    ${row_invoice_amount_value}
    ${invoice_amt}    Get Text    ${row_invoice_amount_value}
    [Return]    ${invoice_amt}

Get "Retention Amount" at select row index
    [Documentation]    Get 'Retention Amount' from GR Item detail on specifice row

    [Arguments]    ${row_index}
    ${row_index}    Convert To String    ${row_index}
    ${row_retention_amount_value}    Set Variable    ${obj_view_invoice_grdetail.item_column.col_retention}
    ${row_retention_amount_value}    Replace String    ${row_retention_amount_value}    REPLACE_ME    ${row_index}
    Wait Until Element Is Visible    ${row_retention_amount_value}
    ${retention_amt}    Get Text    ${row_retention_amount_value}
    [Return]    ${retention_amt}

Get gr detail on selected invoice number and gr number
    [Documentation]    Get item gr detail of invoice from database with parameter "Invoice_Number" and "GR Number"
                ...    Then set data to dictionary, dictionary key is "Item_No", Item_Name, "Unit",
                ...    "GR_Amount", "Invoice_Amount" and "Retention"

    [Arguments]    ${invoice_num}   ${gr_num}
    ${qry_grdetail}    Get gr detail on specific invoice and gr number   ${invoice_num}    ${gr_num}
    ${return_gr_items}=  eInvoice Execute SELECT query string    ${qry_grdetail}
    ${gr_detail_db}    Get gr detail db from list to dictionary    ${return_gr_items}
    [RETURN]    ${gr_detail_db}

Get gr detail db from list to dictionary
    [Arguments]    ${list}
    ${count}    Get Length    ${list}
    @{gr_detail_db}    Create List
    :FOR    ${index}    IN RANGE    ${count}
            ${gr_row}    Get From List    ${list}    ${index}
            ${detail}    Get gr detail row item    ${gr_row}  
            Append To List    ${gr_detail_db}    ${detail}
    END 
    Log     ${gr_detail_db}      
    Return From Keyword    ${gr_detail_db}

Get gr detail row item    
    [Documentation]    Get gr item detail from list argument following index
                ...    item no., item name, unit, gr amount, invoice amount, retention

    [Arguments]    ${list_grdetail_item}
    ${itm_count}    Get Length    ${list_grdetail_item}
    ${itm_count}=    Evaluate    ${itm_count}-1
    ${item_detail}    Create Dictionary
    ${item_no}    Get "Item No" from gr list at index    ${list_grdetail_item}    0
    ${item_name}    Get "Item Name" from list at index    ${list_grdetail_item}    1
    ${unit}    Get "Unit OF Measure" at index    ${list_grdetail_item}    2
    ${gr_amt}    Get "GR Amount" at index    ${list_grdetail_item}    3
    ${invoice_amt}    Get "Invoice Amount" at index    ${list_grdetail_item}    4    
    ${retention}    Get "Retention" at index    ${list_grdetail_item}    5

    Set To Dictionary    ${item_detail}    Item_No    ${item_no}
    Set To Dictionary    ${item_detail}    Item_Name    ${item_name}
    Set To Dictionary    ${item_detail}    Unit    ${unit}
    Set To Dictionary    ${item_detail}    GR_Amount    ${gr_amt}
    Set To Dictionary    ${item_detail}    Invoice_Amount    ${invoice_amt}
    Set To Dictionary    ${item_detail}    Retention    ${retention} 
    Return From Keyword     ${item_detail}

Get "Item No" from gr list at index
    [Arguments]    ${list_item}    ${index}
    ${item_no}    Get From List    ${list_item}    ${index} 
    [RETURN]    ${item_no}

Get "Item Name" from list at index
    [Arguments]    ${list_item}    ${index} 
    ${item_name}    Get From List    ${list_item}    ${index} 
    [RETURN]    ${item_name}

Get "Unit OF Measure" at index
    [Arguments]    ${list_item}    ${index}
    ${unit}    Get From List    ${list_item}    ${index} 
    [RETURN]    ${unit}

Get "GR Amount" at index
    [Arguments]    ${list_item}    ${index}
    ${gr_amount}    Get From List    ${list_item}    ${index}     
    ${gr_amount}    Convert To String    ${gr_amount}
    [RETURN]    ${gr_amount}

Get "Invoice Amount" at index
    [Arguments]    ${list_item}    ${index}
    ${invoice_amt}    Get From List    ${list_item}    ${index} 
    ${invoice_amt}    Convert To String    ${invoice_amt}
    [RETURN]    ${invoice_amt}

Get "Retention" at index
    [Arguments]    ${list_item}    ${index}
    ${retention}    Get From List    ${list_item}    ${index} 
    ${retention}    Convert To String    ${retention}
    [RETURN]    ${retention}

    

