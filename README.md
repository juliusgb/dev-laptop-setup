# Developer Machine Setup for Windows

Automatically installs developer tools on a Windows machine.

The list of tools are <https://github.com/juliusgb/dev-laptop-setup/blob/main/images/win/Windows2022ish-Readme.md>.

That's a subset of the tools that Microsoft installs on [its virtual machines](https://github.com/actions/runner-images) on which GitHub Actions run.
I wanted something similar, i.e., open a shell, execute commands to experiment without having first to worry about installing and configuring the tools/SDKs/Runtimes. That worry comes later.

I'm using release [`Windows Server 2022 release 20240225.2`](https://github.com/actions/runner-images/releases/tag/win22%2F20240225.2).
But I've removed server-specific settings and tools, such as [`sbt`](https://www.scala-sbt.org/), that I'm not likely to use.
If I need the tool, I'll add the relevant `Install-*` script and corresponding [`Pester`](https://pester.dev/) tests to the repo.

## Getting started

We need the following:

- An internet connection that's not so firewalled.
If network access is locked down via firewalls, remember to add the URLs in the `Install-*` scripts to the firewall's `allowlist`.
Also keep in mind that some of these URLs get redirected. Then, add the redirects to the `allowlist`.
To see all redirects for a URL, use the [`UrlHelpers`](https://github.com/juliusgb/utils/blob/main/powershell/CustomHelperUtils/UrlHelpers.ps1) script.

- Able to open and run PowerShell as Administrator. In it, elevate the [PowerShell session's execution policy](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_execution_policies?view=powershell-7.2) with `Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope Process`
- The Packer executable. It doesn't have to be on the PATH. Download it from <https://www.packer.io/downloads>.

- `Winrm` has been setup and tested. `Winrm` is to Windows what `ssh` is to Linux.
Just as Packer uses `ssh` to remotely manage Linux machines, so [Packer uses `winrm` to remotely manage Windows machines](https://www.packer.io/docs/communicators/winrm).
To set up `winrm`, follow the post, <https://til.juliusgamanyi.com/posts/setup-winrm>


:warning:

Running scripts with Administrator privileges triggers an alarm at the back of my mind.
So read them, test them. And buyer beware!

## Testing

To change these scripts, we need portable versions of some tools, like Packer, 7zip, vscode, git.

There's no one script (yet) to bootstrap everything.
To test manually, do the following:

1. Run PowerShell as Administrator: PowerShell -> Run as Admin
2. Setup `winrm`. In PowerShell, run `.\winrm\SetupWinRmForPacker.ps1`
3. Validate the packer template file with `C:\path\to\packer.exe validate packer\template.pkr.hcl`.
4. Add username and password in the Packer template file under `winrm-username` and `winrm-password`.
5. Packer build the template file with `C:\path\to\packer.exe build packer\template.pkr.hcl`.
:zap: Read the section "more on step 4" :zap:
6. Cleanup what was added during the `winrm` setup. In PowerShell, run `.\winrm\CleanupWinrmSetupForPacker.ps1`

### More on step 4

Changes to the packer template file mean re-running `packer build`.
That's a once-for-all operation: there are no intermediate caches for previous steps to use again.

- The `Install-*` scripts use [`Chocolatey`](https://chocolatey.org/) to install the dev tools. And `Chocolatey` knows whether a tool was installed.
If I re-run the `choco install` step without the `--force` option, `Chocolatey` doesn't reinstall it.
Yay, for [Idempotency](https://en.wikipedia.org/wiki/Idempotence)!! :sparkles:

- What's not idempotent are the directories and environment variables that were created during installation.
    - That's ideal when starting from a fresh, clean machine. But have to take more care when running on my one dev
   machine (laptop) - no immutability.
    - One way I re-test is to manually delete them before re-running `packer build`.
    - Another way is that when testing 2 lines, and the 2nd fails, I comment out line 1 and re-run `packer build`,
   which executes only line 2. That leaves the directories and env vars from line 1 untouched.

## Customisations

Besides keeping a subset of tooling, I've customised some to match my preferences.

- I prefer the tooling to be installed in `C:\opt` instead of `C:\`.
This meant changing related files, such as the tests and the scripts that generate the reports for the installed software.

- I've commented out some files instead of deleting them.
These are for tooling that I'm _likely_ (or would like) to use.
Their corresponding tests are `skipped`.

- For tooling installed with Chocolatey, I prefer the [`<package>.portable` instead of the `<package>.install` versions](https://docs.chocolatey.org/en-us/faqs#what-distinction-does-chocolatey-make-between-an-installable-and-a-portable-application)
that don't require Admin rights to install nor integration with Windows file explorer.
Some Chocolatey packages allow you to change where they're installed. For these ones, I install them in `C:\opt`
I use the `default` or `<package>.install` version for those that need Admin rights (Git, 7zip) or that need integration with Windows File Explorer or whose installer is to cumbersome to change (CMake, AWS CLIs).

## Excluded Tooling

Excluded tools are those that I don't use on a day-by-day basis.

Because of excluded tooling, customized installers, I've added the `-ish` suffix to the file listing the installed tooling, i.e., to `Windows2022ish`.

## Upgrading

The current version of this repo corresponds to <https://github.com/actions/runner-images/releases/tag/win22%2F20240225.2>.

To upgrade/update this repo to a specific released tag, I run the following manually:

1. Clone the runner-images repo
2. Git Checkout a specific release tag
3. Run a diff on the `win` folder, especially the `win/scripts` folder. Take what changed.
4. Follow the steps [mentioned above](#testing) until step 4.
5. Then test each `Install-*` one at at time.
    - Comment out all Packer blocks of Provisioners.
    - In a particulr block, comment out all but one `Install-*` script. E.g. `Install-PowerShellModules.ps1`.
    - Run `C:\path\to\packer.exe build packer\template.pkr.hcl`.
    - Fix any errors that occur.

```powershell
. . .
    provisioner "powershell" {
        execution_policy = "unrestricted"
        scripts          = [
            "./images/win/scripts/Installers/Install-PowerShellModules.ps1",
            #"./images/win/scripts/Installers/Install-WindowsFeatures.ps1",
            #"./images/win/scripts/Installers/Install-Chocolatey.ps1",
            #"./images/win/scripts/Installers/Initialize-VM.ps1",
            #"./images/win/scripts/Installers/Update-DotnetTLS.ps1"
        ]
	}
# other provisioners should be commented out
```

6. Move onto the next `Install-*`. Example below is for `Install-Chocolatey.ps1`

```powershell
. . .
provisioner "powershell" {
    execution_policy = "unrestricted"
    scripts          = [
        #"./images/win/scripts/Installers/Install-PowerShellModules.ps1",
        #"./images/win/scripts/Installers/Install-WindowsFeatures.ps1",
        "./images/win/scripts/Installers/Install-Chocolatey.ps1",
        #"./images/win/scripts/Installers/Initialize-VM.ps1",
        #"./images/win/scripts/Installers/Update-DotnetTLS.ps1"
    ]
}
# other provisioners should be commented out
```

## References

- Setting up WinRM and manually testing it - <https://til.juliusgamanyi.com/posts/setup-winrm>
- Setup Packer with WinRM - <https://til.juliusgamanyi.com/posts/packer-winrm-setup>
- Use Packer to install dev tooling - <https://til.juliusgamanyi.com/posts/setup-local-dev-with-packer>
- Virtual machines for GitHub Actions - <https://github.com/actions/runner-images>
- Best script was `Configure-Toolset.ps1`. It's idempotent.
It checked the directories and registry keys, deleting them, if they already exist.
That made testing (i.e., re-running it) easy.
