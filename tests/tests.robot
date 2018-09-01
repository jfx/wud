*** Settings ***
Library           OperatingSystem

*** Variables ***
${WUD.SH}        ${CURDIR}/../wud.sh

*** Test Cases ***
Display version: [-v] option
    ${rc}    ${output} =    When Run and Return RC and Output    ${WUD.SH} -v
    Then Should Be Equal As Integers    ${rc}    0
    And Should Contain    ${output}    wud.sh, version
    And Should Contain    ${output}    Copyright (C)
    And Should Contain    ${output}    License GPLv3+

Display usage: [-h] option
    ${rc}    ${output} =    When Run and Return RC and Output    ${WUD.SH} -h
    Then Should Be Equal As Integers    ${rc}    0
    And Should Contain    ${output}    Usage: wud.sh -u <url> [options...]
    And Should Contain    ${output}    Options:
    And Should Contain    ${output}    -h print usage

*** Keywords ***

