# Microsoft Windows 10 Pro
- OS Version: 10.0.19044 Build 1826
- Image Version: dev

## Installed Software
### Language and Runtime
- Bash 4.4.23(1)-release
- Go 1.17.12
- Julia 1.7.3
- Kotlin 1.7.10
- Node 16.16.0
- Perl 5.32.1
- Python 3.9.13
- Ruby 3.0.4p208

### Package Management
- Chocolatey 1.1.0
- Miniconda 4.12.0 (pre-installed on the image but not added to PATH)
- NPM 8.11.0
- NuGet 6.2.1.2
- pip 22.1.2 (python 3.9)
- Pipx 1.1.0
- RubyGems 3.2.33
- Yarn 1.22.19

### Project Management
- Ant 1.10.12
- Gradle 7.4
- Maven 3.8.6

### Tools
- 7zip 22.00
- aria2 1.36.0
- CMake 3.23.2
- Git 2.37.1.windows.1
- Git LFS 3.2.0
- InnoSetup 6.2.1
- jq 1.6
- Mingw-w64 11.2.0
- Newman 5.3.2
- OpenSSL 3.0.4
- Packer 1.8.2
- Pulumi v3.36.0
- yamllint 1.27.1

### CLI Tools
- AWS CLI 2.7.16
- AWS SAM CLI 1.53.0
- AWS Session Manager CLI 1.2.339.0

### Java
| Version              | Vendor          | Environment Variable |
| -------------------- | --------------- | -------------------- |
| 8.0.332+9            | Eclipse Temurin | JAVA_HOME_8_X64      |
| 11.0.15+10 (default) | Eclipse Temurin | JAVA_HOME_11_X64     |
| 17.0.3+7             | Eclipse Temurin | JAVA_HOME_17_X64     |

### Shells
| Name          | Target                            |
| ------------- | --------------------------------- |
| gitbash.exe   | C:\Program Files\Git\bin\bash.exe |
| msys2bash.cmd | C:\opt\msys64\usr\bin\bash.exe    |
| wslbash.exe   | C:\Windows\System32\bash.exe      |

### Cached Tools
#### Go
| Version | Architecture | Environment Variable |
| ------- | ------------ | -------------------- |
| 1.16.15 | x64          | GOROOT_1_16_X64      |
| 1.17.12 (Default) | x64          | GOROOT_1_17_X64      |
| 1.18.4  | x64          | GOROOT_1_18_X64      |

#### Node
| Version | Architecture |
| ------- | ------------ |
| 12.22.12 | x64          |
| 14.20.0 | x64          |
| 16.16.0 | x64          |

#### Python
| Version | Architecture |
| ------- | ------------ |
| 3.7.9   | x64, x86     |
| 3.8.10  | x64, x86     |
| 3.9.13 (Default) | x64, x86     |
| 3.10.5  | x64, x86     |

#### Ruby
| Version | Architecture |
| ------- | ------------ |
| 2.7.6   | x64          |
| 3.0.4 (Default) | x64          |
| 3.1.2   | x64          |

#### PyPy
| Python Version | PyPy Version |
| -------------- | ------------ |
| 2.7.18         | PyPy 7.3.9 with MSC v.1929 64 bit (AMD64) |
| 3.7.13         | PyPy 7.3.9 with MSC v.1929 64 bit (AMD64) |
| 3.8.12         | PyPy 7.3.9 with MSC v.1929 64 bit (AMD64) |

### Databases
#### PostgreSQL
| Property             | Value                                                                                                                                |
| -------------------- | ------------------------------------------------------------------------------------------------------------------------------------ |
| ServiceName          | postgresql-x64-14                                                                                                                    |
| Version              | 14.4                                                                                                                                 |
| ServiceStatus        | Stopped                                                                                                                              |
| ServiceStartType     | Disabled                                                                                                                             |
| EnvironmentVariables | PGBIN=C:\Program Files\PostgreSQL\14\bin <br> PGDATA=C:\Program Files\PostgreSQL\14\data <br> PGROOT=C:\Program Files\PostgreSQL\14  |
| Path                 | C:\Program Files\PostgreSQL\14                                                                                                       |
| UserName             | postgres                                                                                                                             |
| Password             | root                                                                                                                                 |

### Web Servers
| Name   | Version | ConfigFile                          | ServiceName | ServiceStatus | ListenPort |
| ------ | ------- | ----------------------------------- | ----------- | ------------- | ---------- |
| Apache | 2.4.54  | C:\opt\Apache24\conf\httpd.conf     | Apache      | Stopped       | 80         |
| Nginx  | 1.23.0  | C:\opt\nginx-1.23.0\conf\nginx.conf | nginx       | Stopped       | 80         |

### PowerShell Tools
- PowerShell 7.2.5

#### Powershell Modules
| Module             | Version            |
| ------------------ | ------------------ |
| AWSPowerShell      | 4.1.125<br>4.1.126 |
| DockerMsftProvider | 1.0.0.8            |
| MarkdownPS         | 1.9                |
| Pester             | 3.4.0<br>5.3.3     |
| PowerShellGet      | 1.0.0.1<br>2.2.5   |
| PSScriptAnalyzer   | 1.20.0             |
| PSWindowsUpdate    | 2.2.0.3            |


