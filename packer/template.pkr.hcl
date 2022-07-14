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
  default = "C:\\tmp\\vm-image"
}

variable "helper_scripts_dir" {
  type = string
  default = "C:\\Program Files\\WindowsPowerShell\\Modules"
}

variable "image_data_file" {
  type = string
  default = "C:\\tmp\\vm-image\\imagedata.json"
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
    inline = ["New-Item -Path ${var.image_folder} -ItemType Directory -Force"]
  }

	provisioner "file" {
    destination = "${var.helper_scripts_dir}"
		source = "./images/win/scripts/ImageHelpers"
  }

	provisioner "file" {
    destination = "${var.image_folder}"
		source = "./images/win/scripts/SoftwareReport"
  }

	provisioner "file" {
    destination = "${var.image_folder}"
		source = "./images/win/scripts/Tests"
  }

	provisioner "file" {
    destination = "${var.image_folder}\\toolset.json"
		source = "./images/win/toolsets/toolset-2022.json"
  }

	provisioner "powershell" {
		execution_policy = "unrestricted"
		scripts          = [
			"./images/win/scripts/Installers/Install-PowerShellModules.ps1"
		]
	}
}
