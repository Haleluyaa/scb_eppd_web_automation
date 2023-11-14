*** Keywords ***
Get cndnid for approve cndn
    [Arguments]    ${cndn_number}
    [Documentation]    ${buyer_mpid} is test variable, get in step login

    ${query_string}  CATENATE
    ...  SELECT CNDN.CNDNID
    ...  FROM CNDN INNER JOIN GroupCNDN 
    ...      ON CNDN.GroupID = GroupCNDN.GroupID
    ...  WHERE CNDN.CNDNNum = '${cndn_number}' AND GroupCNDN.BuyerMPID = '${buyer_mpid}'  

    [Return]    ${query_string}

Get cndn approval data
    [Arguments]    ${approved_cndn_id}
    [Documentation]    Get approval data via condition equal cndnid

    ${query_string}    CATENATE
    ...  SELECT CNDNApproval.SeqNum AS "SequenceNumber"
    ...    ,  ApprovalType.[Description]  AS "ApprovalType"
    ...    ,  CNDNApproval.ApprovalTemplateSeq "ApprovalTemplateSequence"
    ...    ,  CNDNApprovalStatus.ApprovalStatus AS "ApprovalStatus"
    ...    ,  CNDNApproval.Approver AS "Approver"
    ...    ,  CNDNApproval.ApprovalNote AS "ApprovalNote"
    ...    ,  CNDNApproval.UpdatedBy AS "UpdateBy"
    ...    ,  DateAdd(hour,7,CNDNApproval.UpdatedDate) AS "UpdateDate"
    ...    FROM CNDNApproval
    ...      INNER JOIN CNDNApprovalStatus ON CNDNApprovalStatus.StatusID = CNDNApproval.ApprovalStatusID
    ...      INNER JOIN ApprovalType ON ApprovalType.ApprovalTypeID = CNDNApproval.ApprovalTypeID
    ...    WHERE  CNDNApproval.CNDNID = ${approved_cndn_id}
    ...    Group By SeqNum, ApprovalType.[Description], ApprovalTemplateSeq, CNDNApprovalStatus.ApprovalStatus
    ...           , CNDNApproval.Approver, CNDNApproval.UpdatedBy, CNDNApproval.UpdatedDate, CNDNApproval.ApprovalNote  

    [Return]    ${query_string}

Get row count history log approved cndn    
    [Arguments]    ${approved_cndn_id}    ${buyer_approved_username}

    ${query_string}    CATENATE
    ...    SELECT Count(HistoryID) FROM CNDNHistory
    ...    WHERE Category = 'Approve'
    ...    AND Activity = 'Approved'
    ...    AND CNDNID = ${approved_cndn_id}
    ...    AND ActionBy = '${buyer_approved_username}'

    [Return]    ${query_string}

Get cndn data via cndn id and buyermp id   
    [Arguments]    ${cndn_id}    ${mpid}

    ${query_string}    CATENATE
    ...    SELECT CNDNStatus.CNDNStatus
    ...         , CNDN.UpdatedBy
    ...         , DateAdd(hour,7,CNDN.UpdatedDate)
    ...    FROM CNDN  
    ...    INNER JOIN CNDNStatus ON CNDN.StatusID = CNDNStatus.StatusID
    ...      AND CNDNStatus.TypeID = CNDN.InvoiceType
    ...      AND CNDNStatus.BuyerMpID = '${mpid}'
    ...    WHERE CNDN.CNDNID = ${cndn_id}

    [Return]    ${query_string}

Preparetion query get invoice remaing for amount after create cndn
    [Arguments]    ${invoice_num}

    ${query_string}    CATENATE
    ...   SELECT  T1.InvAmt -  SUM(T1.Amt) AS Amt
    ...   FROM (
    ...       SELECT  SUM(CNDNItemDetail.CNDNAmount) AS Amt
    ...    , (SELECT DISTINCT(InvoiceAmount) FROM CNDNItem INNER JOIN CNDN ON CNDN.CNDNID = CNDNItem.CNDNID WHERE InvoiceNum = 'EED-BUGBATCH-INV05') AS InvAmt
    ...         FROM CNDNItemDetail INNER JOIN CNDNItem ON CNDNItem.CNDNItemID = CNDNItemDetail.CNDNItemID
    ...   INNER JOIN CNDN ON CNDN.CNDNID = CNDNItem.CNDNID
    ...   INNER JOIN GroupCNDN ON CNDN.GroupID = GroupCNDN.GroupID 
    ...   WHERE CNDNItem.InvoiceNum = 'EED-BUGBATCH-INV05'
    ...      AND CNDN.StatusID IN (1, 2,3)
    ...      AND GroupCNDN.BuyerMPID = '19553eee-b30a-46dd-b978-d75f807295ce'
    ...   GROUP BY CNDNItem.InvoiceNum, CNDNItem.InvoiceAmount,    CNDNItem.CNDNAmount, CNDNItemDetail.CNDNItemDetailID, CNDNItem.InvoiceAmount 
    ...   ) T1 
    ...   Group By T1.InvAmt

    [Return]    ${query_string}





