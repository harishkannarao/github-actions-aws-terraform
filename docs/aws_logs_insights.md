# AWS Cloudwatch Log Insights

Choose log group as `docker-http-app-development`

### All Application Logs

    fields @timestamp, @message
    | filter @message not like /ACCESS_LOG/
    | sort @timestamp desc
    | display @message

### All Access Logs

    fields @timestamp, @message
    | filter @message like /ACCESS_LOG/
    | sort @timestamp desc
    | display @message

### All Access Logs (without health checks)

    fields @timestamp, @message
    | filter @message like /ACCESS_LOG/
    | parse '* * * * * * * * * *' as date, time, message, resTime, byte, status, ip, reqId, method, url
    | filter url not like /\/health-check/
    | sort @timestamp desc
    | display @message

### Total requests

    fields @timestamp, @message
    | filter @message like /ACCESS_LOG/
    | parse '* * * * * * * * * *' as date, time, message, resTime, byte, status, ip, reqId, method, url
    | filter url not like /\/health-check/
    | stats count(@message)

### Generate graph of total requests per minute

    fields @timestamp, @message
    | filter @message like /ACCESS_LOG/
    | parse '* * * * * * * * * *' as date, time, message, resTime, byte, status, ip, reqId, method, url
    | filter url not like /\/health-check/
    | stats count(@message) by bin(60s)

### Generate graph of response time per minute

    fields @timestamp, @message
    | filter @message like /ACCESS_LOG/
    | parse '* * * * * * * * * *' as date, time, message, resTime, byte, status, ip, reqId, method, url
    | filter url not like /\/health-check/
    | stats avg(resTime) as avg, pct(resTime, 95) as pct95 by bin(60s)

### Generate data table of requests grouped by status code

    fields @timestamp, @message
    | filter @message like /ACCESS_LOG/
    | parse '* * * * * * * * * *' as date, time, message, resTime, byte, status, ip, reqId, method, url
    | filter url not like /\/health-check/
    | stats count(@message) as statusCount by status
    | sort statusCount desc

### Filter client and server errors

    fields @timestamp, @message
    | filter @message like /ACCESS_LOG/
    | parse '* * * * * * * * * *' as date, time, message, resTime, byte, status, ip, reqId, method, url
    | filter url not like /\/health-check/
    | filter status like /[4-5]../
    | sort @timestamp desc
    | display @message

### Filter success requests

    fields @timestamp, @message
    | filter @message like /ACCESS_LOG/
    | parse '* * * * * * * * * *' as date, time, message, resTime, byte, status, ip, reqId, method, url
    | filter url not like /\/health-check/
    | filter status like /[2-3]../
    | sort @timestamp desc
    | display @message

### Filter requests with response time greater than 2 minutes (120000 millis)

    fields @timestamp, @message
    | filter @message like /ACCESS_LOG/
    | parse '* * * * * * * * * *' as date, time, message, resTime, byte, status, ip, reqId, method, url
    | filter url not like /\/health-check/
    | filter (resTime>=6000)
    | sort @timestamp desc
    | display @message

### Filter requests with specific status code

    fields @timestamp, @message
    | filter @message like /ACCESS_LOG/
    | parse '* * * * * * * * * *' as date, time, message, resTime, byte, status, ip, reqId, method, url
    | filter url not like /\/health-check/
    | filter status in [400,401,404]
    | sort @timestamp desc
    | display @message


    fields @timestamp, @message
    | filter @message like /ACCESS_LOG/
    | parse '* * * * * * * * * *' as date, time, message, resTime, byte, status, ip, reqId, method, url
    | filter url not like /\/health-check/
    | filter status not in [200,204]
    | sort @timestamp desc
    | display @message