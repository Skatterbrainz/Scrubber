function Join-Url {
    <#
    .DESCRIPTION
    Join-Path but for URL strings instead
    
    .PARAMETER Path
    Base path string
    
    .PARAMETER ChildPath
    Child path or item name

    .PARAMETER AdditionalChildPath
    Additional child path or item name
    
    .EXAMPLE
    Join-Url -Path "https://www.contoso.local" -ChildPath "foo.htm"
    returns "https://www.contoso.local/foo.htm"

    .EXAMPLE
    Join-Url -Path "https://www.contoso.local/" -ChildPath "/inner/" -AdditionalChildPath "foo.htm"
    returns "https://www.contoso.local/inner/foo.htm"

    #>
    param (
        [parameter(Mandatory=$True, HelpMessage="Base Path")]
        [ValidateNotNullOrEmpty()]
        [string] $Path,
        [parameter(Mandatory=$True, HelpMessage="Child Path or Item Name")]
        [ValidateNotNullOrEmpty()]
        [string] $ChildPath,
        [Parameter(Mandatory=$False, HelpMessage="Additional Child Path or Item Name")]
        [string[]] $AdditionalChildPath
    )
    $CleanedPath = $Path -replace '\/$'
    $CleanedChildPath = $ChildPath -replace '^\/'
    $JoinedPath = "$CleanedPath/$CleanedChildPath"

    $NextChild, $AdditionalChild = $AdditionalChildPath
    $FullPath = if ($NextChild) {
        Join-Url -Path $JoinedPath -ChildPath $NextChild `
        -AdditionalChildPath $AdditionalChild
    }
    else {
        $JoinedPath
    }

    return $FullPath
}