
Import-Module posh-git/src/posh-git
Import-Module DockerCompletion/DockerCompletion
# Set oh-my-posh theme
# powerlevel10k_rainbow
# Another good option: cobalt2
oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH/powerlevel10k_rainbow.omp.json" | Invoke-Expression

# https://ohmyposh.dev/docs/segments/git
$env:POSH_GIT_ENABLED = $true

# Allow using TLS 1.1 and 1.2
[Net.ServicePointManager]::SecurityProtocol = ([Net.ServicePointManager]::SecurityProtocol -bor [Net.SecurityProtocolType]::Tls11 -bor [Net.SecurityProtocolType]::Tls12)

# Chocolatey profile
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}


# AWS CLI
# PowerShell parameter completion shim for the aws CLI
$AWSCompleter = "aws_completer.exe"
if (Get-Command $AWSCompleter -errorAction SilentlyContinue)
{
  Register-ArgumentCompleter -Native -CommandName aws -ScriptBlock {
    param($commandName, $wordToComplete, $cursorPosition)
    Set-Item -Path Env:COMP_LINE -Value $wordToComplete
    Set-Item -Path Env:COMP_POINT -Value $cursorPosition
    $AWSCompleter | ForEach-Object {
        [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_)
    }
  }
}
