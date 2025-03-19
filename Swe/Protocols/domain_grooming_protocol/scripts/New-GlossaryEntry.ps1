<#
.SYNOPSIS
    Creates a new glossary entry with proper formatting.
.DESCRIPTION
    Adds a new term to the Glossary.md file with the mandatory
    structure required by the Domain Grooming Protocol.
.EXAMPLE
    ./New-GlossaryEntry.ps1 -Term "CustomerOrder" -Definition "A record of items purchased by a customer" -QualifyingRef "QualifyingResponses/Terms/CustomerOrder.md"
.PARAMETER Term
    The term to add to the glossary.
.PARAMETER Definition
    The core definition of the term.
.PARAMETER QualifyingRef
    Reference to the qualifying questions document for this term.
.PARAMETER GlossaryPath
    Path to the glossary markdown file.
.PARAMETER Contexts
    Optional hashtable of contexts and their specific definitions for this term.
.NOTES
    Part of the Domain Grooming Protocol toolkit for systematic domain knowledge capture.
#>
[CmdletBinding()]
param(
    [Parameter(Mandatory=$true)]
    [string]$Term,
    
    [Parameter(Mandatory=$false)]
    [string]$Definition = "TBD",
    
    [Parameter(Mandatory=$false)]
    [string]$QualifyingRef = "",
    
    [Parameter(Mandatory=$false)]
    [string]$GlossaryPath = "./DomainKnowledge/Glossary.md",

    [Parameter(Mandatory=$false)]
    [hashtable]$Contexts = @{}
)

try {
    # Backup the glossary file if it exists
    if (Test-Path -Path $GlossaryPath) {
        $BackupPath = "$GlossaryPath.bak"
        Copy-Item -Path $GlossaryPath -Destination $BackupPath -Force -ErrorAction Stop
        Write-Verbose "Created backup of glossary at: $BackupPath"
    }

    # Check for qualifying questions
    if ([string]::IsNullOrEmpty($QualifyingRef)) {
        # Generate qualifying questions if not provided
        $QualifyingScript = Join-Path -Path (Split-Path -Path $MyInvocation.MyCommand.Path) -ChildPath "New-QualifyingQuestions.ps1"
        if (Test-Path -Path $QualifyingScript) {
            Write-Host "PROTOCOL ENFORCEMENT: Generating qualifying questions for '$Term'" -ForegroundColor Yellow
            $QualifyingRef = & $QualifyingScript -Type "Term" -Name $Term
            if (-not $QualifyingRef) {
                Write-Error "Failed to generate qualifying questions for term '$Term'"
                return $false
            }
            
            # Make the reference relative to the glossary
            $GlossaryDir = Split-Path -Path $GlossaryPath -Parent
            $QualifyingRef = $QualifyingRef -replace [regex]::Escape($GlossaryDir), ""
            $QualifyingRef = $QualifyingRef.TrimStart("\", "/")
            
            Write-Host "PROTOCOL WARNING: Qualifying questions MUST be answered before term is finalized" -ForegroundColor Yellow
        } else {
            Write-Error "PROTOCOL VIOLATION: Cannot proceed without qualifying questions script"
            return $false
        }
    }

    # Ensure glossary file exists
    if (-not (Test-Path -Path $GlossaryPath)) {
        # Create glossary file with header
        $GlossaryHeader = @"
# Domain Glossary

This document contains all domain-specific terms and their contextual variations as defined by the Domain Grooming Protocol.

"@
        $GlossaryHeader | Out-File -FilePath $GlossaryPath -Encoding utf8 -NoNewline
        Write-Host "Created new glossary file at: $GlossaryPath" -ForegroundColor Green
    }

    # Check if term already exists
    $GlossaryContent = Get-Content -Path $GlossaryPath -Raw
    if ($GlossaryContent -match "## $([regex]::Escape($Term))(\s|$)") {
        Write-Warning "Term '$Term' already exists in the glossary."
        return $false
    }

    # Build context variations section
    $ContextVariations = "**Context Variations:**`n"
    if ($Contexts.Count -gt 0) {
        foreach ($ContextName in $Contexts.Keys) {
            $ContextDef = $Contexts[$ContextName]
            $ContextVariations += "- **[$ContextName]:** $ContextDef`n"
        }
    } else {
        $ContextVariations += "- **[Context A]:** TBD`n- **[Context B]:** TBD`n"
    }

    # Create new term entry
    $NewEntry = @"

## $Term

**Core Definition:** $Definition

$ContextVariations
**Relationships:** TBD

**Boundary Markers:** TBD

**Status:** Proposed

**Qualifying Analysis:** [$Term Qualifying Questions]($QualifyingRef)
"@

    # Append to glossary
    Add-Content -Path $GlossaryPath -Value $NewEntry -Encoding UTF8

    Write-Host "Added new term '$Term' to the glossary." -ForegroundColor Green
    Write-Host "PROTOCOL REMINDER: Complete qualifying questions at: $QualifyingRef" -ForegroundColor Cyan
    return $true
} catch {
    Write-Error "Failed to add term '$Term' to glossary: $_"
    
    # Restore backup if available
    $BackupPath = "$GlossaryPath.bak"
    if (Test-Path -Path $BackupPath) {
        Copy-Item -Path $BackupPath -Destination $GlossaryPath -Force -ErrorAction SilentlyContinue
        Write-Host "Restored glossary from backup." -ForegroundColor Yellow
    }
    
    return $false
} 