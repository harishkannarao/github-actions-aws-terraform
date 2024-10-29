# Temporary addtion of ingress rule for bastion

## Get the group-id for bastion

    aws ec2 describe-security-groups --output text --query "SecurityGroups[*].[GroupId]" --filters Name=group-name,Values=bastion-development-sg

## List the current rules for bastion

    aws ec2 describe-security-group-rules --filters Name="group-id",Values="{group-id}"

## Add ingress rule for bastion

    aws ec2 authorize-security-group-ingress --group-id {group-id} --protocol '-1' --port 0 --cidr '{ip-to-add}/32'

## Remove ingress rule for bastion

Get the `security-group-rule-id` for the added `ip` address using

    aws ec2 describe-security-group-rules --filters Name="group-id",Values="{group-id}"

Remove the rule by `security-group-rule-id`

    aws ec2 revoke-security-group-ingress --group-id {group-id} --security-group-rule-ids {security-group-rule-id}
