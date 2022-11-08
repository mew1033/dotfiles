
Import-Module posh-git
Import-Module DockerCompletion
Import-Module oh-my-posh
Set-PoshPrompt -Theme Paradox


# Chocolatey profile
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}


# AWS CLI
# PowerShell parameter completion shim for the aws CLI
Register-ArgumentCompleter -Native -CommandName aws -ScriptBlock {
  param($commandName, $wordToComplete, $cursorPosition)
  Set-Item -Path Env:COMP_LINE -Value $wordToComplete
  Set-Item -Path Env:COMP_POINT -Value $cursorPosition
  aws_completer.exe | ForEach-Object {
      [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_)
  }
}
