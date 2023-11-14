#***Settings***
#Variables    ../../../resources/locators/invoice/buyer_approve_invoice_grdetail_locator.yaml

#***Keywords***
########################################################################################################################
# KEYWORD LEVEL 1 : To Support BDD style
# PLEASE DO
#   1. Passing parameter in keyword's name, then pass it to keyword level 2.
#
# PLEASE DO NOT 
#   1. Access any LOCATOR.
#   2. Access any VARIABLE directly.
########################################################################################################################
#Select invoice number is "${invoice_number}"
#    Input value to "Keyword Search" text field    ${invoice_number} 
#    Click "Search" button
#    
#Go to invoice status via click on invoice number
#    Click on the first row of Invoice Number in invoice list  
#
#Click on gr number is "${gr_number}"
#    Click on the first row of PO Detail in view invoice page
#
#Verify gr detail in display modal on "${invoice_num}" and "${gr_num}"
#    ${web_grdetail}    Get gr detail from gr details modal
#    ${db_grdetail}    Get gr detail on selected ${invoice_num} and ${gr_num}
#    List should be equal as    ${web_grdetail}    ${db_grdetail}

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

# Set "GR Detail" to list
#     Wait Until Element Is Visible    //div[@class="modal-inner modal-history"]    ${TIMEOUT}
#     @{list}    Create List 
       
#     ${count}=    Get gr details items row count
#     Return From Keyword If    ${count}=="Not Found GR Data, This case fail!!"
#     ${row_count}=    Evaluate    ${count}+1
#     FOR    ${index}    IN RANGE    1    ${row_count}
#            ${gr_detail}    Create Dictionary 
#            ${item_no}    Get "Item No" at select row index    ${index}
#            ${item_name}    Get "Item Name" at select row index    ${index}
#            ${unit}    Get "Unit Of Measure" at select row index    ${index}
#            ${gr_amount}    Get "GR Amount" at select row index    ${index}
#            ${invoice_amt}    Get "Invoice Amount" at select row index    ${index}
#            ${retention_amt}    Get "Retention Amount" at select row index    ${index}
#            Set To Dictionary    ${gr_detail}    Item_No    ${item_no}
#            Set To Dictionary    ${gr_detail}    Item_Name    ${item_name}
#            Set To Dictionary    ${gr_detail}    Unit    ${unit}
#            Set To Dictionary    ${gr_detail}    GR_Amount    ${gr_amount}
#            Set To Dictionary    ${gr_detail}    Invoice_Amount    ${invoice_amt}
#            Set To Dictionary    ${gr_detail}    Retention    ${retention_amt}
#            Append To List    ${list}    ${gr_detail}   
#     END 
#     log    ${list}
#     Return From Keyword     ${list}

# Get gr detail from gr details modal    
#     ${gr_detail}    Set "GR Detail" to list
#     [Return]    ${gr_detail}

# Get gr details items row count
#     Wait Until Element Is Visible    ${tbl_approve_invoice_grdetail.modal_gr_detail}    ${TIMEOUT}
#     ${count}=    Get Element Count   ${tbl_approve_invoice_grdetail.item_list_row.row_all_items}
#     Run Keyword If    ${count}==0    Return From Keyword    "Not Found GR Data, This case fail!!"
#     ...    ELSE    Return From Keyword    ${count}        

# Get "Item No" at select row index
#     [Arguments]    ${row_index}
#     ###
#     ###

# Get "Item Name" at select row index
#     [Arguments]    ${row_index}
#     ###
#     ###

# Get "Unit Of Measure" at select row index
#     [Arguments]    ${row_index}
#     ###
#     ###

# Get "GR Amount" at select row index
#     [Arguments]    ${row_index}
#     ###
#     ###

# Get "Invoice Amount" at select row index
#     [Arguments]    ${row_index}
#     ###
#     ###

# Get "Retention Amount" at select row index
#     [Arguments]    ${row_index}
#     ###
#     ###

# Get gr detail on selected ${invoice_num} and ${gr_num}
#     ${db_grdetail}    Get gr detail on specific invoice and gr number   ${invoice_num}    ${gr_num} 
#     ${gr_detail_db}    Get gr detail db from list to dictionary    ${db_grdetail}
#     [RETURN]    ${gr_detail_db}

# Get gr detail db from list to dictionary
#     [Arguments]    ${list}
#     ${count}    Get Length    ${list}
#     @{gr_detail_db}    Create List
#     :FOR    ${index}    IN RANGE    ${count}
#             ${gr_row}    Get From List    ${list}    ${index}
#             ${detail}    Get gr detail row item    ${gr_row}  
#             Append To List    ${gr_detail_db}    ${detail}
#     END 
#     Log     ${gr_detail_db}      
#     Return From Keyword    ${gr_detail_db}

# Get gr detail row item    
#     [Arguments]    ${list_grdetail_item}
#     ${itm_count}    Get Length    ${list_grdetail_item}
#     ${itm_count}=    Evaluate    ${itm_count}-1
#     ${item_detail}    Create Dictionary
#     ${item_no}    Get "Item No" from gr list at index    ${list_grdetail_item}    0
#     ${item_name}    Get "Item Name" from list at index    ${list_grdetail_item}    1
#     ${unit}    Get "Unit OF Measure" at index    ${list_grdetail_item}    2
#     ${gr_amt}    Get "GR Amount" at index    ${list_grdetail_item}    3
#     ${invoice_amt}    Get "Invoice Amount" at index    ${list_grdetail_item}    4    
#     ${retention}    Get "Retention" at index    ${list_grdetail_item}    5

#     Set To Dictionary    ${item_detail}    Item_No    ${item_no}
#     Set To Dictionary    ${item_detail}    Item_Name    ${item_name}
#     Set To Dictionary    ${item_detail}    Unit    ${unit}
#     Set To Dictionary    ${item_detail}    GR_Amount    ${gr_amt}
#     Set To Dictionary    ${item_detail}    Invoice_Amount    ${invoice_amt}
#     Set To Dictionary    ${item_detail}    Retention    ${retention} 
#     Return From Keyword     ${item_detail}

# Get "Item No" from gr list at index
#     [Arguments]    ${list_item}    ${index}
#     ${item_no}    Get From List    ${list_item}    ${index} 
#     [RETURN]    ${item_no}

# Get "Item Name" from list at index
#     [Arguments]    ${list_item}    ${index} 
#     ${item_name}    Get From List    ${list_item}    ${index} 
#     [RETURN]    ${item_name}

# Get "Unit OF Measure" at index
#     [Arguments]    ${list_item}    ${index}
#     ${unit}    Get From List    ${list_item}    ${index} 
#     [RETURN]    ${unit}

# Get "GR Amount" at index
#     [Arguments]    ${list_item}    ${index}
#     ${gr_amount}    Get From List    ${list_item}    ${index}     
#     ${gr_amount}    Convert To String    ${gr_amount}
#     [RETURN]    ${gr_amount}

# Get "Invoice Amount" at index
#     [Arguments]    ${list_item}    ${index}
#     ${invoice_amt}    Get From List    ${list_item}    ${index} 
#     ${invoice_amt}    Convert To String    ${invoice_amt}
#     [RETURN]    ${invoice_amt}

# Get "Retention" at index
#     [Arguments]    ${list_item}    ${index}
#     ${retention}    Get From List    ${list_item}    ${index} 
#     ${retention}    Convert To String    ${retention}
#     [RETURN]    ${retention}

    

