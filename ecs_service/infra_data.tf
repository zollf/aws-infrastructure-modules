data "terraform_remote_state" "infra" {
  backend = "s3"

  config = {
    bucket = "${var.s3_remote_state_bucket}"
    key    = "${var.infrastructure_name}"
    region = "${var.region}"
  }
}
