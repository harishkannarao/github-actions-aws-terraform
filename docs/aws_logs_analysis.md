# AWS Cloudwatch Log Analysis

Choose log group as `docker-http-app-development`

## Access Logs

All access logs

    [date, time, logLevel=ACCESS_LOG, resTime, byte, status, ip, reqId, method, url]

Exlude `health-check` calls

    [date, time, logLevel=ACCESS_LOG, resTime, byte, status, ip, reqId, method, url!=*health-check*]

Display only `GET` operations

    [date, time, logLevel=ACCESS_LOG, resTime, byte, status, ip, reqId, method=*GET*, url!=*health-check*]

Display access logs with status code between `400` and `599`

    [date, time, logLevel=ACCESS_LOG, resTime, byte, status>=400&&status<=599, ip, reqId, method, url]

Display access logs with response time greater than 2 minutes (120000 millis)

    [date, time, logLevel=ACCESS_LOG, resTime>=120000, byte, status, ip, reqId, method, url!=*health-check*]

## Application Logs

Display all application logs (excluding ACCESS_LOG)

    - "ACCESS_LOG"

Display only `ERROR` level application logs

    [date, time, logLevel=ERROR, message]

Display only `RuntimeException` application logs

    - "ACCESS_LOG" "RuntimeException"

## Rest Client Access Logs

All access logs

    [date, time, logLevel, ignore1, ignore2, ignore3, ignore4, ignore5, reqId, message=REST_CLIENT_ACCESS_LOG, responseTime, status, method, uri]

Display only `GET` operations

    [date, time, logLevel, ignore1, ignore2, ignore3, ignore4, ignore5, reqId, message=REST_CLIENT_ACCESS_LOG, responseTime, status, method=GET, uri]

Display access logs with status code between `400` and `599`

    [date, time, logLevel, ignore1, ignore2, ignore3, ignore4, ignore5, reqId, message=REST_CLIENT_ACCESS_LOG, responseTime, status>=400&&status<=599, method=GET, uri]

Display access logs with timeout errors

    [date, time, logLevel, ignore1, ignore2, ignore3, ignore4, ignore5, reqId, message=REST_CLIENT_ACCESS_LOG, responseTime, status=0, method=GET, uri]