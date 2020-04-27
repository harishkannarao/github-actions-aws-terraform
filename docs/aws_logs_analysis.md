# AWS Cloudwatch Log Analysis

Choose log group as `docker-http-app-development`

## Access Logs

All access logs

    [date, time, message=ACCESS_LOG, resTime, byte, status, ip, reqId, method, url]

Exlude `health-check` calls

    [date, time, message=ACCESS_LOG, resTime, byte, status, ip, reqId, method, url!=*health-check*]

Display only `GET` operations

    [date, time, message=ACCESS_LOG, resTime, byte, status, ip, reqId, method=*GET*, url!=*health-check*]

Display access logs with status code between `400` and `599`

    [date, time, message=ACCESS_LOG, resTime, byte, status>=400&&status<=599, ip, reqId, method, url]

Display access logs with response time greater than 2 minutes (120000 millis)

    [date, time, message=ACCESS_LOG, resTime>=120000, byte, status, ip, reqId, method, url!=*health-check*]

## Application Logs

Display only application logs

    - "ACCESS_LOG"

Display only `ERROR` level application logs

    - "ACCESS_LOG" "ERROR"

Display only `RuntimeException` application logs

    - "ACCESS_LOG" "RuntimeException"