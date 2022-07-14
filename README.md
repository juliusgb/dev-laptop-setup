# Setup Developer Machine for Windows

Automatically installs developer tools on a Windows machine.

- What I'm installing is a stripped-down version of what gets installed on GitHub's runners - <https://github.com/actions/virtual-environments>. I'm using release [`Windows Server 2022 (20220710 update)`](https://github.com/actions/virtual-environments/releases/tag/win22%2F20220710.1)
- That's why the structure of this repo, the tab/space indentation closely matches the one at actions/virtual-environments (<https://github.com/actions/virtual-environment>)

I'm making lots of assumptions:

- Can run PowerShell as Administrator
- Can read these scripts to atleast make sure that there's nothing malicious in there.
