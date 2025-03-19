<#
.SYNOPSIS
    Validates domain knowledge documentation for consistency.
.DESCRIPTION
    Checks the domain knowledge markdown files for formatting issues,
    missing cross-references, and other consistency problems. This 
    script helps maintain the integrity of your domain knowledge base.
.EXAMPLE
    ./Test-DomainConsistency.ps1 -DomainPath "./MyProject/DomainKnowledge"
.PARAMETER DomainPath
    Path to the domain knowledge directory.
.PARAMETER Strict
    When enabled, treats warnings as errors, resulting in a non-zero exit code.
.PARAMETER OutputFormat
    Format for output: "Text" (default), "JSON", or "CSV".
.NOTES
    Part of the Domain Grooming Protocol toolkit for systematic domain knowledge capture.
#>
[CmdletBinding()]
param(
    [Parameter(Mandatory=$false)]
    [string]$DomainPath = "./DomainKnowledge",
    
    [Parameter(Mandatory=$false)]
    [switch]$Strict,
    
    [Parameter(Mandatory=$false)]
    [ValidateSet("Text", "JSON", "CSV")]
    [string]$OutputFormat = "Text"
)

# Initialize result tracking
$Issues = New-Object System.Collections.ArrayList
$Stats = @{
    TermCount = 0
    ContextCount = 0
    EntityCount = 0
    QualifyingCount = 0
    CriticalIssues = 0
    WarningIssues = 0
    InfoIssues = 0
}

function Add-Issue {
    param (
        [Parameter(Mandatory=$true)]
        [ValidateSet("CRITICAL", "WARNING", "INFO")]
        [string]$Severity,
        
        [Parameter(Mandatory=$true)]
        [string]$Message,
        
        [Parameter(Mandatory=$false)]
        [string]$ItemName = "",
        
        [Parameter(Mandatory=$false)]
        [string]$ItemType = "",
        
        [Parameter(Mandatory=$false)]
        [string]$FilePath = ""
    )
    
    $Issue = [PSCustomObject]@{
        Severity = $Severity
        Message = $Message
        ItemName = $ItemName
        ItemType = $ItemType
        FilePath = $FilePath
        Timestamp = Get-Date
    }
    
    $null = $Issues.Add($Issue)
    
    switch ($Severity) {
        "CRITICAL" { $Stats.CriticalIssues++ }
        "WARNING" { $Stats.WarningIssues++ }
        "INFO" { $Stats.InfoIssues++ }
    }
}

try {
    # Validate domain path exists
    if (-not (Test-Path -Path $DomainPath)) {
        Add-Issue -Severity "CRITICAL" -Message "Domain knowledge directory not found" -FilePath $DomainPath
        return $false
    }

    # Define expected file paths
    $GlossaryPath = Join-Path -Path $DomainPath -ChildPath "Glossary.md"
    $ContextsPath = Join-Path -Path $DomainPath -ChildPath "Contexts.md"
    $EntitiesPath = Join-Path -Path $DomainPath -ChildPath "EntityMap.md"
    $QualifyingPath = Join-Path -Path $DomainPath -ChildPath "QualifyingResponses"
    $SessionsPath = Join-Path -Path $DomainPath -ChildPath "SessionNotes"

    # Ensure all required files and directories exist
    if (-not (Test-Path -Path $GlossaryPath)) {
        Add-Issue -Severity "CRITICAL" -Message "Glossary.md is missing" -FilePath $GlossaryPath
    }
    if (-not (Test-Path -Path $ContextsPath)) {
        Add-Issue -Severity "CRITICAL" -Message "Contexts.md is missing" -FilePath $ContextsPath
    }
    if (-not (Test-Path -Path $EntitiesPath)) {
        Add-Issue -Severity "CRITICAL" -Message "EntityMap.md is missing" -FilePath $EntitiesPath
    }
    if (-not (Test-Path -Path $QualifyingPath)) {
        Add-Issue -Severity "CRITICAL" -Message "QualifyingResponses directory is missing" -FilePath $QualifyingPath
    }
    if (-not (Test-Path -Path $SessionsPath)) {
        Add-Issue -Severity "WARNING" -Message "SessionNotes directory is missing" -FilePath $SessionsPath
    }

    # If any critical files are missing, we can still proceed with partial validation
    # but we'll note the deficiencies

    # Load file contents if available
    $GlossaryContent = if (Test-Path -Path $GlossaryPath) { Get-Content -Path $GlossaryPath -Raw } else { "" }
    $ContextsContent = if (Test-Path -Path $ContextsPath) { Get-Content -Path $ContextsPath -Raw } else { "" }
    $EntitiesContent = if (Test-Path -Path $EntitiesPath) { Get-Content -Path $EntitiesPath -Raw } else { "" }

    # Extract terms, contexts, and entities
    $Terms = @()
    $TermMatches = if ($GlossaryContent) { [regex]::Matches($GlossaryContent, '(?m)^## (.+?)(?:\s|$)') } else { @() }
    foreach ($Match in $TermMatches) {
        $Terms += $Match.Groups[1].Value.Trim()
    }
    $Stats.TermCount = $Terms.Count

    $Contexts = @()
    $ContextMatches = if ($ContextsContent) { [regex]::Matches($ContextsContent, '(?m)^## (.+?)(?:\s|$)') } else { @() }
    foreach ($Match in $ContextMatches) {
        $Contexts += $Match.Groups[1].Value.Trim()
    }
    $Stats.ContextCount = $Contexts.Count

    $Entities = @()
    $EntityMatches = if ($EntitiesContent) { [regex]::Matches($EntitiesContent, '(?m)^## (.+?)(?:\s|$)') } else { @() }
    foreach ($Match in $EntityMatches) {
        $Entities += $Match.Groups[1].Value.Trim()
    }
    $Stats.EntityCount = $Entities.Count

    # Get qualifying questions directories
    $TermQualifyingDir = Join-Path -Path $QualifyingPath -ChildPath "Terms"
    $ContextQualifyingDir = Join-Path -Path $QualifyingPath -ChildPath "Contexts"
    $EntityQualifyingDir = Join-Path -Path $QualifyingPath -ChildPath "Entities"

    # Count qualifying question files
    $QualifyingTermCount = if (Test-Path -Path $TermQualifyingDir) { 
        (Get-ChildItem -Path $TermQualifyingDir -Filter "*.md" -ErrorAction SilentlyContinue).Count 
    } else { 0 }
    
    $QualifyingContextCount = if (Test-Path -Path $ContextQualifyingDir) { 
        (Get-ChildItem -Path $ContextQualifyingDir -Filter "*.md" -ErrorAction SilentlyContinue).Count 
    } else { 0 }
    
    $QualifyingEntityCount = if (Test-Path -Path $EntityQualifyingDir) { 
        (Get-ChildItem -Path $EntityQualifyingDir -Filter "*.md" -ErrorAction SilentlyContinue).Count 
    } else { 0 }
    
    $Stats.QualifyingCount = $QualifyingTermCount + $QualifyingContextCount + $QualifyingEntityCount

    # Validate qualifying question directories exist
    foreach ($Dir in @($TermQualifyingDir, $ContextQualifyingDir, $EntityQualifyingDir)) {
        if (-not (Test-Path -Path $Dir)) {
            $DirName = Split-Path -Path $Dir -Leaf
            Add-Issue -Severity "CRITICAL" -Message "QualifyingResponses/$DirName directory is missing" -FilePath $Dir
        }
    }

    # Check for terms missing required sections
    foreach ($Term in $Terms) {
        $TermSection = [regex]::Match($GlossaryContent, "(?sm)^## $([regex]::Escape($Term)).*?(?=^## |\z)").Value
        
        # Check for required sections
        if (-not ($TermSection -match "Core Definition:")) {
            Add-Issue -Severity "CRITICAL" -Message "Missing Core Definition section" -ItemName $Term -ItemType "Term" -FilePath $GlossaryPath
        }
        
        if (-not ($TermSection -match "Context Variations:")) {
            Add-Issue -Severity "WARNING" -Message "Missing Context Variations section" -ItemName $Term -ItemType "Term" -FilePath $GlossaryPath
        }
        
        if (-not ($TermSection -match "Relationships:")) {
            Add-Issue -Severity "WARNING" -Message "Missing Relationships section" -ItemName $Term -ItemType "Term" -FilePath $GlossaryPath
        }
        
        if (-not ($TermSection -match "Boundary Markers:")) {
            Add-Issue -Severity "WARNING" -Message "Missing Boundary Markers section" -ItemName $Term -ItemType "Term" -FilePath $GlossaryPath
        }
        
        if (-not ($TermSection -match "Status:")) {
            Add-Issue -Severity "WARNING" -Message "Missing Status section" -ItemName $Term -ItemType "Term" -FilePath $GlossaryPath
        }
        
        if (-not ($TermSection -match "Qualifying Analysis:")) {
            Add-Issue -Severity "CRITICAL" -Message "Missing Qualifying Analysis reference" -ItemName $Term -ItemType "Term" -FilePath $GlossaryPath
        }
        
        # Check for TBD values in critical fields
        if ($TermSection -match "Core Definition:\s*TBD") {
            Add-Issue -Severity "WARNING" -Message "Core Definition is TBD" -ItemName $Term -ItemType "Term" -FilePath $GlossaryPath
        }
        
        # Check for qualifying questions file
        $SafeName = $Term -replace '[\\/:*?"<>|]', '_'
        $ExpectedQualifyingFile = Join-Path -Path $TermQualifyingDir -ChildPath "$SafeName.md"
        if (-not (Test-Path -Path $ExpectedQualifyingFile)) {
            Add-Issue -Severity "CRITICAL" -Message "Missing qualifying questions file" -ItemName $Term -ItemType "Term" -FilePath $ExpectedQualifyingFile
        } else {
            # Check if qualifying questions have been answered
            $QualifyingContent = Get-Content -Path $ExpectedQualifyingFile -Raw
            if ($QualifyingContent -match "\[RECORD VERBATIM RESPONSE\]") {
                Add-Issue -Severity "WARNING" -Message "Qualifying questions not fully answered" -ItemName $Term -ItemType "Term" -FilePath $ExpectedQualifyingFile
            }
        }
    }

    # Check for contexts missing key information
    foreach ($Context in $Contexts) {
        $ContextSection = [regex]::Match($ContextsContent, "(?sm)^## $([regex]::Escape($Context)).*?(?=^## |\z)").Value
        
        # Check for required sections
        if (-not ($ContextSection -match "Definition:")) {
            Add-Issue -Severity "CRITICAL" -Message "Missing Definition section" -ItemName $Context -ItemType "Context" -FilePath $ContextsPath
        }
        
        if (-not ($ContextSection -match "Boundary Indicators:")) {
            Add-Issue -Severity "WARNING" -Message "Missing Boundary Indicators section" -ItemName $Context -ItemType "Context" -FilePath $ContextsPath
        }
        
        if (-not ($ContextSection -match "Key Terms:")) {
            Add-Issue -Severity "WARNING" -Message "Missing Key Terms section" -ItemName $Context -ItemType "Context" -FilePath $ContextsPath
        }
        
        if (-not ($ContextSection -match "Transition Warnings:")) {
            Add-Issue -Severity "WARNING" -Message "Missing Transition Warnings section" -ItemName $Context -ItemType "Context" -FilePath $ContextsPath
        }
        
        if (-not ($ContextSection -match "Qualifying Analysis:")) {
            Add-Issue -Severity "CRITICAL" -Message "Missing Qualifying Analysis reference" -ItemName $Context -ItemType "Context" -FilePath $ContextsPath
        }
        
        # Check for qualifying questions file
        $SafeName = $Context -replace '[\\/:*?"<>|]', '_'
        $ExpectedQualifyingFile = Join-Path -Path $ContextQualifyingDir -ChildPath "$SafeName.md"
        if (-not (Test-Path -Path $ExpectedQualifyingFile)) {
            Add-Issue -Severity "CRITICAL" -Message "Missing qualifying questions file" -ItemName $Context -ItemType "Context" -FilePath $ExpectedQualifyingFile
        }
    }

    # Check for entities missing information
    foreach ($Entity in $Entities) {
        $EntitySection = [regex]::Match($EntitiesContent, "(?sm)^## $([regex]::Escape($Entity)).*?(?=^## |\z)").Value
        
        # Check for required sections
        if (-not ($EntitySection -match "Core Definition:")) {
            Add-Issue -Severity "CRITICAL" -Message "Missing Core Definition section" -ItemName $Entity -ItemType "Entity" -FilePath $EntitiesPath
        }
        
        if (-not ($EntitySection -match "Contextual Variations:")) {
            Add-Issue -Severity "WARNING" -Message "Missing Contextual Variations section" -ItemName $Entity -ItemType "Entity" -FilePath $EntitiesPath
        }
        
        if (-not ($EntitySection -match "Critical Attributes:")) {
            Add-Issue -Severity "WARNING" -Message "Missing Critical Attributes section" -ItemName $Entity -ItemType "Entity" -FilePath $EntitiesPath
        }
        
        if (-not ($EntitySection -match "Key Relationships:")) {
            Add-Issue -Severity "WARNING" -Message "Missing Key Relationships section" -ItemName $Entity -ItemType "Entity" -FilePath $EntitiesPath
        }
        
        if (-not ($EntitySection -match "Qualifying Analysis:")) {
            Add-Issue -Severity "CRITICAL" -Message "Missing Qualifying Analysis reference" -ItemName $Entity -ItemType "Entity" -FilePath $EntitiesPath
        }
        
        # Check for qualifying questions file
        $SafeName = $Entity -replace '[\\/:*?"<>|]', '_'
        $ExpectedQualifyingFile = Join-Path -Path $EntityQualifyingDir -ChildPath "$SafeName.md"
        if (-not (Test-Path -Path $ExpectedQualifyingFile)) {
            Add-Issue -Severity "CRITICAL" -Message "Missing qualifying questions file" -ItemName $Entity -ItemType "Entity" -FilePath $ExpectedQualifyingFile
        }
    }

    # Generate report based on output format
    switch ($OutputFormat) {
        "JSON" {
            $Result = [PSCustomObject]@{
                Stats = $Stats
                Issues = $Issues
                Timestamp = Get-Date
            }
            $Result | ConvertTo-Json -Depth 5
        }
        "CSV" {
            $Issues | Export-Csv -Path "DomainConsistencyIssues.csv" -NoTypeInformation
            "CSV report saved to DomainConsistencyIssues.csv"
        }
        default { # Text output
            Write-Host "=== DOMAIN KNOWLEDGE CONSISTENCY REPORT ===" -ForegroundColor Cyan
            Write-Host "Terms: $($Stats.TermCount)" -ForegroundColor White
            Write-Host "Contexts: $($Stats.ContextCount)" -ForegroundColor White
            Write-Host "Entities: $($Stats.EntityCount)" -ForegroundColor White
            Write-Host "Qualifying Questions Files: $($Stats.QualifyingCount)" -ForegroundColor White
            Write-Host ""

            if ($Issues.Count -gt 0) {
                Write-Host "ISSUES FOUND: $($Issues.Count)" -ForegroundColor Yellow
                Write-Host "  Critical: $($Stats.CriticalIssues)" -ForegroundColor Red
                Write-Host "  Warnings: $($Stats.WarningIssues)" -ForegroundColor Yellow
                Write-Host "  Info: $($Stats.InfoIssues)" -ForegroundColor Gray
                Write-Host ""
                
                # Group issues by severity for better readability
                $CriticalIssues = $Issues | Where-Object { $_.Severity -eq "CRITICAL" }
                $WarningIssues = $Issues | Where-Object { $_.Severity -eq "WARNING" }
                $InfoIssues = $Issues | Where-Object { $_.Severity -eq "INFO" }
                
                if ($CriticalIssues.Count -gt 0) {
                    Write-Host "CRITICAL ISSUES:" -ForegroundColor Red
                    foreach ($Issue in $CriticalIssues) {
                        $ItemInfo = if ($Issue.ItemName) { "[$($Issue.ItemType)] $($Issue.ItemName)" } else { "" }
                        Write-Host "- $($Issue.Message) $ItemInfo" -ForegroundColor Red
                    }
                    Write-Host ""
                }
                
                if ($WarningIssues.Count -gt 0) {
                    Write-Host "WARNINGS:" -ForegroundColor Yellow
                    foreach ($Issue in $WarningIssues) {
                        $ItemInfo = if ($Issue.ItemName) { "[$($Issue.ItemType)] $($Issue.ItemName)" } else { "" }
                        Write-Host "- $($Issue.Message) $ItemInfo" -ForegroundColor Yellow
                    }
                    Write-Host ""
                }
                
                if ($InfoIssues.Count -gt 0 -and $Verbose) {
                    Write-Host "INFO:" -ForegroundColor Gray
                    foreach ($Issue in $InfoIssues) {
                        $ItemInfo = if ($Issue.ItemName) { "[$($Issue.ItemType)] $($Issue.ItemName)" } else { "" }
                        Write-Host "- $($Issue.Message) $ItemInfo" -ForegroundColor Gray
                    }
                    Write-Host ""
                }
                
                if ($Stats.CriticalIssues -gt 0) {
                    Write-Host "Domain knowledge documentation contains critical issues that must be addressed." -ForegroundColor Red
                } else {
                    Write-Host "Domain knowledge documentation contains non-critical issues that should be addressed." -ForegroundColor Yellow
                }
            } else {
                Write-Host "No issues found. Domain knowledge documentation is consistent." -ForegroundColor Green
            }
        }
    }

    # Determine exit code based on issues found and strict mode
    if ($Stats.CriticalIssues -gt 0) {
        return $false
    } elseif ($Strict -and $Stats.WarningIssues -gt 0) {
        return $false
    } else {
        return $true
    }
} catch {
    Write-Error "An error occurred while testing domain consistency: $_"
    return $false
} 