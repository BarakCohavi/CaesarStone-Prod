*** Settings ***
Documentation    Creation Quick Quote (1 room,1 product)
Library    SeleniumLibrary
Resource    ../Processes/Create Quick Quote.robot
Resource    ../Processes/retailerFabricatorOnboardingProcess.robot



*** Variables ***

${Room1}=    Kitchen 1
${Room2}=    Bathroom 1

${room description1} =    Bathroom 1

${Product in first_row1} =    xpath:(//*[@class="slds-card__body"]/slot/c-quick-quote-item-list-row[1]/div/div[2]/c-search-autocomplete-selector/div/div/div/div/div/input[@placeholder="Search by name or code"])[2]
${Product in second_row1} =    xpath:(//*[@class="slds-card__body"]/slot/c-quick-quote-item-list-row[2]/div/div[2]/c-search-autocomplete-selector/div/div/div/div/div/input[@placeholder="Search by name or code"])[2]
${Product in third_row1} =    xpath:(//*[@class="slds-card__body"]/slot/c-quick-quote-item-list-row[3]/div/div[2]/c-search-autocomplete-selector/div/div/div/div/div/input[@placeholder="Search by name or code"])[2]
${Product in fourth_row1} =    xpath:(//*[@class="slds-card__body"]/slot/c-quick-quote-item-list-row[4]/div/div[2]/c-search-autocomplete-selector/div/div/div/div/div/input[@placeholder="Search by name or code"])[2]

${first_dropDown_option of first Product1} =    xpath:(//*[@class="slds-card__body"]/slot/c-quick-quote-item-list-row[1]/div/div[2]/c-search-autocomplete-selector/div/div/div/div/div[2]/ul/c-search-autocomplete-selector-item[1]/li/div/span/span)[2]
${first_dropDown_option of second Product1} =     xpath:(//*[@class="slds-card__body"]/slot/c-quick-quote-item-list-row[2]/div/div[2]/c-search-autocomplete-selector/div/div/div/div/div[2]/ul/c-search-autocomplete-selector-item[1]/li/div/span/span)[2]
${first_dropDown_option of third Product1} =     xpath:(//*[@class="slds-card__body"]/slot/c-quick-quote-item-list-row[3]/div/div[2]/c-search-autocomplete-selector/div/div/div/div/div[2]/ul/c-search-autocomplete-selector-item[1]/li/div/span/span)[2]
${first_dropDown_option of fourth Product1} =     xpath:(//*[@class="slds-card__body"]/slot/c-quick-quote-item-list-row[4]/div/div[2]/c-search-autocomplete-selector/div/div/div/div/div[2]/ul/c-search-autocomplete-selector-item[1]/li/div/span/span)[2]


${Quantity in first_row1} =    xpath:(//*[@class="slds-card__body"]/slot/c-quick-quote-item-list-row[1]/div/div[3]/lightning-input/div/input)[2]
${Quantity in second_row1} =    xpath:(//*[@class="slds-card__body"]/slot/c-quick-quote-item-list-row[2]/div/div[3]/lightning-input/div/input)[2]
${Quantity in third_row1} =    xpath:(//*[@class="slds-card__body"]/slot/c-quick-quote-item-list-row[3]/div/div[3]/lightning-input/div/input)[2]
${Quantity in fourth_row1} =    xpath:(//*[@class="slds-card__body"]/slot/c-quick-quote-item-list-row[4]/div/div[3]/lightning-input/div/input)[2]
${Quantity in fifth_row} =    xpath:(//*[@title="Other"]/c-quick-quote-item-list/lightning-card/article/*[@class="slds-card__body"]/slot/c-quick-quote-item-list-row[1]/div/div[3]/lightning-input/div/input)[1]
${Product in fifth_row} =    xpath:(//*[@title="Other"]/c-quick-quote-item-list/lightning-card/article/*[@class="slds-card__body"]/slot/c-quick-quote-item-list-row[1]/div/div[2]/c-search-autocomplete-selector/div/div/div/div/div/input[@placeholder="Search by name or code"])[1]

${Notes in fourth_row1} =    xpath:(//*[@class="slds-card__body"]/slot/c-quick-quote-item-list-row[4]/div/div[4]/lightning-input/div/input)[2]



*** Keywords ***
Creation Quick Quote Add one room Add one product
    create quick quote.process
    Click Edit Quote
    Add New Product To The Current room
    Add New Room
    Add Products To New Room
    Submit Changing
    Uploading File and Finishing "Quote" Creation
    Verifying "New Quote" Was Changed

Submit Changing
    page should contain button    Submit
    click button    Submit
    click button    Yes
Add New Room
    scroll element into view    xpath://*[text()="Create room, add products and insert qty."]
    wait until element is visible    xpath://*[@class="slds-button pad-right"]
    click element    xpath://div[@class="slds-dropdown-trigger slds-dropdown-trigger_click"]
    ${present}=    run keyword and return status    element should be visible     xpath://*[text()="Bathroom"]
    IF    ${present}==0
        click element    xpath://div[@class="slds-dropdown-trigger slds-dropdown-trigger_click"]
    END
    wait until page contains element    xpath://*[text()="Bathroom"]    60s
    click element    xpath://*[text()="Bathroom"]

    scroll element into view    xpath://*[text()="Service and Travel Related Items:"]
    capture page screenshot

Add Products To New Room
    input text    ${room description1}    New Room
    click element    ${Product in first_row1}
    click element    ${first_dropDown_option of first Product1}
    #click element    xpath://span[text()="Airy Concrete - 2cm"]

    input text    ${Quantity in first_row1}    2
    click element    ${Product in second_row1}
    click element    ${first_dropDown_option of second Product1}
    #click element    xpath://span[text()="20mm Arris Edge"]

    input text    ${Quantity in second_row1}    4
    click element    ${Product in third_row1}
    click element    ${first_dropDown_option of third Product1}
    #click element    xpath://span[text()="Additional Rough Cutout"]

    input text    ${Quantity in third_row1}    3
    click element    ${Product in fourth_row1}
    click element    ${first_dropDown_option of fourth Product1}
    #click element    xpath:(//span[text()="Drop in Sink"])[2]

    input text    ${Quantity in fourth_row1}    3
    input text    ${Notes in fourth_row1}    one spare





Click Edit Quote
    Wait Until Page Contains Element    xpath://*[text()="Edit Quote"]    60s
    click element    xpath://*[text()="Edit Quote"]
    sleep    0.5s

Verifying "New Quote" Was Changed
    wait until page contains element    xpath://*[text()="View All"]    90s
    scroll element into view    xpath://*[text()="View All"]
    click element    xpath://*[text()="View All"]
    wait until page does not contain    COC Uploaded
    wait until page contains    Job Product Name
    capture page screenshot
    Check There Are 2 Rooms
    Check Products


Check Products
    ${CountProducts}=    get element count    xpath://*[contains(text(),"Kitchen 1")]
    should be true    ${CountProducts}>=5

Check There Are 2 Rooms
    page should contain     ${Room1}
    page should contain     ${Room2}

Add New Product To The Current room
    sleep    5s
    ${handles}=    Get Window Handles
    Switch Window    ${handles}[1]
    wait until page contains    Application    30s
    click element    xpath:(//*[@class="slds-button__icon" and @data-key="add"])[1]
    sleep    1s
    #scroll element into view    xpath://*[text()="Submit"]
    Scroll To Element     xpath://*[text()="Submit"]
    ${CountProducts}=    get element count    xpath:(//*[@class="slds-card__body"])[1]/slot/c-quick-quote-item-list-row
    capture page screenshot
    click element    xpath:(//*[@class="slds-card__body"])[1]/slot/c-quick-quote-item-list-row[${CountProducts}]/div/div/lightning-combobox/div/lightning-base-combobox/div/div/button
    #scroll element into view    xpath://*[text()="Submit"]
    Scroll To Element     xpath://*[text()="Submit"]
    click element    xpath:(//*[@class="slds-card__body"])[1]/slot/c-quick-quote-item-list-row[${CountProducts}]/div/div/lightning-combobox/div/lightning-base-combobox/div/div[2]/lightning-base-combobox-item[2]

    click element     xpath:(//*[@class="slds-card__body"]/slot/c-quick-quote-item-list-row[${CountProducts}]/div/div[2]/c-search-autocomplete-selector/div/div/div/div/div/input[@placeholder="Search by name or code"])[1]
    click element    xpath:(//*[@class="slds-card__body"]/slot/c-quick-quote-item-list-row[${CountProducts}]/div/div[2]/c-search-autocomplete-selector/div/div/div/div/div[2]/ul/c-search-autocomplete-selector-item[1]/li/div/span/span)[1]
    click element    xpath:(//*[@class="slds-card__body"]/slot/c-quick-quote-item-list-row[${CountProducts}]/div/div[3]/lightning-input/div/input)[1]
    input text    xpath:(//*[@class="slds-card__body"]/slot/c-quick-quote-item-list-row[${CountProducts}]/div/div[3]/lightning-input/div/input)[1]    2
    capture page screenshot