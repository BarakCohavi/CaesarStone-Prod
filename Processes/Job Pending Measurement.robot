*** Settings ***
Library    SeleniumLibrary
Resource    Common.robot

*** Variables ***
${AddFile} =   ${EXECDIR}\\Input Files\\Capture.png


*** Keywords ***
Process
    [Documentation]    Pending Fabricator Review & Acceptance
    [Arguments]    ${CURJOB}
    Upload photo    ${AddFile}
    
Upload photo
    [Arguments]    ${path_Photo}
    wait until page does not contain element    xpath://*[text()="Save"]    60s
    wait until page contains element    xpath://*[@class="uiMenu"]/div/div/div/a/lightning-icon    60s
    #reload page
    wait until page does not contain element    xpath://*[text()="Save"]    60s
    wait until page contains element    xpath://*[@class="uiMenu"]/div/div/div/a/lightning-icon    60s
    sleep    3s
    click element    xpath://*[@class="uiMenu"]/div/div/div/a/lightning-icon

    #Wait Until Page Contains Element    xpath://*[@title="Upload Photos"]    60s
    click element    xpath://*[@title="Upload Photos"]
    Wait Until Page Contains Element    xpath://*[@name="fileUploader"]    60s
    choose file    xpath://*[@name="fileUploader"]   ${path_Photo}
    Wait Until Page Contains Element    xpath://*[text()="1 of 1 file uploaded"]    60s
    click element    xpath://*[text()="Done"]

    Wait Until Page Contains Element    xpath://*[text()="Next"]    60s
    click element    xpath://*[text()="Next"]




