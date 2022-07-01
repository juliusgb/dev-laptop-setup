variable "winrm-username" {
  sensitive = true
  default = {
    key = "juliusg"
  }
}

variable "winrm-password" {
  sensitive = true
  default = {
    key = "SECR3TP4SSW0RD"
  }
}

variable "image_folder" {
  type = string
  default = "C:\\tmp\\vm-image\\"
}

source "null" basic-example {
  communicator = "winrm"
  winrm_host = "127.0.0.1"
  winrm_port = "5986"
  winrm_insecure = true
  winrm_use_ssl = true
  winrm_username = "${var.winrm-username.key}"
  winrm_password = "${var.winrm-password.key}"
}

build {
  sources = ["sources.null.basic-example"]
  
  provisioner "powershell" {
    inline = ["dir $env"]
  }
  
  provisioner "powershell" {
    inline = ["New-Item -Path ${var.image_folder} -ItemType Directory -Force"]
  }
  
  provisioner "file" {
    destination = "${var.image_folder}"
	source = "hello.txt"
  }
}