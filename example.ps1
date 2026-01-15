<#
.SYNOPSIS
    Example PowerShell script demonstrating common patterns

.DESCRIPTION
    This script shows PowerShell best practices including:
    - Parameter validation
    - Error handling
    - Output formatting
    - Cmdlet binding
#>

[CmdletBinding()]
param(
    [Parameter(Mandatory = $false)]
    [ValidateRange(1, 100)]
    [int]$Count = 10,

    [Parameter(Mandatory = $false)]
    [ValidateSet("Info", "Warning", "Error")]
    [string]$LogLevel = "Info"
)

function Write-LogMessage {
    <#
    .SYNOPSIS
        Internal function for consistent logging
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [string]$Message,

        [Parameter(Mandatory = $false)]
        [ValidateSet("Info", "Warning", "Error")]
        [string]$Level = "Info"
    )

    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $logMessage = "[$timestamp] [$Level] $Message"

    switch ($Level) {
        "Error"   { Write-Error $logMessage }
        "Warning" { Write-Warning $logMessage }
        default   { Write-Host $logMessage }
    }
}

try {
    Write-LogMessage "Starting example script..." -Level $LogLevel

    # Example: Process items
    for ($i = 1; $i -le $Count; $i++) {
        $item = [PSCustomObject]@{
            Id = $i
            Name = "Item $i"
            Value = $i * 2
            Created = Get-Date
        }

        Write-LogMessage "Processing: $($item.Name) (Value: $($item.Value))" -Level $LogLevel
    }

    Write-LogMessage "Script completed successfully!" -Level $LogLevel
}
catch {
    Write-LogMessage "Error occurred: $($_.Exception.Message)" -Level "Error"
    throw
}
