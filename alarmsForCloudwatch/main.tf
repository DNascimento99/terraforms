module "cloudwatch_alarms" {
  source = "../../modules/alarms"

  alarms = merge(
                                #############################
                                ########## EC2 ##############
                                #############################

    #Alarms for Ec2 - CPU Utilization
    { for instance_id in local.ec2_instances_id : "Alarms-Resources[EC2][${instance_id}] - CPUUtilization" => {
        alarm_name          = "Alarms-Resources[EC2][${instance_id}] - CPUUtilization"
        comparison_operator = "GreaterThanThreshold"
        evaluation_periods  = var.cpu_utilization_evaluation_periods
        metric_name         = "CPUUtilization"
        namespace           = "AWS/EC2"
        period              = var.cpu_utilization_period
        statistic           = "Average"
        threshold           = var.cpu_utilization_threshold
        alarm_description   = "CPUUtilization is greater than ${var.cpu_utilization_threshold}% on instance ${instance_id}"
        alarm_actions       = [var.sns_topic_arn]
        dimensions = {
          InstanceId = instance_id
        }
      }
    },

    #Alarms for Ec2 - EBS Wrire IOPS
    { for instance_id in local.ec2_instances_id : "Alarms-Resources[EC2][${instance_id}] - EBSWriteIOPS" => {
        alarm_name          = "Alarms-Resources[EC2][${instance_id}] - EBSWriteIOPS"
        comparison_operator = "GreaterThanThreshold"
        evaluation_periods  = var.ebs_write_iops_evaluation_period
        metric_name         = "EBSWriteOps"
        namespace           = "AWS/EC2"
        period              = var.ebs_write_iops_period
        statistic           = "Average"
        threshold           = var.ebs_write_iops_threshold
        alarm_description   = "EBSWriteIOPS is greater than ${var.ebs_write_iops_threshold} on instance ${instance_id}"
        alarm_actions       = [var.sns_topic_arn]
        dimensions = {
          InstanceId = instance_id
        }
      }
    },

    #Alarms for Ec2 - Network Out
    { for instance_id in local.ec2_instances_id : "Alarms-Resources[EC2][${instance_id}] - NetworkOut" => {
        alarm_name          = "Alarms-Resources[EC2][${instance_id}] - NetworkOu"
        comparison_operator = "GreaterThanThreshold"
        evaluation_periods  = var.network_out_evaluation_periods
        metric_name         = "NetworkOut"
        namespace           = "AWS/EC2"
        period              = var.network_out_period
        statistic           = "Average"
        threshold           = var.network_out_threshold
        alarm_description   = "NetworkOut is greater than ${var.network_out_threshold} bytes on instance ${instance_id}"
        alarm_actions       = [var.sns_topic_arn]
        dimensions = {
          InstanceId = instance_id
        }
      }
    },
    
    # Alarmes for Ec2 - Status Check Failed
    { for instance_id in local.ec2_instances_id : "Alarms-Resources[EC2][${instance_id}] - StatusCheckFailed" => {
        alarm_name          = "Alarms-Resources[EC2][${instance_id}] - StatusCheckFailed"
        comparison_operator = "GreaterThanThreshold"
        evaluation_periods  = var.status_check_failed_evaluation_period
        metric_name         = "StatusCheckFailed"
        namespace           = "AWS/EC2"
        period              = var.status_check_failed_period
        statistic           = "Minimum"
        threshold           = var.status_check_failed_threshold
        alarm_description   = "StatusCheckFailed is greater than 0 on instance ${instance_id}"
        alarm_actions       = [var.sns_topic_arn]
        dimensions = {
          InstanceId = instance_id
        }
      }
    },

                                #############################
                                ###########  S3  ############
                                #############################
                                
    # Alarmes for S3 - Error 4xx Rate
    { for bucket in local.s3_buckets_name : "Alarms-Resources[S3][${bucket}] - S3-4xxErrorRate" => {
        alarm_name          = "Alarms-Resources[S3][${bucket}] - S3-4xxErrorRate"
        comparison_operator = "GreaterThanOrEqualToThreshold"
        evaluation_periods  = var.s3_alarm_4xx_errors_evaluation_periods
        metric_name         = "4xxErrors"
        namespace           = "AWS/S3"
        period              = var.s3_alarm_4xx_errors_period
        statistic           = "Sum"
        threshold           = var.s3_alarm_4xx_errors_threshold
        alarm_description   = "High rate of 4xx errors on S3 bucket ${bucket}"
        alarm_actions       = [var.sns_topic_arn]
        treat_missing_data  = "notBreaching"
        dimensions = {
          BucketName = bucket
          FilterId   = "EntireBucket"
        }
      }
    },

    # Alarmes for S3 - Error 5xx Rate
    { for bucket in local.s3_buckets_name : "Alarms-Resources[S3][${bucket}] - S3-5xxErrorRate" => {
        alarm_name          = "Alarms-Resources[S3][${bucket}] - S3-5xxErrorRate"
        comparison_operator = "GreaterThanOrEqualToThreshold"
        evaluation_periods  = var.s3_alarm_5xx_errors_evaluation_periods
        metric_name         = "5xxErrors"
        namespace           = "AWS/S3"
        period              = var.s3_alarm_5xx_errors_period
        statistic           = "Sum"
        threshold           = var.s3_alarm_5xx_errors_threshold
        alarm_description   = "High rate of 5xx errors on S3 bucket ${bucket}"
        alarm_actions       = [var.sns_topic_arn]
        treat_missing_data  = "notBreaching"
        dimensions = {
          BucketName = bucket
          FilterId   = "EntireBucket"
        }
      }
    },

    # Alarmes for S3 - Operations Failed Replication
    { for bucket in local.s3_buckets_name : "Alarms-Resources[S3][${bucket}] - S3-OperationsFailedReplication" => {
        alarm_name          = "Alarms-Resources[S3][${bucket}] - S3-OperationsFailedReplication"
        comparison_operator = "GreaterThanThreshold"
        evaluation_periods  = var.s3_alarm_s3_alarm_operations_failed_replication_evaluation_periods
        metric_name         = "OperationsFailedReplication"
        namespace           = "AWS/S3"
        period              = var.s3_alarm_s3_alarm_operations_failed_replication_period
        statistic           = "Maximum"
        threshold           = var.s3_alarm_s3_alarm_operations_failed_replication_threshold
        alarm_description   = "This metric tracks the status of new objects replicated using S3 CRR or S3 SRR and also tracks existing objects replicated using S3 batch replication"
        alarm_actions       = [var.sns_topic_arn]
        treat_missing_data  = "notBreaching"
        dimensions = {
          BucketName = bucket
          FilterId   = "EntireBucket"
        }
      }
    },

                                    ##############################
                                    ######### Dynamo DB ##########
                                    ##############################

    # Alarm for DynamoDB Read Throttle Events
    { for table_name in local.dynamodb_table_names : "Alarms-Resources[DynamoDB][${table_name}] - ReadThrottleEvents" => {
        alarm_name          = "Alarms-Resources[DynamoDB][${table_name}] - ReadThrottleEvents"
        comparison_operator = "GreaterThanThreshold"
        evaluation_periods  = var.read_throttle_evaluation_periods
        metric_name         = "ReadThrottleEvents"
        namespace           = "AWS/DynamoDB"
        period              = var.read_throttle_period
        statistic           = "Sum"
        threshold           = var.read_throttle_threshold
        alarm_description   = "This alarm monitors read throttle events."
        alarm_actions       = [var.sns_topic_arn]
        dimensions = {
          TableName = table_name
        }
      }
    },

    # Alarm for DynamoDB Write Throttle Events
    { for table_name in local.dynamodb_table_names : "Alarms-Resources[DynamoDB][${table_name}] - WriteThrottleEvents" => {
        alarm_name          = "Alarms-Resources[DynamoDB][${table_name}] - WriteThrottleEvent"
        comparison_operator = "GreaterThanThreshold"
        evaluation_periods  = var.write_throttle_evaluation_periods
        metric_name         = "WriteThrottleEvents"
        namespace           = "AWS/DynamoDB"
        period              = var.write_throttle_period
        statistic           = "Sum"
        threshold           = var.write_throttle_threshold
        alarm_description   = "This alarm monitors write throttle events."
        alarm_actions       = [var.sns_topic_arn]
        dimensions = {
          TableName = table_name
        }
      }
    },

    # Alarm for DynamoDB System Errors
    { for table_name in local.dynamodb_table_names : "Alarms-Resources[DynamoDB][${table_name}] - SystemErrors" => {
        alarm_name          = "Alarms-Resources[DynamoDB][${table_name}] - SystemErrors"
        comparison_operator = "GreaterThanThreshold"
        evaluation_periods  = var.system_errors_evaluation_periods
        metric_name         = "SystemErrors"
        namespace           = "AWS/DynamoDB"
        period              = var.system_errors_period
        statistic           = "Sum"
        threshold           = var.system_errors_threshold
        alarm_description   = "This alarm monitors system errors in DynamoDB."
        alarm_actions       = [var.sns_topic_arn]
        dimensions = {
          TableName = table_name
        }
      }
    },

   # Alarm for DynamoDB User Errors
    { for table_name in local.dynamodb_table_names : "Alarms-Resources[DynamoDB][${table_name}] - UserErrors" => {
        alarm_name          = "Alarms-Resources[DynamoDB][${table_name}] - UserErrors"
        comparison_operator = "GreaterThanThreshold"
        evaluation_periods  = var.user_errors_evaluation_periods
        metric_name         = "UserErrors"
        namespace           = "AWS/DynamoDB"
        period              = var.user_errors_period
        statistic           = "Sum"
        threshold           = var.user_errors_threshold
        alarm_description   = "This alarm monitors user errors in DynamoDB."
        alarm_actions       = [var.sns_topic_arn]
        dimensions = {
          TableName = table_name
        }
      }
    },

    # Alarm for DynamoDB Replication Latency
    { for table_name in local.dynamodb_table_names : "Alarms-Resources[DynamoDB][${table_name}] - ReplicationLatency" => {
        alarm_name          = "Alarms-Resources[DynamoDB][${table_name}] - ReplicationLatency"
        comparison_operator = "GreaterThanThreshold"
        evaluation_periods  = var.replication_latency_evaluation_periods
        metric_name         = "ReplicationLatency"
        namespace           = "AWS/DynamoDB"
        period              = var.replication_latency_period
        statistic           = "Average"
        threshold           = var.replication_latency_threshold
        alarm_description   = "This alarm monitors replication latency in DynamoDB global tables."
        alarm_actions       = [var.sns_topic_arn]
        dimensions = {
          TableName = table_name
        }
      }
    },

                                #############################
                                ###########  SQS  ###########
                                #############################
    # Alarm for SQS Approximate Age Of Oldest Message
    { for queue in local.sqs_queues_name : "Alarms-Resources[SQS][${queue}] - ApproximateAgeOfOldestMessage" => {
        alarm_name          = "Alarms-Resources[SQS][${queue}] - ApproximateAgeOfOldestMessage"
        comparison_operator = "GreaterThanThreshold"
        evaluation_periods  = var.sqs_alarm_approximate_age_of_oldest_message_evaluation_periods
        metric_name         = "ApproximateAgeOfOldestMessage"
        namespace           = "AWS/SQS"
        period              = var.sqs_alarm_approximate_age_of_oldest_message_period
        statistic           = "Maximum"
        threshold           = var.sqs_alarm_approximate_age_of_oldest_message_threshold
        alarm_description   = "Alert when the age of the oldest message in the SQS queue ${queue} exceeds the limit."
        alarm_actions       = [var.sns_topic_arn]
        dimensions = {
          QueueName = queue
        }
      }
    },

    # Alarm for SQS Approximate Number Of Messages Visible
    { for queue in local.sqs_queues_name : "Alarms-Resources[SQS][${queue}] - ApproximateNumberOfMessagesVisible" => {
        alarm_name          = "Alarms-Resources[SQS][${queue}] - ApproximateNumberOfMessagesVisible"
        comparison_operator = "GreaterThanThreshold"
        evaluation_periods  = var.sqs_alarm_approximate_number_of_messages_visible_evaluation_periods
        metric_name         = "ApproximateNumberOfMessagesVisible"
        namespace           = "AWS/SQS"
        period              = var.sqs_alarm_approximate_number_of_messages_visible_period
        statistic           = "Maximum"
        threshold           = var.sqs_alarm_approximate_number_of_messages_visible_threshold
        alarm_description   = "Alert when the number of messages visible in the SQS queue ${queue} exceeds the limit."
        alarm_actions       = [var.sns_topic_arn]
        dimensions = {
          QueueName = queue
        }
      }
    },

    # Alarm for SQS Of Messages Sent
    { for queue in local.sqs_queues_name : "Alarms-Resources[SQS][${queue}] - NumberOfMessagesSent" => {
        alarm_name          = "Alarms-Resources[SQS][${queue}] - NumberOfMessagesSent"
        comparison_operator = "GreaterThanThreshold"
        evaluation_periods  = var.sqs_alarm_number_of_messages_sent_evaluation_periods
        metric_name         = "NumberOfMessagesSent"
        namespace           = "AWS/SQS"
        period              = var.sqs_alarm_number_of_messages_sent_period
        statistic           = "Sum"
        threshold           = var.sqs_alarm_number_of_messages_sent_threshold
        alarm_description   = "Alert when the number of messages sent to the SQS queue ${queue} exceeds the limit."
        alarm_actions       = [var.sns_topic_arn]
        dimensions = {
          QueueName = queue
        }
      }
    },

    # Alarm for SQS Of Messages Received
    { for queue in local.sqs_queues_name : "Alarms-Resources[SQS][${queue}] - NumberOfMessagesReceived" => {
        alarm_name          = "Alarms-Resources[SQS][${queue}] - NumberOfMessagesReceived"
        comparison_operator = "LessThanThreshold"
        evaluation_periods  = var.sqs_alarm_number_of_messages_received_evaluation_periods
        metric_name         = "NumberOfMessagesReceived"
        namespace           = "AWS/SQS"
        period              = var.sqs_alarm_number_of_messages_received_period
        statistic           = "Sum"
        threshold           = var.sqs_alarm_number_of_messages_received_threshold
        alarm_description   = "Alert when the number of messages received from the SQS queue ${queue} falls below the threshold."
        alarm_actions       = [var.sns_topic_arn]
        dimensions = {
          QueueName = queue
        }
      }
    },

    # Alarm for SQS Of Messages Deleted
    { for queue in local.sqs_queues_name : "Alarms-Resources[SQS][${queue}] - NumberOfMessagesDeleted" => {
        alarm_name          = "Alarms-Resources[SQS][${queue}] - NumberOfMessagesDeleted"
        comparison_operator = "LessThanThreshold"
        evaluation_periods  = var.sqs_alarm_number_of_messages_deleted_evaluation_periods
        metric_name         = "NumberOfMessagesDeleted"
        namespace           = "AWS/SQS"
        period              = var.sqs_alarm_number_of_messages_deleted_period
        statistic           = "Sum"
        threshold           = var.sqs_alarm_number_of_messages_deleted_threshold
        alarm_description   = "Alert when the number of messages deleted from the SQS queue ${queue} falls below the threshold."
        alarm_actions       = [var.sns_topic_arn]
        dimensions = {
          QueueName = queue
        }
      }
    },
                                #############################
                                ########## CloudFront #######
                                #############################

    # Alarm for Cloudfront 5xx Error Rate
    { for distribution_id in local.cloudfront_distribution_ids : "Alarms-Resources[CloudFront][${distribution_id}] - 5xxErrorRate" => {
        alarm_name          = "Alarms-Resources[CloudFront][${distribution_id}] - 5xxErrorRate"
        comparison_operator = "GreaterThanThreshold"
        evaluation_periods  = var.error_rate_5xx_evaluation_periods
        metric_name         = "5xxErrorRate"
        namespace           = "AWS/CloudFront"
        period              = var.error_rate_5xx_period
        statistic           = "Average"
        threshold           = var.error_rate_5xx_threshold
        alarm_description   = "Alert when 5xx error rate for CloudFront distribution ${distribution_id} exceeds threshold."
        alarm_actions       = [var.sns_topic_arn]
        dimensions = {
          DistributionId = distribution_id
          Region         = "Global"
        }
      }
    },

    # Alarm for Cloudfront Origin latency
    { for distribution_id in local.cloudfront_distribution_ids : "Alarms-Resources[CloudFront][${distribution_id}] - Originlatency" => {
        alarm_name          = "Alarms-Resources[CloudFront][${distribution_id}] - Originlatency"
        comparison_operator = "GreaterThanThreshold"
        evaluation_periods  = var.origin_latency_evaluation_periods
        metric_name         = "OriginLatency"
        namespace           = "AWS/CloudFront"
        period              = var.origin_latency_period
        extended_statistic  = "p90"
        threshold           = var.origin_latency_threshold
        alarm_description   = "Alert when origin latency for CloudFront distribution ${distribution_id} exceeds threshold."
        alarm_actions       = [var.sns_topic_arn]
        dimensions = {
          DistributionId = distribution_id
          Region         = "Global"
        }
      }
    },

    # Alarm for Cloudfront 5xx Error Rate
    { for distribution_id in local.cloudfront_distribution_ids : "Alarms-Resources[CloudFront][${distribution_id}] - 4xx_error_rate" => {
        alarm_name          = "Alarms-Resources[CloudFront][${distribution_id}] - 4xx_error_rate"
        comparison_operator = "GreaterThanThreshold"
        evaluation_periods  = var.error_rate_4xx_evaluation_periods
        metric_name         = "4xxErrorRate"
        namespace           = "AWS/CloudFront"
        period              = var.error_rate_4xx_period
        statistic           = "Average"
        threshold           = var.error_rate_4xx_threshold
        alarm_description   = "Alert when 4xx error rate for CloudFront distribution ${distribution_id} exceeds threshold."
        alarm_actions       = [var.sns_topic_arn]
        dimensions = {
          DistributionId = distribution_id
          Region         = "Global"
        }
      }
    },

                                #############################
                                ############ SNS ############
                                ############################# 
                                  
    # Alarm for SNS Reputation Complaint Rate
    { 
      for sns_name in local.sns_topics_name : "Alarms-Resources[SNS] - ReputationComplaintRate[${sns_name}]" => {
        alarm_name          = "Alarms-Resources[SNS] - ReputationComplaintRate[${sns_name}]"
        comparison_operator = "GreaterThanThreshold"
        evaluation_periods  = var.sns_alarm_number_of_notifications_failed_evaluation_periods
        metric_name         = "NumberOfNotificationsFailed"
        namespace           = "AWS/SNS"
        period              = var.sns_alarm_number_of_notifications_failed_period
        statistic           = "Sum"
        threshold           = var.sns_alarm_number_of_notifications_failed_threshold
        alarm_description   = "Monitor SNS - Number of Notifications Failed for ${sns_name}."
        alarm_actions       = [var.sns_topic_arn]
        dimensions = {
          ConfigurationSetName = sns_name
        }
      }
    },
                                #############################
                                ########## Lambda ###########
                                #############################

    # Alarm for Lambda Errors
    {
      for lambda_func in local.lambda_functions_name  : "Alarms-Resources[LambdaAlert][${lambda_func}] - Errors" => {
        alarm_name          = "Alarms-Resources[LambdaAlert][${lambda_func}] - Errors"
        comparison_operator = "GreaterThanThreshold"
        evaluation_periods  = var.lambda_alarm_errors_evaluation_periods
        metric_name         = "Errors"
        namespace           = "AWS/Lambda"
        period              = var.lambda_alarm_errors_period
        statistic           = "Sum"
        threshold           = var.lambda_alarm_errors_threshold
        alarm_description   = "Monitor Lambda function errors exceeding threshold for function ${lambda_func}."
        alarm_actions       = [var.sns_topic_arn]
        dimensions = {
          FunctionName = lambda_func
        }
      }
    },
    
    # Alarm for Lambda Duration
    {
      for lambda_func in local.lambda_functions_name  : "Alarms-Resources[LambdaAlert][${lambda_func}] - Duration" => {
        alarm_name          = "Alarms-Resources[LambdaAlert][${lambda_func}] - Duration"
        comparison_operator = "GreaterThanThreshold"
        evaluation_periods  = var.lambda_alarm_duration_evaluation_periods
        metric_name         = "Duration"
        namespace           = "AWS/Lambda"
        period              = var.lambda_alarm_duration_period
        statistic           = "Average"
        threshold           = var.lambda_alarm_duration_threshold
        alarm_description   = "Monitor Lambda function duration exceeding threshold for function ${lambda_func}."
        alarm_actions       = [var.sns_topic_arn]
        dimensions = {
          FunctionName = lambda_func
        }
      }
    },
                                #############################
                                ######## API Gateway ########
                                #############################

    # Alarm for API Gateway REST 4XX Errors
    {
      for api in local.apigateway_apis_name_rest : "Alarms-Resources[ApiGatewayAlert][${api}] - 4XXErrors" => {
        alarm_name          = "Alarms-Resources[ApiGatewayAlert][${api}] - 4XXErrors"
        comparison_operator = "GreaterThanThreshold"
        evaluation_periods  = var.api_gateway_alarm_4xx_errors_evaluation_periods
        metric_name         = "4XXError"
        namespace           = "AWS/ApiGateway"
        period              = var.api_gateway_alarm_4xx_errors_period
        statistic           = "Average"
        threshold           = var.api_gateway_alarm_4xx_errors_threshold
        alarm_description   = "Monitor API Gateway - 4XX Errors for API ${api}."
        alarm_actions       = [var.sns_topic_arn]
        dimensions = {
          ApiName = api
        }
      }
    },

    # Alarm for API Gateway REST 5XX Errors
    {
      for api in local.apigateway_apis_name_rest : "Alarms-Resources[ApiGatewayAlert][${api}] - 5XXErrors" => {
        alarm_name          = "Alarms-Resources[ApiGatewayAlert][${api}] - 5XXErrors"
        comparison_operator = "GreaterThanThreshold"
        evaluation_periods  = var.api_gateway_alarm_5xx_errors_evaluation_periods
        metric_name         = "5XXError"
        namespace           = "AWS/ApiGateway"
        period              = var.api_gateway_alarm_5xx_errors_period
        statistic           = "Average"
        threshold           = var.api_gateway_alarm_5xx_errors_threshold
        alarm_description   = "Monitor API Gateway - 5XX Errors for API ${api}."
        alarm_actions       = [var.sns_topic_arn]
        dimensions = {
          ApiName = api
        }
      }
    },
    # Alarm for API Gateway 4XX HTTP Errors
    {
      for api in local.apigateway_apis_name_http : "Alarms-Resources[ApiGatewayAlert][${api}] - 4XXErrors" => {
        alarm_name          = "Alarms-Resources[ApiGatewayAlert][${api}] - 4XXErrors"
        comparison_operator = "GreaterThanThreshold"
        evaluation_periods  = var.api_gateway_alarm_4xx_errors_evaluation_periods
        metric_name         = "4XXError"
        namespace           = "AWS/ApiGateway"
        period              = var.api_gateway_alarm_4xx_errors_period
        statistic           = "Average"
        threshold           = var.api_gateway_alarm_4xx_errors_threshold
        alarm_description   = "Monitor API Gateway - 4XX Errors for API ${api}."
        alarm_actions       = [var.sns_topic_arn]
        dimensions = {
          ApiName = api
        }
      }
    },

    # Alarm for API Gateway HTTP 5XX Errors
    {
      for api in local.apigateway_apis_name_http : "Alarms-Resources[ApiGatewayAlert][${api}] - 5XXErrors" => {
        alarm_name          = "Alarms-Resources[ApiGatewayAlert][${api}] - 5XXErrors"
        comparison_operator = "GreaterThanThreshold"
        evaluation_periods  = var.api_gateway_alarm_5xx_errors_evaluation_periods
        metric_name         = "5XXError"
        namespace           = "AWS/ApiGateway"
        period              = var.api_gateway_alarm_5xx_errors_period
        statistic           = "Average"
        threshold           = var.api_gateway_alarm_5xx_errors_threshold
        alarm_description   = "Monitor API Gateway - 5XX Errors for API ${api}."
        alarm_actions       = [var.sns_topic_arn]
        dimensions = {
          ApiName = api
        }
      }
    }
  )
}