# Escape from Jerusalem

## Design Bible

> **An interactive Book of Mormon Adventure.**

**Engine:** Godot
**Genre:** 2D Top-Down Puzzle / Adventure
**Primary Platform:** Mobile
**Initial Experience:** Approximately 1 hour
**Primary Source:** *The Book of Mormon*, primarily 1 Nephi 1–4
**Current Development Goal:** Playable Act I / Brass Plates vertical slice

Miro: https://miro.com/app/board/uXjVHwxdBoI=/

---

# 1. Game Overview

**Escape from Jerusalem** is a 2D top-down puzzle/adventure game inspired by the opening chapters of *The Book of Mormon*.

The game takes place primarily in Jerusalem around 600 BC and follows Lehi's family during their departure from Jerusalem and subsequent return to obtain the brass plates.

The player explores a compact, interconnected world, interacts with NPCs, investigates their surroundings, gathers information, solves environmental and information-based puzzles, and determines how to approach problems.

The game emphasizes:

* Exploration
* Investigation
* Discovery
* NPC interaction
* Environmental puzzles
* Information gathering
* Time and NPC schedules
* Multiple approaches to objectives
* Narrative discovery

Combat is secondary and is not intended to define the core experience.

---

# 2. Core Design Philosophy

The fundamental design philosophy is:

> **Information is a gameplay resource.**

The player should frequently solve problems by learning something rather than acquiring a stronger weapon.

Knowledge may come from:

* NPC conversations
* Observing NPC behavior
* Exploring locations
* Examining objects
* Discovering clues
* Learning schedules
* Understanding relationships
* Revisiting previously explored areas
* Connecting information discovered at different times

The player should gradually construct a mental model of Jerusalem.

The desired question is:

> **"What can I do?"**

rather than:

> "What does the game want me to do?"

---

# 3. Core Gameplay Loop

The primary gameplay loop is:

**Explore → Observe → Investigate → Gather Information → Choose an Approach → Act → Advance Time → Adapt**

A shorter representation is:

**Explore → Discover → Interact → Solve → Progress**

The two representations describe the same experience at different levels.

---

# 4. Player Experience

The player should feel:

* Curious
* Uncertain
* Resourceful
* Increasingly knowledgeable
* Connected to the characters
* Familiar with the city
* Responsible for their own decisions

The world should not constantly explain itself.

Players should be rewarded for paying attention.

A player who remembers:

* where someone goes,
* when they go there,
* who they know,
* what they said,
* what they need,
* or what they saw earlier

should have an advantage.

---

# 5. Narrative Structure

The initial adventure follows the broad narrative structure of 1 Nephi 1–4.

## Act I — Jerusalem

The player begins in Jerusalem.

The protagonist's identity is intentionally concealed from the player.

The player explores the city, learns about Lehi's family, encounters NPCs, and gradually becomes aware of the growing danger surrounding Lehi.

The player participates in the family's preparations to leave Jerusalem.

### Act I Goal

**Escape Jerusalem.**

---

## Act II — Wilderness

The family establishes itself outside Jerusalem.

The player experiences the transition from city life to the wilderness.

Lehi receives another commandment.

The family learns that the sons must return to Jerusalem to obtain the brass plates.

This changes the direction of the adventure.

---

# 6. The Identity Reveal

### Internal Design Secret

The player character is **Laman**.

The player should initially believe they are **Nephi**.

This is a deliberate narrative deception.

The game should avoid revealing the protagonist's identity during the first portion of the game.

The player should not be explicitly identified by name through:

* Narration
* Nameplates
* Character selection
* UI
* Internal monologue
* Obvious exposition
* Character introductions that reveal the protagonist

The reveal occurs when Lehi commands the sons to return to Jerusalem.

Lehi addresses the player:

> **“Laman, behold, I would that thou shouldst go again unto the land of Jerusalem...”**

The player realizes that the character they have been controlling is Laman.

Nephi then responds:

> **“I will go and do the things which the Lord hath commanded...”**

The player now understands that Nephi has always been a separate character.

### Design Purpose

The reveal should:

1. Surprise the player.
2. Recontextualize the first act.
3. Establish Nephi as a separate character.
4. Change the player's understanding of the story.
5. Transition the player into the Brass Plates adventure.

The twist should never be used merely as a gimmick.

The first act should still be satisfying even after the player understands what happened.

---

# 7. Act III — Return to Jerusalem

The brothers return to Jerusalem.

The player now knows they are Laman.

The city is familiar because the player has already explored it.

Previously visited locations should gain new significance.

The player now has a new objective:

## Obtain the Brass Plates

The return should demonstrate the game's central design philosophy:

> **The player already knows the city, but does not yet know how to accomplish the objective.**

---

# 8. The First Attempt

The brothers attempt to obtain the brass plates from Laban.

The brothers determine who will approach Laban.

Laman is selected.

Laman approaches Laban and requests the records.

Laban refuses.

The brothers attempt to exchange their family's wealth for the records.

Laban takes their property but refuses to surrender the plates.

The brothers flee.

This sequence should emphasize:

* Dialogue
* Social interaction
* Information
* Risk
* Consequences

---

# 9. The Second Attempt

The brothers return to recover their property.

They are discovered.

Laban's servants pursue them.

The brothers escape.

The situation becomes increasingly desperate.

Laman and Lemuel become angry with Nephi.

Nephi proposes another plan.

---

# 10. Act IV — Nephi

Nephi decides to enter Jerusalem alone.

The player remains Laman.

The player does **not** become Nephi.

Nephi becomes an important active character within the story while remaining an NPC.

Nephi is led by the Spirit and encounters Laban.

The major events described in 1 Nephi 4 occur.

The player experiences these events from Laman's perspective rather than controlling Nephi.

This preserves the central design premise:

> **The player experiences Nephi's story without necessarily playing Nephi.**

---

# 11. Act V — Escape

Nephi returns with the brass plates.

The brothers now possess the records they were commanded to obtain.

The objective becomes:

## Escape Jerusalem.

The player controls Laman.

The final sequence moves through previously visited portions of Jerusalem and toward the wilderness.

Familiar locations should feel different because the player's understanding of them has changed.

The brothers successfully return to their family.

---

# 12. Ending

The family prepares to continue its journey.

The brass plates have been obtained.

Jerusalem is behind them.

The wilderness lies ahead.

The game ends on a scripture-based closing moment.

Possible closing text:

> **“And we did again take our journey in the wilderness...”**

The screen fades to black.

# ESCAPE FROM JERUSALEM

---

# 13. World Design

## Jerusalem

Jerusalem should be represented as a **compact, interconnected gameplay space**, not a literal historical reconstruction.

The city should feel large enough to explore while remaining small enough for the player to learn.

The player should gradually develop a mental map of important locations.

Potential areas include:

* Family residence
* Residential district
* Lower City
* Upper City
* Marketplace
* Temple area
* Wealthier district
* Narrow streets
* City gates
* Laban's area
* Restricted areas
* Hidden areas
* Wilderness outskirts

---

# 14. World Structure

The city should encourage multiple directions and approaches.

There should not necessarily be one correct path through every objective.

A player might:

* Discover information from one NPC.
* Use that information to access another area.
* Learn about an NPC's schedule.
* Return at a different time.
* Discover an alternate route.
* Solve an environmental obstacle.
* Revisit a previously explored location.

The world itself should function as a puzzle.

---

# 15. NPC Design

NPCs should be more than dialogue dispensers.

NPCs should have:

* Locations
* Schedules
* Relationships
* Routines
* Dialogue
* Goals
* Knowledge
* Potential reactions to player actions

NPCs should appear to exist independently of the player.

The player should be able to observe their behavior.

For example:

> An NPC may be in the marketplace in the morning, travel to another area in the afternoon, and return home in the evening.

The player can learn this through observation or conversation.

---

# 16. Time System

Time is a gameplay system.

The world contains a centralized clock.

Time can advance as the player performs activities or reaches important narrative states.

Time affects:

* NPC locations
* NPC schedules
* Availability of conversations
* Access to certain locations
* Potential opportunities
* Narrative progression

The player should eventually understand that **when** they approach a problem can matter as much as **how** they approach it.

---

# 17. Investigation System

Investigation is a developing core system.

The player should be able to:

* Examine objects
* Talk to NPCs
* Discover clues
* Record useful information where appropriate
* Connect information
* Use previously learned knowledge to solve later problems

The system should avoid turning investigation into a conventional checklist whenever possible.

The player should feel like they are **figuring things out**, rather than completing database entries.

---

# 18. Dialogue

Dialogue should support:

* Character development
* Worldbuilding
* Investigation
* Puzzle solving
* Narrative progression
* Humor
* Conflict
* Player discovery

Dialogue should not constantly explain information that the player could reasonably discover through the environment.

Whenever practical, information should be distributed across multiple sources.

---

# 19. Puzzle Design

Puzzles should be inspired by classic Zelda-style environmental adventure design while remaining original to the project.

## Environmental Puzzles

Potential mechanics include:

* Pushable objects
* Switches
* Gates
* Hidden passages
* Keys
* Locked buildings
* Pressure plates
* Environmental manipulation
* Light/dark interactions
* Multi-step puzzles

## Information Puzzles

Potential mechanics include:

* NPC clues
* Written clues
* Symbols
* Maps
* Schedules
* Environmental storytelling
* Remembering locations
* Connecting information

## Exploration Puzzles

Potential mechanics include:

* Alternate routes
* Hidden areas
* Restricted areas
* Shortcuts
* Returning to previous locations
* Discovering previously inaccessible paths

Mechanics should be introduced gradually.

Later challenges should combine multiple systems.

---

# 20. Combat

Combat is **not currently a core requirement**.

If included, combat should:

* Support the adventure.
* Remain relatively simple.
* Avoid overpowering exploration and investigation.
* Fit the setting.
* Avoid turning the game into an action-focused experience.

The project should be capable of working without combat being the primary progression system.

**Status:** TBD.

---

# 21. Art Direction

The visual direction is:

**2D top-down pixel/illustrated adventure style.**

Primary gameplay inspiration:

**The Legend of Zelda: A Link to the Past**

The game should prioritize:

* Readable silhouettes
* Distinct characters
* Clear interactive objects
* Readable environments
* Visually understandable puzzles
* Compact spaces
* Mobile readability

The project should develop its own visual identity rather than directly reproducing Zelda's artwork.

### Current Open Decisions

* Pixel art vs. illustrated 2D
* Exact rendering style
* Character design
* Environmental art direction

---

# 22. Mobile Design

Mobile is a primary platform rather than a later port.

The design should prioritize:

* Touch movement
* Large interactive controls
* Minimal UI clutter
* Readable text
* Clear interaction prompts
* Short gameplay interactions
* Comfortable touch targets

The game should not simply be a desktop game compressed onto a phone.

Mobile interaction should influence level and interface design from the beginning.

### Open Decision

* Portrait vs. landscape

---

# 23. Audio

Potential audio components include:

* Jerusalem ambience
* Wilderness ambience
* Footsteps
* Environmental interactions
* NPC interaction sounds
* Puzzle feedback
* Exploration music
* Tension music
* Story music
* Final escape music

Audio should reinforce the major environmental transitions:

**Jerusalem → Wilderness → Return → Escape**

---

# 24. Technical Architecture

## Engine

**Godot**

Godot is the primary engine because of familiarity with the engine and its suitability for 2D development and mobile deployment.

---

## Development Assistance

AI development tools may assist with:

* Project setup
* Boilerplate code
* Scene creation
* Grey-boxing
* UI implementation
* Repetitive implementation
* Debugging
* Refactoring
* Development tooling

AI-generated code and content should remain understandable, maintainable, and reviewable by the primary developer.

---

# 25. Source-Fidelity Policy

The **Book of Mormon is the primary narrative source**.

Principal source material:

* 1 Nephi 1
* 1 Nephi 2
* 1 Nephi 3
* 1 Nephi 4

Major documented events should not be changed merely for gameplay convenience.

Creative additions are permitted for:

* Exploration
* Puzzles
* NPC interactions
* Environmental storytelling
* Travel
* Gameplay objectives
* Transitions between documented events

However:

> **Creative additions should not contradict the primary source.**

Direct scripture should be quoted accurately.

Scriptural dialogue should be verified against the source before final implementation.

---

# 26. Characters

## Laman

**Player Character**

Oldest son of Lehi.

The player controls Laman for the majority of the game.

The player's identity is intentionally concealed during the opening portion of the adventure.

---

## Nephi

Lehi's younger son.

Nephi becomes increasingly important after the identity reveal.

He ultimately volunteers to obtain the brass plates and carries out the events recorded in 1 Nephi 4.

Nephi remains an important character without becoming the player's character.

---

## Lehi

Father of Laman, Lemuel, Sam, and Nephi.

Primary narrative driver.

His revelations and commandments establish the family's major objectives.

---

## Sariah

Mother of the family.

Provides family interaction, emotional grounding, and opportunities for dialogue.

---

## Lemuel

Brother of Laman and Nephi.

Provides dialogue, conflict, humor, and gameplay interaction.

---

## Sam

Brother of Laman and Nephi.

Supporting character.

---

## Laban

Keeper of the brass plates.

Primary antagonist associated with the brass-plate objective.

---

# 27. Success Criteria

The initial game should be considered successful if it:

1. Provides a complete beginning-to-end playable experience.
2. Can be played comfortably on mobile.
3. Clearly communicates its story.
4. Makes Jerusalem interesting to explore.
5. Makes information and observation meaningful gameplay resources.
6. Provides meaningful puzzle/adventure gameplay.
7. Successfully delivers the narrative reveal.
8. Remains faithful to major scriptural events.
9. Is enjoyable without requiring prior knowledge of the *Book of Mormon*.
10. Can be demonstrated publicly as a polished game rather than merely a prototype.

---

# 28. Current Design Decisions

The following are considered current working decisions:

* 2D top-down perspective
* Godot
* Mobile-first
* Jerusalem as the primary environment
* Laman as the player character
* Initial identity concealment
* Nephi remains an NPC
* Exploration-focused gameplay
* Investigation and information as core systems
* NPC schedules
* Centralized world clock
* Environmental and information-based puzzles
* Approximately one-hour initial experience
* 1 Nephi 1–4 as primary source material
* Combat is secondary / optional
* Initial focus is a focused vertical slice

---

# 29. Open Design Questions

These decisions remain unresolved and should not be treated as requirements until finalized.

* [ ] Portrait vs. landscape
* [ ] Exact art style
* [ ] Pixel art vs. illustrated 2D
* [ ] Combat: none / limited / full
* [ ] Exact puzzle mechanics
* [ ] Final Jerusalem map layout
* [ ] Character designs
* [ ] Dialogue system details
* [ ] Save system
* [ ] Sound/music direction
* [ ] Monetization
* [ ] Distribution platforms
* [ ] App Store / Google Play strategy
* [ ] Privacy requirements for the target audience
* [ ] Multiplayer architecture for future expansion
* [ ] Backend requirements
* [ ] Asset ownership/licensing
* [ ] Final script
* [ ] Final source verification of scriptural dialogue

---

# 30. Design Principle

The game should always favor **player discovery over developer explanation**.

Whenever possible:

> Let the player notice it.

Then:

> Let the player investigate it.

Then:

> Let the player figure it out.

The world should provide enough information for the player to make intelligent decisions without constantly telling them what to do.

---

# 31. The Secret

**Internal development note — DO NOT expose in player-facing materials.**

The player character is Laman.

The game intentionally allows the player to believe they are Nephi during the opening portion.

This is a core narrative mechanic and should be protected during:

* Marketing
* Store descriptions
* Trailers
* Screenshots
* Public demonstrations
* Pitch materials
* UI
* Dialogue
* Documentation visible to players

The reveal should be experienced rather than explained.

**The player should discover the truth at the same moment the story reveals it.**
