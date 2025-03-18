# UI/UX Prototyping Protocol System

This protocol system is designed to guide AI agents in creating high-quality UI/UX prototypes that can be iteratively refined with stakeholders and eventually extended into fully functional applications.

## Protocol Overview

The system consists of three interconnected protocols:

1. **UX_prototype_agent.md** - Defines the core identity, capabilities, and methodologies of the UX prototyping agent. It provides the overall framework for how the agent should approach UI/UX design and prototyping.

2. **UX_workspace_protocol.md** - Establishes the file and directory structure for managing design artifacts, iterations, and documentation. It ensures consistent organization throughout the prototyping process.

3. **domain_grooming_protocol.md** - Guides the systematic capture, documentation, and refinement of domain language and concepts. This ensures that the UI aligns with stakeholder mental models and facilitates future implementation.

## How to Use This Protocol System

### Initial Setup

1. Create the required directory structure as defined in `UX_workspace_protocol.md`:
   ```
   /AgentAssets/
   └── Prototype/
       ├── IterationLog/            
       ├── DesignSystem/            
       ├── UserFlows/               
       ├── StubData/                
       └── ScreenDesigns/           
   ```

2. Create the domain knowledge structure as defined in `domain_grooming_protocol.md`:
   ```
   /AgentAssets/
   └── Prototype/
       └── DomainKnowledge/
           ├── Glossary.md                
           ├── EntityRelationships.md     
           ├── BusinessRules.md           
           ├── InteractionPatterns.md     
           └── Sessions/                  
   ```

### Working with the Agent

When interacting with the AI agent, provide these protocols at the beginning of your conversation. The agent will:

1. **Elicit Requirements** - Ask key questions to understand user needs, target audience, and success criteria.

2. **Create User Flows** - Develop high-level user journeys before diving into specific screens.

3. **Design System Development** - Establish visual language, component patterns, and design tokens.

4. **Screen Design** - Create wireframes or mockups for each step in user journeys.

5. **Stub Data Separation** - Structure mock data separately from UI to facilitate future integration.

6. **Iteration Documentation** - Track changes, rationales, and stakeholder feedback.

7. **Domain Language Curation** - Systematically document business terminology and concepts.

### Best Practices

1. **Start with Core Flows** - Begin with the most critical user journeys rather than trying to design everything at once.

2. **Regularly Review with Stakeholders** - Schedule feedback sessions after each significant iteration.

3. **Maintain Data Separation** - Always keep UI and data cleanly separated to facilitate future implementation.

4. **Document Design Decisions** - Record the rationale behind significant design choices.

5. **Build a Living Glossary** - Continuously update the domain terminology as new concepts emerge.

6. **Version Thoughtfully** - Use the versioning strategy to maintain clarity about the prototype's evolution.

7. **Consider Implementation Realities** - Design with future development constraints in mind.

## Extending to Implementation

When the prototype achieves stakeholder alignment and you're ready to implement:

1. **Reference the Domain Glossary** - Ensure code entities match the established terminology.

2. **Use the Entity Relationships** - As a starting point for data models and schemas.

3. **Implement from the Stub Data** - The JSON structures provide a template for actual data models.

4. **Preserve Interaction Patterns** - Maintain the documented workflows in the implemented solution.

5. **Leverage the Design System** - Use the established components and visual language for implementation.

## Protocol Maintenance

These protocols are designed to be living documents. As your process evolves:

1. **Update the Protocols** - Refine based on what works best for your team.

2. **Extend as Needed** - Add new sections or details specific to your context.

3. **Share Improvements** - Document successful adaptations for future projects.