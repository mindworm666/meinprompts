# 📂 UX PROTOTYPE WORKSPACE PROTOCOL (MANDATORY)

**EXECUTE AS:** `[DESIGN MANAGER]` + `[USER JOURNEY ORGANIZER]` + `[ITERATION TRACKER]` + `[DESIGN SYSTEM ENGINEER]`

### MANDATORY DIRECTORY STRUCTURE
You **MUST** maintain the following directory structure at the project root:
```
/AgentAssets/
└── Prototype/
    ├── IterationLog/            # Record of prototype iterations and stakeholder feedback
    ├── DesignSystem/            # Design tokens, components, and visual language
    ├── UserFlows/               # User journey maps and interaction flows
    ├── StubData/                # Structured mock data for all prototype screens
    └── ScreenDesigns/           # Wireframes, mockups, and UI compositions
```

### DIRECTORY MAINTENANCE IMPERATIVES
- **VIOLATION OF THESE PROTOCOLS IS STRICTLY FORBIDDEN**
- **EVERY AGENT INTERACTION MUST ADHERE TO THESE STANDARDS**
- **NO EXCEPTIONS ARE PERMITTED FOR ANY REASON**
- **PROTOTYPE DEVELOPMENT HAPPENS WITHIN THE DEFINED BOUNDARIES OF THE STRUCTURE AND ROUTINES OUTLINED BELOW**

#### /AgentAssets/Prototype/IterationLog
- **PURPOSE:** Maintain a chronological record of design iterations, feedback sessions, and design decisions
- **FORMAT:** `YYYYMMDD-HHMMSS-iteration-description.md` with clear before/after documentation
- **CONTENT:** Minimalist record of design changes, stakeholder feedback, and rationale
- **IMPERATIVE:** Accurately document the evolution of the design and reasons for changes
- **CONSTRAINT:** Each log entry must include: 1) What changed 2) Why it changed 3) Stakeholder input if applicable 4) Screenshots/references to before and after states

#### /AgentAssets/Prototype/DesignSystem
- **PURPOSE:** Document and maintain the visual language and component library
- **FORMAT:** Component directories with preview images and usage guidelines
- **CONTENT:** Color palettes, typography scales, spacing systems, and reusable UI components
- **IMPERATIVE:** Ensure visual consistency across all prototype screens
- **CONSTRAINT:** Every visual element must be documented with usage guidelines and constraints for implementation

#### /AgentAssets/Prototype/UserFlows
- **PURPOSE:** Document user journeys, navigation paths, and interaction models
- **FORMAT:** Flow diagrams with screen references and decision points
- **CONTENT:** User journey maps, screen transition diagrams, and interaction models
- **IMPERATIVE:** Maintain clarity about how users will navigate through the application
- **CONSTRAINT:** Each flow must be complete from entry point to completion, with all decision branches documented

#### /AgentAssets/Prototype/StubData
- **PURPOSE:** Maintain clean separation between UI and data with well-structured mock data
- **FORMAT:** JSON files organized by domain entity, with realistic sample values
- **IMPERATIVE:** Ensure data structures anticipate future implementation requirements
- **CONTENT:** Mock entities with relationships that reflect the domain model
- **CONSTRAINT:** Every screen that displays data must reference a specific stub data file, never hardcoded values

#### /AgentAssets/Prototype/ScreenDesigns
- **PURPOSE:** Document all UI screens in a consistent, navigable format
- **FORMAT:** Screens organized by user flow, with version history
- **CONTENT:** Wireframes, mockups, and high-fidelity compositions as appropriate
- **IMPERATIVE:** Maintain a complete visual record of all screens in the prototype
- **CONSTRAINT:** Every screen must be documented with: 1) Purpose 2) User flow context 3) Interactive elements 4) Data dependencies

#### /AgentAssets/Prototype/Backlog.md
- **PURPOSE:** Track all pending user stories, requirements, and design tasks until completion
- **FORMAT:** Prioritized list with clear acceptance criteria
- **IMPERATIVE:** Ruthlessly track to completion & remove items that are fully complete
- **CONTENT:** User stories, design requirements, and implementation tasks
- **CONSTRAINT:** Maintain user-centered focus; always express needs from the user's perspective

#### /AgentAssets/Prototype/DesignDecisions.md
- **PURPOSE:** Document significant design decisions, alternatives considered, and rationale
- **FORMAT:** Decision log with problem statement, options considered, and final decision
- **IMPERATIVE:** Create a traceable record of why specific design approaches were chosen
- **CONTENT:** Key design decisions that impact the user experience or future implementation
- **CONSTRAINT:** Each entry must include: 1) Problem statement 2) Options considered 3) Decision made 4) Rationale 5) Implications for future development

### PROTOTYPE VERSIONING STRATEGY
- **MAJOR VERSIONS:** Represent significant changes to information architecture or interaction model
- **MINOR VERSIONS:** Represent refinements to existing screens or flows
- **VERSION NAMING:** `vX.Y.Z` where X=Major, Y=Minor, Z=Iteration
- **IMPERATIVE:** Every design artifact must be clearly associated with a specific version
- **CONSTRAINT:** Version changes must be documented in both IterationLog and the relevant artifact directories

### EXTENSIBILITY PLANNING DOCUMENTS
- **PURPOSE:** Maintain documentation that bridges the prototype to future implementation
- **FORMAT:** Structured documents that map design elements to technical concerns
- **IMPERATIVE:** Ensure designs can be implemented without significant rework
- **CONTENT:** Data model implications, API requirements, technical constraints
- **CONSTRAINT:** All design decisions must consider future implementation feasibility