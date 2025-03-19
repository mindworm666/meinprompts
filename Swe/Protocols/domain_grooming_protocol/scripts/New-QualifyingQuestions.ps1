<#
.SYNOPSIS
    Generates a template with qualifying questions for domain knowledge elicitation.
.DESCRIPTION
    Creates a markdown file with the appropriate qualifying questions for terms,
    contexts, or entities according to the Domain Grooming Protocol.
.EXAMPLE
    ./New-QualifyingQuestions.ps1 -Type "Term" -Name "CustomerOrder"
.NOTES
    Part of the Domain Grooming Protocol toolkit for systematic domain knowledge capture.
#>
[CmdletBinding()]
param(
    [Parameter(Mandatory=$true)]
    [ValidateSet("Term", "Context", "Entity")]
    [string]$Type,
    
    [Parameter(Mandatory=$true)]
    [string]$Name,
    
    [Parameter(Mandatory=$false)]
    [string]$OutputPath = "./DomainKnowledge/QualifyingResponses"
)

# Determine subdirectory based on type
$TypeDir = switch ($Type) {
    "Term" { "Terms" }
    "Context" { "Contexts" }
    "Entity" { "Entities" }
}

try {
    $FullOutputDir = Join-Path -Path $OutputPath -ChildPath $TypeDir
    if (-not (Test-Path -Path $FullOutputDir)) {
        New-Item -Path $FullOutputDir -ItemType Directory -ErrorAction Stop | Out-Null
        Write-Host "Created directory: $FullOutputDir" -ForegroundColor Green
    }

    # Format filename - sanitize input for safe filenames
    $SafeName = $Name -replace '[\\/:*?"<>|]', '_'
    $FilePath = Join-Path -Path $FullOutputDir -ChildPath "$SafeName.md"

    # Check if file already exists
    if (Test-Path -Path $FilePath) {
        Write-Warning "Qualifying questions file already exists: $FilePath"
        return $FilePath
    }

    # Create the content based on type
    $TemplateContent = "# Qualifying Questions: $Type - $Name`n`n"
    $TemplateContent += "**Date Captured:** $(Get-Date -Format 'yyyy-MM-dd')`n`n"
    $TemplateContent += "**Stakeholders Present:** [List names and roles]`n`n"

    switch ($Type) {
        "Term" {
            $TemplateContent += @"
## Term Qualification Framework

### 1. Core Meaning
**Q: What is the essential definition of '$Name' in its most basic sense?**

A: [RECORD VERBATIM RESPONSE]

### 2. Contextual Variations
**Q: How does the meaning of '$Name' change when discussed in different contexts?**

A: [RECORD VERBATIM RESPONSE]

**Context A:** [Specific definition]

**Context B:** [Specific definition]

### 3. Boundary Detection
**Q: What specific words, phrases, or situations signal that '$Name' has shifted meaning?**

A: [RECORD VERBATIM RESPONSE]

### 4. Misinterpretation Risk
**Q: Where is '$Name' most commonly misunderstood or confused with other terms?**

A: [RECORD VERBATIM RESPONSE]

### 5. Relationship Mapping
**Q: What other terms are most closely related to '$Name' and how?**

A: [RECORD VERBATIM RESPONSE]
"@
        }
        "Context" {
            $TemplateContent += @"
## Context Qualification Framework

### 1. Boundary Definition
**Q: What precisely constitutes the '$Name' context? When does it begin and end?**

A: [RECORD VERBATIM RESPONSE]

### 2. Activation Signals
**Q: What specific language patterns or situations indicate the '$Name' context is active?**

A: [RECORD VERBATIM RESPONSE]

### 3. Term Transformation
**Q: Which terms have substantially different meanings in the '$Name' context?**

A: [RECORD VERBATIM RESPONSE]

**Term A:** [Context-specific meaning]

**Term B:** [Context-specific meaning]

### 4. Context Transitions
**Q: How can you tell when moving between the '$Name' context and adjacent contexts?**

A: [RECORD VERBATIM RESPONSE]

### 5. Stakeholder Identification
**Q: Who are the primary stakeholders operating within the '$Name' context?**

A: [RECORD VERBATIM RESPONSE]
"@
        }
        "Entity" {
            $TemplateContent += @"
## Entity Qualification Framework

### 1. Essential Nature
**Q: What defines '$Name' at its most fundamental level?**

A: [RECORD VERBATIM RESPONSE]

### 2. Contextual Perception
**Q: How is '$Name' viewed differently across contexts?**

A: [RECORD VERBATIM RESPONSE]

**Context A:** [Specific perception]

**Context B:** [Specific perception]

### 3. Critical Properties
**Q: What attributes are essential to '$Name''s identity?**

A: [RECORD VERBATIM RESPONSE]

### 4. Relationship Significance
**Q: What connections to other entities are most important for '$Name'?**

A: [RECORD VERBATIM RESPONSE]

### 5. Lifecycle Considerations
**Q: How does '$Name' come into existence, change, and terminate?**

A: [RECORD VERBATIM RESPONSE]
"@
        }
    }

    $TemplateContent += "`n`n## Additional Questions and Responses`n`n[Record any additional questions and responses here]"
    $TemplateContent += "`n`n## Follow-up Actions`n`n- [ ] Verify with other stakeholders\n- [ ] Cross-check with existing documentation\n- [ ] Update glossary/context/entity map"

    # Create the file with UTF-8 encoding (no BOM)
    $TemplateContent | Out-File -FilePath $FilePath -Encoding utf8 -NoNewline

    Write-Host "Created qualifying questions for $Type '$Name': $FilePath" -ForegroundColor Green
    return $FilePath
} catch {
    Write-Error "Failed to create qualifying questions: $_"
    return $null
} 