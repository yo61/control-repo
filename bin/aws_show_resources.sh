#!/bin/bash

if [ ! -z $1 ]; then
  region=$1
else
  region='us-east-1 us-west-1 us-west-2 eu-west-1 eu-central-1 ap-south-1 ap-northeast-1 ap-northeast-2 ap-southeast-1 ap-southeast-2 sa-east-1'
fi

for reg in $region; do 

  export AWS_REGION=$reg

  resources="ec2_autoscalinggroup ec2_elastic_ip ec2_instance ec2_launchconfiguration ec2_scalingpolicy ec2_securitygroup ec2_vpc ec2_vpc_customer_gateway ec2_vpc_dhcp_options ec2_vpc_internet_gateway ec2_vpc_routetable ec2_vpc_subnet ec2_vpc_vpn ec2_vpc_vpn_gateway elb_loadbalancer rds_instance rds_db_securitygroup rds_db_parameter_group"
  global_resources="route53_a_record route53_aaaa_record route53_cname_record route53_mx_record route53_ns_record route53_ptr_record route53_spf_record route53_srv_record route53_txt_record route53_zone"

  echo
  echo "### Current region: $reg"
  echo

  for res in $resources; do
    echo "# puppet resource $res"
    puppet resource $res
    echo
  done

done

echo "### Global resources"
for res in $global_resources; do
    echo "# puppet resource $res"
    puppet resource $res
    echo
done
