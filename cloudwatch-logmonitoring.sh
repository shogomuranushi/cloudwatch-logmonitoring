#!/bin/sh -v

# retrieve ec2 intance id
InstanceId=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)
Region=$(curl -s http://169.254.169.254/latest/meta-data/local-hostname | cut -d '.' -f2)
TimeStamp=$(date -u +%Y-%m-%dT%H:%M:%S.000Z)

# variable
NameSpace=$1
MetricName=$2
LogFile=$3
TargetText="$4"

Wc=$(grep "${TargetText}" ${LogFile} |wc -l)

# publish metrics to CloudWatch
aws cloudwatch put-metric-data --region ${Region} --output json --dimensions InstanceId=${InstanceId} --timestamp ${TimeStamp} --namespace ${NameSpace} --metric-name ${MetricName}  --value ${Wc} --unit Count
