*** Settings ***
Library    SeleniumLibrary
Library    functions.py
Resource    Common.robot
Resource    ../Processes/Pending Fabricator Review & Acceptance.robot
Library    DateTime
*** Variables ***

${path_File} =  ${EXECDIR}\\Input Files\\MyFile.pdf


*** Keywords ***
Proccess
    [Arguments]    ${CURJOB}
    Login To Experience As Fabricator
    Click Search CaesarStone Page    ${CURJOB}
    Upload an Invoice    ${CURJOB}
    Common.LogOut As Fabricator
    Common.Search Job By Job Name    ${CURJOB}
    Close The Job



Close The Job
    wait until page contains element    xpath://*[text()="Job Number"]    60s
    sleep    1s
    scroll element into view    xpath://*[text()="Pick Slip Generated?"]
    click button    xpath://*[text()="COC Uploaded"]/parent::div/following-sibling::div/button

    scroll element into view    xpath://*[text()="Status"]
    click element    xpath://*[text()="Status"]/parent::lightning-combobox/div/lightning-base-combobox/div/div/button

    click element    xpath://*[@role="listbox"]/lightning-base-combobox-item[10]

    sleep    0.1s
    scroll element into view    xpath://*[text()="Installation Time Preference"]
    select checkbox    xpath://*[@name="Test_Job__c"]

    scroll element into view    xpath://*[text()="Fabricator PO Number"]
    click element    xpath://*[text()="Sync Status Fabricator Order"]/parent::lightning-combobox/div/lightning-base-combobox/div/div/button
    click element    xpath:(//*[text()="Ready to be sync"])[1]
    click element    xpath://*[text()="Sync Status Retailer Order"]/parent::lightning-combobox/div/lightning-base-combobox/div/div/button
    click element    xpath:(//*[text()="Ready to be sync"])[1]


    wait until page contains element    xpath://*[text()="Save"]    60s
    click button    Save
    #sleep    2s

    ${present}=    get element count    xpath://*[text()="Save"]
    #run keyword if    ${present}>0    Click Save

Click Save
     click element    xpath://*[text()="Save"]


Upload an Invoice
    [Arguments]    ${CURJOB}
    Wait Until Page Contains Element     xpath://*[@class="uiMenu"]/div/div/div/a/lightning-icon    60s
    click element    xpath://*[@class="uiMenu"]/div/div/div/a/lightning-icon
    Wait Until Page Contains Element    xpath://*[@title="Upload an Invoice"]    60s
    click element    xpath://*[@title="Upload an Invoice"]
    Wait Until Page Contains Element    xpath://*[@name="Invoice_Number"]    60s
    ${Invoice_Number}=    NumJob    ${CURJOB}
    input text    xpath://*[@name="Invoice_Number"]    ${Invoice_Number}
    click element    xpath://*[@name="InvoiceDate"]
    ${InvoiceDate}    Get Current Date    result_format=%d/%m/%Y
    input text    xpath://*[@name="InvoiceDate"]    ${InvoiceDate}
    Wait Until Page Contains Element    xpath://*[text()="Next"]    60s
    click button   xpath://*[text()="Next"]
    Wait Until Page Contains Element    xpath://*[text()="Previous"]    60s
    click button    xpath://*[text()="Next"]

    Wait Until Page Contains Element    xpath://*[text()="Upload a File"]    60s

    choose file    xpath://input[@name="fileUploader"]   ${path_File}
    Wait Until Page Contains Element    xpath://*[text()="1 of 1 file uploaded"]    60s
    click element    xpath://*[text()="Done"]
    Wait Until Page Contains Element    xpath://*[text()="Uploaded successfully!"]    60s
    click button    xpath://*[text()="Next"]
    Wait Until Page Contains Element    xpath://*[text()="The invoice was uploaded successfully."]    60s
    click button    xpath://*[text()="Finish"]

