##### SNS ARN ######
sns_topic_arn = ""


##### Tags List #####
tags = {
  Terraform   = "true"
  Environment = ""
}

###################################
############## EC2 ################
###################################

# CPU Utilization Alarms
cpu_utilization_threshold          = 90 # CPU utilization exceeds this percentage
cpu_utilization_period             = 60 # Period in seconds for CPU utilization monitoring
cpu_utilization_evaluation_periods = 15 # Number of evaluation periods for the CPU utilization alarm

# EBS Write IOPS Alarms
ebs_write_iops_threshold         = 250 # EBS Write IOPS exceeds this threshold
ebs_write_iops_period            = 900 # Period in seconds for EBS Write IOPS monitoring
ebs_write_iops_evaluation_period = 1   # Number of evaluation periods for the EBS Write IOPS alarm

# Network Out Alarms
network_out_threshold          = 300000000   # Network Out exceeds this number of bytes
network_out_period             = 60          # Period in seconds for Network Out monitoring
network_out_evaluation_periods = 1           # Number of evaluation periods for the Network Out alarm

# Status Check Failed Alarms
status_check_failed_period            = 600 # Period in seconds for Status Check Failed monitoring
status_check_failed_evaluation_period = 1   # Number of evaluation periods for the Status Check Failed alarm
status_check_failed_threshold         = 1   # Status Check Failed exceeds this threshold

###################################
############## SQS ################
###################################

# ApproximateAgeOfOldestMessage Alarm
sqs_alarm_approximate_age_of_oldest_message_evaluation_periods = 1   # Number of evaluation periods
sqs_alarm_approximate_age_of_oldest_message_period             = 300 # Period in seconds for ApproximateAgeOfOldestMessage monitoring
sqs_alarm_approximate_age_of_oldest_message_threshold          = 300 # Threshold for ApproximateAgeOfOldestMessage alarm

# ApproximateNumberOfMessagesVisible Alarm
sqs_alarm_approximate_number_of_messages_visible_evaluation_periods = 1   # Number of evaluation periods
sqs_alarm_approximate_number_of_messages_visible_period             = 300 # Period in seconds for ApproximateNumberOfMessagesVisible monitoring
sqs_alarm_approximate_number_of_messages_visible_threshold          = 100 # Threshold for ApproximateNumberOfMessagesVisible alarm

# NumberOfMessagesSent Alarm
sqs_alarm_number_of_messages_sent_evaluation_periods = 1    # Number of evaluation periods
sqs_alarm_number_of_messages_sent_period             = 300  # Period in seconds for NumberOfMessagesSent monitoring
sqs_alarm_number_of_messages_sent_threshold          = 1000 # Threshold for NumberOfMessagesSent alarm

# NumberOfMessagesReceived Alarm
sqs_alarm_number_of_messages_received_evaluation_periods = 1   # Number of evaluation periods
sqs_alarm_number_of_messages_received_period             = 300 # Period in seconds for NumberOfMessagesReceived monitoring
sqs_alarm_number_of_messages_received_threshold          = 0   # Threshold for NumberOfMessagesReceived alarm

# NumberOfMessagesDeleted Alarm
sqs_alarm_number_of_messages_deleted_evaluation_periods = 1   # Number of evaluation periods
sqs_alarm_number_of_messages_deleted_period             = 300 # Period in seconds for NumberOfMessagesDeleted monitoring
sqs_alarm_number_of_messages_deleted_threshold          = 0   # Threshold for NumberOfMessagesDeleted alarm

###################################
############### S3 ################
###################################

###### S3 4xxErrors Alarm Variables #######
s3_alarm_4xx_errors_evaluation_periods = 15   # Number of evaluation periods for 4xx Errors
s3_alarm_4xx_errors_period             = 60   # Period in seconds for 4xx Errors monitoring
s3_alarm_4xx_errors_threshold          = 0.05 # Threshold for 4xx Errors alarm

###### S3 5xxErrors Alarm Variables ######
s3_alarm_5xx_errors_evaluation_periods = 15   # Number of evaluation periods for 5xx Errors
s3_alarm_5xx_errors_period             = 60   # Period in seconds for 5xx Errors monitoring
s3_alarm_5xx_errors_threshold          = 0.05 # Threshold for 5xx Errors alarm

###### S3 OperationsFailedReplication ######
s3_alarm_s3_alarm_operations_failed_replication_evaluation_periods = 15   # Number of evaluation periods for OperationsFailedReplication
s3_alarm_s3_alarm_operations_failed_replication_period             = 60   # Period in seconds for OperationsFailedReplication monitoring
s3_alarm_s3_alarm_operations_failed_replication_threshold          = 0.00 # Threshold for OperationsFailedReplication alarm

###################################
########### Dynamo DB #############
###################################

# ReadThrottleEvents Alarm
read_throttle_evaluation_periods = 5  # Number of evaluation periods for ReadThrottleEvents
read_throttle_period             = 60 # Period in seconds for ReadThrottleEvents monitoring
read_throttle_threshold          = 15 # Threshold for ReadThrottleEvents alarm

# WriteThrottleEvents Alarm
write_throttle_evaluation_periods = 5  # Number of evaluation periods for WriteThrottleEvents
write_throttle_period             = 60 # Period in seconds for WriteThrottleEvents monitoring
write_throttle_threshold          = 15 # Threshold for WriteThrottleEvents alarm

# SystemErrors Alarm
system_errors_evaluation_periods = 15 # Number of evaluation periods for SystemErrors
system_errors_period             = 60 # Period in seconds for SystemErrors monitoring
system_errors_threshold          = 15 # Threshold for SystemErrors alarm

# UserErrors Alarm
user_errors_evaluation_periods = 10 # Number of evaluation periods for UserErrors
user_errors_period             = 60 # Period in seconds for UserErrors monitoring
user_errors_threshold          = 15 # Threshold for UserErrors alarm

# ReplicationLatency (for global tables)
replication_latency_evaluation_periods = 15 # Number of evaluation periods for ReplicationLatency
replication_latency_period             = 60 # Period in seconds for ReplicationLatency monitoring
replication_latency_threshold          = 15 # Threshold for ReplicationLatency alarm

####################################
############## CloudFront ##########
####################################

# 5xxErrorRate variables
error_rate_5xx_evaluation_periods = 5    # Number of evaluation periods for 5xx Error Rate
error_rate_5xx_period             = 60   # Period in seconds for 5xx Error Rate monitoring
error_rate_5xx_threshold          = 0.05 # Threshold for 5xx Error Rate alarm

# OriginLatency variables
origin_latency_evaluation_periods = 5    # Number of evaluation periods for Origin Latency
origin_latency_period             = 60   # Period in seconds for Origin Latency monitoring
origin_latency_threshold          = 2000 # Threshold in milliseconds for Origin Latency alarm

# 4xxErrorRate variables
error_rate_4xx_evaluation_periods = 5  # Number of evaluation periods for 4xx Error Rate
error_rate_4xx_period             = 60 # Period in seconds for 4xx Error Rate monitoring
error_rate_4xx_threshold          = 10 # Threshold for 4xx Error Rate alarm

####################################
################ SNS ###############
####################################

# Configuração do alarme NumberOfNotificationsFailed
sns_alarm_number_of_notifications_failed_evaluation_periods = 1   # This determines how many periods are used to evaluate if the alarm condition is met.
sns_alarm_number_of_notifications_failed_period             = 300 # This specifies how frequently the metric data is aggregated for the alarm evaluation.
sns_alarm_number_of_notifications_failed_threshold          = 1   # The alarm will trigger if the number of failed notifications exceeds this value during the evaluation periods.

####################################
############### Lambda #############
####################################

# Configuration for Lambda Errors Alarm
lambda_alarm_errors_evaluation_periods = 1   # Number of evaluation periods for the Lambda Errors alarm.
lambda_alarm_errors_period             = 300 # The period (in seconds) over which the Lambda Errors metric is evaluated.
lambda_alarm_errors_threshold          = 1   # Threshold for the number of Lambda Errors that triggers the alarm.

# Configuration for Lambda Duration Alarm
lambda_alarm_duration_evaluation_periods = 1    # Number of evaluation periods for the Lambda Duration alarm.
lambda_alarm_duration_period             = 300  # The period (in seconds) over which the Lambda Duration metric is evaluated.
lambda_alarm_duration_threshold          = 1000 # Threshold for the duration (in milliseconds) of Lambda execution that triggers the alarm.

####################################
########### API Gateway ############
####################################

# API Gateway 4XX Errors Alarm Configuration
api_gateway_alarm_4xx_errors_evaluation_periods = 1 # Number of evaluation periods for the 4XX Errors alarm
api_gateway_alarm_4xx_errors_period             = 300 # Time period in seconds for the 4XX Errors metric
api_gateway_alarm_4xx_errors_threshold          = 100 # Threshold for the 4XX Errors metric

# API Gateway 5XX Errors Alarm Configuration
api_gateway_alarm_5xx_errors_evaluation_periods = 1 # Number of evaluation periods for the 5XX Errors alarm
api_gateway_alarm_5xx_errors_period             = 300 # Time period in seconds for the 5XX Errors metric
api_gateway_alarm_5xx_errors_threshold          = 100 # Threshold for the 5XX Errors metric
