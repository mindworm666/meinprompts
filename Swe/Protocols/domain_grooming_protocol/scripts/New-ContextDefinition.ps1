<#
.SYNOPSIS
    Creates a new context definition with proper formatting.
.DESCRIPTION
    Adds a new context to the Contexts.md file with the mandatory
    structure required by the Domain Grooming Protocol.
.EXAMPLE
    ./New-ContextDefinition.ps1 -Name "OrderProcessing" -Definition "The context where customer orders are processed and fulfilled"
.PARAMETER Name
    The name of the context to add.
.PARAMETER Definition
    The definition of the context.
.PARAMETER QualifyingRef
    Reference to the qualifying questions document for this context.
.PARAMETER ContextsPath
    Path to the contexts markdown file.
.PARAMETER KeyTerms
    Optional hashtable of terms and their context-specific definitions.
.NOTES
    Part of the Domain Grooming Protocol toolkit for systematic domain knowledge capture.
#>
[CmdletBinding()]
param(
    [Parameter(Mandatory=$true)]
    [string]$Name,
    
    [Parameter(Mandatory=$false)]
    [string]$Definition = "TBD",
    
    [Parameter(Mandatory=$false)]
    [string]$QualifyingRef = "",
    
    [Parameter(Mandatory=$false)]
    [string]$ContextsPath = "./DomainKnowledge/Contexts.md",

    [Parameter(Mandatory=$false)]
    [hashtable]$KeyTerms = @{}
)

try {
    # Backup the contexts file if it exists
    if (Test-Path -Path $ContextsPath) {
        $BackupPath = "$ContextsPath.bak"
        Copy-Item -Path $ContextsPath -Destination $BackupPath -Force -ErrorAction Stop
        Write-Verbose "Created backup of contexts file at: $BackupPath"
    }

    # Check for qualifying questions
    if ([string]::IsNullOrEmpty($QualifyingRef)) {
        # Generate qualifying questions if not provided
        $QualifyingScript = Join-Path -Path (Split-Path -Path $MyInvocation.MyCommand.Path) -ChildPath "New-QualifyingQuestions.ps1"
        if (Test-Path -Path $QualifyingScript) {
            Write-Host "PROTOCOL ENFORCEMENT: Generating qualifying questions for context '$Name'" -ForegroundColor Yellow
            $QualifyingRef = & $QualifyingScript -Type "Context" -Name $Name
            if (-not $QualifyingRef) {
                Write-Error "Failed to generate qualifying questions for context '$Name'"
                return $false
            }
            
            # Make the reference relative to the contexts file
            $ContextsDir = Split-Path -Path $ContextsPath -Parent
            $QualifyingRef = $QualifyingRef -replace [regex]::Escape($ContextsDir), ""
            $QualifyingRef = $QualifyingRef.TrimStart("\", "/")
            
            Write-Host "PROTOCOL WARNING: Qualifying questions MUST be answered before context is finalized" -ForegroundColor Yellow
        } else {
            Write-Error "PROTOCOL VIOLATION: Cannot proceed without qualifying questions script"
            return $false
        }
    }

    # Ensure contexts file exists
    if (-not (Test-Path -Path $ContextsPath)) {
        # Create contexts file with header
        $ContextsHeader = @"
# Domain Contexts

This document defines all identified contexts and their boundaries as defined by the Domain Grooming Protocol.

"@
        $ContextsHeader | Out-File -FilePath $ContextsPath -Encoding utf8 -NoNewline
        Write-Host "Created new contexts file at: $ContextsPath" -ForegroundColor Green
    }

    # Check if context already exists
    $ContextsContent = Get-Content -Path $ContextsPath -Raw
    if ($ContextsContent -match "## $([regex]::Escape($Name))(\s|$)") {
        Write-Warning "Context '$Name' already exists in the contexts file."
        return $false
    }

    # Build key terms section
    $KeyTermsSection = "**Key Terms:**`n"
    if ($KeyTerms.Count -gt 0) {
        foreach ($TermName in $KeyTerms.Keys) {
            $TermDef = $KeyTerms[$TermName]
            $KeyTermsSection += "- **[$TermName]:** $TermDef`n"
        }
    } else {
        $KeyTermsSection += "- **[Term A]:** TBD`n- **[Term B]:** TBD`n"
    }

    # Create new context entry
    $NewEntry = @"

## $Name

**Definition:** $Definition

**Boundary Indicators:** TBD

$KeyTermsSection
**Transition Warnings:** TBD

**Qualifying Analysis:** [$Name Qualifying Questions]($QualifyingRef)
"@

    # Append to contexts file
    Add-Content -Path $ContextsPath -Value $NewEntry -Encoding UTF8

    Write-Host "Added new context '$Name' to the contexts file." -ForegroundColor Green
    Write-Host "PROTOCOL REMINDER: Complete qualifying questions at: $QualifyingRef" -ForegroundColor Cyan
    return $true
} catch {
    Write-Error "Failed to add context '$Name' to contexts file: $_"
    
    # Restore backup if available
    $BackupPath = "$ContextsPath.bak"
    if (Test-Path -Path $BackupPath) {
        Copy-Item -Path $BackupPath -Destination $ContextsPath -Force -ErrorAction SilentlyContinue
        Write-Host "Restored contexts file from backup." -ForegroundColor Yellow
    }
    
    return $false
} 