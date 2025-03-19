# Domain Grooming Protocol

A systematic approach to capturing, analyzing, and preserving domain knowledge with precision, context-awareness, terminological rigor, and stakeholder validation.

## Overview

The Domain Grooming Protocol is a disciplined methodology for domain knowledge management that recognizes fundamental truths:
1. **Accurate domain modeling requires precision in language**
2. **Domain experts are the ultimate authority on domain knowledge**
3. **Every step must be validated before proceeding**

This protocol mandates rigorous attention to contextual variations in terminology, ensuring conceptual integrity and alignment with stakeholder mental models across different contexts and perspectives. Most critically, it requires explicit user validation at each step before proceeding with documentation.

## Key Concepts

1. **Collaborative Qualification**: Every term, context, and entity must undergo specific qualifying questions with explicit stakeholder validation before documentation.

2. **Context Awareness**: Terms often have different meanings in different contexts—this protocol explicitly documents these variations after validation.

3. **Boundary Detection**: Identifying precise signals when terminology shifts meaning across contexts.

4. **Iterative Verification**: Cross-validating terminology with multiple stakeholders to prevent misunderstandings.

5. **Validation-First Approach**: No domain documentation is created until qualifying questions have been explicitly validated by stakeholders.

## User Collaboration Model

The protocol enforces a strict collaboration sequence:

1. **Present Qualifying Questions**: Generate and present questions for one domain element at a time
2. **Await Explicit Feedback**: Never proceed with documentation until receiving specific stakeholder responses
3. **Incorporate User Expertise**: Treat user feedback as authoritative and adjust understanding accordingly
4. **Validate Before Proceeding**: Seek confirmation before expanding documentation
5. **Document With Authority**: Create formal documentation only after validation is complete

## Why Use This Protocol

### Business Value

- **Reduced Misunderstandings**: Prevents costly mistakes from terminology confusion
- **Improved Communication**: Creates a shared language between business and technical teams
- **Enhanced Requirements**: Produces clearer, more precise specifications
- **Knowledge Preservation**: Captures domain expertise that would otherwise be lost
- **Accelerated Onboarding**: Helps new team members understand complex domains faster
- **Stakeholder Ownership**: Ensures domain experts recognize their terminology in models

### Technical Value

- **Better Domain Models**: Creates more accurate and nuanced domain models
- **Contextual Boundaries**: Clearly defines bounded contexts for domain-driven design
- **Reduced Defects**: Prevents bugs stemming from terminological inconsistencies
- **Architecture Alignment**: Ensures system architecture aligns with domain realities
- **Technical Debt Prevention**: Avoids accidental complexity from misunderstood concepts
- **Validated Understanding**: Confirms technical interpretations with domain experts

## Repository Structure

```
domain_grooming_protocol/
├── protocol.md              # Core protocol documentation
├── README.md                # This file
└── scripts/                 # Automation scripts
    ├── Initialize-DomainKnowledge.ps1
    ├── New-QualifyingQuestions.ps1
    ├── New-GlossaryEntry.ps1
    ├── New-ContextDefinition.ps1
    ├── New-EntityEntry.ps1
    ├── New-SessionTemplate.ps1
    ├── Test-DomainConsistency.ps1
    └── README.md            # Script documentation
```

## Getting Started

1. **Read the Protocol**: Start by thoroughly reading `protocol.md` to understand the methodology.

2. **Set Up Repository**: Use the initialization script to create your domain knowledge structure:
   ```powershell
   cd scripts
   ./Initialize-DomainKnowledge.ps1 -Path "../MyProject/DomainKnowledge"
   ```

3. **Plan Elicitation Sessions**: Schedule domain knowledge sessions with stakeholders.

4. **Prepare Sessions**: Create session templates before each meeting:
   ```powershell
   ./New-SessionTemplate.ps1 -Topic "Order Processing Domain Discovery"
   ```

5. **Execute Protocol**: During sessions, meticulously follow the qualifying question framework and await validation before proceeding.

6. **Document Findings**: After sessions and only after receiving explicit stakeholder validation, document terms, contexts, and entities:
   ```powershell
   ./New-GlossaryEntry.ps1 -Term "CustomerOrder" -Definition "A record of items purchased by a customer"
   ```

7. **Verify Consistency**: Regularly test documentation integrity:
   ```powershell
   ./Test-DomainConsistency.ps1
   ```

## Troubleshooting PowerShell Scripts

If you encounter issues with PowerShell script execution:

1. **Set Execution Policy**: Run PowerShell as Administrator and execute:
   ```powershell
   Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
   ```

2. **Run Individual Commands**: Execute scripts one by one rather than chaining commands:
   ```powershell
   cd scripts
   ./Initialize-DomainKnowledge.ps1 -Path "../MyProject/DomainKnowledge"
   ```

3. **Manual Setup**: If script execution continues to fail, create the directory structure manually:
   ```
   /DomainKnowledge/
       ├── Glossary.md
       ├── Contexts.md
       ├── EntityMap.md
       ├── SessionNotes/
       └── QualifyingResponses/
           ├── Terms/
           ├── Contexts/
           └── Entities/
   ```

   Then create the template files by copying the formats specified in protocol.md.

## Implementation Examples

The protocol can be applied in various domains:

- **Financial Systems**: Documenting how terms like "Account" have different meanings in different banking contexts
- **Healthcare**: Capturing the precise definitions of medical terminology across different clinical departments
- **E-commerce**: Defining how "Order" differs between sales, fulfillment, and customer service contexts
- **Manufacturing**: Documenting how "Product" changes meaning from design to manufacturing to shipping

## Best Practices

1. **Be Relentless About Validation**: Never proceed without explicit stakeholder confirmation.
2. **Present Questions Incrementally**: Focus on one entity or context at a time to avoid overwhelming stakeholders.
3. **Capture Raw Responses**: Record stakeholder answers verbatim before analysis.
4. **Challenge Ambiguity**: Don't accept vague terminology—push for precision.
5. **Follow the Protocol Strictly**: Don't skip steps, especially qualifying questions and validation.
6. **Use the Tools**: Leverage the automation scripts to enforce consistency.
7. **Regular Reviews**: Schedule periodic reviews of domain documentation.
8. **Version Your Knowledge**: Use version control for your domain knowledge assets.

## Adapt With Caution

While you may adapt this protocol to your organization's needs, certain elements are non-negotiable:

- Qualifying questions must always be asked and documented
- User validation must be received before proceeding with documentation
- Contextual variations must always be captured
- The structured documentation format must be maintained
- Verification across contexts must be performed

## Acknowledgments

This protocol builds upon concepts from:

- Domain-Driven Design by Eric Evans
- Domain Storytelling by Stefan Hofer and Henning Schwentner
- Bounded Context Canvas by Nick Tune
- Ubiquitous Language from Domain-Driven Design 