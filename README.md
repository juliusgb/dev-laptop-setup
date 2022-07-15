# Setup Developer Machine for Windows

Automatically installs developer tools on a Windows machine.

- What I'm installing is a stripped-down version of what gets installed on GitHub's runners - <https://github.com/actions/virtual-environments>. I'm using release [`Windows Server 2022 (20220710 update)`](https://github.com/actions/virtual-environments/releases/tag/win22%2F20220710.1)
- That's why the structure of this repo, the tab/space indentation closely matches the one at actions/virtual-environments (<https://github.com/actions/virtual-environment>)

I'm making lots of assumptions:

- Can run PowerShell as Administrator
- Can read these scripts to atleast make sure that there's nothing malicious in there.

## Testing

## Maintenance
- Make changes to relevant files and rerun packer build. Tools installed via chocolatey won't be reinstalled.
- Some install scripts make changes to folders and add environment variables.
Before I rerun Packer I manually delete these.
- When testing 2 lines, and the 2nd fails, I comment out line 1 and retest with only line 2.

## Tools:

- Windows features: install WSL and virtual-machine-feature. See [docs](https://docs.microsoft.com/en-us/windows/wsl/install-manual#step-3---enable-virtual-machine-feature)
- Docker: don't install it via OneGet but use choco to install docker desktop and docker compose.
When installing via OneGet, the Windows container, as opposed to Linux, are installed.
Docker Desktop allows us to choose which containers to build and run - we can choose Windows or Linux containers.

For tools installed with Chocolatey, I'm choosing the [`.portable` versions](https://docs.chocolatey.org/en-us/faqs#what-distinction-does-chocolatey-make-between-an-installable-and-a-portable-application) that don't require Admin rights to install nor integration with Windows explorer.
For those that do need them, I use the `.install` version: git,

When testing java install
- manually delete tools\Adopt*|Temurin directories
- manually delete the created JAVA* env vars
