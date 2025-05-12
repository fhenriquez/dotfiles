cite about-alias
about-alias 'custom aliases'

#alias aws-show-instance=aws ec2 describe-instances --region us-east-1 --filters Name=tag:Name,Values=wub* --query 'Reservations[].Instances[].[InstanceId,PublicDnsName,State.Name,InstanceType,join(`,`,Tags[?Key==`Name`].Value)]' --output table
