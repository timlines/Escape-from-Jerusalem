# Escape from Jerusalem

## Conversational Investigation MVP — Game Design Document

**Version:** 0.1
**Purpose:** Vertical-slice MVP
**Engine:** Godot
**Genre:** Narrative Investigation / Social Exploration / Conversational Adventure
**Core Fantasy:** *Use people, information, relationships, and deduction as your inventory.*

---

## 1. MVP Vision

This vertical slice tests a new gameplay model for *Escape from Jerusalem*.

The player is placed in a small portion of Jerusalem and given a simple objective:

> **Find Laban and obtain the plates.**

The player is not given a linear quest path.

Instead, they must:

**Explore → Talk → Gather information → Evaluate clues → Follow leads → Build relationships → Adapt to changing circumstances → Find Laban → Earn his trust → Obtain the plates.**

The purpose of this slice is to determine whether **conversation and information can function as the primary gameplay mechanics** in place of conventional combat and loot-based progression.

---

# 2. Design Pillars

### 2.1 Information Is Inventory

The player's most important possessions are not swords and potions.

They are:

* Facts
* Rumors
* Observations
* Relationships
* Favors
* Secrets
* Reputation
* Knowledge of locations and routines

The player should eventually think:

> “I know someone who can help me.”

rather than:

> “I have the right item.”

---

### 2.2 NPCs Are Part of a Network

NPCs should not exist merely to provide dialogue.

Every important NPC has:

* Knowledge
* Relationships
* Goals
* Fears
* Routines
* Trust toward the player
* Information they will or will not reveal

NPCs know different things.

The player must connect those pieces.

---

### 2.3 Information Is Imperfect

Information can be:

* Correct
* Incorrect
* Incomplete
* Outdated
* Misinterpreted
* Unverified
* Corroborated

The player should never automatically know whether a piece of information is true.

---

### 2.4 The World Changes

NPCs move.

Events happen.

Information becomes stale.

The player can discover patterns, but should not be able to memorize a completely deterministic schedule.

NPC behavior follows **patterns with variation**.

---

### 2.5 Player Agency

The game should rarely tell the player exactly what to do.

Instead of:

> **QUEST: Go to the Stable**

the player receives information such as:

> “Laban was seen near the stable.”

The player decides whether that information is worth pursuing.

---

# 3. MVP Objective

The complete vertical slice has one major objective:

> **Find Laban and obtain the plates.**

The objective has two major phases.

### Phase 1 — Locate Laban

The player must discover where Laban is through exploration and information gathering.

### Phase 2 — Obtain the Plates

Finding Laban is insufficient.

The player must understand him, build trust, and find a way to convince him to surrender the plates.

---

# 4. MVP Map

The playable world should remain small.

## Jerusalem

### 1. Family House

Starting location.

### 2. Merchant's House

Primary information hub.

### 3. Potter's Shop

Provides information about Laban's recent activity.

### 4. Stable

Provides information about travel and movement.

### 5. Eastern Gate

Provides guards, travelers, and contradictory observations.

## Hills

### 6. Old Watchtower

Provides evidence of Laban's movements.

### 7. Stone House

Introduces the courier/information network.

### 8. Northern Caravan Road

Potential final Laban encounter.

The map should be compact enough that the player can understand the geography.

---

# 5. Core NPCs

The MVP should use approximately 10 significant NPCs.

| NPC               | Gameplay Function         |
| ----------------- | ------------------------- |
| Merchant          | Information hub           |
| Potter            | Laban sightings           |
| Stable Worker     | Travel information        |
| Older Guard       | Reliable witness          |
| Younger Guard     | Contradictory information |
| Shepherd          | Wilderness information    |
| Courier Boy       | High-value information    |
| Stone House Woman | Courier network           |
| Laban's Companion | Laban context             |
| Laban             | Final social challenge    |

NPCs should have different levels of reliability.

---

# 6. Information System

Every important clue should exist as structured game data.

Example:

```text
Information
Subject: Laban
Claim: Laban visited the stable.
Source: Stable Worker
Age: 5 minutes
Confidence: High
Status: Unconfirmed
```

Another:

```text
Information
Subject: Laban
Claim: Laban passed through the eastern gate.
Source: Older Guard
Age: 20 minutes
Confidence: Medium
Status: Corroborated
```

## Information Properties

### Source

Who provided the information?

### Age

How recently was it learned?

### Confidence

How trustworthy is the source?

### Status

Possible states:

* Unknown
* Rumor
* Reported
* Observed
* Confirmed
* Corroborated
* Contradicted

---

# 7. Knowledge Inventory

The player should have a dedicated knowledge interface.

Example:

## LABAN

* Seen at Merchant's House — 45 minutes ago
* Purchased dark cloak — Today
* Seen at Stable — 30 minutes ago
* Seen at Eastern Gate — uncertain
* Traveling east — high confidence
* Accompanied by another man — confirmed

The player should be able to inspect why they believe something.

Example:

> **Laban was at the Stable.**

**Source:** Stable Worker
**Reported:** 30 minutes ago
**Confidence:** High

This turns information into a tangible gameplay resource.

---

# 8. Social Network System

NPC relationships are another form of inventory.

Each important NPC has a relationship state with the player.

Example:

```text
Merchant
Trust: 3 / 5
Attitude: Cautious
Knows Player: Yes
Will Share: Basic Information
```

Trust can change through:

* Helping NPCs
* Providing information
* Keeping promises
* Lying
* Threatening
* Stealing
* Revealing secrets
* Completing favors

The player should be able to lose relationships as well as gain them.

---

# 9. NPC Knowledge

NPCs should not possess all game information.

Each NPC has a limited knowledge set.

Example:

```text
Merchant knows:
- Laban visited today
- Laban bought a cloak
- Stable worker saw Laban
- Courier network exists
```

But:

```text
Merchant does NOT know:
- Laban's exact current location
- Who summoned Laban
- What is inside the plates
```

This prevents NPC conversations from becoming magical databases.

---

# 10. NPC Goals

NPCs should have their own motivations.

Example:

### Merchant

**Goal:** Protect his business.

**Fear:** Getting involved with dangerous people.

**Will help:** If player establishes trust.

**Will refuse:** If player becomes threatening.

This makes conversations feel like interactions with characters rather than information vending machines.

---

# 11. NPC Routines

NPCs should follow patterns rather than fixed schedules.

Example:

```text
Laban

Morning:
Usually Upper City

Afternoon:
Marketplace / Stable / Home

Evening:
May leave Jerusalem

Night:
Northern Road / Hideout
```

Each day or time period can vary within these possibilities.

The goal is:

> **Predictable enough to investigate. Unpredictable enough to remain interesting.**

---

# 12. Waiting

**WAIT** is a core action.

Waiting advances world time.

When time advances:

* NPCs move
* Information becomes older
* New NPCs may arrive
* Events may occur
* Rumors may spread
* Laban may change location

Waiting should not always generate a clue.

This creates a meaningful tradeoff:

> **Wait for information or act on what you already know?**

---

# 13. Conversation System

The player should be able to interact naturally with NPCs.

Basic interaction categories:

* Ask
* Tell
* Offer
* Persuade
* Lie
* Threaten
* Trade
* Observe
* Follow
* Wait

The MVP does not require unrestricted AI dialogue.

NPC responses can be driven by structured knowledge and conversational intent.

The player should nevertheless feel that they are **having a conversation**, not navigating a traditional dialogue tree.

---

# 14. Investigation Loop

The fundamental loop is:

### 1. Explore

Choose a location.

### 2. Interact

Talk to NPCs or investigate the environment.

### 3. Acquire Information

Receive facts, rumors, observations, or clues.

### 4. Evaluate

Determine whether the information is trustworthy and useful.

### 5. Form a Hypothesis

Example:

> “Laban probably went to the Stable.”

### 6. Act

Travel, wait, follow, question, observe, or investigate.

### 7. World Changes

NPCs move and events occur.

### 8. Update Knowledge

The player gains or loses confidence in their theories.

### 9. Progress

Eventually the player locates Laban.

---

# 15. Finding Laban

The player should not have a single correct path.

A possible chain:

```text
Merchant
   ↓
Laban was here
   ↓
Potter
   ↓
Laban went toward Stable
   ↓
Stable
   ↓
Laban traveled east
   ↓
Eastern Gate
   ↓
Laban went toward hills
   ↓
Shepherd
   ↓
Watchtower
   ↓
Laban used hill path
   ↓
Northern Road
   ↓
Laban
```

But players should be able to discover alternate paths.

The goal is not to reproduce one exact sequence.

The goal is for the player to **construct a plausible chain of evidence.**

---

# 16. Contradictory Information

Contradictions are intentional gameplay.

Example:

Older Guard:

> “Laban was here twenty minutes ago.”

Younger Guard:

> “That was yesterday.”

The player must investigate.

The player can:

* Question both guards
* Look for physical evidence
* Ask another NPC
* Follow another lead
* Decide which source to trust

This introduces detective gameplay without requiring a traditional puzzle system.

---

# 17. Environmental Investigation

Not every clue should come from conversation.

The player can discover:

* Footprints
* Objects
* Written messages
* Clothing
* Seals
* Signs of recent activity
* Open doors
* Missing objects
* Physical traces

Environmental evidence can corroborate or contradict NPC statements.

---

# 18. Laban Encounter

The first encounter with Laban should intentionally fail.

The player finds him.

The player asks for the plates.

Laban refuses.

This teaches the player:

> **Location is only half the problem.**

The next objective becomes:

> **Earn Laban's trust.**

The player can learn:

* What Laban wants
* What Laban fears
* Who Laban trusts
* Who Laban owes
* What pressures him
* What relationships matter to him

---

# 19. Social Solution

The MVP should allow several possible approaches.

Potential strategies:

### Persuasion

Build enough trust.

### Favor

Help Laban solve a problem.

### Information

Provide Laban with valuable information.

### Leverage

Discover something Laban needs or fears.

### Reputation

Build relationships with people Laban trusts.

### Deception

Convince Laban the player has another purpose.

The MVP does not need every possible strategy implemented.

At least **two distinct approaches** should be possible.

---

# 20. Success Condition

The vertical slice ends when:

> **Laban willingly gives the player the plates.**

The player receives:

### Item

**Brass Plates**

But the more important achievement is:

### Social State

**Laban Trust: Sufficient**

The game should make it clear that the player succeeded because of their actions and accumulated knowledge.

---

# 21. Failure Philosophy

Failure should generally produce **new information**, not simply a Game Over.

Examples:

Player fails to persuade Laban:

> Laban reveals what he wants.

Player follows the wrong lead:

> They discover the information was unreliable.

Player waits too long:

> Laban moves somewhere else.

Player angers an NPC:

> That NPC stops cooperating.

Failure should change the player's knowledge or relationships.

---

# 22. MVP UI

The MVP needs only a few major interfaces.

### World View

Shows:

* Player
* Locations
* NPCs
* Movement

### Conversation UI

Shows:

* NPC speech
* Player response/input
* Available conversational actions

### Knowledge Journal

Shows:

* People
* Locations
* Information
* Confidence
* Recent clues

### Social Network

Shows:

* NPC relationships
* Trust
* Known connections
* Favors

The UI should remain lightweight.

---

# 23. Technical Architecture

Recommended conceptual systems:

```text
GameState
├── Time
├── CurrentLocation
├── NPCStates
├── PlayerState
├── InformationDatabase
├── RelationshipDatabase
└── EventState
```

### NPCState

```text
NPC
├── Location
├── Routine
├── Goals
├── Knowledge
├── Trust
├── Relationships
└── CurrentState
```

### Information

```text
Information
├── Subject
├── Claim
├── Source
├── Timestamp
├── Confidence
└── Status
```

### Relationship

```text
Relationship
├── NPC
├── Trust
├── Reputation
├── Favors
└── KnownSecrets
```

---

# 24. MVP Scope Control

The following should **NOT** be required for this slice:

* Combat system
* Large inventory
* Crafting
* Character leveling
* Skill trees
* Procedural city generation
* Hundreds of NPCs
* Fully autonomous AI NPCs
* Full Jerusalem
* Complete biblical story
* Complete escape sequence

Those systems can come later.

The MVP exists to prove the **investigation/social gameplay loop**.

---

# 25. MVP Success Criteria

The slice is successful if a tester can play without being told the solution and naturally experiences:

### Discovery

> “I need to find Laban.”

### Investigation

> “Maybe someone here knows where he went.”

### Uncertainty

> “I'm not sure if this information is reliable.”

### Deduction

> “These two clues probably point toward the eastern gate.”

### Agency

> “I'm going to wait here instead of following that lead.”

### Social gameplay

> “This NPC trusts me enough to tell me something.”

### Adaptation

> “Laban moved. I need new information.”

### Achievement

> “I figured out how to get him to give me the plates.”

If players experience those emotions, **the MVP has succeeded.**

---

# 26. The Core Design Statement

The entire slice can be summarized by one sentence:

> **Escape from Jerusalem is a game where information is the player's inventory, relationships are their equipment, and conversation is their primary means of interacting with the world.**

The player isn't following a quest.

**The player is building a theory about the world and testing it.**

That is the gameplay system this vertical slice should prove.
