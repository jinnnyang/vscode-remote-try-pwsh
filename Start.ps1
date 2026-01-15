<#
.SYNOPSIS
    Project initialization and setup script

.DESCRIPTION
    This script performs initial project setup including:
    - Checking PowerShell version
    - Installing required modules
    - Verifying dependencies
    - Setting up project environment
#>

[CmdletBinding()]
param()

# Required PowerShell modules for this project
$requiredModules = @(
    @{ Name = "PSScriptAnalyzer"; Version = "1.21.0" },
    @{ Name = "Pester"; Version = "5.5.0" }
)

function Test-PowerShellVersion {
    <#
    .SYNOPSIS
        Verify PowerShell version meets minimum requirements
    #>
    $currentVersion = $PSVersionTable.PSVersion
    $minVersion = [Version]"7.0.0"

    if ($currentVersion -lt $minVersion) {
        throw "PowerShell $minVersion or higher is required. Current version: $currentVersion"
    }

    Write-Host "✓ PowerShell version: $currentVersion" -ForegroundColor Green
}

function Install-RequiredModules {
    <#
    .SYNOPSIS
        Install required PowerShell modules
    #>
    [CmdletBinding()]
    param()

    Write-Host "`nInstalling required modules..." -ForegroundColor Cyan

    foreach ($module in $requiredModules) {
        $installed = Get-Module -ListAvailable -Name $module.Name -ErrorAction SilentlyContinue |
                     Where-Object { $_.Version -ge [Version]$module.Version }

        if ($installed) {
            Write-Host "  ✓ $($module.Name) already installed (v$($installed.Version))" -ForegroundColor Green
        }
        else {
            Write-Host "  → Installing $($module.Name) v$($module.Version)..." -ForegroundColor Yellow
            Install-Module -Name $module.Name -MinimumVersion $module.Version -Force -Scope CurrentUser -AllowClobber
            Write-Host "  ✓ $($module.Name) installed successfully" -ForegroundColor Green
        }
    }
}

function Initialize-ProjectEnvironment {
    <#
    .SYNOPSIS
        Set up project-specific environment variables and paths
    #>
    [CmdletBinding()]
    param()

    Write-Host "`nInitializing project environment..." -ForegroundColor Cyan

    # Set project root
    $script:ProjectRoot = Split-Path -Parent $PSScriptRoot
    $env:PROJECT_ROOT = $script:ProjectRoot

    # Create output directories if they don't exist
    $outputDirs = @("output", "logs", "temp")

    foreach ($dir in $outputDirs) {
        $path = Join-Path $script:ProjectRoot $dir
        if (-not (Test-Path $path)) {
            New-Item -ItemType Directory -Path $path -Force | Out-Null
            Write-Host "  ✓ Created directory: $dir" -ForegroundColor Green
        }
    }

    Write-Host "  ✓ Project root: $script:ProjectRoot" -ForegroundColor Green
}

function Test-Dependencies {
    <#
    .SYNOPSIS
        Verify all dependencies are available
    #>
    [CmdletBinding()]
    param()

    Write-Host "`nVerifying dependencies..." -ForegroundColor Cyan

    # Check for common tools
    $tools = @("git", "pwsh")

    foreach ($tool in $tools) {
        $exists = Get-Command $tool -ErrorAction SilentlyContinue
        if ($exists) {
            Write-Host "  ✓ $tool is available" -ForegroundColor Green
        }
        else {
            Write-Warning "  ⚠ $tool not found in PATH"
        }
    }
}

# Main execution
try {
    Write-Host "`n=== PowerShell Project Setup ===" -ForegroundColor Cyan
    Write-Host "Starting initialization..." -ForegroundColor Cyan

    Test-PowerShellVersion
    Install-RequiredModules
    Initialize-ProjectEnvironment
    Test-Dependencies

    Write-Host "`n✓ Setup completed successfully!" -ForegroundColor Green
    Write-Host "`nYou can now run the example script:" -ForegroundColor Cyan
    Write-Host "  pwsh ./example.ps1" -ForegroundColor Yellow
}
catch {
    Write-Error "`n✗ Setup failed: $($_.Exception.Message)"
    exit 1
}
