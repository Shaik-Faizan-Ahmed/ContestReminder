# Brainstorming Session Results

**Session Date:** 2025-09-02
**Facilitator:** Business Analyst Mary
**Participant:** User

---

## Executive Summary

**Topic:** A mobile app for upcoming coding contests with reminders.

**Session Goals:** Broad exploration of the app concept, targeting student users on Android and iOS.

**Techniques Used:** 
- Six Thinking Hats
- Five Whys
- Role Playing

**Total Ideas Generated:** 15+

### Key Themes Identified:
- **Simplicity and Focus:** The app must avoid feature bloat and provide a clean, simple UI focused on listing contests and setting reminders.
- **Reliability of Alarms:** The reminder feature must function as a true system-level alarm, not a passive notification. This is the critical make-or-break feature.
- **Motivation and Learning:** The app's core purpose is to help students maintain learning momentum and participation streaks, making it a motivational tool.

---

## Technique Sessions

### Six Thinking Hats

- **White Hat (Facts & Information):**
  - Existing apps are often cluttered and packed with unnecessary features.
  - The core user need is simple: list upcoming contests and set reminders.
  - Key platforms to integrate are LeetCode, HackerRank, CodeChef, and Codeforces.
  - We will need to collect APIs from these platforms that provide contest name, time, and duration.

- **Red Hat (Feelings & Intuition):**
  - The desired user feeling is "happy and clear."
  - The biggest challenge is perceived to be API integration and the technical aspects of app development.
  - The biggest opportunity is to create a simple, wonderful project that helps millions of people.
  - Personal excitement and daily utility are strong motivators for the project.

- **Black Hat (Caution & Risks):**
  - **API Unreliability:** APIs from contest platforms could be unstable or have breaking changes.
  - **Reminder Complexity:** Implementing a reliable alarm feature that works across both Android and iOS is a significant technical challenge.
  - **User Interface:** A lack of a good, intuitive UI could cause the app to fail.
  - **Hidden Complexity:** We might be overlooking the overall complexity of building and maintaining the app.

- **Yellow Hat (Benefits & Value):**
  - The single biggest benefit is the reliable alarm that reminds people of contests.
  - The core value proposition is the combination of a simple UI with this powerful alarm feature.
  - The best possible outcome is a fully functional, reliable app that delivers on its core promise.

- **Green Hat (Creativity & New Ideas):**
  - **Countdown Timer:** Display a live countdown timer for each contest to create a sense of urgency.
  - **Card-Based UI:** Use a modern, vertical card-based layout where each contest is a distinct, full-width card.

- **Blue Hat (Process & Summary):**
  - The exercise successfully defined the app's core features, risks, and value proposition from multiple perspectives, providing a well-rounded initial project view.

### Five Whys

- **1. Why make the app?** To provide integrated reminders without users needing to use a generic alarm app.
- **2. Why is that important?** To save time and effort for busy users who might not be free to set alarms manually.
- **3. Why is that a problem?** Because if they have to do it manually, they might forget the contest exists.
- **4. Why does forgetting matter?** Because the target users have a strong desire to participate in every contest.
- **5. Why do they want to participate every time?** **(Root Cause)** To learn to code and to maintain a motivational streak of participation.

### Role Playing

- **Persona 1: Priya (The Busy Student)**
  - **First Action:** Immediately look at the contest list and set reminders.
  - **"Wow" Factor:** A simple UI, no login/signup requirement, and a very easy way to set alarms.
  - **Frustrations:** A confusing UI or alarms that don't work properly.

- **Persona 2: David (The Skeptical Student)**
  - **Instant Delete Condition:** If the "alarms" are just standard, easily-missed notifications instead of actual alarms.
  - **Surprise Feature:** An alarm that functions as a real, system-level alarm and works reliably even if the app is closed.
  - **Biggest Doubt:** Skepticism is focused on whether the core features (displaying contests and the alarm) will actually work reliably.

---

## Idea Categorization

### Immediate Opportunities
*   **Idea:** A simple, focused MVP with a clean UI that lists contests from 1-2 platforms and has a reliable, system-level alarm feature.
    - **Rationale:** This directly addresses the core need and the key differentiator identified in the session.
    - **Resources:** Mobile developer (iOS/Android or cross-platform), UI/UX designer, access to platform APIs.

### Future Innovations
*   **Idea:** Streak Tracking & Gamification.
    - **Rationale:** Builds on the root motivation discovered in the "Five Whys" to help users maintain their learning momentum.
    - **Development Needed:** A user account system (optional at first), logic to track contest participation, and UI elements to display streaks.

### Moonshots
*   **Idea:** AI-powered contest recommendations.
    - **Rationale:** Could provide massive value by suggesting contests based on a user's skill level, past performance, or stated goals.
    - **Challenges:** Requires significant data, machine learning expertise, and a robust user data model.

---

*Session facilitated using the BMAD-METHOD™ brainstorming framework*
