# Escape from Jerusalem

## Production Plan

> **Build one great adventure before building the whole world.**

**Engine:** Godot
**Primary Platform:** Mobile
**Current Stage:** Prototype / Pre-production
**Immediate Goal:** Playable Act I → Laman Reveal → Brass Plates Vertical Slice

---

# 1. Production Philosophy

The project will be developed through progressively larger playable versions.

The goal is **not** to build the complete one-hour game immediately.

Instead, each milestone should answer a meaningful question about the game.

The production sequence is:

**Prototype → Playable Act I → Narrative Reveal → Vertical Slice → Complete Adventure → Expansion**

Every stage should produce something playable.

---

# 2. Current Project State

The project already contains a functional Godot prototype.

Existing systems include:

* Top-down player movement
* Camera
* Collision
* Jerusalem environment
* Connected city areas
* NPC movement
* NPC schedules
* Centralized world clock
* Time advancement
* NPC location changes based on time
* Dialogue/interactions
* Basic investigation systems
* HUD
* Early gameplay infrastructure

The project is therefore **past the "can we make a character move?" stage**.

The immediate challenge is turning the existing systems into a coherent playable experience.

---

# 3. Production Priorities

When choosing what to build next, prioritize in this order:

### 1. Playability

Can the player actually play from beginning to end?

### 2. Core Gameplay

Does exploration, investigation, interaction, and puzzle-solving feel good?

### 3. Narrative

Does the player understand what is happening and why they should care?

### 4. Presentation

Does the game look and feel intentional enough to demonstrate?

### 5. Expansion

Only after the above work should additional systems or content be prioritized.

---

# 4. Immediate Milestone

## Playable Act I

The first immediate milestone is:

> **A player can start the game, explore Jerusalem, interact with NPCs, experience Lehi's warning, prepare to leave, and leave Jerusalem.**

The player should not know their identity.

### Required Experience

**Start → Explore → Investigate → Interact → Discover → Prepare → Escape**

This milestone does not need final art.

It does not need every puzzle.

It does not need the complete city.

It needs to prove that the **first act is fun to play**.

---

# 5. Milestone 1 — Stabilize the Foundation

### Goal

Make the existing prototype reliable enough to support content development.

### Tasks

* [ ] Verify player movement
* [ ] Verify collision
* [ ] Verify camera
* [ ] Verify scene transitions
* [ ] Verify world clock
* [ ] Verify time advancement
* [ ] Verify NPC schedules
* [ ] Verify NPC movement
* [ ] Verify NPC interactions
* [ ] Verify dialogue
* [ ] Fix HUD/time display issues
* [ ] Fix NPC placement/overlap problems
* [ ] Refactor unstable systems where necessary
* [ ] Establish reliable save/load architecture if required
* [ ] Remove obvious prototype-breaking bugs

### Definition of Done

A developer can run the game repeatedly without encountering major system failures.

---

# 6. Milestone 2 — Act I Grey Box

### Goal

Create a complete playable first act using grey-box environments.

### Required Content

* [ ] Player starting location
* [ ] Family residence
* [ ] Lower City
* [ ] Marketplace
* [ ] Relevant NPCs
* [ ] Lehi
* [ ] Family members
* [ ] Basic exploration objectives
* [ ] Initial investigation
* [ ] Simple environmental puzzle(s)
* [ ] Lehi's warning
* [ ] Preparation sequence
* [ ] Departure sequence
* [ ] Jerusalem exit
* [ ] Transition to wilderness

### Important Constraint

**Do not build the entire city.**

Build only the areas required to make Act I playable.

---

# 7. Milestone 3 — Narrative Reveal

### Goal

Make the identity reveal playable.

The sequence should establish:

1. The family is in the wilderness.
2. Lehi commands the sons to return.
3. Lehi addresses the player as Laman.
4. The player realizes their identity.
5. Nephi responds.
6. The player understands Nephi is a separate character.
7. The Brass Plates mission begins.

### Definition of Done

A first-time player experiences the reveal without prior explanation.

The reveal should feel like a **story event**, not a developer message.

---

# 8. Milestone 4 — Brass Plates Vertical Slice

This is the primary demonstration milestone.

### Target

**10–15 minutes of polished gameplay**, representing the intended final experience.

The vertical slice should demonstrate:

* Living Jerusalem
* NPC schedules
* Exploration
* Investigation
* Information gathering
* Dialogue
* Multiple approaches
* Environmental interaction
* Time-driven gameplay
* Narrative progression
* Return to previously visited locations
* Brass Plates objective

The vertical slice does not need to contain every planned system.

It needs to demonstrate the **core thesis of the game**.

---

# 9. Vertical Slice Quality Bar

The vertical slice should feel like a small piece of a real game rather than a collection of prototypes.

It should have:

### Functional

* Reliable controls
* Reliable NPC behavior
* Reliable time system
* Working interactions
* Working dialogue
* Clear objectives
* No major progression blockers

### Visual

* Consistent art direction
* Readable environments
* Clear interactive objects
* Distinct characters
* Cohesive UI

### Narrative

* Clear motivation
* Strong pacing
* Character interactions
* Meaningful discovery
* Laman reveal
* Brass Plates objective

### Gameplay

* Exploration
* Investigation
* At least one meaningful information-based problem
* At least one environmental puzzle
* At least one situation with multiple possible approaches

---

# 10. Milestone 5 — Complete Adventure

After the vertical slice has validated the concept, production can expand toward the complete approximately one-hour experience.

### Target Structure

**Act I — Jerusalem**

→ Explore
→ Investigate
→ Discover danger
→ Prepare
→ Escape

**Act II — Wilderness**

→ Establish camp
→ Receive new commandment
→ Return objective

**Act III — Jerusalem**

→ First attempt
→ Loss of property
→ Second attempt
→ Escape

**Act IV — Nephi**

→ Nephi's independent mission
→ Laban
→ Brass Plates

**Act V — Escape**

→ Return
→ Escape Jerusalem
→ Wilderness

---

# 11. Content Production Strategy

Content should be built around reusable systems.

Prefer:

**System → Reusable Content → Multiple Uses**

rather than:

**One-off feature → One-off content**

Examples:

### NPC Schedule System

Can support:

* Merchants
* Guards
* Families
* Workers
* Religious figures
* Wealthy citizens
* Servants

### Dialogue System

Can support:

* Story dialogue
* Investigation
* Clues
* Character relationships
* Optional conversations

### Time System

Can support:

* NPC schedules
* Access windows
* Events
* Puzzles
* Narrative progression

### Investigation System

Can support:

* Clues
* Objects
* NPC knowledge
* Environmental discoveries
* Multi-step objectives

---

# 12. Technical Development Strategy

Technical work should support gameplay rather than become an end in itself.

Prioritize architecture that makes it easy to:

* Add NPCs
* Add dialogue
* Add locations
* Add schedules
* Add interactions
* Add objectives
* Add puzzles
* Add narrative events

Avoid premature infrastructure for systems that are not required by the current milestone.

---

# 13. AI-Assisted Development

AI tools may be used aggressively for implementation while maintaining human ownership of design.

AI can assist with:

* Boilerplate
* Refactoring
* Debugging
* Scene creation
* Data structures
* UI
* Tooling
* Test scaffolding
* Repetitive content
* Documentation
* Code review

The human developer remains responsible for:

* Game design
* Creative direction
* Narrative
* Source accuracy
* Architecture decisions
* Final implementation
* Quality control

The standard is:

> **AI can accelerate development. It does not replace design ownership.**

---

# 14. Scope Control

The project should actively resist feature creep.

Before adding a feature, ask:

1. Does it improve exploration?
2. Does it improve investigation?
3. Does it improve puzzle solving?
4. Does it improve the narrative?
5. Does it support the current milestone?

If the answer is no, defer it.

---

# 15. Explicitly Out of Initial Scope

The following are **not required for the initial vertical slice**:

* Multiplayer
* Backend accounts
* Online infrastructure
* Large-scale procedural generation
* Complete historical reconstruction of Jerusalem
* Full combat system
* Multiple playable characters
* Multiple major cities
* Complete Book of Mormon adaptation
* Large-scale monetization systems
* Merchandise infrastructure
* Full analytics platform

These may become future considerations.

They should not delay the vertical slice.

---

# 16. Development Order

When multiple tasks compete for attention, use this order:

### NOW

**Make Act I playable.**

### NEXT

**Make the wilderness transition and Laman reveal playable.**

### THEN

**Make the Brass Plates scenario playable.**

### THEN

**Polish the vertical slice.**

### AFTER VALIDATION

**Expand toward the complete one-hour adventure.**

### FUTURE

**Expand the universe.**

---

# 17. Production Backlog Categories

All future work should be categorized as one of:

### Critical

Required for the current milestone.

### Important

Improves the current experience but does not block progress.

### Polish

Improves presentation after functionality works.

### Future

Not required for the current release.

This prevents interesting ideas from becoming accidental requirements.

---

# 18. Prototype Strategy

The project should progress through progressively larger playable versions.

## Prototype 0 — Movement

Purpose:

> Prove the basic player experience.

Includes:

* Player movement
* Camera
* Collision
* Basic mobile controls

---

## Prototype 1 — Jerusalem

Purpose:

> Prove that the world is fun to explore.

Includes:

* Small grey-box Jerusalem
* NPC interaction
* Basic exploration
* One simple puzzle

---

## Prototype 2 — Narrative

Purpose:

> Prove that the story works as gameplay.

Includes:

* Lehi
* Family
* Act I
* Investigation
* Departure from Jerusalem

---

## Prototype 3 — Reveal

Purpose:

> Prove that the narrative twist works.

Includes:

* Wilderness
* Return commandment
* Laman reveal
* Nephi response
* Brass Plates objective

---

## Prototype 4 — Vertical Slice

Purpose:

> Prove that the complete design thesis works.

Target:

**10–15 minutes of polished gameplay.**

---

## Version 1.0

Purpose:

> Deliver the complete initial adventure.

Target:

**Approximately one hour of gameplay.**

---

# 19. Definition of Done

A milestone is not complete simply because the feature technically exists.

A feature is complete when it is:

* Playable
* Understandable
* Stable
* Integrated into the game
* Tested
* Appropriate to the current design
* Free of major blockers

A milestone is complete when a player can experience the intended gameplay without developer assistance.

---

# 20. Public Demonstration Goal

The vertical slice should eventually be suitable for:

* Cardon Ellis pitch
* Ward Radio discussion
* Public demonstration
* Portfolio presentation
* itch.io build
* Potential funding discussions

The demo should communicate the concept without requiring a verbal explanation.

A person should be able to pick it up and understand:

> **This is an exploration and investigation adventure where the world itself is part of the puzzle.**

---

# 21. Future Expansion

Once the initial game succeeds, potential expansion includes:

### Additional Book of Mormon Adventures

New stories can reuse the game's underlying systems.

### Lehi's Journey

Potential expansion:

**Jerusalem → Wilderness → Valley → Journey → Ocean**

### Additional Characters

Potential playable or supporting characters include:

* Nephi
* Sam
* Laman
* Lemuel
* Other Book of Mormon characters

### Multiplayer

Potential cooperative experiences may eventually allow multiple players to participate in shared adventures.

Multiplayer is **not part of the initial scope**.

---

# 22. Production North Star

The project should always move toward a playable experience.

When in doubt:

> **Build the smallest version that proves the idea.**

Do not spend weeks building infrastructure for a feature that has not yet been proven fun.

Do not expand the world before the existing world is fun to explore.

Do not polish systems that have not yet been validated.

Do not build the whole game to discover whether the core idea works.

Instead:

> **Prototype → Play → Learn → Refine → Expand.**

---

# Current Milestone

## Act I Grey-Box Prototype

The immediate development target is:

**Start → Explore Jerusalem → Interact with NPCs → Investigate → Experience Lehi's warning → Prepare to leave → Leave Jerusalem**

Once this is playable:

**Build the wilderness → Reveal Laman → Begin the Brass Plates mission.**

The next major production milestone is the **10–15 minute Brass Plates vertical slice**.
