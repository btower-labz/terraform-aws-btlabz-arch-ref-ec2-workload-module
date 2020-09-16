# Terraform inputs and outputs.

## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |
| random | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| ami | Workload AMI identifier | `string` | `""` | no |
| hostnames | Hostnames to add to rules. Default is \* | `list` | `[]` | no |
| instance\_type | n/a | `string` | `"t3.nano"` | no |
| lb\_listener\_arn | ALB listener ARN to bind all the rules | `string` | n/a | yes |
| name | Name prefix to tag workload objects | `string` | `""` | no |
| security\_groups | Additional security groups for the workload | `list` | `[]` | no |
| subnets | Subnets list. Any change here may cause EC2 instances recreation | `list` | n/a | yes |
| tags | Additional tags. E.g. environment, backup tags etc | `map` | `{}` | no |
| workload\_egress\_cidr | n/a | `list` | <pre>[<br>  "0.0.0.0/0"<br>]</pre> | no |
| workload\_ingress\_cidr | n/a | `list` | `[]` | no |
| workload\_ingress\_sgs | n/a | `list` | `[]` | no |
| zone\_id | R53 zone identifier to use for records | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| latest\_ami | The latest AMI |
| server\_a\_fqdn | n/a |
| server\_b\_fqdn | n/a |
| tg\_service1\_arn | n/a |
| tg\_service2\_arn | n/a |
| tg\_service3\_arn | n/a |

