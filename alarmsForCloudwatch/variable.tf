###### Tags variables ######
variable "tags" {
  description = "A map of tags to assign to the bucket"
  type        = map(string)
}

###### Alarms variables ######
variable "alarms" {
  description = "List of CloudWatch alarm configurations"
  type        = list(map(any))
  default     = []
}

###### SNS Topic Arn ######
variable "sns_topic_arn" {
  description = "List of SNS topic ARNs to send notifications"
  default     = []
}

###################################
########### Variables EC2 #########
###################################

# CPU Utilization
variable "cpu_utilization_threshold" {
  description = "Threshold for CPU Utilization alarm for Linux instances"
  default     = []
}

variable "cpu_utilization_period" {
  description = "Period in seconds for CPU Utilization alarm for Linux instances"
  default     = []
}

variable "cpu_utilization_evaluation_periods" {
  description = "Number of evaluation periods for CPU Utilization alarm for Linux instances"
  default     = []
}
# EBS Write IOPS
variable "ebs_write_iops_threshold" {
  description = "Threshold for EBS Write IOPS alarm for Linux instances"
  default     = []
}

variable "ebs_write_iops_period" {
  description = "Period in seconds for EBS Write IOPS alarm for Linux instances"
  default     = []
}

variable "ebs_write_iops_evaluation_period" {
  description = "Number of evaluation periods for EBS Write IOPS alarm for Linux instances"
  default     = []
}

# Network Out
variable "network_out_threshold" {
  description = "Threshold for Network Out alarm for Linux instances"
  default     = []
}

variable "network_out_period" {
  description = "Period in seconds for Network Out alarm for Linux instances"
  default     = []
}

variable "network_out_evaluation_periods" {
  description = "Number of evaluation periods for Network Out alarm for Linux instances"
  default     = []
}

# Status Check Failed
variable "status_check_failed_period" {
  description = "Period in seconds for Status Check Failed alarm for Windows instances"
  default     = []
}

variable "status_check_failed_evaluation_period" {
  description = "Number of evaluation periods for Status Check Failed alarm for Windows instances"
  default     = []
}

variable "status_check_failed_threshold" {
  description = "Threshold for Status Check Failed alarm for Windows instances"
  default     = []
}

###################################
########### Variables SQS #########
###################################

###### ApproximateAgeOfOldestMessage #######
variable "sqs_alarm_approximate_age_of_oldest_message_evaluation_periods" {
  description = "Number of evaluation periods for the SQS alarm ApproximateAgeOfOldestMessage"
  default     = []
}

variable "sqs_alarm_approximate_age_of_oldest_message_period" {
  description = "Period in seconds for the SQS alarm ApproximateAgeOfOldestMessage"
  default     = []
}

variable "sqs_alarm_approximate_age_of_oldest_message_threshold" {
  description = "Threshold for the SQS alarm ApproximateAgeOfOldestMessage in seconds"
  default     = []
}

###### ApproximateNumberOfMessagesVisible #######
variable "sqs_alarm_approximate_number_of_messages_visible_evaluation_periods" {
  description = "Number of evaluation periods for the SQS alarm ApproximateNumberOfMessagesVisible"
  default     = []
}

variable "sqs_alarm_approximate_number_of_messages_visible_period" {
  description = "Period in seconds for the SQS alarm ApproximateNumberOfMessagesVisible"
  default     = []
}

variable "sqs_alarm_approximate_number_of_messages_visible_threshold" {
  description = "Threshold for the SQS alarm ApproximateNumberOfMessagesVisible"
  default     = []
}

###### NumberOfMessagesSent #######
variable "sqs_alarm_number_of_messages_sent_evaluation_periods" {
  description = "Number of evaluation periods for the SQS alarm NumberOfMessagesSent"
  default     = []
}

variable "sqs_alarm_number_of_messages_sent_period" {
  description = "Period in seconds for the SQS alarm NumberOfMessagesSent"
  default     = []
}

variable "sqs_alarm_number_of_messages_sent_threshold" {
  description = "Threshold for the SQS alarm NumberOfMessagesSent"
  default     = []
}

###### NumberOfMessagesReceived #######
variable "sqs_alarm_number_of_messages_received_evaluation_periods" {
  description = "Number of evaluation periods for the SQS alarm NumberOfMessagesReceived"
  default     = []
}

variable "sqs_alarm_number_of_messages_received_period" {
  description = "Period in seconds for the SQS alarm NumberOfMessagesReceived"
  default     = []
}

variable "sqs_alarm_number_of_messages_received_threshold" {
  description = "Threshold for the SQS alarm NumberOfMessagesReceived"
  default     = []
}

###### NumberOfMessagesDeleted #######
variable "sqs_alarm_number_of_messages_deleted_evaluation_periods" {
  description = "Number of evaluation periods for the SQS alarm NumberOfMessagesDeleted"
  default     = []
}

variable "sqs_alarm_number_of_messages_deleted_period" {
  description = "Period in seconds for the SQS alarm NumberOfMessagesDeleted"
  default     = []
}

variable "sqs_alarm_number_of_messages_deleted_threshold" {
  description = "Threshold for the SQS alarm NumberOfMessagesDeleted"
  default     = []
}

###################################
########### Variables S3 ##########
###################################

###### S3 4xxErrors Alarm Variables #######
variable "s3_alarm_4xx_errors_evaluation_periods" {
  description = "Number of evaluation periods for the S3 4xxErrors alarm"
  default     = []
}

variable "s3_alarm_4xx_errors_period" {
  description = "Period in seconds for the S3 4xxErrors alarm"
  default     = []
}

variable "s3_alarm_4xx_errors_threshold" {
  description = "Threshold for the S3 4xxErrors alarm"
  default     = []
}

###### S3 5xxErrors Alarm Variables #######
variable "s3_alarm_5xx_errors_evaluation_periods" {
  description = "Number of evaluation periods for the S3 5xxErrors alarm"
  default     = []
}

variable "s3_alarm_5xx_errors_period" {
  description = "Period in seconds for the S3 5xxErrors alarm"
  default     = []
}

variable "s3_alarm_5xx_errors_threshold" {
  description = "Threshold for the S3 5xxErrors alarm"
  default     = []
}

###### S3 OperationsFailedReplication Alarm Variables #######
variable "s3_alarm_s3_alarm_operations_failed_replication_evaluation_periods" {
  description = "Number of evaluation periods for the S3 OperationsFailedReplication alarm"
  default     = []
}

variable "s3_alarm_s3_alarm_operations_failed_replication_period" {
  description = "Period in seconds for the S3 OperationsFailedReplication alarm"
  default     = []
}

variable "s3_alarm_s3_alarm_operations_failed_replication_threshold" {
  description = "Threshold for the S3 OperationsFailedReplication alarm"
  default     = []
}

###################################
####### DynamoDB Variables ########
###################################

# Alarm for DynamoDB Read Throttle Events
variable "read_throttle_evaluation_periods" {
  description = "Number of evaluation periods for DynamoDB Read Throttle alarm"
  default     = []
}

variable "read_throttle_period" {
  description = "Period in seconds for DynamoDB Read Throttle alarm"
  default     = []
}

variable "read_throttle_threshold" {
  description = "Threshold for DynamoDB Read Throttle alarm"
  default     = []
}

# Alarm for DynamoDB Write Throttle Events
variable "write_throttle_evaluation_periods" {
  description = "Number of evaluation periods for DynamoDB Write Throttle alarm"
  default     = []
}

variable "write_throttle_period" {
  description = "Period in seconds for DynamoDB Write Throttle alarm"
  default     = []
}

variable "write_throttle_threshold" {
  description = "Threshold for DynamoDB Write Throttle alarm"
  default     = []
}

# Alarm for DynamoDB System Errors
variable "system_errors_evaluation_periods" {
  description = "Number of evaluation periods for DynamoDB System Errors alarm"
  default     = []
}

variable "system_errors_period" {
  description = "Period in seconds for DynamoDB System Errors alarm"
  default     = []
}

variable "system_errors_threshold" {
  description = "Threshold for DynamoDB System Errors alarm"
  default     = []
}

# Alarm for DynamoDB User Errors
variable "user_errors_evaluation_periods" {
  description = "Number of evaluation periods for DynamoDB User Errors alarm"
  default     = []
}

variable "user_errors_period" {
  description = "Period in seconds for DynamoDB User Errors alarm"
  default     = []
}

variable "user_errors_threshold" {
  description = "Threshold for DynamoDB User Errors alarm"
  default     = []
}

# Alarm for DynamoDB Replication Latency
variable "replication_latency_evaluation_periods" {
  description = "Number of evaluation periods for DynamoDB Replication Latency alarm"
  default     = []
}

variable "replication_latency_period" {
  description = "Period in seconds for DynamoDB Replication Latency alarm"
  default     = []
}

variable "replication_latency_threshold" {
  description = "Threshold for DynamoDB Replication Latency alarm"
  default     = []
}

###################################
###### Cloudfront Variables #######
###################################

# 5xxErrorRate variables
variable "error_rate_5xx_evaluation_periods" {
  description = "Number of evaluation periods for the 5xxErrorRate alarm."
  default     = []
}
variable "error_rate_5xx_period" {
  description = "Time period in seconds for the 5xxErrorRate alarm."
  default     = []
}

variable "error_rate_5xx_threshold" {
  description = "Threshold for the 5xxErrorRate alarm."
  default     = []
}

# OriginLatency variables
variable "origin_latency_evaluation_periods" {
  description = "Number of evaluation periods for the OriginLatency alarm."
  default     = []
}
variable "origin_latency_period" {
  description = "Time period in seconds for the OriginLatency alarm."
  default     = []
}

variable "origin_latency_threshold" {
  description = "Threshold for the OriginLatency alarm."
  default     = []
}

# 4xxErrorRate variables
variable "error_rate_4xx_evaluation_periods" {
  description = "Number of evaluation periods for the 4xxErrorRate alarm."
  default     = []
}
variable "error_rate_4xx_period" {
  description = "Time period in seconds for the 4xxErrorRate alarm."
  default     = []
}

variable "error_rate_4xx_threshold" {
  description = "Threshold for the 4xxErrorRate alarm."
  default     = []
}

##############################
####### SNS Variables ########
##############################

# Configuração do alarme NumberOfNotificationsFailed
variable "sns_alarm_number_of_notifications_failed_evaluation_periods" {
  description = "The number of evaluation periods over which the SNS NumberOfNotificationsFailed metric is measured. This determines how many periods are used to assess if the alarm condition is met."
  default     = []
}

variable "sns_alarm_number_of_notifications_failed_period" {
  description = "The period in seconds over which the SNS NumberOfNotificationsFailed metric is collected. This defines the frequency at which the metric is aggregated for alarm evaluation."
  default     = []
}

variable "sns_alarm_number_of_notifications_failed_threshold" {
  description = "The threshold for the SNS NumberOfNotificationsFailed metric. The alarm triggers when the metric exceeds this value during the specified evaluation periods."
  default     = []
}

##############################
##### Lambda Variables #######
##############################

# Errors alarm configuration
variable "lambda_alarm_errors_evaluation_periods" {
  description = "Number of evaluation periods for the Lambda Errors alarm."
  default     = []
}

variable "lambda_alarm_errors_period" {
  description = "The period (in seconds) over which the Lambda Errors metric is evaluated."
  default     = []
}

variable "lambda_alarm_errors_threshold" {
  description = "Threshold for the number of Lambda Errors that triggers the alarm."
  default     = []
}

# Alarm Duration setting
variable "lambda_alarm_duration_evaluation_periods" {
  description = "Number of evaluation periods for the Lambda Duration alarm."
  default     = []
}

variable "lambda_alarm_duration_period" {
  description = "The period (in seconds) over which the Lambda Duration metric is evaluated."
  default     = []
}

variable "lambda_alarm_duration_threshold" {
  description = "Threshold for the duration (in milliseconds) of Lambda execution that triggers the alarm."
  default     = []
}

##############################
### API Gateway Variables ####
##############################

# Configuração do alarme 4XX Errors para API Gateway
variable "api_gateway_alarm_4xx_errors_evaluation_periods" {
  description = "Number of periods over which data is evaluated for the 4XX Errors alarm."
  default     = []
}

variable "api_gateway_alarm_4xx_errors_period" {
  description = "The time period in seconds over which the 4XX Errors metric is collected for the alarm."
  default     = []
}

variable "api_gateway_alarm_4xx_errors_threshold" {
  description = "The threshold for the 4XX Errors metric that triggers the alarm."
  default     = []
}

# Configuração do alarme 5XX Errors para API Gateway
variable "api_gateway_alarm_5xx_errors_evaluation_periods" {
  description = "Number of periods over which data is evaluated for the 5XX Errors alarm."
  default     = []
}

variable "api_gateway_alarm_5xx_errors_period" {
  description = "The time period in seconds over which the 5XX Errors metric is collected for the alarm."
  default     = []
}

variable "api_gateway_alarm_5xx_errors_threshold" {
  description = "The threshold for the 5XX Errors metric that triggers the alarm."
  default     = []
}