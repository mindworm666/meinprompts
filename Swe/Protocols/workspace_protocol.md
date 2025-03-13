## 📂 WORKSPACE MANAGEMENT PROTOCOL (MANDATORY)

**EXECUTE AS:** `[KNOWLEDGE MANAGER]` + `[SYSTEM ORGANIZER]` + `[EXECUTION TRACKER]` + `[PROCESS ENGINEER]`

### MANDATORY DIRECTORY STRUCTURE
You **MUST** maintain the following directory structure at the project root:
```
/AgentAssets/
├── ActionLog/               # Execution record with appropriate abstraction
└── Scripts/                 # Reusable commands and operations
```

### DIRECTORY MAINTENANCE IMPERATIVES
- **VIOLATION OF THESE PROTOCOLS IS STRICTLY FORBIDDEN**
- **EVERY AGENT INTERACTION MUST ADHERE TO THESE STANDARDS**
- **NO EXCEPTIONS ARE PERMITTED FOR ANY REASON**
- **DEVELOPMENT HAPPENS WITHIN THE DEFINED BOUNDARIES OF THE STRUCTURE AND ROUTINES OUTLINED BELOW**

#### /AgentAssets/ActionLog
- **PURPOSE:** Maintain an execution ledger with appropriate abstraction for rapid context reconstruction
- **FORMAT:** `YYYYMMDD-HHMMSS-action-description.md` with extremely terse syntax
- **CONTENT:** Minimalist record of executed actions, decisions, discoveries, and outcomes
- **IMPERATIVE:** Accurately telegraph the gestalt significance of actions taken 
- **CONSTRAINT:** Maximum 3-5 bullet points per log; preserve critical context only; Appendices if applicable.

#### /AgentAssets/Backlog.md
- **PURPOSE:** Track all pending user stories and requirements until completion.
- **FORMAT:** Minimalistic & focused on project management from a client perspective.
- **IMPERATIVE:** Ruthlessly track to completion & remove items that are fully complete.
- **CONTENT:** Clarified requirements, acceptance criteria, and implementation status
- **CONSTRAINT:** Maintain atomicity; split entries when requirements diverge, always focused on the separation of the UX vs technical decomposition.

#### /AgentAssets/Scripts
- **PURPOSE:** Catalog all trivial & non-trivial scripts so that you & future devs can leverage them. 
- **FORMAT:** Scripts named by function, not implementation (`build-application.ps1` not `compile-with-dotnet.ps1`)
- **INDEX:** Maintain `index.md` with references to all other files in the directory and subdirectories with tags and a terse purpose description
- **IMPERATIVE:** Depend upon the scripts in this directory as much as possible, and consistently add scripts of any kind that prove useful.
- **CONSTRAINT:** Each operation must be executable without modification; no manual adjustment required.

#### /AgentAssets/AgentNotes.md
- **PURPOSE:** A short list of seemingly trivial points of confusion that future agents and devs would benefit from reviewing frequently.
- **FORMAT:** growing list of standardized sections for problem description, impact, and resolution
- **IMPERATIVE:** Reference `AgentNotes.md` as part of 'MANDATORY INITIAL ROUTINE' so that small snags are avoided during development.
- **CONSTRAINT:** Focus on reproducible insights; avoid speculation or unverified solutions. (e.g. don't get these two contracts mixed up because they share the same name etc. etc.)
- **EXAMPLE:** Two classes are often confused with each other, you find out something about your environment (running on windows etc. etc.)