*** Keywords ***
Connect eInvoice DB
    Connect To Database    dbapiModuleName=pymssql    dbConfigFile=./resources/configs/${env}/db_einvoice.cfg

Connect RBAC DB
    Connect To Database    dbapiModuleName=pymssql    dbConfigFile=./resources/configs/${env}/db_rbac.cfg    

Connect BestSupply DB
    Connect To Database    dbapiModuleName=pymssql    dbConfigFile=./resources/configs/${env}/db_best_supplier.cfg

Connect BuySite_EBD_TrueOP DB
    Connect To Database    dbapiModuleName=pymssql    dbConfigFile=./resources/configs/${env}/db_ebd_true_op.cfg

Connect PIS DB
    Connect To Database    dbapiModuleName=pymssql    dbConfigFile=./resources/configs/${env}/db_pis.cfg

eInvoice Execute INSERT, UPDATE, DELETE query string
    [Arguments]    ${query_string}
    Connect eInvoice DB
    ${status}=  Run Keyword And Return Status    Execute Sql String    ${query_string}
    Disconnect From Database
    [Return]    ${status}

eInvoice Execute SELECT query string
    [Arguments]    ${query_string}
    Connect eInvoice DB
    @{results}=  Query    ${query_string}
    Disconnect From Database
    [Return]    @{results}

eInvoice Execute Row Count query string
    [Arguments]    ${query_string}
    Connect eInvoice DB
    ${results}=  Row Count    ${query_string}
    Disconnect From Database
    [Return]    ${results}   

RBAC Execute SELECT query string
    [Arguments]    ${query_string}
    Connect RBAC DB
    @{results}=  Query    ${query_string}
    Disconnect From Database
    [Return]    @{results}    
