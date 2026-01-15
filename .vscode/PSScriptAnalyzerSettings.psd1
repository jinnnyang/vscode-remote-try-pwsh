@{
    # Only disable rules that are truly not applicable to this project
    Rules = @{
        PSUseShouldProcessForStateChangingFunctions = @{
            Enable = $true
        }
        PSAvoidUsingWriteHost                       = @{
            Enable = $false
        }
        PSAvoidUsingCmdletAliases                   = @{
            Enable = $true
        }
        PSUseSingularNouns                          = @{
            Enable = $true
        }
        PSUseDeclaredVarsMoreThanAssignments        = @{
            Enable = $true
        }
    }
}
