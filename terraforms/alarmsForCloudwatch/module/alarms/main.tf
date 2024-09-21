resource "aws_cloudwatch_metric_alarm" "cloudwatch_alarms" {
  for_each                  = var.alarms
  alarm_name                = each.value.alarm_name
  comparison_operator       = each.value.comparison_operator
  evaluation_periods        = each.value.evaluation_periods
  metric_name               = each.value.metric_name
  namespace                 = each.value.namespace
  period                    = each.value.period
  statistic                 = lookup(each.value, "statistic", null)
  extended_statistic        = lookup(each.value, "extended_statistic", null)
  threshold                 = each.value.threshold
  alarm_description         = each.value.alarm_description
  treat_missing_data        = lookup(each.value, "treat_missing_data", null)
  insufficient_data_actions = lookup(each.value, "insufficient_data_actions", null)
  alarm_actions             = each.value.alarm_actions
  dimensions                = each.value.dimensions
}