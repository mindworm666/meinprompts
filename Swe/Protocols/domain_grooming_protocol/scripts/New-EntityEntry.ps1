<#
.SYNOPSIS
    Creates a new entity entry with proper formatting.
.DESCRIPTION
    Adds a new entity to the EntityMap.md file with the mandatory
    structure required by the Domain Grooming Protocol.
.EXAMPLE
    ./New-EntityEntry.ps1 -Name "Customer" -Definition "An individual or organization that purchases products or services"
.PARAMETER Name
    The name of the entity to add.
.PARAMETER Definition
    The core definition of the entity.
.PARAMETER QualifyingRef
    Reference to the qualifying questions document for this entity.
.PARAMETER EntityMapPath
    Path to the entity map markdown file.
.PARAMETER ContextualVariations
    Optional hashtable of contexts and their specific views of this entity.
.PARAMETER Attributes
    Optional array of critical attributes that define this entity.
.PARAMETER Relationships
    Optional hashtable of relationships with other entities.
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
    [string]$EntityMapPath = "./DomainKnowledge/EntityMap.md",

    [Parameter(Mandatory=$false)]
    [hashtable]$ContextualVariations = @{},

    [Parameter(Mandatory=$false)]
    [string[]]$Attributes = @(),

    [Parameter(Mandatory=$false)]
    [hashtable]$Relationships = @{}
)

try {
    # Backup the entity map file if it exists
    if (Test-Path -Path $EntityMapPath) {
        $BackupPath = "$EntityMapPath.bak"
        Copy-Item -Path $EntityMapPath -Destination $BackupPath -Force -ErrorAction Stop
        Write-Verbose "Created backup of entity map at: $BackupPath"
    }

    # Check for qualifying questions
    if ([string]::IsNullOrEmpty($QualifyingRef)) {
        # Generate qualifying questions if not provided
        $QualifyingScript = Join-Path -Path (Split-Path -Path $MyInvocation.MyCommand.Path) -ChildPath "New-QualifyingQuestions.ps1"
        if (Test-Path -Path $QualifyingScript) {
            Write-Host "PROTOCOL ENFORCEMENT: Generating qualifying questions for entity '$Name'" -ForegroundColor Yellow
            $QualifyingRef = & $QualifyingScript -Type "Entity" -Name $Name
            if (-not $QualifyingRef) {
                Write-Error "Failed to generate qualifying questions for entity '$Name'"
                return $false
            }
            
            # Make the reference relative to the entity map
            $EntityMapDir = Split-Path -Path $EntityMapPath -Parent
            $QualifyingRef = $QualifyingRef -replace [regex]::Escape($EntityMapDir), ""
            $QualifyingRef = $QualifyingRef.TrimStart("\", "/")
            
            Write-Host "PROTOCOL WARNING: Qualifying questions MUST be answered before entity is finalized" -ForegroundColor Yellow
        } else {
            Write-Error "PROTOCOL VIOLATION: Cannot proceed without qualifying questions script"
            return $false
        }
    }

    # Ensure entity map file exists
    if (-not (Test-Path -Path $EntityMapPath)) {
        # Create entity map file with header
        $EntityMapHeader = @"
# Domain Entity Map

This document maps all essential domain entities and their relationships as defined by the Domain Grooming Protocol.

"@
        $EntityMapHeader | Out-File -FilePath $EntityMapPath -Encoding utf8 -NoNewline
        Write-Host "Created new entity map file at: $EntityMapPath" -ForegroundColor Green
    }

    # Check if entity already exists
    $EntityMapContent = Get-Content -Path $EntityMapPath -Raw
    if ($EntityMapContent -match "## $([regex]::Escape($Name))(\s|$)") {
        Write-Warning "Entity '$Name' already exists in the entity map."
        return $false
    }

    # Build contextual variations section
    $VariationsSection = "**Contextual Variations:**`n"
    if ($ContextualVariations.Count -gt 0) {
        foreach ($ContextName in $ContextualVariations.Keys) {
            $ContextView = $ContextualVariations[$ContextName]
            $VariationsSection += "- **[$ContextName]:** $ContextView`n"
        }
    } else {
        $VariationsSection += "- **[Context A]:** TBD`n- **[Context B]:** TBD`n"
    }

    # Build attributes section
    $AttributesSection = "**Critical Attributes:**`n"
    if ($Attributes.Count -gt 0) {
        foreach ($Attribute in $Attributes) {
            $AttributesSection += "- $Attribute`n"
        }
    } else {
        $AttributesSection += "- TBD`n"
    }

    # Build relationships section
    $RelationshipsSection = "**Key Relationships:**`n"
    if ($Relationships.Count -gt 0) {
        foreach ($RelatedEntity in $Relationships.Keys) {
            $Relationship = $Relationships[$RelatedEntity]
            $RelationshipsSection += "- $Relationship with [$RelatedEntity]`n"
        }
    } else {
        $RelationshipsSection += "- TBD`n"
    }

    # Create new entity entry
    $NewEntry = @"

## $Name

**Core Definition:** $Definition

$VariationsSection
$AttributesSection
$RelationshipsSection
**Qualifying Analysis:** [$Name Qualifying Questions]($QualifyingRef)
"@

    # Append to entity map
    Add-Content -Path $EntityMapPath -Value $NewEntry -Encoding UTF8

    Write-Host "Added new entity '$Name' to the entity map." -ForegroundColor Green
    Write-Host "PROTOCOL REMINDER: Complete qualifying questions at: $QualifyingRef" -ForegroundColor Cyan
    return $true
} catch {
    Write-Error "Failed to add entity '$Name' to entity map: $_"
    
    # Restore backup if available
    $BackupPath = "$EntityMapPath.bak"
    if (Test-Path -Path $BackupPath) {
        Copy-Item -Path $BackupPath -Destination $EntityMapPath -Force -ErrorAction SilentlyContinue
        Write-Host "Restored entity map from backup." -ForegroundColor Yellow
    }
    
    return $false
} 