# Subscribe an email to alarm's notifications

## Subscribe an email to SNS topic

#### Get topic arn

    snsTopicArn=$(aws s3api get-object --bucket "github-actions-ci" --key "terraform-development.tfstate" /dev/stdout | jq -r '.outputs["alarm_topic_arn"].value' | grep -E '\S' | grep -v 'null')

    echo $snsTopicArn

#### List existing subscriptions for this topic

    aws sns list-subscriptions-by-topic --topic-arn "$snsTopicArn" --no-paginate

#### Subscribe an email

    aws sns subscribe --topic-arn "$snsTopicArn" --protocol email --notification-endpoint your_email@example.com

Note: **Confirm the subscription by validating the link sent to the email**

## Unsubscribe an email from SNS topic

#### Get the subscription arn by email

    subscriptionArn=$(aws sns list-subscriptions-by-topic --topic-arn "$snsTopicArn" --no-paginate --output text | grep 'your_email@example.com' | cut -f 5)

    echo $subscriptionArn

#### Unsubscribe the arn

    aws sns unsubscribe --subscription-arn $subscriptionArn