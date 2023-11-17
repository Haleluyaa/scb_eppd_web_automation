# Eppd Web Automation Testing

TODO: Write a project description

## Installation Guide
pip3 install -r requirements.txt
### Robot Framework
${env}= sit | uat
${-i tagName}= -i regression | -i smoketest **optional
Run Command : Python3 -m robot -v env:${env} -d results {-i tagname} -L TRACE ./testcases/${service_folder}/${testcase.robot}
### Virtual Environment
TODO: Describe the installation process

# Usage
## Files Structure

## Keywords Structure

TODO: Write usage instructions

# File Management
## Resource File Page Meaning  (Keywords, Locator and others not executable file)

| File Name                                             | Refer to Page                                 | Comment                   |
| ------------------------------------------------------|:-------------------------------------------- :|--------------------------:|
| approve_cndn_keywords.resource                        | CNDN Approve List                             |                           |
| cndn_approve_keywords.resource                        | CNDN Approve List                             |                           |
| view_cndn_keywords.resource                           | CNDN Supplier Detail (View Page)              |                           |
| approval_view_cndn_keywords.resource                  | CNDN Approve Detail (View Page)               |                           |
| cndn_status_keywords.resource                         | CNDN Supplier List                            |                           |
| cndn_history_keywords.resource                        | Modal History (Supplier and Buyer)            |                           |
| create_cndn_step1_keywords.resource                   | CNDN Supplier Create on Step1                 |                           |
| create_cndn_step2_keywords.resource                   | CNDN Supplier Create on Step2                 |                           |
| create_creditnotedebitnote_modal_keywords.resource    | CNDN Supplier Modal Create Credit/Debit Note  |                           |

## Robot File Page Meaning (Test cases)

# Contributing

TODO: Write Contributing

# History

TODO: Write history

# Credits

TODO: Write credits

# License

TODO: Write license



