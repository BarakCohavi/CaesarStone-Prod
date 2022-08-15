*** Settings ***
Library    SeleniumLibrary
Library        DateTime
Resource    Common.robot
Resource    ../Processes/Pending Fabricator Review & Acceptance.robot

*** Variables ***

${Comment}=    Comment

${AddFile} =   ${EXECDIR}\\Input Files\\Capture.png

${name} =    name

*** Keywords ***
Proccess
    [Arguments]    ${CURJOB}
    Order Material
    Upload Photos    ${AddFile}
    Generate COC Form
    wait until page does not contain element    xpath://*[text()="Next"]    100s
    sleep  5s
    Wait Until Page Contains Element    xpath://div[text()="Job"]/parent::h1/div/span    60s
    Common.LogOut As Fabricator
    Common.Search Job By Job Name    ${CURJOB}
    select checkbox COCUploaded
    capture page screenshot



Change The Status To Complete & Save
    wait until page contains element    xpath://*[text()="Job Number"]    60s
    scroll element into view    xpath://*[text()="Pick Slip Generated?"]
    click button    xpath://*[text()="COC Uploaded"]/parent::div/following-sibling::div/button

    scroll element into view    xpath://*[text()="Pick Slip Generated?"]
    click element    xpath://*[text()="Status"]/parent::lightning-combobox/div/lightning-base-combobox/div/div/input

    click element    xpath://*[@role="listbox"]/lightning-base-combobox-item[9]
    wait until page contains element    xpath://*[text()="Save"]    60s
    click button    Save





Order Material
    Wait Until Page Contains Element    xpath://*[@title="Pending Approval"]/*[@class="complete slds-path__stage"]    60s
    sleep    2s
    click element    xpath://*[text()="Order Material"]
    Wait Until Page Contains Element    xpath://*[text()="Product"]    60s

    click button    xpath://*[@class="slds-hint-parent"]/td[3]/lightning-primitive-cell-factory/span/button
    Wait Until Page Contains Element    xpath://*[@type="text"]    60s
    input text    xpath://*[text()="Slabs To Order"]/parent::lightning-input/div/input    1
    press key    xpath://*[text()="Slabs To Order"]/parent::lightning-input/div/input    \\13     #Click Enter

    click button    xpath://*[@class="slds-hint-parent"]/td[4]/lightning-primitive-cell-factory/span/button
    click element    xpath://*[text()="Pickup Date"]/parent::div/div/input
    ${Pickup_Date}    Get Current Date    result_format=%Y-%m-%d
    ${ThreeDaysMore} =  Add Time To Date  ${Pickup_Date}  3 days
    ${ThreeDaysMore} =     subDate    ${ThreeDaysMore}
    ${ThreeDaysMore} =     Convert Date    ${ThreeDaysMore}    result_format=%d/%m/%Y    date_format=%Y-%m-%d
    input text    xpath://*[text()="Pickup Date"]/parent::div/div/input    ${ThreeDaysMore}
    press key    xpath://*[text()="Pickup Date"]/parent::div/div/input   \\13

    click button    Save
    click button    Yes
    sleep    5s
    Wait Until Page Contains Element    xpath://*[text()="Next"]    60s
    click button    Next
    Wait Until Page Contains Element    xpath://*[text()="Your order was sent successfully."]    60s
    click button    Finish



Upload Photos
    [Arguments]    ${path_Photo}
    sleep    2s
    Wait Until Page Contains Element    xpath://*[@class="uiMenu"]/div/div/div/a/lightning-icon    60s
    click element    xpath://*[@class="uiMenu"]/div/div/div/a/lightning-icon
    Wait Until Page Contains Element    xpath://*[@title="Upload Photos"]    60s
    click element      xpath://*[@title="Upload Photos"]
    Wait Until Page Contains Element    xpath://*[text()="Upload a File"]    60s


    choose file    xpath://*[@name="fileUploader"]   ${path_Photo}
    Wait Until Page Contains Element    xpath://*[text()="1 of 1 file uploaded"]    60s
    click element    xpath://*[text()="Done"]

    Wait Until Page Contains Element    xpath://*[text()="Uploaded successfully!"]    60s
    click button    xpath://*[text()="Next"]




Generate COC Form
    wait until page does not contain element    xpath://*[text()="Next"]    100s
    sleep  5s
    click element    xpath://*[@class="uiMenu"]/div/div/div/a/lightning-icon

    Wait Until Page Contains Element    xpath://*[@title="Generate COC Form"]    60s
    click element    xpath://*[@title="Generate COC Form"]

    Wait Until Page Contains Element    xpath://*[@title="Sign now"]    60s
    click element    xpath://*[@title="Sign now"]
    ${url} =    get title
    sleep    2s
    #SeleniumLibrary.Switch Window    New COC AUS
    switch window    NEW
    Select All CheckBoxes

    SeleniumLibrary.switch window    ${url}
    wait until page contains element    xpath://button[@title="Close this window"]/lightning-primitive-icon    60s
    click element    xpath://button[@title="Close this window"]/lightning-primitive-icon




Select All CheckBoxes
    Wait Until Page Contains Element  xpath:(//*[text()="SURFACE INSTALLATION COMPLETION FORM"])  60s
    select checkbox    xpath:(//input[@type="checkbox"])[1]
    select checkbox    xpath:(//input[@type="checkbox"])[2]
    select checkbox    xpath:(//input[@type="checkbox"])[3]
    select checkbox    xpath:(//input[@type="checkbox"])[4]
    select checkbox    xpath:(//input[@type="checkbox"])[5]
    select checkbox    xpath:(//input[@type="checkbox"])[6]
    select checkbox    xpath:(//input[@type="checkbox"])[7]
    input text    xpath://input[@type="text"]    ${name}

    mouse down    xpath://canvas[@class="jSignature"]
    mouse up    xpath://*[text()="Submit"]
    sleep    1s
    click button    Submit


Mark Status as Complete
    sleep    1s
    Wait Until Page Contains Element    xpath://*[text()="Mark Status as Complete"]    60s
    click element    xpath://*[text()="Mark Status as Complete"]
