# Download AWS Cloudwatch Logs

## Print all logs to console

    aws logs filter-log-events --log-group-name docker-http-app-development | jq -r '.events[].message'

## Save all logs to a file

    aws logs filter-log-events --log-group-name docker-http-app-development | jq -r '.events[].message' > ignored/downloaded.logs

## Print logs between specified time in epoch milliseconds

    aws logs filter-log-events --log-group-name docker-http-app-development --start-time 1586603083000 --end-time 1586603652000 | jq -r '.events[].message'

## Filter logs using AWS Metric Filter patterns

    aws logs filter-log-events --filter-pattern '{filter_pattern}' --log-group-name docker-http-app-development | jq -r '.events[].message'

Example:

    aws logs filter-log-events --filter-pattern '"ACCESS_LOG" - "/health-check"' --log-group-name docker-http-app-development | jq -r '.events[].message'

### useful metric filter patterns

Application Logs

    - "ACCESS_LOG"    

Error level application logs

    [date, time, logLevel=ERROR, message]

All access Logs

    [date, time, logLevel=ACCESS_LOG, resTime, byte, status, ip, reqId, method, url]

All non-health check access logs

    [date, time, logLevel=ACCESS_LOG, resTime, byte, status, ip, reqId, method, url!=*health-check*]

All `GET` operations in access logs

    [date, time, logLevel=ACCESS_LOG, resTime, byte, status, ip, reqId, method=*GET*, url]

All errors in access logs

    [date, time, logLevel=ACCESS_LOG, resTime, byte, status>=400&&status<=599, ip, reqId, method, url]

All access logs with response time greater than 2 minutes (120000 millis)

    [date, time, logLevel=ACCESS_LOG, resTime>=120000, byte, status, ip, reqId, method, url!=*health-check*]