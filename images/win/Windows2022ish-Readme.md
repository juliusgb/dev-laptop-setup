# Windows 10 Pro
- OS Version: 10.0.19045 Build 4046
- Image Version: dev

## Windows features
- Windows Subsystem for Linux (WSLv1): Enabled

## Installed Software

### Language and Runtime
- Bash 5.2.26(1)-release
- Go 1.21.7
- Julia 1.7.3
- Kotlin 1.9.22
- Node 18.18.2
- Perl 5.38.2
- Python 3.9.13
- Ruby 3.0.4p208

### Package Management
- Chocolatey 1.1.0
- Miniconda 4.12.0 (pre-installed on the image but not added to PATH)
- NPM 9.8.1
- NuGet 6.2.1.2
- pip 24.0 (python 3.9)
- Pipx 1.4.3
- RubyGems 3.2.33
- Yarn 1.22.21

#### Environment variables
| Name                    | Value            |
| ----------------------- | ---------------- |
| VCPKG_INSTALLATION_ROOT |                  |
| CONDA                   | C:\opt\Miniconda |

### Project Management
- Ant 1.10.12
- Gradle 7.4
- Maven 3.8.6

### Tools
- 7zip 22.00
- aria2 1.36.0
- CMake 3.23.2
- Docker Compose v1 1.29.2
- Docker Compose v2 2.19.1
- Docker-wincred 0.8.1
- Git 2.44.0.windows.1
- Git LFS 3.4.1
- ImageMagick 7.1.1-29
- InnoSetup 6.2.2 [Approved]
- jq 1.6
- gcc 11.2.0
- gdb 10.2
- Newman 6.1.1
- OpenSSL 1.1.1w
- Packer 1.8.2
- Pulumi 3.36.0
- yamllint 1.27.1
- zstd 1.5.5

### CLI Tools
- AWS CLI 2.7.16
- AWS SAM CLI 1.110.0
- AWS Session Manager CLI 1.2.553.0

### Java
| Version             | Environment Variable |
| ------------------- | -------------------- |
| 8.0.402+6           | JAVA_HOME_8_X64      |
| 11.0.22+7 (default) | JAVA_HOME_11_X64     |
| 17.0.10+7           | JAVA_HOME_17_X64     |
| 21.0.2+13.0         | JAVA_HOME_21_X64     |

### Shells
| Name          | Target                            |
| ------------- | --------------------------------- |
| gitbash.exe   | C:\Program Files\Git\bin\bash.exe |
| msys2bash.cmd | C:\opt\msys2\usr\bin\bash.exe     |
| wslbash.exe   | C:\Windows\System32\bash.exe      |

### MSYS2
- Pacman 6.0.2

#### Notes
```
Location: C:\opt\msys2

Note: MSYS2 is pre-installed on image but not added to PATH.
```

### Cached Tools

#### Go
- 1.16.15
- 1.17.12
- 1.18.4
- 1.20.14
- 1.21.7
- 1.22.0

#### Node.js
- 12.22.12
- 14.20.0
- 16.16.0
- 16.20.2
- 18.19.1
- 20.11.1

#### Python
- 3.7.9
- 3.8.10
- 3.9.13
- 3.10.5
- 3.10.11
- 3.11.8
- 3.12.2

#### PyPy
- 2.7.18 [PyPy 7.3.15]
- 3.7.13 [PyPy 7.3.9]
- 3.8.16 [PyPy 7.3.11]
- 3.9.18 [PyPy 7.3.15]
- 3.10.13 [PyPy 7.3.15]

#### Ruby
- 2.7.6
- 3.0.4
- 3.0.6
- 3.1.2
- 3.1.4

### Databases

#### PostgreSQL
| Property             | Value                                                                                                                                |
| -------------------- | ------------------------------------------------------------------------------------------------------------------------------------ |
| ServiceName          | postgresql-x64-14                                                                                                                    |
| Version              | 14.11                                                                                                                                |
| ServiceStatus        | Stopped                                                                                                                              |
| ServiceStartType     | Disabled                                                                                                                             |
| EnvironmentVariables | PGBIN=C:\Program Files\PostgreSQL\14\bin <br> PGDATA=C:\Program Files\PostgreSQL\14\data <br> PGROOT=C:\Program Files\PostgreSQL\14  |
| Path                 | C:\Program Files\PostgreSQL\14                                                                                                       |
| UserName             | postgres                                                                                                                             |
| Password             | root                                                                                                                                 |

### Database tools

### Web Servers
| Name   | Version | ConfigFile                          | ServiceName | ServiceStatus | ListenPort |
| ------ | ------- | ----------------------------------- | ----------- | ------------- | ---------- |
| Apache | 2.4.54  | C:\opt\Apache24\conf\httpd.conf     | Apache      | Stopped       | 80         |
| Nginx  |         | C:\opt\nginx-1.23.0\conf\nginx.conf | nginx       | Stopped       | 80         |

### PowerShell Tools
- PowerShell 7.4.1

#### Powershell Modules
- AWSPowershell: 4.1.125, 4.1.126, 4.1.528
- DockerMsftProvider: 1.0.0.8
- MarkdownPS: 1.9
- Pester: 3.4.0, 5.3.3, 5.5.0
- PowerShellGet: 1.0.0.1, 2.2.5
- PSScriptAnalyzer: 1.20.0, 1.21.0
- PSWindowsUpdate: 2.2.0.3, 2.2.1.4
