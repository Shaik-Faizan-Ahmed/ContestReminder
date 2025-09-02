# ContestReminder Product Requirements Document (PRD)

## Goals and Background Context

### Goals

*   Launch a stable, functional MVP for both iOS and Android.
*   Achieve significant user adoption (e.g., 10,000 downloads) within six months post-launch.
*   Become the trusted, go-to tool for coding contest reminders.
*   Ensure users feel confident they will not miss a contest they've set a reminder for.
*   Drive a high rate of alarm-setting on contest detail views.
*   Help users increase their contest participation rate.

### Background Context

The Contest Reminder app addresses a key pain point for students and developers: missing coding contests due to cluttered apps and the unreliability of manual reminders. Existing solutions often use passive notifications that are easily missed, breaking a user's learning momentum.

This project aims to solve this by providing a mobile application with a clean, simple interface focused on one core function: setting a **true, system-level alarm** for upcoming contests. By prioritizing reliability and ease of use, the app will provide a delightful, focused experience that helps users stay consistent in their competitive programming journey.

### Change Log

| Date | Version | Description | Author |
| :--- | :--- | :--- | :--- |
| 2025-09-02 | 1.0 | Initial PRD draft | John (PM) |

## Requirements

### Functional

*   **FR1:** The app must display a clean, vertical, card-based list of upcoming coding contests.
*   **FR2:** Users must be able to set a reliable, system-level alarm for any contest with a single tap from the contest card.
*   **FR3:** Each contest card must display a live countdown timer to the event's start time.
*   **FR4:** All core features of the app must be accessible immediately on launch, without requiring any user login or registration.
*   **FR5:** The app must fetch and display contest data from an initial set of 2-3 platforms (e.g., LeetCode, Codeforces).

### Non-Functional

*   **NFR1:** The app must support the two most recent major versions of both iOS and Android.
*   **NFR2:** The application must be lightweight and launch in under 2 seconds.
*   **NFR3:** The user interface must provide a smooth, responsive scrolling experience.
*   **NFR4:** The app must be developed using a cross-platform framework (e.g., Flutter, React Native) for efficient development.
*   **NFR5:** The MVP will operate without a dedicated backend, fetching data directly from third-party contest platform APIs.
*   **NFR6:** The MVP will not require any local or remote database.
*   **NFR7:** Any API keys used for fetching contest data must be stored securely within the application.
*   **NFR8:** The system-level alarm must be 100% reliable, functioning correctly even if the app is closed or the device is restarted.

## User Interface Design Goals

### Overall UX Vision

The user experience must be defined by **simplicity, clarity, and reliability**. The app should feel like a dependable, single-purpose utility that gets the job done with zero friction. The design should be clean, modern, and intuitive, making the process of viewing contests and setting alarms feel effortless and reassuring. The ultimate goal is an experience that is not just functional but also a delight to use.

### Key Interaction Paradigms

*   **Vertical Feed:** The primary interface will be a vertically scrolling list of contest cards, a familiar and intuitive pattern.
*   **One-Tap Action:** The core interaction for setting a reminder must be a single, unambiguous tap on a clear call-to-action element on each contest card.
*   **Minimalism:** The UI will avoid any clutter. Information will be presented clearly and concisely, with no unnecessary steps or distractions from the core user flow.

### Core Screens and Views

For the MVP, we will focus on a single, primary screen:
*   **Contest List Screen:** This view will display the vertically scrolling list of upcoming contest cards. It is the heart of the application where users will spend all of their time. No other screens are in scope for the MVP.

### Accessibility: WCAG AA

While not explicitly defined in the brief, we should aim for **WCAG AA** compliance as a standard to ensure the app is usable by people with disabilities. This includes sufficient color contrast, clear typography, and support for screen readers.

### Branding

No specific branding guidelines have been provided. The aesthetic should be clean, modern, and minimalist, with a focus on readability and ease of use. The visual design should support the core values of simplicity and reliability.

### Target Device and Platforms: Cross-Platform

The application will target mobile devices on both **iOS and Android**, developed using a cross-platform framework to ensure a consistent experience.

## Technical Assumptions

### Repository Structure: Monorepo

For the initial development, a **Monorepo** structure is recommended. This will keep all the code for the mobile application in a single, easy-to-manage repository.

### Service Architecture: Serverless (Client-Side Only)

The MVP will employ a **client-side only architecture**. The application will not have its own dedicated backend. Instead, it will fetch contest data directly from the public APIs of third-party platforms like LeetCode and Codeforces.

### Testing Requirements: Unit + Integration

To ensure the reliability of the application, especially the critical alarm and API integration features, the testing strategy must include both **Unit Tests** (to validate individual components) and **Integration Tests** (to validate interactions between the app and third-party APIs).

### Additional Technical Assumptions and Requests

*   **Cross-Platform Framework:** The application must be built using a modern cross-platform framework, such as **Flutter or React Native**, to ensure efficient development and a consistent user experience across both iOS and Android.
*   **Native Alarm Integration:** This is the highest-risk technical feature. The architecture must support robust, reliable integration with the native system alarm APIs for both iOS and Android. A technical spike or proof-of-concept is required to validate this approach before full development.
*   **API Integration:** The architecture must be designed to handle interactions with multiple, external third-party APIs gracefully, including managing potential instability, rate limits, and errors.
*   **Secure Key Storage:** Any API keys used to access contest platform data must be stored securely within the client application, following platform-specific best practices (e.g., not hardcoded in source).

## Epic List

### MVP Epic

*   **Epic 1: Core Contest Reminder Functionality:** Establish the foundational mobile application for iOS and Android, implement the ability to fetch and display contests from the initial set of platforms, and deliver the core, reliable system alarm feature.

### Post-MVP Epics

*   **Epic 2: Gamification & User Engagement:** Introduce optional user accounts to allow for tracking contest participation streaks, directly supporting the user's core motivation to stay consistent.
*   **Epic 3: Platform Expansion & Advanced Filtering:** Incrementally add more contest platforms based on user feedback and introduce features for filtering and sorting the contest list.
*   **Epic 4: Personalization & Integration:** Introduce AI-powered recommendations and allow users to sync contest reminders with their native calendar applications.

## Epic 1: Core Contest Reminder Functionality

**Goal:** This epic will deliver a fully functional MVP of the Contest Reminder app. This includes setting up the project structure, fetching and displaying contest data from a primary source in a clean UI, and implementing the app's single most important feature: a 100% reliable, system-level alarm. By the end of this epic, the app will be ready for its first release.

---

#### **Story 1.1: Project Setup & CI/CD Foundation**

*   **As a** developer,
*   **I want** a new, empty cross-platform mobile application with a basic CI/CD pipeline,
*   **so that** I have a stable foundation to start building features.

**Acceptance Criteria:**
1.  A new Git repository is created for the project.
2.  A new project is initialized using a cross-platform framework (e.g., Flutter).
3.  The default "Hello World" application runs successfully on both an iOS simulator and an Android emulator.
4.  A basic CI/CD pipeline (e.g., using GitHub Actions) is configured to build the application on every push to the main branch.

---

#### **Story 1.2: Contest Data Model and API Service**

*   **As a** developer,
*   **I want** a service that can fetch contest data from a single platform's public API (e.g., Codeforces) and parse it into a clean data model,
*   **so that** the app has contest information to display.

**Acceptance Criteria:**
1.  A `Contest` data model is defined in the code to hold contest information (e.g., name, platform, startTime, url).
2.  An API service is created that makes a network request to the chosen platform's public API.
3.  The service correctly parses the API's JSON response into a list of `Contest` objects.
4.  The service includes unit tests that mock the network request and verify the parsing logic.
5.  The service gracefully handles network errors.

---

#### **Story 1.3: Display Contest List UI**

*   **As a** user,
*   **I want** to see a list of upcoming contests in a clean, card-based interface,
*   **so that** I can quickly see what's coming up.

**Acceptance Criteria:**
1.  The main screen fetches contest data from the API service upon loading.
2.  A loading indicator is shown while the data is being fetched.
3.  Fetched contests are displayed in a vertically scrolling list of cards.
4.  Each card clearly displays the contest name, platform, and start time.
5.  If the fetch fails, a user-friendly error message is displayed.

---

#### **Story 1.4: Add Live Countdown Timer**

*   **As a** user,
*   **I want** to see a live countdown on each contest card,
*   **so that** I know exactly how much time is left until a contest starts.

**Acceptance Criteria:**
1.  Each contest card in the list displays a countdown timer reflecting the time until the contest starts.
2.  The timer updates in real-time (e.g., every second).
3.  Once a contest's start time has passed, the countdown is replaced by a "Started" or similar status indicator.

---

#### **Story 1.5 (Spike): Native Alarm Proof-of-Concept**

*   **As a** developer,
*   **I need** to create a proof-of-concept that demonstrates the ability to reliably schedule and trigger a native, system-level alarm on both iOS and Android,
*   **so that** we can validate the technical feasibility of the app's core feature.

**Acceptance Criteria:**
1.  The proof-of-concept successfully schedules an alarm for a future time.
2.  The alarm triggers as a true system alarm (full-screen, audible), not a simple notification, on both platforms.
3.  The alarm functions correctly even if the proof-of-concept app is closed.
4.  A brief report is created documenting the findings, chosen libraries, and any platform-specific challenges.

---

#### **Story 1.6: Implement Alarm Setting**

*   **As a** user,
*   **I want** to tap a button on a contest card to set a reliable system alarm for that contest,
*   **so that** I won't forget to attend.

**Acceptance Criteria:**
1.  Each contest card has a clear "Set Reminder" button/icon.
2.  Tapping the button uses the validated native alarm functionality to schedule an alarm for the contest's start time.
3.  The UI on the card updates to confirm that the reminder has been set (e.g., the button changes to "Reminder Set").
4.  The scheduled alarm is persistent and survives app closures and device restarts.
5.  Tapping the "Reminder Set" button again provides an option to cancel the scheduled alarm.
