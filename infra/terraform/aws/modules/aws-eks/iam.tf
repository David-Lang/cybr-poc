resource "aws_iam_user" "k8s_user" {
  name = "${var.name_prefix}-k8s_user"
  tags = merge(var.common_tags, { Name = "${var.name_prefix}-k8s_user" })
}

resource "aws_iam_access_key" "k8s_user" {
  user = aws_iam_user.k8s_user.name
}

resource "aws_iam_user_policy" "k8s_user" {
  name = "${var.name_prefix}-k8s_user_policy"
  user = aws_iam_user.k8s_user.name

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : [
          "eks:DescribeCluster",
          "eks:ListClusters"
        ],
        "Resource" : "*"
      }
    ]
  })
}

