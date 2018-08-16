---
external help file: Scrubber-help.xml
Module Name: Scrubber
online version:
schema: 2.0.0
---

# Remove-MSOffice

## SYNOPSIS

## SYNTAX

```
Remove-MSOffice [[-ScriptSource] <String>] [-ForceDownload] [<CommonParameters>]
```

## DESCRIPTION
Rip out Office products by the roots

## EXAMPLES

### EXAMPLE 1
```
Remove-MSOffice -Verbose
```

## PARAMETERS

### -ScriptSource
Source URL to the MS Office Scrub scripts (github repo)

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: Https://raw.githubusercontent.com/OfficeDev/Office-IT-Pro-Deployment-Scripts/master/Office-ProPlus-Deployment/Remove-PreviousOfficeInstalls
Accept pipeline input: False
Accept wildcard characters: False
```

### -ForceDownload
Download source scripts even if local copies exist

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable.
For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
David Stein 08/15/2018

## RELATED LINKS
