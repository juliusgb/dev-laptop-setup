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

variable "agent_tools_dir" {
  type = string
  default = "C:\\opt\\tools"
}

variable "helper_scripts_dir" {
  type = string
  default = "C:\\Program Files\\WindowsPowerShell\\Modules"
}

variable "image_data_file" {
  type = string
  default = "C:\\tmp\\vm-image\\imagedata.json"
}

variable "image_version" {
	type = string
	default = "dev"
}

variable "opt_dir" {
	type = string
	default = "C:\\opt"
}

variable "repo_dir" {
	type = string
	default = "C:\\dev-work\\dev-laptop-windows"
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
			"./images/win/scripts/Installers/Install-PowerShellModules.ps1",
			"./images/win/scripts/Installers/Install-WindowsFeatures.ps1",
			"./images/win/scripts/Installers/Install-Choco.ps1",
			"./images/win/scripts/Installers/Initialize-VM.ps1",
			"./images/win/scripts/Installers/Update-DotnetTLS.ps1"
		]
	}

	# TODO: restart machine

	# refresh shell to use env vars created from above scripts.
	provisioner "powershell" {
		inline = ["refreshenv"]
	}

	provisioner "powershell" {
		execution_policy = "unrestricted"
		scripts          = [
			"./images/win/scripts/Installers/Install-PowershellCore.ps1",
			"./images/win/scripts/Installers/Install-CommonUtils.ps1"
		]
	}

	# restart machine

	# refresh shell to use env vars created from above scripts.
	provisioner "powershell" {
    inline = ["refreshenv"]
  }

	provisioner "powershell" {
		environment_vars = [
			"AGENT_TOOLSDIRECTORY=${var.agent_tools_dir}"
		]
		execution_policy = "unrestricted"
		scripts          = [
			"./images/win/scripts/Installers/Install-JavaTools.ps1",
			"./images/win/scripts/Installers/Install-Kotlin.ps1"
		]
	}

	# restart
	provisioner "powershell" {
    inline = ["refreshenv"]
  }

	provisioner "powershell" {
		environment_vars = [
			"AGENT_TOOLSDIRECTORY=${var.agent_tools_dir}"
		]
		execution_policy = "unrestricted"
		scripts          = [
			"./images/win/scripts/Installers/Install-Ruby.ps1",
#			"./images/win/scripts/Installers/Install-PyPy.ps1", # doesn't create Scripts dir for py version 3.8 and 3.9
      "./images/win/scripts/Installers/Install-Toolset.ps1",
      "./images/win/scripts/Installers/Configure-Toolset.ps1",
      "./images/win/scripts/Installers/Install-NodeLts.ps1",
			"./images/win/scripts/Installers/Install-Pipx.ps1",
      "./images/win/scripts/Installers/Install-PipxPackages.ps1",
				"./images/win/scripts/Installers/Install-Git.ps1"
			"./images/win/scripts/Installers/Install-Apache.ps1",
      "./images/win/scripts/Installers/Install-Nginx.ps1",
			"./images/win/scripts/Installers/Install-AWS.ps1",
			"./images/win/scripts/Installers/Install-Mingw64.ps1",
			"./images/win/scripts/Installers/Install-Miniconda.ps1",
			"./images/win/scripts/Installers/Install-PostgreSQL.ps1",
			## someday/maybe list ##
			#"./images/win/scripts/Installers/Install-Rust.ps1",
			# ./images/win/scripts/Installers/Install-R.ps1
			#"./images/win/scripts/Installers/Install-Msys2.ps1", # required for haskell
			# "./images/win/scripts/Installers/Install-Haskell.ps1",
			# "./images/win/scripts/Installers/Install-Stack.ps1"
		]
	}

	provisioner "powershell" {
		execution_policy = "unrestricted"
		scripts          = [
			"./images/win/scripts/Installers/Configure-Shell.ps1"
		]
	}

	# restart

	provisioner "powershell" {
    inline = ["refreshenv"]
  }

	provisioner "powershell" {
		environment_vars = [
			"AGENT_TOOLSDIRECTORY=${var.agent_tools_dir}"
		]
		execution_policy = "unrestricted"
		scripts          = [
			"./images/win/scripts/Tests/RunAll-Tests.ps1"
		]
	}

	provisioner "powershell" {
		inline = ["if (-not (Test-Path ${var.image_folder}\\Tests\\testResults.xml)) { throw '${var.image_folder}\\Tests\\testResults.xml not found' }"]
  }

	provisioner "powershell" {
		environment_vars = [
			"IMAGE_VERSION=${var.image_version}",
			"AGENT_TOOLSDIRECTORY=${var.agent_tools_dir}"
		]
		inline = ["pwsh -File '${var.image_folder}\\SoftwareReport\\SoftwareReport.Generator.ps1'"]
  }

	provisioner "powershell" {
		inline = ["if (-not (Test-Path ${var.opt_dir}\\InstalledSoftware.md)) { throw '${var.opt_dir}\\InstalledSoftware.md not found' }"]
  }

	provisioner "powershell" {
		inline = ["Copy-Item -Force ${var.opt_dir}\\InstalledSoftware.md -Destination ${var.repo_dir}\\images\\win\\Windows2022ish-Readme.md"]
  }

}
