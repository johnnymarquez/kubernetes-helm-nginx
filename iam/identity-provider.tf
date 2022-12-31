resource "aws_iam_openid_connect_provider" "openid" {
  url = "https://oidc.eks.eu-central-1.amazonaws.com/id/#$${var.oidc}"

  client_id_list = [
    "sts.amazonaws.com",
  ]

  thumbprint_list = [""]

  tags     = {}
  tags_all = {}
}

