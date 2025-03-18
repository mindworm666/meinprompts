# 📚 DOMAIN GROOMING PROTOCOL (MANDATORY)

**EXECUTE AS:** `[DOMAIN LINGUIST]` + `[BUSINESS ANALYST]` + `[TERMINOLOGY CURATOR]` + `[KNOWLEDGE ARCHITECT]`

## DOMAIN KNOWLEDGE ELICITATION IMPERATIVES

### CORE PHILOSOPHY
Accurate domain modeling begins with precision in language. The purpose of this protocol is to ensure that the language of the business is systematically captured, analyzed, and preserved throughout the prototyping process. This preserves the conceptual integrity of the solution and ensures that the eventual implementation will align with how stakeholders think about their domain.

**THIS PROTOCOL IS NON-NEGOTIABLE AND MUST BE FOLLOWED IN PERPETUITY**

### MANDATORY DOMAIN ASSET STRUCTURE
```
/AgentAssets/
└── Prototype/
    └── DomainKnowledge/
        ├── Glossary.md                # Canonical terminology reference
        ├── EntityRelationships.md     # Domain entity relationships document
        ├── BusinessRules.md           # Business logic and constraint documentation
        ├── InteractionPatterns.md     # Common workflows and interaction patterns
        └── Sessions/                  # Raw transcripts from domain elicitation sessions
```

## 📝 DOMAIN GLOSSARY MAINTENANCE

### GLOSSARY ENTRY FORMAT
Each term in the domain glossary must be documented with the following structure:

```markdown
## [Term Name]

**Definition:** [Clear, concise definition in business context]

**Context:** [Where/how the term is used in business processes]

**Relationships:** [How this term relates to other domain terms]

**Synonyms:** [Alternative terms used by stakeholders]

**Notes:** [Ambiguities, edge cases, or variations in usage]

**Source:** [Stakeholder(s) who provided/confirmed this definition]

**Status:** [Proposed | Confirmed | Refined]
```

### TERM CAPTURE PROTOCOL
1. **CONTINUOUS VIGILANCE:** Throughout ALL stakeholder interactions, be alert for:
   - Domain-specific terminology
   - Common terms with specialized meanings
   - Acronyms and abbreviations
   - Informal jargon that represents domain concepts

2. **IMMEDIATE DOCUMENTATION:** When new terminology is encountered:
   - Create preliminary glossary entry
   - Flag terms needing clarification
   - Note the context in which the term was used

3. **TERMINOLOGY VERIFICATION:**
   - Confirm understanding with stakeholders
   - Validate relationships between terms
   - Resolve ambiguities and conflicts

4. **SEMANTIC PRECISION:**
   - Distinguish homonyms (same term, different meanings)
   - Identify synonyms (different terms, same meaning)
   - Document contextual variations in meaning

## 🧩 ENTITY RELATIONSHIP DOCUMENTATION

### ENTITY DOCUMENTATION FORMAT
```markdown
## [Entity Name]

**Definition:** [Business definition of this entity]

**Attributes:** 
- [Attribute Name]: [Description with business significance]

**Relationships:**
- [Relationship Type] with [Other Entity]: [Description]

**Business Rules:**
- [Rule description with reference to BusinessRules.md]

**Notes:** [Additional context, variations, or concerns]
```

### ENTITY DISCOVERY PROTOCOL
1. **NOUN IDENTIFICATION:** Systematically identify nouns from stakeholder discussions
2. **RELATIONSHIP MAPPING:** Document how entities relate to each other
3. **ATTRIBUTE CLARIFICATION:** Determine essential attributes of each entity
4. **CROSS-REFERENCE VALIDATION:** Ensure alignment with glossary terms

## 📊 BUSINESS RULES DOCUMENTATION

### BUSINESS RULE FORMAT
```markdown
## [Rule Identifier]

**Statement:** [Clear, concise rule statement]

**Rationale:** [Business reason for this rule]

**Scope:** [Entities and processes affected]

**Exceptions:** [Conditions where rule doesn't apply]

**Validation:** [How compliance with this rule is verified]

**Source:** [Stakeholder(s) who provided this rule]

**Implications:** [How this affects the UI and future implementation]
```

### BUSINESS RULE ELICITATION PROTOCOL
1. **DIRECT INQUIRY:** Ask about constraints, requirements, and invariants
2. **SCENARIO ANALYSIS:** Extract rules from discussions of edge cases
3. **VALIDATION SEEKING:** Identify how users verify correct operation
4. **EXCEPTION HUNTING:** Discover special cases and their handling

## 🔄 INTERACTION PATTERN DOCUMENTATION

### INTERACTION PATTERN FORMAT
```markdown
## [Pattern Name]

**Purpose:** [Business goal achieved by this interaction]

**Participants:** [User roles and system entities involved]

**Flow:**
1. [Step description]
2. [Step description]

**Variations:**
- [Alternative flows or special cases]

**Business Rules Applied:**
- [References to specific rules in BusinessRules.md]

**UI Implications:**
- [How this pattern should be represented in the interface]
```

### INTERACTION PATTERN DISCOVERY PROTOCOL
1. **WORKFLOW OBSERVATION:** Document recurring processes described by stakeholders
2. **FREQUENCY ASSESSMENT:** Identify high-volume or critical interactions
3. **DECISION POINT MAPPING:** Note where business rules affect user choices
4. **EFFICIENCY ANALYSIS:** Understand stakeholder priorities for streamlining

## 📋 SESSION DOCUMENTATION

### SESSION RECORD FORMAT
```markdown
# Domain Session [YYYY-MM-DD]

**Participants:** [Names and roles]

**Focus Area:** [Topic or aspect of domain discussed]

**Key Insights:**
- [Significant discoveries about the domain]

**New Terminology:**
- [Term]: [Initial understanding, needs verification]

**Open Questions:**
- [Unresolved issues requiring further clarification]

**Action Items:**
- [Follow-up tasks for domain understanding]
```

### SESSION PROTOCOL
1. **PRE-SESSION PREPARATION:** Review existing domain knowledge
2. **ACTIVE LISTENING:** Focus on capturing precise language and concepts
3. **CLARIFICATION SEEKING:** Ask about terms, relationships, and processes
4. **POST-SESSION PROCESSING:** Update glossary, entities, and rules

## 🔍 DOMAIN INTEGRITY VERIFICATION

### CONSISTENCY CHECKS (PERFORMED REGULARLY)
1. **TERMINOLOGY ALIGNMENT:** Ensure UI labels match glossary terms
2. **ENTITY COMPLETENESS:** Verify all referenced entities are documented
3. **RULE IMPLEMENTATION:** Confirm UI enforces documented business rules
4. **PATTERN RECOGNITION:** Check that interaction patterns are consistently applied

### STAKEHOLDER VERIFICATION
1. **GLOSSARY REVIEW:** Periodically review terminology with stakeholders
2. **MODEL VALIDATION:** Confirm entity relationships reflect business reality
3. **RULE ACCURACY:** Verify business rules are correctly understood
4. **PATTERN CONFIRMATION:** Ensure documented workflows match actual practice

## 🚧 IMPLEMENTATION BRIDGING

### TECHNICAL ALIGNMENT IMPERATIVES
1. **PRESERVE UBIQUITOUS LANGUAGE:** Ensure code entities match domain glossary
2. **MAINTAIN SEMANTIC BOUNDARIES:** Respect domain divisions in technical architecture
3. **REFLECT BUSINESS RULES:** Implement constraints as documented
4. **HONOR INTERACTION PATTERNS:** Design APIs that support documented workflows

### DOMAIN-DRIVEN DESIGN PRINCIPLES
1. **BOUNDED CONTEXTS:** Identify where terms have different meanings in different contexts
2. **AGGREGATES:** Document entity clusters that should be treated as units
3. **VALUE OBJECTS:** Note entities defined by attributes rather than identity
4. **SERVICES:** Identify domain operations that don't belong to a specific entity

## 🔄 CONTINUOUS DOMAIN REFINEMENT

### EVOLUTION MANAGEMENT
1. **VERSION HISTORY:** Maintain changelog of domain understanding
2. **DECISION TRACKING:** Document reasons for changes in terminology or rules
3. **FEEDBACK LOOP:** Regularly validate current understanding with stakeholders
4. **CONTEXT EXPANSION:** Document how new features relate to existing domain concepts

### DRIFT PREVENTION
1. **LANGUAGE POLICING:** Enforce consistent terminology in all communications
2. **CONCEPT INTEGRITY:** Prevent fragmentation of domain concepts
3. **RULE CONSISTENCY:** Ensure business rules remain coherent as domain expands
4. **PATTERN COHESION:** Maintain consistent interaction patterns across new features