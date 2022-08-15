*** Settings ***
Documentation    Creation Quick Quote (1 room,1 product)
Library    SeleniumLibrary
Resource    ../Processes/Login Retailer.robot
Resource    ../Processes/EditOrRemoveQuote.robot

Suite Setup    Login Retailer.Initiate Web Tests    ${BROWSER}    ${BROWSER_OPTIONS}
Suite Teardown    Common.Terminate Web Tests
*** Variables ***
${BROWSER} =    chrome
${BROWSER_OPTIONS} =    add_argument("--start-maximized");add_argument("--disable-notifications");add_argument("--disable-popup-blocking");add_experimental_option('excludeSwitches', ['enable-logging']);add_argument("--window-size=1360,768");add_argument("--headless")

${Room1}=    Kitchen 1
${Room2}=    Bathroom 1


*** Test Cases ***
Edit Quick Quote remove
    [Documentation]    Creation Quick Quote Add(1 room,1 product)
    [Tags]    Edit QQ Add And Remove Room+Product
    Creation Quick Quote Add one room Add one product
    Close Current Window
    Switch Window Back    0
    click edit quote
    Switch Window Back    1
    Remove Room    ${Room2}
    Remove Last Product
    Submit Changing
    Uploading File and Finishing "Quote" Creation
    Verifying Removing Product And Room



*** Keywords ***
Close Current Window
    close window

Switch Window Back
    [Arguments]    ${NoWin}
    sleep    4s
    ${handles}=    Get Window Handles
    Switch Window    ${handles}[${NoWin}]


Remove Room
    [Arguments]    ${Room}
    wait until page contains element    xpath://*[text()="${Room}"]/lightning-button-icon/button/lightning-primitive-icon    60s
    capture page screenshot
    click element    xpath://*[text()="${Room}"]/lightning-button-icon/button/lightning-primitive-icon

Remove Last Product
    scroll element into view     xpath://*[text()="Service and Travel Related Items:"]
    ${CountProducts}=    get element count    xpath://div[@class="tab-collection-container"]/div/div/c-quick-quote-item-list/lightning-card/article/*[@class="slds-card__header slds-grid"]/following-sibling::*[@class="slds-card__body"]/slot/c-quick-quote-item-list-row/div/div/lightning-button-icon/*[@type="button"]/lightning-primitive-icon
    capture page screenshot
    click element    xpath:(//div[@class="tab-collection-container"]/div/div/c-quick-quote-item-list/lightning-card/article/*[@class="slds-card__header slds-grid"]/following-sibling::*[@class="slds-card__body"]/slot/c-quick-quote-item-list-row/div/div/lightning-button-icon/*[@type="button"]/lightning-primitive-icon)[${CountProducts}]


Verifying Removing Product And Room
    wait until page contains element    xpath://*[text()="View All"]    90s
    scroll element into view    xpath://*[text()="View All"]
    click element    xpath://*[text()="View All"]
    wait until page does not contain    COC Uploaded
    wait until page contains    Job Product Name
    capture page screenshot
    Check There Is Only One Room
    Check Products After Removing


Check There Is Only One Room
    page should contain     ${Room1}
    page should not contain     ${Room2}


Check Products After Removing
    ${CountProducts}=    get element count    xpath://*[contains(text(),"${Room1}")]
    should be true    ${CountProducts}<=6