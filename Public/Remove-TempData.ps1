#requires -RunAsAdministrator
#requires -Version 3
function Remove-TempData {
    [CmdletBinding()]
    param (
        [parameter(Mandatory=$False, HelpMessage="Scope")]
        [ValidateSet('User','Machine')]
        [string] $Scope = 'User'
    )
    try {
        Get-ChildItem -Path $env:TEMP -Include *.* -Recurse -ErrorAction SilentlyContinue | 
            Remove-Item -ErrorAction SilentlyContinue | Out-Null
        #Remove-Item -Path $env:TEMP -Recurse -Force -ErrorAction SilentlyContinue | Out-Null
    }
    catch {
        Write-Warning $_.Exception.Message
    }
    if ($Scope -eq 'Machine') {
        try {
            Get-ChildItem -Path "c:\windows\temp" -Include *.* -Recurse -ErrorAction SilentlyContinue | 
                Remove-Item -ErrorAction SilentlyContinue | Out-Null
            #Remove-Item -Path "c:\windows\temp" -Recurse -Force -ErrorAction SilentlyContinue | Out-Null
        }
        catch {
            Write-Warning $_.Exception.Message
        }
    }
    Write-Host "finished"
}

Export-ModuleMember -Function "Remove-TempData"
