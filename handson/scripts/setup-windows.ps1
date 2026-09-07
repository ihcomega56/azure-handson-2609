$ErrorActionPreference = 'Stop'

function Test-WingetPackage {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Id
    )

    $output = & winget list --id $Id --exact --accept-source-agreements 2>$null
    return $LASTEXITCODE -eq 0 -and $output -match [regex]::Escape($Id)
}

function Install-WingetPackage {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Id,

        [Parameter(Mandatory = $true)]
        [string]$Name
    )

    if (Test-WingetPackage -Id $Id) {
        Write-Host "[skip] $Name is already installed."
        return
    }

    Write-Host "[install] $Name"
    & winget install `
        --id $Id `
        --exact `
        --silent `
        --accept-package-agreements `
        --accept-source-agreements `
        --disable-interactivity

    if ($LASTEXITCODE -ne 0) {
        throw "Failed to install $Name ($Id)."
    }
}

if (-not (Get-Command winget -ErrorAction SilentlyContinue)) {
    throw 'winget was not found. Install or update App Installer from Microsoft Store.'
}

$packages = @(
    @{ Id = 'Microsoft.VisualStudioCode'; Name = 'Visual Studio Code' }
    @{ Id = 'Microsoft.AzureCLI'; Name = 'Azure CLI' }
    @{ Id = 'Git.Git'; Name = 'Git' }
)

foreach ($package in $packages) {
    Install-WingetPackage -Id $package.Id -Name $package.Name
}

# Refresh PATH so tools installed in this run can be used immediately.
$machinePath = [Environment]::GetEnvironmentVariable('Path', 'Machine')
$userPath = [Environment]::GetEnvironmentVariable('Path', 'User')
$env:Path = "$machinePath;$userPath"

$codeCommand = Get-Command code -ErrorAction SilentlyContinue
if (-not $codeCommand) {
    $codeCandidates = @(
        (Join-Path $env:LOCALAPPDATA 'Programs\Microsoft VS Code\bin\code.cmd')
        (Join-Path $env:ProgramFiles 'Microsoft VS Code\bin\code.cmd')
    )
    $codePath = $codeCandidates | Where-Object { Test-Path $_ } | Select-Object -First 1
} else {
    $codePath = $codeCommand.Source
}

if (-not $codePath) {
    throw 'The VS Code command-line tool was not found. Restart PowerShell and run this script again.'
}

$extensions = @(
    'GitHub.copilot'
    'GitHub.copilot-chat'
    'ms-azuretools.vscode-azureresourcegroups'
    'ms-azuretools.vscode-bicep'
    'bierner.markdown-mermaid'
)

$installedExtensions = @(& $codePath --list-extensions 2>$null)
foreach ($extension in $extensions) {
    if ($installedExtensions -contains $extension) {
        Write-Host "[skip] VS Code extension $extension is already installed."
        continue
    }

    Write-Host "[install] VS Code extension $extension"
    & $codePath --install-extension $extension --force
    if ($LASTEXITCODE -ne 0) {
        throw "Failed to install VS Code extension $extension."
    }
}

$azCommand = Get-Command az -ErrorAction SilentlyContinue
if (-not $azCommand) {
    throw 'Azure CLI was installed, but az was not found. Restart PowerShell and run this script again.'
}

& az bicep version *> $null
if ($LASTEXITCODE -ne 0) {
    Write-Host '[install] Bicep CLI'
    & az bicep install
    if ($LASTEXITCODE -ne 0) {
        throw 'Failed to install Bicep CLI.'
    }
} else {
    Write-Host '[skip] Bicep CLI is already installed.'
}

Write-Host ''
Write-Host 'Setup completed successfully.'
Write-Host 'Restart Visual Studio Code before starting the hands-on exercises.'