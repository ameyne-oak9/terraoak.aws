resource "aws_elastic_beanstalk_environment" "sac_beanstalk_environment" {
  name                = "sac-testing-beanstalk-env"
  application         = aws_elastic_beanstalk_application.sac_beanstalk_application.name
  solution_stack_name = "64bit Amazon Linux 2015.03 v2.0.3 running Go 1.4"
}