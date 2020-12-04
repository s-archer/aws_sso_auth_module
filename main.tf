data "local_file" "aws_sso" {
  filename = "${path.module}/aws_sso.tpl"
}

resource "local_file" "aws_sso" {
    content     = data.local_file.aws_sso.content
    filename = "${path.root}/sso_auth.sh"
}

resource "null_resource" "aws_sso" {
  provisioner "local-exec" {
    command = "chmod +x ${path.root}/sso_auth.sh && ${path.root}/sso_auth.sh"
  }
}
