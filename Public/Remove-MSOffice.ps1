#requires -version 5
#requires -RunAsAdministrator

function Remove-MSOffice {
    <#
    .DESCRIPTION
    Rip out Office products by the roots

    .PARAMETER ScriptSource
    Source URL to the MS Office Scrub scripts (github repo)

    .PARAMETER ForceDownload
    Download source scripts even if local copies exist

    .EXAMPLE
    Remove-MSOffice -Verbose

    .NOTES
    David Stein 08/15/2018

    #>
    [CmdletBinding()]
    param (
        [parameter(Mandatory=$False, HelpMessage="Source URL")]
        [ValidateNotNullOrEmpty()]
        [string] $ScriptSource = "https://raw.githubusercontent.com/OfficeDev/Office-IT-Pro-Deployment-Scripts/master/Office-ProPlus-Deployment/Remove-PreviousOfficeInstalls",
        [parameter(Mandatory=$False, HelpMessage="Force new download")]
        [switch] $ForceDownload
    )
    $continue = $True

    $files = @("OffScrub03.vbs","OffScrub07.vbs","OffScrub10.vbs","OffScrub_O15msi.vbs",
        "OffScrub_O16msi.vbs","OffScrubc2r.vbs","Remove-PreviousOfficeInstalls.ps1")
    
    Write-Host "downloading source files from remote repository" -ForegroundColor Green
    
    foreach ($f in $files) {
        $remoteFile = Join-Url -Path $ScriptSource -ChildPath $f
        $localFile  = Join-Path -Path $env:TEMP -ChildPath $f
        if (-not(Test-Path $localFile) -or $ForceDownload) {
            Write-Verbose "downloading: $remoteFile"
            try {
                $(New-Object System.Net.WebClient).DownloadFile($remoteFile, $localFile) | Out-Null
            }
            catch {
                Write-Warning $_.Exception.Message
            }
        }
        if (Test-Path $localFile) {
            Write-Verbose "downloaded successfully to: $localFile"
        }
        else {
            Write-Warning "error: failed to download"
            $continue = $null
        }
    }
    if ($continue) {
        Write-Verbose "finished downloading source files"
        Write-Verbose "saving current working location"
        $cwd = Get-Location
        Write-Verbose "changing to temp location"
        Set-Location -Path $env:TEMP
        Write-Verbose "invoking script: Remove-PreviousOfficeInstalls.ps1"
        .\Remove-PreviousOfficeInstalls.ps1
        Write-Verbose "restoring previous working location"
        Set-Location -Path $cwd
        Write-Host "finished" -ForegroundColor Green
    }
    else {
        Write-Warning "failed to download source files, skipping execution"
    }
}

Export-ModuleMember -Function "Remove-MSOffice"
