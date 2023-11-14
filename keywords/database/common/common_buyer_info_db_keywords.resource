*** Keywords ***
Get buyermpid and buyerid from invoice database
    [Documentation]    Get buyer mpid from database via eid condition

    ${query_str}    CATENATE
    ...    SELECT BuyerMpID
    ...    ,BuyerID
    ...    FROM BuyerInvoice
    ...    WHERE EID = ${eid}

    [Return]    ${query_str}