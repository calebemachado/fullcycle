resource "aws_iam_role" "node" {
  name = "${var.prefix}-${var.cluster_name}-role-node"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "ec2.amazonaws.com"
        }
        "Action" : "sts:AssumeRole"
      },
    ]
  })
}