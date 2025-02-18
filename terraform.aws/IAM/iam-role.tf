resource "aws_iam_role" "sac_iam_role" {
  name = "${local.name}-eks-developer-role"
  managed_policy_arns = "arn:aws:iam::aws:policy/AdministratorAccess"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "*"
        Effect = "Allow"
        Resource = "*"
        Principal = "*"
      },
    ]
  })
  inline_policy {
    name = "eks-developer-access-policy"
    policy = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          Principal = "*"
          Action   = "*"
          Effect   = "Allow"
          Resource = "*"
        },
      ]
    })
  }    
}

resource "aws_iam_role_policy_attachment" "eks-developrole-s3fullaccess" {
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
  role       = aws_iam_role.sac_iam_role.name
}

data "aws_iam_policy_document" "sac_iam_managed_policy" {
  statement {
    actions = "*"
    resources = ["*"]

    condition {
      test     = "ForAnyValue:StringEquals"
      variable = "kms:EncryptionContext:service"
      values   = ["pi"]
    }
  }
}
