# Escape from Jerusalem

## Act 03 — Plates

> **Return to Jerusalem. Get the plates.**

This act is the current vertical-slice focus of *Escape from Jerusalem*.

The player has already escaped Jerusalem and learned that the journey is not over. They must now return to the city with their brothers and obtain the brass plates from Laban.

This document describes the **current playable version** of the Plates sequence.

It is intentionally smaller than the complete story described in the Vision and Pitch documents. The goal is to create a fun, playable demonstration of the game's core experience:

**Explore → Investigate → Gather Information → Choose an Approach → Act → Adapt**

---

# 1. Player Objective

The player's primary objective is:

> **Obtain the brass plates from Laban.**

The player should not simply be given a linear sequence of instructions.

Instead, the player should understand the problem and investigate possible ways to solve it.

The player should be able to ask:

> **How can I get the plates?**

---

# 2. Starting State

The player begins this act in the wilderness with:

- Laman
- Lemuel
- Sam
- Nephi

The family has been commanded to return to Jerusalem.

The player now knows that the objective is to obtain the brass plates from Laban.

The player returns to the familiar Jerusalem map.

Previously explored locations should remain recognizable.

---

# 3. Return to Jerusalem

The brothers enter Jerusalem.

The city should feel familiar but different.

The player already understands some of the city's geography, but the objective has changed.

The city is now a tool for solving the problem.

The player can:

- Explore
- Talk to NPCs
- Investigate locations
- Observe NPC behavior
- Gather information
- Discover possible approaches
- Revisit previously explored areas

---

# 4. The Investigation

The player must determine how to approach the problem of obtaining the plates.

The game should provide information through:

- NPC dialogue
- Environmental clues
- Previously discovered knowledge
- NPC schedules
- Locations
- Objects
- Relationships between characters

The player should not necessarily receive a single obvious quest marker saying exactly what to do.

The objective is known.

The solution is discovered.

---

# 5. The Brothers

The brothers should have distinct roles during the mission.

### Laman

**Player character.**

The player controls Laman throughout the act.

### Lemuel

Provides dialogue, opinions, and reactions.

Can participate in conversations and planning.

### Sam

Supporting character.

Can provide information or participate in interactions.

### Nephi

Important supporting character.

Nephi proposes approaches and eventually becomes central to the final solution.

The player does **not** control Nephi.

---

# 6. Laban

Laban is the central obstacle.

He possesses the brass plates.

The player's goal is to find a way to obtain them.

Laban should exist as an NPC within the world rather than simply appearing as a scripted boss encounter.

His location, schedule, relationships, and behavior should contribute to the investigation.

---

# 7. Current Mission Structure

The current playable version follows this basic progression:

**Return to Jerusalem**

↓

**Investigate the city**

↓

**Determine how to approach Laban**

↓

**Approach Laban**

↓

**Request the brass plates**

↓

**Laban refuses**

↓

**Attempt to obtain the plates through the family's wealth**

↓

**Laban takes the property**

↓

**Escape**

↓

**Return / attempt to recover the property**

↓

**Discover the situation has become more dangerous**

↓

**Nephi proposes another approach**

↓

**Nephi enters Jerusalem alone**

↓

**Nephi obtains the plates**

↓

**Mission complete**

This sequence represents the current narrative target.

Individual gameplay steps may change as the prototype develops.

---

# 8. First Attempt

The brothers approach Laban.

Laman is selected to speak with him.

The player approaches Laban and requests the records.

Laban refuses.

The brothers then offer their family's wealth in exchange for the plates.

Laban accepts the wealth but refuses to give them the records.

The brothers lose their property.

The immediate objective changes:

> **Recover the family's property.**

---

# 9. Second Attempt

The brothers return to recover their property.

The situation becomes dangerous.

They are discovered and pursued.

The brothers escape.

The player should experience a clear escalation:

**Investigation → Attempt → Failure → Consequence**

The failure should not feel like the player simply lost a game.

It should advance the story and change the situation.

---

# 10. Nephi's Plan

After the second attempt fails, Nephi proposes another approach.

Nephi decides to enter Jerusalem alone.

This is the point where the player's role becomes particularly important.

The player remains **Laman**.

The player does not take control of Nephi.

Nephi enters Jerusalem while the player remains with the brothers.

---

# 11. The Plates

Nephi returns with the brass plates.

The brothers now possess the records.

The primary objective has been completed:

> **GET THE BRASS PLATES**

This is the completion state for the current Act 03 prototype.

The larger game will continue into the final escape from Jerusalem.

---

# 12. Required Gameplay Systems

The current prototype should support the minimum systems necessary to make this act playable.

### World

- Existing Jerusalem map
- Connected areas
- Collision
- Player movement

### NPCs

- NPC movement
- NPC schedules
- NPC locations
- Dialogue
- Basic interactions

### Time

- World clock
- Time advancement
- NPC schedule changes

### Investigation

- Discoverable information
- Interactions that provide information
- Objective progression
- Player understanding of possible approaches

### Narrative

- Brother interactions
- Laban interaction
- First attempt
- Failure state
- Second attempt
- Nephi's plan
- Plates obtained state

---

# 13. Current Scope

The current implementation does **not** require:

- Full combat system
- Fully realized stealth system
- Complete historical recreation of Jerusalem
- Complex inventory system
- Final art
- Final audio
- Multiplayer
- Backend services
- Full mobile optimization
- Every possible solution to the mission

The objective is to prove the core gameplay.

---

# 14. Vertical Slice Standard

Act 03 should eventually demonstrate the central design thesis of *Escape from Jerusalem*:

> **The player knows what they need, but must figure out how to accomplish it.**

A successful prototype should allow the player to:

1. Return to Jerusalem.
2. Explore the city.
3. Talk to people.
4. Gather useful information.
5. Determine how to approach Laban.
6. Attempt to obtain the plates.
7. Experience consequences.
8. Understand Nephi's alternative.
9. See the plates successfully obtained.

---

# 15. Completion Criteria

Act 03 is considered playable when:

- [ ] The player can enter Jerusalem.
- [ ] The player can navigate the relevant areas.
- [ ] The player can interact with required NPCs.
- [ ] NPC schedules and movement function.
- [ ] The player can gather information.
- [ ] The player can reach Laban.
- [ ] The first attempt can occur.
- [ ] Laban refuses the request.
- [ ] The family's property can be offered.
- [ ] The property is lost.
- [ ] The brothers can escape.
- [ ] The second attempt can occur.
- [ ] The situation escalates.
- [ ] Nephi proposes the final approach.
- [ ] Nephi can enter Jerusalem.
- [ ] The plates can be obtained.
- [ ] The game reaches a clear **Plates Obtained** state.

---

# 16. What We Are Testing

This act is primarily a gameplay experiment.

We are testing:

### Can Jerusalem be a puzzle?

Can the player use knowledge of the city to solve problems?

### Can NPCs become gameplay?

Can schedules, relationships, dialogue, and behavior give the player useful information?

### Can failure be interesting?

Can an unsuccessful attempt create new information and new possibilities rather than simply forcing a reload?

### Can a familiar story become interactive?

Can the player feel like they are figuring out how to accomplish the objective rather than simply following the Book of Mormon's sequence of events?

---

# 17. North Star

The player should finish this act feeling:

> **“I had to figure out how to get those plates.”**

Not:

> **“I followed the quest markers until the game gave me the plates.”**

The story provides the destination.

**The player figures out the journey.**