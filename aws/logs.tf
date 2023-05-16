resource "aws_cloudwatch_log_group" "flowlogs" {
  name              = "/aws/vpc/${aws_vpc.apps.id}"
  retention_in_days = 7
}

resource "aws_cloudwatch_log_resource_policy" "vpc-flow-logs-publishing-policy" {
  policy_document = data.aws_iam_policy_document.vpc-flow-logs-publishing-policy.json
  policy_name     = "custom-vpc-flow-logs-publishing-policy"
}

resource "aws_flow_log" "apps" {
  vpc_id               = aws_vpc.apps.id
  iam_role_arn         = aws_iam_role.flowlogs.arn
  log_destination      = aws_cloudwatch_log_group.flowlogs.arn
  log_destination_type = "cloud-watch-logs"
  traffic_type         = "ALL"

}
