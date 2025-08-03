data "aws_iam_policy_document" "instance_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "this" {
  name               = "${var.env}-s3-${var.role_name}-iam-role"
  path               = "/system/"
  assume_role_policy = data.aws_iam_policy_document.instance_assume_role_policy.json
}

resource "aws_iam_instance_profile" "this" {
  name = "${var.env}-s3-${var.role_name}-instance-profile"
  role = aws_iam_role.this.name
}

resource "aws_iam_policy_attachment" "s3_read_only" {
  name       = "${var.env}-s3-${var.role_name}-policy-attachment"
  roles      = [aws_iam_role.this.name]
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
}   