<#
.SYNOPSIS
    Creates the domain knowledge repository structure with templates.
.DESCRIPTION
    Initializes the required directory structure and creates template files
    for domain knowledge management according to the Domain Grooming Protocol.
.EXAMPLE
    ./Initialize-DomainKnowledge.ps1 -Path "./DomainKnowledge"
#>
[CmdletBinding()]
param(
    [Parameter(Mandatory=$false)]
    [string]$Path = "./DomainKnowledge"
)

# Track success/failure for reporting
$CreatedItems = @()
$FailedItems = @()

try {
    # Ensure the base directory exists
    if (-not (Test-Path -Path $Path)) {
        New-Item -Path $Path -ItemType Directory -ErrorAction Stop | Out-Null
        $CreatedItems += "Base directory: $Path"
        Write-Host "Created base directory: $Path" -ForegroundColor Green
    } else {
        Write-Host "Using existing directory: $Path" -ForegroundColor Cyan
    }

    # Create required subdirectories
    $RequiredDirs = @(
        (Join-Path -Path $Path -ChildPath "SessionNotes"),
        (Join-Path -Path $Path -ChildPath "QualifyingResponses"),
        (Join-Path -Path $Path -ChildPath "QualifyingResponses/Terms"),
        (Join-Path -Path $Path -ChildPath "QualifyingResponses/Contexts"),
        (Join-Path -Path $Path -ChildPath "QualifyingResponses/Entities"),
        (Join-Path -Path $Path -ChildPath "Scripts")
    )

    foreach ($Dir in $RequiredDirs) {
        if (-not (Test-Path -Path $Dir)) {
            New-Item -Path $Dir -ItemType Directory -ErrorAction Stop | Out-Null
            $CreatedItems += "Directory: $Dir"
            Write-Host "Created directory: $Dir" -ForegroundColor Green
        }
    }

    # Templates for core documentation files
    $Templates = @{
        "Glossary.md" = @"
# Domain Glossary

This document contains all domain-specific terms and their contextual variations.

## [Example Term]

**Core Definition:** Essential meaning of the term

**Context Variations:**
- **[Context A]:** Definition specific to Context A
- **[Context B]:** Definition specific to Context B

**Relationships:** Related terms

**Boundary Markers:** Signals that indicate meaning shifts

**Status:** Proposed

**Qualifying Analysis:** [Link to qualifying questions responses]
"@
        "Contexts.md" = @"
# Domain Contexts

This document defines all identified contexts and their boundaries.

## [Example Context]

**Definition:** Precise definition of this context

**Boundary Indicators:** Signals that activate this context

**Key Terms:**
- **[Term A]:** Context-specific definition
- **[Term B]:** Context-specific definition

**Transition Warnings:** Terms with high misinterpretation risk

**Qualifying Analysis:** [Link to qualifying questions responses]
"@
        "EntityMap.md" = @"
# Domain Entity Map

This document maps all essential domain entities and their relationships.

## [Example Entity]

**Core Definition:** Essential meaning

**Contextual Variations:**
- **[Context A]:** View in Context A
- **[Context B]:** View in Context B

**Critical Attributes:** 
- AttributeA: Description with business significance

**Key Relationships:**
- RelationshipType with [Other Entity]: Description

**Qualifying Analysis:** [Link to qualifying questions responses]
"@
    }

    # Create template files if they don't exist
    foreach ($TemplateName in $Templates.Keys) {
        $TemplateFilePath = Join-Path -Path $Path -ChildPath $TemplateName
        if (-not (Test-Path -Path $TemplateFilePath)) {
            $Templates[$TemplateName] | Out-File -FilePath $TemplateFilePath -Encoding utf8
            $CreatedItems += "File: $TemplateFilePath"
            Write-Host "Created template file: $TemplateFilePath" -ForegroundColor Green
        } else {
            Write-Host "Using existing file: $TemplateFilePath" -ForegroundColor Cyan
        }
    }

    # List of scripts to copy to scripts directory
    $ScriptNames = @(
        "Initialize-DomainKnowledge.ps1",
        "New-GlossaryEntry.ps1",
        "New-ContextDefinition.ps1",
        "New-EntityEntry.ps1",
        "New-SessionTemplate.ps1",
        "New-QualifyingQuestions.ps1",
        "Test-DomainConsistency.ps1"
    )

    # Get current script path to copy from
    $CurrentScriptDir = Split-Path -Path $MyInvocation.MyCommand.Path -Parent

    foreach ($ScriptName in $ScriptNames) {
        $SourcePath = Join-Path -Path $CurrentScriptDir -ChildPath $ScriptName
        $TargetPath = Join-Path -Path (Join-Path -Path $Path -ChildPath "Scripts") -ChildPath $ScriptName
        
        if ($ScriptName -ne "Initialize-DomainKnowledge.ps1") {
            if (Test-Path -Path $SourcePath) {
                try {
                    Copy-Item -Path $SourcePath -Destination $TargetPath -ErrorAction Stop
                    $CreatedItems += "Script: $TargetPath"
                    Write-Host "Copied script: $TargetPath" -ForegroundColor Green
                } catch {
                    $FailedItems += "Failed to copy script $ScriptName - see error log"
                    Write-Warning "Failed to copy script $ScriptName - see error log"
                    Write-Warning $_.Exception.Message
                }
            } else {
                $FailedItems += "Source script not found: $SourcePath"
                Write-Warning "Source script not found: $SourcePath. This is normal for initial installation."
            }
        }
    }

    # Summary
    Write-Host "`nDomain knowledge repository initialized successfully at: $Path" -ForegroundColor Green
    Write-Host "Created $($CreatedItems.Count) items" -ForegroundColor Green
    
    if ($FailedItems.Count -gt 0) {
        Write-Warning "Failed to create $($FailedItems.Count) items"
        foreach ($FailedItem in $FailedItems) {
            Write-Warning $FailedItem
        }
    }
} catch {
    Write-Error "Failed to initialize domain knowledge repository: $_"
    return $false
}

return $true 