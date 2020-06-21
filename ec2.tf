# 最新のLinux2を指定
data aws_ssm_parameter amzn2_ami {
  name = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
}

resource "aws_instance" "web" {
  ami           = (data.aws_ssm_parameter.amzn2_ami.value)
  instance_type = "t2.micro"
  tags = {
    Name          = "HelloWorld",
    overtime      = "None",
    AutoStartStop = "TRUE",
    env           = "test",
  }
}

resource "aws_instance" "web2" {
  ami           = (data.aws_ssm_parameter.amzn2_ami.value)
  instance_type = "t2.micro"
  tags = {
    Name          = "HelloWorld2",
    overtime      = "None",
    AutoStartStop = "TRUE",
  }
}