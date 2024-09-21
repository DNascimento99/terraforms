#!/bin/bash

# Função para formatar uma lista no estilo Terraform
format_terraform_list() {
  echo "$1" | tr '\t' '\n' | awk '{print "    \"" $1 "\","}'
}

# Lista todos os buckets S3
buckets=$(aws s3api list-buckets --query "Buckets[].Name" --output text)
bucket_list=$(format_terraform_list "$buckets")

# Lista todas as instâncias EC2
ec2_instances=$(aws ec2 describe-instances --query "Reservations[].Instances[].InstanceId" --output text)
ec2_list=$(format_terraform_list "$ec2_instances")

# Lista todos os CloudFront distributions
cloudfront_distributions=$(aws cloudfront list-distributions --query "DistributionList.Items[].Id" --output text)
cloudfront_list=$(format_terraform_list "$cloudfront_distributions")

# Lista todas as filas SQS
sqs_queues=$(aws sqs list-queues --query "QueueUrls[]" --output text | tr '\t' '\n' | awk -F'/' '{print $NF}')
sqs_list=$(format_terraform_list "$sqs_queues")

# Lista todas as tabelas DynamoDB
dynamodb_tables=$(aws dynamodb list-tables --query "TableNames" --output text )
dynamodb_list=$(format_terraform_list "$dynamodb_tables")

# Lista todos os tópicos SNS
sns_topics=$(aws sns list-topics --query "Topics[].TopicArn" --output text | tr '\t' '\n' | awk -F':' '{print $NF}')
sns_list=$(format_terraform_list "$sns_topics")

# Lista todos os APIs do API Gateway
apigateway_apis=$(aws apigateway get-rest-apis --query "items[].id" --output text)
apigateway_list=$(format_terraform_list "$apigateway_apis")

# Lista todas as funções Lambda
lambda_functions=$(aws lambda list-functions --query "Functions[].FunctionName" --output text)
lambda_list=$(format_terraform_list "$lambda_functions")

# Escreve a lista no arquivo resources.tf
cat <<EOL > locals.tf
locals {
  # Lista de recursos AWS, atualizada automaticamente
  s3_buckets_name = [
$(echo "$bucket_list" | sed '$s/,$//')
  ]

  ec2_instances_id = [
$(echo "$ec2_list" | sed '$s/,$//')
  ]

  cloudfront_distribution_ids = [
$(echo "$cloudfront_list" | sed '$s/,$//')
  ]

  sqs_queues_name = [
$(echo "$sqs_list" | sed '$s/,$//')
  ]

  dynamodb_table_names = [
$(echo "$dynamodb_list" | sed '$s/,$//')
  ]

  sns_topics_name = [
$(echo "$sns_list" | sed '$s/,$//')
  ]

  apigateway_apis_name_rest = [
$(echo "$apigateway_list" | sed '$s/,$//')
  ]

  lambda_functions_name = [
$(echo "$lambda_list" | sed '$s/,$//')
  ]
}
EOL