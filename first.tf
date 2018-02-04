# New resource for the S3 bucket our application will use.
resource "aws_s3_bucket" "example" {
  # NOTE: S3 bucket names must be unique across _all_ AWS accounts, so
  # this name must be changed before applying this example to avoid naming
  # conflicts.
  bucket = "terraform_getting_started_guide_morihaya"
  acl    = "private"
}

resource "aws_instance" "example" {
  ami           = "ami-428aa838"
  instance_type = "t2.micro"

  # Tells Terraform that this EC2 instance must be created only after the
  # S3 bucket has been created.
  depends_on = ["aws_s3_bucket.example"]

  # Our Security group to allow HTTP and SSH access
  vpc_security_group_ids = ["${aws_security_group.default.id}"]

  # We're going to launch into the same subnet as our ELB. In a production
  # environment it's more common to have a separate private subnet for
  # backend instances.
  subnet_id = "${aws_subnet.default.id}"

  # The name of our SSH keypair we created above.
#  key_name = "${aws_key_pair.auth.id}"
  key_name = "morihaya-vaio"

}

resource "aws_eip" "ip" {
  instance = "${aws_instance.example.id}"
}
