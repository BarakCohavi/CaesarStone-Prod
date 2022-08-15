*** Settings ***
Library    SeleniumLibrary
Library    ../Processes/functions.py
Resource    ../Processes/Common.robot
Resource    EditeRemoveCreateQC.robot
*** Variables ***
${CityInput}=     City


*** Keywords ***
Proccess
    ${User_Link_Page}=    ReadInput  2  5
    common.Navigating To "Experience As User"    ${User_Link_Page}
    Select Frames
    Choose Room
    Add SPLASHBACK
    Add Edge
    Add CUTOUTS
    Add SPECIALY CUTS
    Add ADDITIONAL TRAVEL
    capture page screenshot

    ${Total_Inc}=    get text    xpath:(//*[@class="dcart-column__value"])[2]
    ${Total_Exc}=    get text    xpath:(//*[@class="dcart-column__value"])[1]
    ${Total_Inc}=    substringg    ${Total_Inc}   #to cut the dolar
    ${Total_Exc}=    substringg    ${Total_Exc}
    ${Total_Exc}=    multiple10    ${Total_Exc}
    Choose Customer

    Save Qoute
    View & Process Job
    sleep    35s
    reload page
    wait until page contains element   xpath://*[text()="Job"]    120s
    Check Price    ${Total_Inc}    ${Total_Exc}
    VARIFY QC CREATED

Process1 (one room & product)
    ${User_Link_Page}=    ReadInput  2  5
    common.Navigating To "Experience As User"    ${User_Link_Page}
    Select Frames
    Choose Room
    Add SPLASHBACK
    Add Edge
    #Add CUTOUTS
    wait until page does not contain element    xpath://*[contains(text(),"Additional Tap Hole")]    50s
    click element    xpath://*[text()="Add to Quote"]
    #Add SPECIALY CUTS
    click element    xpath://*[text()="Add to Quote"]
    #Add ADDITIONAL TRAVEL
    click element    xpath://*[text()="Add to Quote"]
    click element    xpath://*[text()="Save Quote"]

Process2 (one room & product)
    sleep    2s
    Choose Customer
    Save Qoute
    #View & Process Job
    select frame    //iframe[@class="canvasIframe"]
    select frame    //iframe[@title="Canvas IFrame for application QuoteCountertops."]
    select frame    //iframe[@title="QuoteCountertops"]
    wait until page contains element    xpath://*[text()="View & Process Job"]      60s
    click element    xpath://*[text()="View & Process Job"]
    #wait until page does not contain element    xpath://*[text()="View & Process Job"]    120

    capture page screenshot

View & Process Job
    select frame    //iframe[@class="canvasIframe"]
    select frame    //iframe[@title="Canvas IFrame for application QuoteCountertops."]
    select frame    //iframe[@title="QuoteCountertops"]
    QC CREATED


QC CREATED
    wait until page contains element    xpath://*[text()="View & Process Job"]      60s
    click element    xpath://*[text()="View & Process Job"]
    capture page screenshot

VARIFY QC CREATED
    wait until page contains element   xpath://*[text()="Job"]    120s
    capture page screenshot

Save Qoute
    ${url} =    get title
    #SAVE QUOTE
    click element    xpath:(//*[text()="Save Quote"])[2]
    wait until page contains element    xpath://*[text()="View & Process Job"]    100s
    SeleniumLibrary.switch window    ${url}


Choose Customer
    #CHECKBOX TEST CUST
    ${CountProducts}=    get element count    xpath://span[text()="customer"]/parent::div/following-sibling::div/div/li
    IF    ${CountProducts}==0
    #ADD CUSTOMER
    click element    xpath://*[text()="Add Customer"]
    input text    firstName    Automated
    input text    lastName    Test
    input text    city    ${CityInput}
    input text    state    Australian Capital Territory
    ELSE IF     ${CountProducts}>0
    click element    xpath://*[text()="customer"]/parent::div/parent::div/div[2]/div/li[${CountProducts}]
    END

Add ADDITIONAL TRAVEL
    #ADDITIONAL TRAVEL
    SLEEP    2s
    wait until element is visible    xpath:(//*[@class="ui-quantity-button ui-quantity-button--plus"])[1]    90s
    click button    xpath:(//*[@class="ui-quantity-button ui-quantity-button--plus"])[1]
    click element    xpath://*[text()="Add to Quote"]
    click element    xpath://*[text()="Save Quote"]
    sleep    2s

Add SPECIALY CUTS
    wait until element is visible    xpath:(//*[@class="ui-quantity-button ui-quantity-button--plus"])[1]    90s
    click button    xpath:(//*[@class="ui-quantity-button ui-quantity-button--plus"])[1]
    click element    xpath://*[text()="Add to Quote"]

Add CUTOUTS
    wait until element is visible    xpath:(//*[@class="ui-quantity-button ui-quantity-button--plus"])[1]    90s
    click button    xpath:(//*[@class="ui-quantity-button ui-quantity-button--plus"])[1]
    click element    xpath://*[text()="Add to Quote"]
    wait until page does not contain element    xpath://*[contains(text(),"Additional Tap Hole")]    50s


Add Edge
    #EDGE
    wait until element is visible    xpath://*[@class="bv-item-container"]/div/div[1]/div/div[1]/div/div[1]    90s

    click element    xpath://*[@class="bv-item-container"]/div/div[1]/div/div[1]/div
    click element    xpath://*[@class="bv-item-container"]/div/div[1]/div/div[1]/div[1]/div[2]/button
    sleep    1s
    ${CountProducts1}=    get element count    xpath://*[@class="bv-item-container"]/div/div[1]/div/div[1]/div[1]/div[2]/button
    IF    ${CountProducts1}==1
    click element    xpath://*[@class="bv-item-container"]/div/div[1]/div/div[1]/div[1]/div[2]/button
    END

    wait until element is visible    xpath://*[text()="Add to Quote"]    90s

    click element    xpath://*[text()="Add to Quote"]
    ${CountProducts}=    get element count    xpath://*[contains(text(),"Product info")]
    IF    ${CountProducts}>0
        click element    xpath://*[text()="Add to Quote"]
    END


    #click element    xpath://*[text()="Add to Quote"]
    wait until page does not contain element    xpath://*[contains(text(),"Product info")]    50s


Add Edge2
    #EDGE
    wait until element is visible    xpath://*[@class="bv-item-container"]/div/div[1]/div/div[1]/div/div[1]    90s

    click element    xpath://*[@class="bv-item-container"]/div/div[1]/div/div[1]/div
    sleep    1s

    ${CountProducts1}=    get element count    xpath://*[@class="bv-item-container"]/div/div[1]/div/div[1]/div[1]/div[2]/button
    IF    ${CountProducts1}==1
    click element    xpath://*[@class="bv-item-container"]/div/div[1]/div/div[1]/div[1]/div[2]/button
    END

    #click element    xpath://*[@class="bv-item-container"]/div/div[1]/div/div[1]/div[1]/div[2]/button
    #click button    Add
    wait until element is visible    xpath://*[text()="Add to Quote"]    90s

    click element    xpath://*[text()="Add to Quote"]
    ${CountProducts}=    get element count    xpath://*[contains(text(),"Product info")]
    IF    ${CountProducts}>0
        click element    xpath://*[text()="Add to Quote"]
    END


    #click element    xpath://*[text()="Add to Quote"]
    wait until page does not contain element    xpath://*[contains(text(),"Product info")]    50s


Add SPLASHBACK
#SPLASHBACK
    wait until element is visible    xpath://*[@class="bv-item-container"]/div/div/div/div/div/div[2]/button    90s
    sleep    3s
    click button    xpath://*[@class="bv-item-container"]/div/div/div/div/div/div[2]/button

    wait until element is visible    xpath://*[@class="ui-quantity-button ui-quantity-button--plus"]    90s
    click button    xpath://*[@class="ui-quantity-button ui-quantity-button--plus"]
    click element    xpath://*[text()="Add to Quote"]
    sleep    1s

Choose Room
    wait until page does not contain element    xpath://*[text()="Please wait while the design is ready."]
    wait until element is enabled    xpath://*[@class="bv-item-container"]/div/div/div/div[2]    100s

    click element    xpath://*[@class="bv-item-container"]/div/div/div/div[2]
    sleep    2s
    wait until element is enabled    xpath://*[@class="bv-item-container"]/div/div/div/div[2]/div/div[2]/button    100s
    click button    xpath://*[@class="bv-item-container"]/div/div/div/div[2]/div/div[2]/button

    ${CountProducts}=    get element count    xpath://*[@class="bv-item-container"]/div/div/div/div[2]/div/div[2]/button
    IF    ${CountProducts}==1
    click element    xpath://*[@class="bv-item-container"]/div/div/div/div[2]/div/div[2]/button
    END



    wait until element is visible   xpath://*[text()="Add to Quote"]    100s
    click element    xpath://*[text()="Add to Quote"]

    ${CountProducts}=    get element count    xpath://*[contains(text(),"Product info")]
    IF    ${CountProducts}==1
    click element    xpath://*[text()="Add to Quote"]
    END

    wait until element is visible    xpath://*[@class="bv-item-container"]/div/div/div/div/div/div[2]/button    90s
    sleep    2s
    click button    xpath://*[@class="bv-item-container"]/div/div/div/div/div/div[2]/button
    wait until element is visible    xpath://*[@class="ui-quantity-button ui-quantity-button--plus"]    90s
    click button    xpath://*[@class="ui-quantity-button ui-quantity-button--plus"]
    click element    xpath://*[text()="Add to Quote"]


Select Frames
    wait until page contains element    xpath:(//*[@class="slds-button slds-button_brand"])[1]  130s
    click element  xpath:(//*[@class="slds-button slds-button_brand"])[1]
    wait until element is visible    xpath://iframe[@class="canvasIframe"]    90s
    select frame    //iframe[@class="canvasIframe"]
    #frame should contain    xpath://head    20s
    sleep    0.9m
    wait until element is enabled    xpath://iframe[@title="Canvas IFrame for application QuoteCountertops."]    90s
    select frame    //iframe[@title="Canvas IFrame for application QuoteCountertops."]
    select frame    //iframe[@title="QuoteCountertops"]


Click Edit Quote QC
    Wait Until Page Contains Element    xpath://*[text()="Edit Quote"]    60s
    mouse down    xpath://*[text()="Edit Quote"]
    mouse up    xpath://*[text()="Edit Quote"]
    sleep    0.5s


Switch handle alert Edit
    sleep    2s
    #log to console    Hello
    #close window
    ${handles}=    Get Window Handles
    sleep    2s
    Switch Window    NEW
    #log to console    switched
    capture page screenshot

SELECT FRAMES Edit
    wait until page contains element    xpath://*[text()="Home"]    60s
    wait until element is visible    xpath://iframe[@class="canvasIframe"]    120s
    select frame    //iframe[@class="canvasIframe"]
    sleep    0.9m
    select frame    //iframe[@title="Canvas IFrame for application QuoteCountertops."]
    select frame    //iframe[@title="QuoteCountertops"]

CLICK ADD ROOM Edit
    sleep    2s
    wait until page contains element    xpath://*[text()="Add Room"]    60s
    #scroll element into view    xpath://*[text()="Add Room"]
    click element    //*[@class="quotes-list__item quotes-list__item--add"]
    sleep    1s
    ${CountProducts}=    get element count    xpath://*[@class="quotes-list__item quotes-list__item--add"]
    IF    ${CountProducts}==1
    click element    //*[@class="quotes-list__item quotes-list__item--add"]
    END


Add CUTOUTS & SPECIALY CUTS & ADDITIONAL TRAVEL Edit
    #Add CUTOUTS
    wait until page does not contain element    xpath://*[contains(text(),"Additional Tap Hole")]    50s
    sleep    1s
    click element    xpath://*[text()="Add to Quote"]
    #Add SPECIALY CUTS
    sleep    1s
    click element    xpath://*[text()="Add to Quote"]
    #Add ADDITIONAL TRAVEL
    sleep    1s
    click element    xpath://*[text()="Add to Quote"]

