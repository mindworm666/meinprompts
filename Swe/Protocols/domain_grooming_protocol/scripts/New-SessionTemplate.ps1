<#
.SYNOPSIS
    Creates a new domain knowledge session template.
.DESCRIPTION
    Generates a structured markdown template for documenting domain knowledge
    sessions according to the Domain Grooming Protocol. Each session should
    capture domain insights, terminology, and context transitions.
.EXAMPLE
    ./New-SessionTemplate.ps1 -Topic "Order Processing Domain Discovery" -Participants @("John Doe", "Jane Smith")
.PARAMETER Topic
    The main topic or focus of the domain knowledge session.
.PARAMETER Date
    The date of the session (defaults to today).
.PARAMETER Participants
    Array of participant names and roles.
.PARAMETER SessionsPath
    Path to the directory where session notes are stored.
.NOTES
    Part of the Domain Grooming Protocol toolkit for systematic domain knowledge capture.
#>
[CmdletBinding()]
param(
    [Parameter(Mandatory=$true)]
    [string]$Topic,
    
    [Parameter(Mandatory=$false)]
    [DateTime]$Date = (Get-Date),
    
    [Parameter(Mandatory=$false)]
    [string[]]$Participants = @(),
    
    [Parameter(Mandatory=$false)]
    [string]$SessionsPath = "./DomainKnowledge/SessionNotes"
)

try {
    # Ensure sessions directory exists
    if (-not (Test-Path -Path $SessionsPath)) {
        New-Item -Path $SessionsPath -ItemType Directory -ErrorAction Stop | Out-Null
        Write-Host "Created sessions directory: $SessionsPath" -ForegroundColor Green
    }

    # Format date and create filename
    $DateString = $Date.ToString("yyyy-MM-dd")
    $SafeTopic = $Topic -replace '[\\/:*?"<>|]', '_'
    $FileName = "$DateString-$SafeTopic.md"
    $FilePath = Join-Path -Path $SessionsPath -ChildPath $FileName

    # Check if file already exists
    if (Test-Path -Path $FilePath) {
        $Counter = 1
        while (Test-Path -Path $FilePath) {
            $FileName = "$DateString-$SafeTopic-$Counter.md"
            $FilePath = Join-Path -Path $SessionsPath -ChildPath $FileName
            $Counter++
        }
    }

    # Format participants
    $ParticipantsText = if ($Participants.Count -gt 0) {
        ($Participants -join ", ")
    } else {
        "[List names and roles]"
    }

    # Create session template content
    $TemplateContent = @"
# Domain Session: $Topic ($DateString)

## Session Information

**Participants:** $ParticipantsText

**Facilitator:** [Name]

**Duration:** [Duration]

**Location:** [Physical or virtual location]

## Session Objectives

- [Primary objective 1]
- [Primary objective 2]
- [Primary objective 3]

## Contexts Explored

- [Context 1]
- [Context 2]

## Qualifying Questions Executed

| Entity/Term/Context | Question Type | Responses Recorded |
|---------------------|---------------|-------------------|
| [Item] | [Term/Context/Entity] | [Yes/No/Partial] |

## Terminology Captured

| Term | Definition | Context |
|------|------------|---------|
| [Term 1] | [Definition] | [Context] |
| [Term 2] | [Definition] | [Context] |

## Context Transitions Observed

- [Document when meaning shifted during discussion]
- [Note terms that had different meanings in different contexts]

## Key Insights

- [Key insight 1]
- [Key insight 2]
- [Key insight 3]

## Domain Uncertainties Identified

- [Area of uncertainty 1]
- [Area of uncertainty 2]

## Action Items

| Action | Owner | Due Date | Status |
|--------|-------|----------|--------|
| [Action 1] | [Name] | [Date] | [Status] |
| [Action 2] | [Name] | [Date] | [Status] |

## Follow-up Required

- [ ] Document newly identified terms in glossary
- [ ] Create qualifying questions for [specific terms]
- [ ] Update entity map with [specific entities]
- [ ] Resolve conflicting definitions for [specific terms]

## Session Notes

[Detailed notes from the session]

## Attachments

- [Links to diagrams, whiteboards, or other artifacts]
"@

    # Create the session file
    $TemplateContent | Out-File -FilePath $FilePath -Encoding utf8

    Write-Host "Created domain session template at: $FilePath" -ForegroundColor Green
    return $FilePath
} catch {
    Write-Error "Failed to create session template: $_"
    return $null
} 