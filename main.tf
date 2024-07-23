provider "aws"{
	region = "us-east-1"
}

resource "aws_instance" "demo-project1"{
	ami = "ami-04a81a99f5ec58529"
	instance_type = "t2.micro"
	key_name      = "p1"

	vpc_security_group_ids = [aws_security_group.ssh.id]

	tags = {
		Name = "project1"	
	}
}

resource "aws_security_group" "ssh"{
	name_prefix = "project1"
	description = "Allow SSH traffic"
	vpc_id = "vpc-02c43034fe28998b2"

	ingress {
		from_port = 22             # Starting port of the range
    		to_port = 22             # Ending port of the range (22 for SSH)
    		protocol = "tcp"          # Protocol type (TCP in this case)
    		cidr_blocks = ["0.0.0.0/0"]
	}
	
	ingress {
                from_port = 80             # Starting port of the range
                to_port = 80             # Ending port of the range (22 for SSH)
                protocol = "tcp"          # Protocol type (TCP in this case)
                cidr_blocks = ["0.0.0.0/0"]
        }
	ingress {
                from_port = 3000             # Starting port of the range
                to_port = 3000             # Ending port of the range (22 for SSH)
                protocol = "tcp"          # Protocol type (TCP in this case)
                cidr_blocks = ["0.0.0.0/0"]
        }

	egress {
		from_port = 0              # Starting port of the range
    		to_port = 0              # Ending port of the range (0 allows all ports)
    		protocol = "-1"           # Protocol type (-1 allows all protocols)
    		cidr_blocks = ["0.0.0.0/0"]
	}	
	tags = {
   		 Name = "terraform-example-ssh"
  	}
}

output "instance_public_ip" {
  description = "The public IP address of the EC2 instance"
  value       = aws_instance.demo-project1.public_ip
}
