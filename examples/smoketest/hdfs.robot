

*** Settings ***
Documentation    Test suite to check HDFS functionality
Library          OperatingSystem
Library          String

*** Test Cases ***

Test HDFS Cli
  ${random} =    Generate Random String  5  [NUMBERS]
  Execute        hdfs dfs -ls /
  Execute        hdfs dfs -mkdir /test
  Execute        hdfs dfs -mkdir /test/${random}
  Execute        hdfs dfs -put /opt/hadoop/LICENSE.txt /test/${random}/file1
  Execute        hdfs dfs -get /test/${random}/file1 /tmp/file${random}
  Same files     /tmp/file${random}    /opt/hadoop/LICENSE.txt
  Execute        rm /tmp/file${random}


Run Yarn PI job
  ${output} =      Execute         yarn jar /opt/hadoop/share/hadoop/mapreduce/hadoop-mapreduce-examples-3.2.1.jar pi 10 10
                   Should Contain  ${output}    Estimated value of Pi is 3.20000000000000000000

*** Keywords
Execute
    [arguments]                     ${command}
    ${rc}                           ${output} =                 Run And Return Rc And Output           ${command}
    Log                             ${output}
    Should Be Equal As Integers     ${rc}                       0
    [return]                        ${output}

Execute And Ignore Error
    [arguments]                     ${command}
    ${rc}                           ${output} =                 Run And Return Rc And Output           ${command}
    Log                             ${output}
    [return]                        ${output}

Execute and checkrc
    [arguments]                     ${command}                  ${expected_error_code}
    ${rc}                           ${output} =                 Run And Return Rc And Output           ${command}
    Log                             ${output}
    Should Be Equal As Integers     ${rc}                       ${expected_error_code}
    [return]                        ${output}

Same files
   [arguments]   ${file1}    ${file2}
   ${c1} =    Get File    ${file1}
   ${c2} =    Get File    ${file2}
   Should Be Equal As Strings    ${c1}    ${c2}
