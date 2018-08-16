#requires -version 5
#requires -RunAsAdministrator

function Remove-MSStoreApps {
    <#
    .DESCRIPTION
    Invoke Windows Store App Removals

    .PARAMETER ScriptSource
    URL to source script (github repo)

    .PARAMETER ForceDownload
    Download source script even if local copy exists

    .EXAMPLE
    Remove-MSStoreApps -Verbose

    .NOTES
    David Stein 08/15/2018
    #>
    [CmdletBinding()]
    param (
        [parameter(Mandatory=$False, HelpMessage="Source URL")]
        [ValidateNotNullOrEmpty()]
        [string] $ScriptSource = "https://raw.githubusercontent.com/Sycnex/Windows10Debloater/master/Windows10SysPrepDebloater.ps1",
        [parameter(Mandatory=$False, HelpMessage="Force new download")]
        [switch] $ForceDownload
    )

    $baseName  = "Windows10SysPrepDebloater.ps1"
    $localFile = Join-Path -Path $env:TEMP -ChildPath $baseName

    if (-not(Test-Path $localFile) -or $ForceDownload) {
        try {
            Write-Host "downloading: $ScriptSource" -ForegroundColor Cyan
            $(New-Object System.Net.WebClient).DownloadFile($ScriptSource, $localFile) | Out-Null
        }
        catch {
            Write-Warning $_.Exception.Message
        }
    }
    if (Test-Path $localFile) {
        Write-Verbose "downloaded successfully"
        Set-Location $env:TEMP
        .\Windows10SysPrepDebloater.ps1 -Debloat -Sysprep -StopEdgePDF -Privacy
        Write-Host "finished" -ForegroundColor Green
    }
    else {
        Write-Warning "failed to download script"
    }
}
Export-ModuleMember -Function "Remove-MSStoreApps"
