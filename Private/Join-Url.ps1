function Join-Url {
    <#
    .DESCRIPTION
    Join-Path but for URL strings instead
    
    .PARAMETER Path
    Base path string
    
    .PARAMETER ChildPath
    Child path or item name
    
    .EXAMPLE
    Join-Url -Path "https://www.contoso.local" -ChildPath "foo.htm"
    returns "https://www.contoso.local/foo.htm"

    #>
    param (
        [parameter(Mandatory=$True, HelpMessage="Base Path")]
        [ValidateNotNullOrEmpty()]
        [string] $Path,
        [parameter(Mandatory=$True, HelpMessage="Child Path or Item Name")]
        [ValidateNotNullOrEmpty()]
        [string] $ChildPath
    )
    if ($Path.EndsWith('/')) {
        return "$Path"+"$ChildPath"
    }
    else {
        return "$Path/$ChildPath"
    }
}
