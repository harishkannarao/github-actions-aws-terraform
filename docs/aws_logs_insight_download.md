# Download AWS Cloudwatch Logs from multiple log streams

## Start a query with multiple log streams

    aws logs start-query --log-group-names docker-http-app-development spring-security-rest-api-development --start-time 1730128924 --end-time 1730134869 --query-string 'fields @timestamp, @logStream, @message | filter @message like /Tomcat started/ | sort @timestamp desc | display @logStream, @message'

Note the <query-id> returned from the command

## Download the query result to a file

    aws logs get-query-results --output text --query-id {query-id} | grep 'RESULTS' | grep -v '@ptr' | sed 'N;s/\n/ /g' | sed -E 's/RESULTS//g;s/@logStream//g;s/@message//g' > ignored/downloaded.logs

The grep and sed command helps to filter and trim only useful lines and combine 2 consecutive lines into 1 line, which makes the downloaded logs more helpful

Example:

    aws logs get-query-results --output text --query-id f1e8f0d4-bf98-466f-8299-8525afec553e | grep 'RESULTS' | grep -v '@ptr' | sed 'N;s/\n/ /g' > ignored/downloaded.logs