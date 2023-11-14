#***Settings***
#Variables    ../../../resources/locators/invoice/view_invoice_detail_locator.yaml

#***Keywords***
#Click on the first row of PO Detail in view invoice page
#    Wait Until Element Is Visible    ${obj_view_invoice_detail.tbl_po_detail.row_first_nongr}
#    Click Element    ${obj_view_invoice_detail.tbl_po_detail.row_first_nongr}