*** Keywords ***
Get mapping CN/DN status code via status name
    [Arguments]    ${cndn_status}
    [Documentation]    to get CN/DN status code number to set to database                 
    ${cndn_status_code}=   Run Keyword If    '${cndn_status.upper()}' == 'AWAITING APPROVAL'    Set Variable    1
                            ...   ELSE IF    '${cndn_status.upper()}' == 'PENDING'    Set Variable    2
                            ...   ELSE IF    '${cndn_status.upper()}' == 'COMPLETED'    Set Variable    3
                            ...   ELSE IF    '${cndn_status.upper()}' == 'REJECTED'    Set Variable    4
                            ...   ELSE IF    '${cndn_status.upper()}' == 'EXPIRED'    Set Variable    5
                            ...   ELSE IF    '${cndn_status.upper()}' == 'DOCUMENT RETURN'    Set Variable    6
                            ...   ELSE IF    '${cndn_status.upper()}' == 'CANCELLED'    Set Variable    7
                            ...   ELSE    Set Variable    1
    [Return]    ${cndn_status_code}

Get query string for UPDATE 'CNDN' for set 'DueDate', 'PaymentLocation' where with 'CNDNNum'
    [Arguments]   ${due_date}    ${payment_location}    ${cndn_num}
    ${query_string}    CATENATE    
    ...  UPDATE CNDN
    ...  SET CNDN.DueDate = ${due_date} , CNDN.PaymentLocation = ${payment_location}
    ...  FROM CNDN
    ...  INNER JOIN GroupCNDN
    ...  ON CNDN.GroupID = GroupCNDN.GroupID
    ...  AND CNDNNum = ${cndn_num}
    [Return]    ${query_string}

Get mapping Approval CN/DN status code via status name
    [Arguments]    ${cndn_status}
    [Documentation]    to get Approval CN/DN status code number to set to database                 
    ${cndn_status_code}=   Run Keyword If    '${cndn_status.upper()}' == 'AWAITING'    Set Variable    1
                            ...   ELSE IF    '${cndn_status.upper()}' == 'PENDING'    Set Variable    2
                            ...   ELSE IF    '${cndn_status.upper()}' == 'APPROVED'    Set Variable    3
                            ...   ELSE IF    '${cndn_status.upper()}' == 'REJECTED'    Set Variable    4
                            ...   ELSE IF    '${cndn_status.upper()}' == 'SUSPEND'    Set Variable    5
                            ...   ELSE IF    '${cndn_status.upper()}' == 'PROCESSING'    Set Variable    6
                            ...   ELSE    Set Variable    1
    [Return]    ${cndn_status_code}

Get mapping action of CN/DN status code via status name
    [Arguments]    ${action_button}
    [Documentation]    to get Approval CN/DN status code number to set to database                 
    ${cndn_action_field}=   Run Keyword If    '${action_button.upper()}' == 'CANCEL CN/DN'    Set Variable    CancelInvoice
                            ...   ELSE IF    '${action_button.upper()}' == 'RETURN DOCUMENT'    Set Variable    DocReturned
                            ...   ELSE IF    '${action_button.upper()}' == 'PRINT BILLING'    Set Variable   PrintBilling
                            ...   ELSE IF    '${action_button.upper()}' == 'PRINT COVER'    Set Variable    PrintCover
                            ...   ELSE IF    '${action_button.upper()}' == 'HISTORY'    Set Variable    History
                            ...   ELSE IF    '${action_button.upper()}' == 'EDIT'    Set Variable    Edit
    [Return]    ${cndn_action_field}

Get mapping CN/DN approval type code via type name
    [Arguments]    ${cndn_type}
    [Documentation]    to get Approval CN/DN type code number to set to database                 
    ${cndn_type_code}=   Run Keyword If    '${cndn_type.upper()}' == 'VERIFY DOCUMENT'    Set Variable    1
                            ...   ELSE IF    '${cndn_type.upper()}' == 'ACCOUNT PAYABLE'    Set Variable    2
                            ...   ELSE IF    '${cndn_type.upper()}' == 'ACCOUNT PAYABLE (SPENDING)'    Set Variable    3
                            ...   ELSE    Set Variable    1
    [Return]    ${cndn_type_code}

Get CN/DN status from 'CN/DN' table in DB
    [Arguments]     ${cndn_num}
    ${sql_cndn}=    CATENATE   SELECT TOP 1 CS.CNDNStatus FROM CNDN C JOIN CNDNStatus CS ON CS.StatusID = C.StatusID and CS.TypeID = 5 WHERE C.CNDNNum = ${cndn_num}
    ${return}=  eInvoice Execute SELECT query string    ${sql_cndn}
    [Return]    ${return[0][0]}

Get query string for UPDATE 'GroupCNDN' for set 'NoteToBuyer' where with 'CNDNNum'
    [Arguments]   ${note_to_buyer}    ${cndn_num}
    ${query_string}    CATENATE    
    ...  UPDATE GroupCNDN
    ...  SET GroupCNDN.NoteToBuyer = ${note_to_buyer}
    ...  FROM CNDN
    ...  INNER JOIN GroupCNDN
    ...  ON CNDN.GroupID = GroupCNDN.GroupID
    ...  AND CNDNNum = ${cndn_num}
    [Return]    ${query_string}

Get query string for UPDATE 'CNDN' for set 'statusID' where with 'CNDNNum'
    [Arguments]   ${status_code}    ${cndn_num}
    ${query_string}    CATENATE    
    ...  UPDATE CNDN
    ...  SET statusID = ${status_code}
    ...  WHERE CNDNNum = ${cndn_num}    
    [Return]    ${query_string}

Get query string for UPDATE 'CNDNApproval' for set 'ApprovalStatusID' where with 'CNDNID','CNDNType'
    [Arguments]   ${cndnid}     ${status_code}      ${cndn_type_code}
    ${query_string}    CATENATE    
    ...  UPDATE CNDNApproval
    ...  SET ApprovalStatusID = ${status_code}
    ...  WHERE CNDNID = ${cndnid} and ApprovalTypeID = ${cndn_type_code}
    [Return]    ${query_string}

Get query string for SELECT 'CNDNItemDetail' where with 'CNDNNum'
    [Arguments]    ${cndn_num}
    ${query_string}    CATENATE  
    ...  SELECT CNDNItemDetail.GRLineNum, replace(CID.ItemDesc,SPACE(2),' ') ItemDesc, CNDNItemDetail.Unit, FORMAT(CNDNItemDetail.InvoiceAmount, 'N2') , FORMAT(CNDNItemDetail.CNDNAmount, 'N2')
    ...  FROM CNDN 
    ...  INNER JOIN CNDNItemDetail
    ...  ON CNDNItemDetail.CNDNID = CNDN.CNDNID
    ...  WHERE CNDN.CNDNNum = ${cndn_num}
    ...  ORDER BY CNDNItemDetail.GRNum ASC, CNDNItemDetail.PONum ASC, CNDNItemDetail.GRLineNum ASC
    [Return]    ${query_string}

Get query string for SELECT 'CNDNItemDetail' where with 'CNDNNum' for 'MANAGE CNDN'
    [Arguments]    ${cndn_num}    
    ${query_string}    CATENATE  
    ...     select TOP 1 CS.CNDNStatus , C.CNDNNum , CG.BuyerName , CG.SupplierName , CONVERT(VARCHAR(10),DATEADD(Hour,+7,C.CreatedDate),103) as Created_date ,CG.GroupNum as Reference_no
    ...     , CONVERT(VARCHAR(10),DATEADD(Hour,+7,C.DueDate),103) as Duedate , C.PaymentLocation , FORMAT(ROUND(C.IncludeVat,2),'N2')  as CNDNtotal , C.Currency
    ...     , CG.NoteToBuyer as notefromsupplier , CONVERT(VARCHAR(10),CNDNDate,103) CNDNDate , CASE WHEN ISNULL(C.TaxInvoiceNum,'') = '' THEN '-' ELSE C.TaxInvoiceNum END AS TaxInvoiceNum , ISNULL(CONVERT(VARCHAR(10), C.TaxInvoiceDate, 103),'-') TaxInvoiceDate
    ...     , FORMAT(ROUND(C.ExcludeVat,2),'N2') ExcludeVat , FORMAT(Round(C.Vat,2),'N2') Vat , FORMAT(ROUND(C.VatBaseAmount,2),'N2') as VatBaseAmount , FORMAT(ROUND(C.IncludeVat,2),'N2') IncludeVat
    ...     , LTRIM(STR(CI.Linenum)) as Linenum, CI.InvoiceNum , FORMAT(ROUND(CI.InvoiceAmount,2),'N2') InvoiceAmount , FORMAT(ROUND(CI.CNDNAmount,2),'N2') CNDNAmount, 'Credit / Debit Note Number: ' + C.CNDNNum as CNDNNumwithtitle
    ...     FROM CNDN C
    ...     JOIN GroupCNDN CG on CG.GroupID = C.GroupID
    ...     JOIN CNDNItem CI on CI.CNDNID = C.CNDNID
    ...     JOIN CNDNStatus CS on CS.StatusID = C.StatusID AND CS.BuyerMPID = CG.BuyerMPID AND CS.TYPEID = 6
    ...     WHERE C.CNDNNum = '${cndn_num}'
    ...     ORDER BY CI.Linenum asc
    [Return]    ${query_string}     

Get query string for SELECT 'CNDNItemDetail' where with 'CNDNID'
    [Arguments]    ${cndn_id}
    [Documentation]      Query data for verify with expansion that show only 10 invoices
    ${query_string}    CATENATE  
    ...  SELECT Distinct TOP 10 ltrim(rtrim(CNDNItem.InvoiceNum)) InvoiceNum, CNDNItemDetail.PONum, ltrim(rtrim(CNDNItemDetail.GRNum)) GRNum, CNDNItem.CNDNItemID 
    ...  FROM CNDN 
    ...  INNER JOIN CNDNItem
    ...  ON CNDNItem.CNDNID = CNDN.CNDNID 
    ...  INNER JOIN CNDNItemDetail
    ...  ON CNDNItemDetail.CNDNITEMID = CNDNItem.CNDNITEMID  
    ...  WHERE CNDNItem.CNDNID = ${cndn_id}
    ...  ORDER BY CNDNItem.CNDNItemID,PONum ASC,GRNum ASC
    [Return]    ${query_string}    

Get query string for SELECT 'CNDNItemDetail' where with 'CNDNID' for PO Detail
    [Arguments]    ${cndn_id} 
    ${query_string}    CATENATE 
    ...  SELECT CNDNItemDetail.GRLineNum,ltrim(rtrim(replace(CNDNItemDetail.ItemDesc,SPACE(2),' '))) ItemDesc,CNDNItemDetail.PONum, CNDNItemDetail.GRNum,CNDN_10.CNDNItemID FROM
    ...  (
    ...  SELECT * FROM 
    ...  ( SELECT Distinct TOP 10 CNDNItem.InvoiceNum, CNDNItemDetail.PONum, CNDNItemDetail.GRNum, CNDNItem.CNDNItemID
    ...  FROM CNDN INNER JOIN CNDNItem ON CNDNItem.CNDNID = CNDN.CNDNID 
    ...  INNER JOIN CNDNItemDetail ON CNDNItemDetail.CNDNITEMID = CNDNItem.CNDNITEMID
    ...  WHERE CNDNItem.CNDNID = ${cndn_id} ORDER BY CNDNItem.CNDNItemID) CN  
    ...  ) CNDN_10 JOIN CNDNItemDetail
    ...  ON CNDN_10.CNDNItemID = CNDNItemDetail.CNDNITEMID  
    ...  AND CNDN_10.GRNum = CNDNItemDetail.GRNum
    ...  AND CNDN_10.PONum = CNDNItemDetail.PONUM 
    ...  ORDER BY CNDN_10.CNDNItemID ASC,CNDNItemDetail.PONum ASC,CNDNItemDetail.GRNum ASC,CNDNItemDetail.GRLineNum ASC    
    [Return]    ${query_string}  

Set value to field 'Due Date​', 'Payment Location' and 'Note to Buyer​' in DB
    [Arguments]    ${due_date}    ${payment_location}    ${note_to_buyer}    ${cndn_num}
    ${sql_cndn}=  Get query string for UPDATE 'CNDN' for set 'DueDate', 'PaymentLocation' where with 'CNDNNum'      ${due_date}    ${payment_location}    ${cndn_num}
    ${sql_group_cndn}=  Get query string for UPDATE 'GroupCNDN' for set 'NoteToBuyer' where with 'CNDNNum'    ${note_to_buyer}    ${cndn_num}    
    ${return_status_1}=  eInvoice Execute INSERT, UPDATE, DELETE query string    ${sql_cndn}    
    ${return_status_2}=  eInvoice Execute INSERT, UPDATE, DELETE query string    ${sql_group_cndn}   

Update value to field 'CN/DN status' in DB
    [Arguments]    ${cndn_status}    ${cndn_num}
    ${cndn_status_code}=    Get mapping CN/DN status code via status name    ${cndn_status}
    ${sql_cndn_status}=    Get query string for UPDATE 'CNDN' for set 'statusID' where with 'CNDNNum'    ${cndn_status_code}    ${cndn_num}
    ${return_status_1}=  eInvoice Execute INSERT, UPDATE, DELETE query string    ${sql_cndn_status}  

Update value to field 'CN/DN approval status' in DB
    [Arguments]    ${cndn_approval_status}    ${cndn_num}   ${cndn_type}
    ${cndn_approval_status_code}=    Get mapping Approval CN/DN status code via status name    ${cndn_approval_status}
    ${cndn_type_code}=      Get mapping CN/DN approval type code via type name  ${cndn_type}
    ${cndn_id}=     Query CNDNID from 'CNDN' in DB  ${cndn_num}
    ${sql_cndn_status}=    Get query string for UPDATE 'CNDNApproval' for set 'ApprovalStatusID' where with 'CNDNID','CNDNType'     ${cndn_id}    ${cndn_approval_status_code}         ${cndn_type_code}
    ${return_status_1}=  eInvoice Execute INSERT, UPDATE, DELETE query string    ${sql_cndn_status}  

Update 'UserID_Temp' to field 'UserID' table 'GroupUser' with where 'UserID' in DB
    [Arguments]     ${ep_user}  ${site_mpid} 
    ${sql_update_groupuser}=         CATENATE    UPDATE GROUPUSER SET UserID = '${ep_user}_Temp' WHERE BuyerMpID = ${site_mpid} and UserID = '${ep_user}'
    ${return_status_1}=  eInvoice Execute INSERT, UPDATE, DELETE query string    ${sql_update_groupuser} 

Update 'UserID' to field 'UserID' table 'GroupUser' with where 'UserID_Temp' in DB
    [Arguments]     ${ep_user}  ${site_mpid}   
    ${sql_update_groupuser}=         CATENATE    UPDATE GROUPUSER SET UserID = '${ep_user}' WHERE BuyerMpID = ${site_mpid} and UserID = '${ep_user}_Temp'
    ${return_status_1}=  eInvoice Execute INSERT, UPDATE, DELETE query string    ${sql_update_groupuser} 

Query value 'CNDNItemDetail' in DB
    [Arguments]    ${cndn_num} 
    ${sql_cndn_item_detail}=    Get query string for SELECT 'CNDNItemDetail' where with 'CNDNNum'    ${cndn_num}
    ${return_gr_items}=  eInvoice Execute SELECT query string    ${sql_cndn_item_detail}
    [Return]    ${return_gr_items}

Query CNDNID from 'CNDN' in DB  
    [Arguments]     ${cndn_num}
    ${sql_cndn}=    CATENATE   SELECT TOP 1 CNDNID FROM CNDN WHERE CNDNNum = ${cndn_num} ORDER BY CREATEDDATE DESC
    ${return_cndnid}=  eInvoice Execute SELECT query string    ${sql_cndn}
    [Return]    ${return_cndnid[0][0]}

Query value 'GroupUser' in DB
    [Arguments]    ${ep_username}   ${site_mpid}  
    ${sql_group_user_list}  CATENATE    SELECT GroupUser FROM GROUPUSER WHERE USERID = ${ep_username} AND BuyerMpID = ${site_mpid}
    ${return_group_user_list}=  eInvoice Execute SELECT query string    ${sql_group_user_list}   
    [Return]    ${return_group_user_list}

Query value 'ConditionUser' in DB  
    [Arguments]    ${group_user_list}   ${site_mpid}  
    ${sql_condition_group_list}     CATENATE    SELECT DISTINCT ConditionGroupValue FROM CONDITIONUSER WHERE GroupUser in (${group_user_list}) AND BuyerMpID = ${site_mpid} order by ConditionGroupValue asc
    ${return_condition_group}=  eInvoice Execute SELECT query string    ${sql_condition_group_list}   
    [Return]    ${return_condition_group}

Query value 'ConditionUser' in DB for user who does not have group     
    [Arguments]     ${site_mpid}  
    ${sql_condition_group_list}     CATENATE    SELECT DISTINCT ConditionGroupValue FROM CONDITIONUSER WHERE BuyerMpID = ${site_mpid} order by ConditionGroupValue asc
    ${return_condition_group}=  eInvoice Execute SELECT query string    ${sql_condition_group_list}    
    [Return]    ${return_condition_group}

Get query string for SELECT Count 'CNDNApproval' where with 'Approver' , 'ApproverGroup' and ApprovalType is 'Verify Document'  
    [Arguments]    ${approver}  ${groupuser}
    ${query_string}    CATENATE  
    ...     SELECT Count(1) as total
    ...     FROM CNDNApproval CA 
    ...     WHERE ((CA.ApproverGroup = '${groupuser}') or (CA.Approver = '${approver}' and CA.ApproverGroup is null) or (CA.Approver = '${approver}' and CA.ApproverGroup ='${groupuser}'))
    [Return]    ${query_string}    

Get query string for SELECT Count 'CNDNApproval' where with 'Approver' , 'ApproverGroup' , 'ConditionGroup' and ApprovalType is 'Verify Document' 
    [Arguments]     ${approver}     ${groupuser}    ${filter_condition}
    ${query_string}    CATENATE  
    ...     SELECT Count(1) as total
    ...     FROM CNDNApproval CA 
    ...     WHERE ((CA.ApproverGroup = '${groupuser}') or (CA.Approver = '${approver}' and CA.ApproverGroup is null) or (CA.Approver = '${approver}' and CA.ApproverGroup ='${groupuser}'))
    ...     and CA.ConditionGroup = '${filter_condition}'
    [Return]    ${query_string}     

Query value 'CNDNItemDetail' in DB with 'CNDNNo' , 'InvoiceNo' for PONUM GRNUM
    [Arguments]     ${cndn_num}  ${invoice_num}
    ${sql_po}=    Get query string for SELECT 'CNDNItemDetail' where with 'CNDNNum','InvoiceNum' for PO    ${cndn_num}  ${invoice_num}
    ${return_po_items}=  eInvoice Execute SELECT query string    ${sql_po}
    [Return]    ${return_po_items}

Query value 'CNDNItemDetail' in DB with 'CNDNNo' , 'InvoiceNo' for GR Detail
    [Arguments]     ${cndn_num}  ${invoice_num}
    ${sql_gr_detail}=    Get query string for SELECT 'CNDNItemDetail' where with 'CNDNNum','InvoiceNum' for GR Detail    ${cndn_num}  ${invoice_num}
    ${return_gr_items}=  eInvoice Execute SELECT query string    ${sql_gr_detail}
    [Return]    ${return_gr_items}

Get query string for SELECT 'CNDNItemDetail' where with 'CNDNNum','InvoiceNum' for PO
    [Arguments]     ${cndn_num}  ${invoice_num} 
    ${query_string}    CATENATE  
    ...     SELECT DISTINCT CID.PONum , CID.GRNum 
    ...     FROM CNDN C 
    ...     JOIN CNDNItem CI on CI.CNDNID = C.CNDNID
    ...     JOIN CNDNItemDetail CID on CID.CNDNItemID = CI.CNDNItemID 
    ...     WHERE C.CNDNNum = ${cndn_num} AND CI.InvoiceNum = ${invoice_num}
    ...     ORDER BY PONum ASC,CID.GRNum ASC
    [Return]    ${query_string}    

Get query string for SELECT 'CNDNItemDetail' where with 'CNDNNum','InvoiceNum' for GR Detail
    [Arguments]     ${cndn_num}  ${invoice_num}
    ${query_string}    CATENATE  
    ...     SELECT CID.PONum , CID.GRNum , CID.GRLineNum , ltrim(rtrim(replace(CID.ItemDesc,SPACE(2),' '))) ItemDesc , CID.Unit , FORMAT(ROUND(CID.InvoiceAmount,2),'N2') InvoiceAmount , FORMAT(ROUND(CID.CNDNAmount,2),'N2') CNDNAmount
    ...     FROM CNDN C 
    ...     JOIN CNDNItem CI on CI.CNDNID = C.CNDNID
    ...     JOIN CNDNItemDetail CID on CID.CNDNItemID = CI.CNDNItemID 
    ...     WHERE C.CNDNNum = ${cndn_num} AND CI.InvoiceNum = ${invoice_num} and CID.InvoiceAmount is not null
    ...     ORDER BY PONum ASC,CID.GRNum ASC,CID.GRLineNum ASC
    [Return]    ${query_string}   

Get query string for SELECT 'CNDNItemDetail' where with 'CNDNNum' , 'CNDNType'    
    [Arguments]     ${cndn_num}   ${cndn_type}    
        ${query_string}    CATENATE  
    ...     SELECT CS.ApprovalStatus , C.CNDNNum , CG.BuyerName , CG.SupplierName , CONVERT(VARCHAR(10),DATEADD(Hour,+7,CA.CreatedDate),103) as Received_date ,CG.GroupNum as Reference_no 
    ...     , CONVERT(VARCHAR(10),DATEADD(Hour,+7,C.DueDate),103) as Duedate , C.PaymentLocation , FORMAT(ROUND(C.IncludeVat,2),'N2')  as CNDNtotal , C.Currency
    ...     , CG.NoteToBuyer as notefromsupplier , CONVERT(VARCHAR(10),CNDNDate,103) CNDNDate , CASE WHEN ISNULL(C.TaxInvoiceNum,'') = '' THEN '-' ELSE C.TaxInvoiceNum END AS TaxInvoiceNum , ISNULL(CONVERT(VARCHAR(10), C.TaxInvoiceDate, 103),'-') TaxInvoiceDate
    ...     , FORMAT(ROUND(C.ExcludeVat,2),'N2') ExcludeVat , FORMAT(Round(C.Vat,2),'N2') Vat , FORMAT(ROUND(C.VatBaseAmount,2),'N2') as VatBaseAmount , FORMAT(ROUND(C.IncludeVat,2),'N2') IncludeVat
    ...     , LTRIM(STR(CI.Linenum)) as Linenum, CI.InvoiceNum , FORMAT(ROUND(CI.InvoiceAmount,2),'N2') InvoiceAmount , FORMAT(ROUND(CI.CNDNAmount,2),'N2') CNDNAmount, 'Credit / Debit Note Number: ' + C.CNDNNum as CNDNNumwithtitle
    ...     FROM CNDNApproval CA 
    ...     JOIN CNDN C on CA.CNDNID = C.CNDNID 
    ...     JOIN GroupCNDN CG on CG.GroupID = C.GroupID
    ...     JOIN CNDNApprovalStatus CS on CS.StatusID = CA.ApprovalStatusID AND CS.BuyerMPID = CG.BuyerMPID
    ...     JOIN ApprovalType AT on AT.ApprovalTypeID = CA.ApprovalTypeID
    ...     JOIN CNDNItem CI on CI.CNDNID = C.CNDNID
    ...     WHERE AT.Description = '${cndn_type}' and C.CNDNNum = '${cndn_num}'
    ...     ORDER BY CI.Linenum asc
    [Return]    ${query_string}   

Query value 'CNDNItemDetail' in DB for buyer
   [Arguments]    ${cndn_num}   ${cndn_type} 
    ${sql_cndn_item_detail}=    Get query string for SELECT 'CNDNItemDetail' where with 'CNDNNum' , 'CNDNType'    ${cndn_num}   ${cndn_type}
    ${return_cndn_detail}=  eInvoice Execute SELECT query string    ${sql_cndn_item_detail}
    ${rowCount}     Get Length   ${return_cndn_detail}
    @{CNDNItemHeader}    Create List
    ${dictionary_header}=    Create Dictionary    ApprovalStatus=${return_cndn_detail[0][0]}    CNDNNumwithtitle=${return_cndn_detail[0][22]}   BuyerName=${return_cndn_detail[0][2]}    SupplierName=${return_cndn_detail[0][3]}     Received_date=${return_cndn_detail[0][4]}   Reference_no=${return_cndn_detail[0][5]}     Duedate=${return_cndn_detail[0][6]}     PaymentLocation=${return_cndn_detail[0][7]}      CNDNtotal=${return_cndn_detail[0][8]}     Currency=${return_cndn_detail[0][9]}        
    Append To List    ${CNDNItemHeader}    ${dictionary_header}
    @{CNDNItemDetail}   Create List
    ${dictionary_detail}=    Create Dictionary    Notefromsupplier=${return_cndn_detail[0][10]}    CNDNNum=${return_cndn_detail[0][1]}    CNDNDate=${return_cndn_detail[0][11]}   TaxInvoiceNum=${return_cndn_detail[0][12]}    TaxInvoiceDate=${return_cndn_detail[0][13]}      ExcludeVat=${return_cndn_detail[0][14]}     Vat=${return_cndn_detail[0][15]}     VatBaseAmount=${return_cndn_detail[0][16]}      IncludeVat=${return_cndn_detail[0][17]}      
    Append To List    ${CNDNItemDetail}    ${dictionary_detail}
    @{CNDNItemInvoice}    Create List
    :FOR    ${i}    IN RANGE    0    ${rowCount}
    \   ${dictionary_inv}=    Create Dictionary    Linenum=${return_cndn_detail[${i}][18]}    InvoiceNum=${return_cndn_detail[${i}][19]}   InvoiceAmount=${return_cndn_detail[${i}][20]}    CNDNAmount=${return_cndn_detail[${i}][21]}
    \   Append To List    ${CNDNItemInvoice}    ${dictionary_inv}
    set test variable   ${CNDNItemHeader}
    set test variable   ${CNDNItemDetail}
    set test variable   ${CNDNItemInvoice}

Query value 'CNDNItemDetail' in DB for buyer manage cndn
   [Arguments]    ${cndn_num}
    ${sql_cndn_item_detail}=    Get query string for SELECT 'CNDNItemDetail' where with 'CNDNNum' for 'MANAGE CNDN'  ${cndn_num}
    ${return_cndn_detail}=  eInvoice Execute SELECT query string    ${sql_cndn_item_detail}
    ${rowCount}     Get Length   ${return_cndn_detail}
    @{CNDNItemHeader}    Create List
    ${dictionary_header}=    Create Dictionary    Status=${return_cndn_detail[0][0]}    CNDNNumwithtitle=${return_cndn_detail[0][22]}   BuyerName=${return_cndn_detail[0][2]}    SupplierName=${return_cndn_detail[0][3]}     Created_date=${return_cndn_detail[0][4]}   Reference_no=${return_cndn_detail[0][5]}     Duedate=${return_cndn_detail[0][6]}     PaymentLocation=${return_cndn_detail[0][7]}      CNDNtotal=${return_cndn_detail[0][8]}     Currency=${return_cndn_detail[0][9]}        
    Append To List    ${CNDNItemHeader}    ${dictionary_header}
    @{CNDNItemDetail}   Create List
    ${dictionary_detail}=    Create Dictionary    Notefromsupplier=${return_cndn_detail[0][10]}    CNDNNum=${return_cndn_detail[0][1]}    CNDNDate=${return_cndn_detail[0][11]}   TaxInvoiceNum=${return_cndn_detail[0][12]}    TaxInvoiceDate=${return_cndn_detail[0][13]}      ExcludeVat=${return_cndn_detail[0][14]}     Vat=${return_cndn_detail[0][15]}     VatBaseAmount=${return_cndn_detail[0][16]}      IncludeVat=${return_cndn_detail[0][17]}      
    Append To List    ${CNDNItemDetail}    ${dictionary_detail}
    @{CNDNItemInvoice}    Create List
    :FOR    ${i}    IN RANGE    0    ${rowCount}
    \   ${dictionary_inv}=    Create Dictionary    Linenum=${return_cndn_detail[${i}][18]}    InvoiceNum=${return_cndn_detail[${i}][19]}   InvoiceAmount=${return_cndn_detail[${i}][20]}    CNDNAmount=${return_cndn_detail[${i}][21]}
    \   Append To List    ${CNDNItemInvoice}    ${dictionary_inv}
    set test variable   ${CNDNItemHeader}
    set test variable   ${CNDNItemDetail}
    set test variable   ${CNDNItemInvoice}    

Get query string for SELECT 'CNDNApproval' where with 'Approver' , 'ApproverGroup' , TaxInvoice is not null and ApprovalType is 'Verify Document'  
    [Arguments]    ${approver}  ${groupuser}
    ${query_string}    CATENATE  
    ...     SELECT top 20 C.CNDNNum , isnull('('+C.InvoiceNumBuyer+')','') as CNDNGen , ltrim(rtrim(CG.BuyerName)) , ltrim(rtrim(CG.SupplierName)) , CONVERT(VARCHAR(10),DATEADD(Hour,+7,CA.CreatedDate),103) as Received_date
    ...     , C.ConditionGroup , AT.Description , C.NoteType , FORMAT(ROUND(C.IncludeVat,2),'N2')+' '+C.Currency IncludeVat , CS.ApprovalStatus , CA.approveBeginDate
    ...     FROM CNDNApproval CA 
    ...     JOIN CNDN C on CA.CNDNID = C.CNDNID 
    ...     JOIN GroupCNDN CG on CG.GroupID = C.GroupID
    ...     JOIN CNDNApprovalStatus CS on CS.StatusID = CA.ApprovalStatusID AND CS.BuyerMPID = CG.BuyerMPID
    ...     JOIN ApprovalType AT on AT.ApprovalTypeID = CA.ApprovalTypeID
    ...     WHERE ((CA.ApproverGroup = '${groupuser}') or (CA.Approver = '${approver}'))
    ...     AND (TaxInvoiceNum is not null and ltrim(rtrim(TaxInvoiceNum)) <> '')
    ...     ORDER BY CA.approveBeginDate DESC
    [Return]    ${query_string}     

Get query string for SELECT 'CNDNApproval' where with 'Approver' , 'ApproverGroup' , TaxInvoice is null and ApprovalType is 'Verify Document'
    [Arguments]    ${approver}  ${groupuser}
    ${query_string}    CATENATE  
    ...     SELECT top 20 C.CNDNNum , isnull('('+C.InvoiceNumBuyer+')','') as CNDNGen , ltrim(rtrim(CG.BuyerName)), ltrim(rtrim(CG.SupplierName)) 
    ...     , CONVERT(VARCHAR(10),DATEADD(Hour,+7,CA.CreatedDate),103) as Received_date
    ...     , C.ConditionGroup , AT.Description , C.NoteType , FORMAT(ROUND(C.IncludeVat,2),'N2')+' '+C.Currency IncludeVat , CS.ApprovalStatus , CA.approveBeginDate
    ...     FROM CNDNApproval CA 
    ...     JOIN CNDN C on CA.CNDNID = C.CNDNID 
    ...     JOIN GroupCNDN CG on CG.GroupID = C.GroupID
    ...     JOIN CNDNApprovalStatus CS on CS.StatusID = CA.ApprovalStatusID AND CS.BuyerMPID = CG.BuyerMPID
    ...     JOIN ApprovalType AT on AT.ApprovalTypeID = CA.ApprovalTypeID
    ...     WHERE ((CA.ApproverGroup = '${groupuser}') or (CA.Approver = '${approver}'))
    ...     AND (TaxInvoiceNum is null or ltrim(rtrim(TaxInvoiceNum)) = '')
    ...     ORDER BY CA.approveBeginDate DESC
    [Return]    ${query_string}  

Get query string for SELECT 'CNDNApproval' where with 'Approver' , 'ApproverGroup' , 'Approval status' and ApprovalType is 'Verify Document'
    [Arguments]    ${approver}  ${groupuser}    ${approval_status}
    ${query_string}    CATENATE  
    ...     SELECT top 20 C.CNDNNum , isnull('('+C.InvoiceNumBuyer+')','') as CNDNGen , ltrim(rtrim(CG.BuyerName)) , ltrim(rtrim(CG.SupplierName)) 
    ...     , CONVERT(VARCHAR(10),DATEADD(Hour,+7,CA.CreatedDate),103) as Received_date
    ...     , C.ConditionGroup , AT.Description , C.NoteType , FORMAT(ROUND(C.IncludeVat,2),'N2')+' '+C.Currency IncludeVat , CS.ApprovalStatus , CA.approveBeginDate
    ...     FROM CNDNApproval CA 
    ...     JOIN CNDN C on CA.CNDNID = C.CNDNID 
    ...     JOIN GroupCNDN CG on CG.GroupID = C.GroupID
    ...     JOIN CNDNApprovalStatus CS on CS.StatusID = CA.ApprovalStatusID AND CS.BuyerMPID = CG.BuyerMPID
    ...     JOIN ApprovalType AT on AT.ApprovalTypeID = CA.ApprovalTypeID
    ...     WHERE ((CA.ApproverGroup = '${groupuser}') or (CA.Approver = '${approver}'))
    ...     AND CS.ApprovalStatus = '${approval_status}'
    ...     ORDER BY CA.approveBeginDate Desc
    [Return]    ${query_string}  

Get query string for SELECT 'CNDN' where with 'Condition' and 'Status'
    [Arguments]     ${condition_list}   ${status}
    ${query_string}    CATENATE  
    ...     SELECT top 20 C.CNDNNum , isnull('('+C.InvoiceNumBuyer+')','') as CNDNGen , ltrim(rtrim(CG.BuyerName)) , ltrim(rtrim(CG.SupplierName)) 
    ...     , CONVERT(VARCHAR(10),DATEADD(Hour,+7,C.CreatedDate),103) as Created_date
    ...     , C.ConditionGroup , C.NoteType , FORMAT(ROUND(C.IncludeVat,2),'N2')+' '+C.Currency IncludeVat , CS.CNDNStatus ,C.CNDNID
    ...     FROM CNDN C
    ...     JOIN GroupCNDN CG on CG.GroupID = C.GroupID
    ...     JOIN CNDNStatus CS on CS.StatusID = C.StatusID AND CS.BuyerMPID = CG.BuyerMPID AND CS.TYPEID = 6
    ...     WHERE C.ConditionGroup in (${condition_list},'ConditionGroup') and CS.CNDNStatus = '${status}'
    ...     ORDER BY CG.CreatedDate DESC,C.CNDNID DESC
    [Return]    ${query_string}    

Get query string for SELECT 'CNDN' where with 'Condition' and TaxInvoice is not null
    [Arguments]     ${condition_list}
    ${query_string}    CATENATE  
    ...     SELECT top 20 C.CNDNNum , isnull('('+C.InvoiceNumBuyer+')','') as CNDNGen , ltrim(rtrim(CG.BuyerName)) , ltrim(rtrim(CG.SupplierName)) 
    ...     , CONVERT(VARCHAR(10),DATEADD(Hour,+7,C.CreatedDate),103) as Created_date
    ...     , C.ConditionGroup , C.NoteType , FORMAT(ROUND(C.IncludeVat,2),'N2')+' '+C.Currency IncludeVat , CS.CNDNStatus ,C.CNDNID
    ...     FROM CNDN C
    ...     JOIN GroupCNDN CG on CG.GroupID = C.GroupID
    ...     JOIN CNDNStatus CS on CS.StatusID = C.StatusID AND CS.BuyerMPID = CG.BuyerMPID AND CS.TYPEID = 6
    ...     WHERE C.ConditionGroup in (${condition_list},'ConditionGroup') 
    ...     AND (TaxInvoiceNum is not null and ltrim(rtrim(TaxInvoiceNum)) <> '')
    ...     ORDER BY CG.CreatedDate DESC,C.CNDNID DESC
    [Return]    ${query_string}  

Get query string for SELECT 'CNDN' where with 'Condition' and TaxInvoice is null
    [Arguments]     ${condition_list}
    ${query_string}    CATENATE  
    ...     SELECT top 20 C.CNDNNum , isnull('('+C.InvoiceNumBuyer+')','') as CNDNGen , ltrim(rtrim(CG.BuyerName)) , ltrim(rtrim(CG.SupplierName)) 
    ...     , CONVERT(VARCHAR(10),DATEADD(Hour,+7,C.CreatedDate),103) as Created_date
    ...     , C.ConditionGroup , C.NoteType , FORMAT(ROUND(C.IncludeVat,2),'N2')+' '+C.Currency IncludeVat , CS.CNDNStatus ,C.CNDNID
    ...     FROM CNDN C
    ...     JOIN GroupCNDN CG on CG.GroupID = C.GroupID
    ...     JOIN CNDNStatus CS on CS.StatusID = C.StatusID AND CS.BuyerMPID = CG.BuyerMPID AND CS.TYPEID = 6
    ...     WHERE C.ConditionGroup in (${condition_list},'ConditionGroup')
    ...     AND 
    ...     (TaxInvoiceNum is null or ltrim(rtrim(TaxInvoiceNum)) = '')   
    ...     ORDER BY CG.CreatedDate DESC ,C.CNDNID DESC
    [Return]    ${query_string}         

Get query string for UPDATE 'CNDN' for set 'InvoiceType' where with 'CNDNNum'    
    [Arguments]     ${CNDNNumber}    ${InvType}    
     ${query_string}    CATENATE    
    ...  UPDATE CNDN
    ...  SET CNDN.InvoiceType = ${InvType}
    ...  WHERE CNDNNum = '${CNDNNumber}'
    [Return]    ${query_string}          

Get query string for SELECT 'CNDN' where with 'CNDNNumber'
    [Arguments]     ${cndn_num}
    ${query_string}     CATENATE   
    ...     SELECT TOP 1 NoteToSupplier,FORMAT(DATEADD(Hour,+7,C.UpdatedDate), 'dd/MM/yyyy HH:mm') as UpdatedDate,Updatedby 
    ...     FROM CNDN C 
    ...     WHERE C.CNDNNum = '${cndn_num}'
    [Return]    ${query_string}         

Get query string for SELECT 'Users' where with 'Username','eid'
    [Arguments]     ${user}     ${eid}
    ${query_string}     CATENATE   
    ...     SELECT firstname 
    ...     FROM Users 
    ...     WHERE username = '${user}' AND eid = ${eid}
    [Return]    ${query_string}

Get query string for DELETE 'CNDNAttachment' where with 'CNDNID' 
    [Arguments]     ${cndn_id}
    ${query_string}     CATENATE   
    ...     DELETE 
    ...     FROM CNDNAttachment 
    ...     WHERE CNDNID = ${cndn_id}
    [Return]    ${query_string}

Delete row 'CN/DN attachment' in DB
    [Arguments]    ${cndn_num}   
    ${cndn_id}=     Query CNDNID from 'CNDN' in DB  ${cndn_num}
    ${sql_cndn_atth}=    Get query string for DELETE 'CNDNAttachment' where with 'CNDNID'     ${cndn_id}
    ${return_status_1}=  eInvoice Execute INSERT, UPDATE, DELETE query string    ${sql_cndn_atth}   

Query value 'CNDN' where 'CNDNNumber' for Request document information
    [Arguments]     ${cndn_num}
    ${query_string}     CATENATE   
    ...     SELECT TOP 1 NoteToSupplier
    ...     FROM CNDN C 
    ...     WHERE C.CNDNNum = '${cndn_num}'
    [Return]    ${query_string}        