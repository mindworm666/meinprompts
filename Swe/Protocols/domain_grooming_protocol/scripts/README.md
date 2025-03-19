# Domain Grooming Protocol Scripts

This directory contains PowerShell scripts that automate and enforce the Domain Grooming Protocol, a rigorous approach to capturing and managing domain knowledge with precision.

## Overview

These scripts work together to create a systematic framework for domain knowledge management, ensuring terminology, contexts, and entities are properly documented with qualifying questions and appropriate cross-references.

## Key Benefits

- **Consistent Structure:** Enforces standardized formats for all domain knowledge assets
- **Rigorous Qualification:** Ensures all terms, contexts, and entities are properly vetted with qualifying questions
- **Error Prevention:** Catches missing sections, incomplete documentation, and inconsistencies
- **Automation:** Reduces manual effort through templates and guided workflows
- **Domain Integrity:** Maintains conceptual consistency across complex domain models

## Script Descriptions

| Script | Purpose |
|--------|---------|
| **Initialize-DomainKnowledge.ps1** | Creates the domain knowledge directory structure and initial template files |
| **New-QualifyingQuestions.ps1** | Generates templates for domain knowledge qualification based on type (Term/Context/Entity) |
| **New-GlossaryEntry.ps1** | Creates properly formatted glossary term entries with automatic qualifying question generation |
| **New-ContextDefinition.ps1** | Documents business contexts with boundary indicators and term transformations |
| **New-EntityEntry.ps1** | Creates entity documentation with contextual variations and relationships |
| **New-SessionTemplate.ps1** | Generates structured templates for domain knowledge elicitation sessions |
| **Test-DomainConsistency.ps1** | Validates domain knowledge documentation for consistency and completeness |

## Getting Started

1. Initialize the domain knowledge structure:
   ```powershell
   ./Initialize-DomainKnowledge.ps1 -Path "./MyProject/DomainKnowledge"
   ```

2. Generate qualifying questions for a new term:
   ```powershell
   ./New-QualifyingQuestions.ps1 -Type "Term" -Name "CustomerOrder"
   ```

3. Add a new term to the glossary:
   ```powershell
   ./New-GlossaryEntry.ps1 -Term "CustomerOrder" -Definition "A record of items purchased by a customer"
   ```

4. Create a context definition:
   ```powershell
   ./New-ContextDefinition.ps1 -Name "OrderProcessing" -Definition "The context where customer orders are processed and fulfilled"
   ```

5. Document an entity:
   ```powershell
   ./New-EntityEntry.ps1 -Name "Customer" -Definition "An individual or organization that purchases products or services"
   ```

6. Create a session template:
   ```powershell
   ./New-SessionTemplate.ps1 -Topic "Order Processing Domain Discovery" -Participants @("John Doe", "Jane Smith")
   ```

7. Test for consistency:
   ```powershell
   ./Test-DomainConsistency.ps1 -Strict
   ```

## Advanced Usage

### Working with Context-Specific Definitions

```powershell
$ContextDefinitions = @{
    "OrderProcessing" = "A request to purchase that is being fulfilled"
    "CustomerService" = "A historical record of items purchased by a customer"
}

./New-GlossaryEntry.ps1 -Term "Order" -Definition "A request for products or services" -Contexts $ContextDefinitions
```

### Documenting Entity Relationships

```powershell
$Relationships = @{
    "Order" = "Is placed by"
    "Address" = "Is located at"
    "PaymentMethod" = "Pays using"
}

./New-EntityEntry.ps1 -Name "Customer" -Definition "An individual or organization that purchases products or services" -Relationships $Relationships
```

### Validation with Different Output Formats

```powershell
# Generate JSON report
./Test-DomainConsistency.ps1 -OutputFormat "JSON" > domain-consistency-report.json

# Generate CSV report
./Test-DomainConsistency.ps1 -OutputFormat "CSV"
```

## Best Practices

1. **Run qualifying questions first:** Always complete the qualifying questions before creating glossary entries, contexts, or entities.

2. **Use script automation:** Avoid manual creation of domain assets to ensure consistency.

3. **Set up regular validation:** Schedule weekly runs of `Test-DomainConsistency.ps1` to maintain quality.

4. **Document context transitions:** Pay special attention to how terms change meaning across contexts.

5. **Track term status:** Use the Status field to show progression from Proposed → Confirmed → Refined.

6. **Back up domain knowledge:** Consider placing the entire DomainKnowledge directory under version control.

## Customization

These scripts can be customized to fit your specific domain modeling needs:

- Modify templates in the initialize script to match your organizational standards
- Add additional validation rules to the consistency testing script
- Extend with additional scripts for your specific use cases

## Troubleshooting

- If you encounter path errors, check that your current directory contains the scripts or provide absolute paths.
- For script execution policy issues, you may need to run: `Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned`
- Backup files (.bak) are automatically created before modifications to prevent data loss 