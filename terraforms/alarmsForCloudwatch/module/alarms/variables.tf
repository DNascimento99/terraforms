variable "alarms" {
  description = "Mapa de configurações de alarmes do CloudWatch"
  type = map(object({
    alarm_name                = string
    comparison_operator       = string
    evaluation_periods        = number
    metric_name               = string
    namespace                 = string
    period                    = number
    extended_statistic        = optional(string, null)
    statistic                 = optional(string, null)
    threshold                 = number
    alarm_description         = string
    insufficient_data_actions = optional(list(string), null)
    alarm_actions             = list(string)
    dimensions                = map(string)
    treat_missing_data        = optional(string, null)
  }))
}