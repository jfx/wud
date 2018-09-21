** Settings ***
Library           OperatingSystem
Library           DateTime

*** Variables ***
${WUD.SH}        ${CURDIR}/../../wud.sh

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

Wrong option: display usage
    ${rc}    ${output} =    When Run and Return RC and Output    ${WUD.SH} -a
    Then Should Be Equal As Integers    ${rc}    1
    And Should Contain    ${output}    Usage: wud.sh -u <url> [options...]

Wrong usage: [-u] argument not set
    ${rc}    ${output} =    When Run and Return RC and Output    ${WUD.SH}
    Then Should Be Equal As Integers    ${rc}    1
    And Should Contain    ${output}    u argument is mandatory

Wrong usage: [-i] argument should be an integer
    ${rc}    ${output} =    When Run and Return RC and Output    ${WUD.SH} -i X
    Then Should Be Equal As Integers    ${rc}    1
    And Should Contain    ${output}    Error: -i argument should be an integer

Successfull usage with no options
    ${start} =    Get Current Date
    ${low_limit} =    Add Time To Date    ${start}    29s
    ${high_limit} =    Add Time To Date    ${start}    31s
    ${rc}    ${output} =    When Run and Return RC and Output    ${WUD.SH} -u www.google.fr
    Then Should Be Equal As Integers    ${rc}    0
    ${end} =	Get Current Date
    Should Be True    '${low_limit} < ${end}'
    Should Be True    '${end} < ${high_limit}'

Successfull usage with initial wait option [-w]
    ${start} =    Get Current Date
    ${low_limit} =    Add Time To Date    ${start}    4s
    ${high_limit} =    Add Time To Date    ${start}    6s
    ${rc}    ${output} =    When Run and Return RC and Output    ${WUD.SH} -u www.google.fr -w 5
    Then Should Be Equal As Integers    ${rc}    0
    ${end} =	Get Current Date
    Should Be True    '${low_limit} < ${end}'
    Should Be True    '${end} < ${high_limit}'

Unsuccessfull usage with timeout option [-t]
    ${start} =    Get Current Date
    ${low_limit} =    Add Time To Date    ${start}    9s
    ${high_limit} =    Add Time To Date    ${start}    11s
    ${rc}    ${output} =    When Run and Return RC and Output    ${WUD.SH} -u www.googleWrongHost.fr -w 0 -t 5
    Then Should Be Equal As Integers    ${rc}    199
    ${end} =	Get Current Date
    Should Be True    '${low_limit} < ${end}'
    Should Be True    '${end} < ${high_limit}'

Unsuccessfull usage with timeout option [-t] and interval option [-i]: "Interval < Timeout"
    ${start} =    Get Current Date
    ${low_limit} =    Add Time To Date    ${start}    4s
    ${high_limit} =    Add Time To Date    ${start}    6s
    ${rc}    ${output} =    When Run and Return RC and Output    ${WUD.SH} -u www.googleWrongHost.fr -w 0 -t 5 -i 1
    Then Should Be Equal As Integers    ${rc}    199
    ${end} =	Get Current Date
    Should Be True    '${low_limit} < ${end}'
    Should Be True    '${end} < ${high_limit}'

Unsuccessfull usage with timeout option [-t] and interval option [-i]: "Timeout < Interval"
    ${start} =    Get Current Date
    ${low_limit} =    Add Time To Date    ${start}    4s
    ${high_limit} =    Add Time To Date    ${start}    6s
    ${rc}    ${output} =    When Run and Return RC and Output    ${WUD.SH} -u www.googleWrongHost.fr -w 0 -t 1 -i 5
    Then Should Be Equal As Integers    ${rc}    199
    ${end} =	Get Current Date
    Should Be True    '${low_limit} < ${end}'
    Should Be True    '${end} < ${high_limit}'

*** Keywords ***

