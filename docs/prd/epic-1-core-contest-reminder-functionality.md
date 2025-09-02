# Epic 1: Core Contest Reminder Functionality

**Goal:** This epic will deliver a fully functional MVP of the Contest Reminder app. This includes setting up the project structure, fetching and displaying contest data from a primary source in a clean UI, and implementing the app's single most important feature: a 100% reliable, system-level alarm. By the end of this epic, the app will be ready for its first release.

---

### **Story 1.1: Project Setup & CI/CD Foundation**

*   **As a** developer,
*   **I want** a new, empty cross-platform mobile application with a basic CI/CD pipeline,
*   **so that** I have a stable foundation to start building features.

**Acceptance Criteria:**
1.  A new Git repository is created for the project.
2.  A new project is initialized using a cross-platform framework (e.g., Flutter).
3.  The default "Hello World" application runs successfully on both an iOS simulator and an Android emulator.
4.  A basic CI/CD pipeline (e.g., using GitHub Actions) is configured to build the application on every push to the main branch.

---

### **Story 1.2: Contest Data Model and API Service**

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

### **Story 1.3: Display Contest List UI**

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

### **Story 1.4: Add Live Countdown Timer**

*   **As a** user,
*   **I want** to see a live countdown on each contest card,
*   **so that** I know exactly how much time is left until a contest starts.

**Acceptance Criteria:**
1.  Each contest card in the list displays a countdown timer reflecting the time until the contest starts.
2.  The timer updates in real-time (e.g., every second).
3.  Once a contest's start time has passed, the countdown is replaced by a "Started" or similar status indicator.

---

### **Story 1.5 (Spike): Native Alarm Proof-of-Concept**

*   **As a** developer,
*   **I need** to create a proof-of-concept that demonstrates the ability to reliably schedule and trigger a native, system-level alarm on both iOS and Android,
*   **so that** we can validate the technical feasibility of the app's core feature.

**Acceptance Criteria:**
1.  The proof-of-concept successfully schedules an alarm for a future time.
2.  The alarm triggers as a true system alarm (full-screen, audible), not a simple notification, on both platforms.
3.  The alarm functions correctly even if the proof-of-concept app is closed.
4.  A brief report is created documenting the findings, chosen libraries, and any platform-specific challenges.

---

### **Story 1.6: Implement Alarm Setting**

*   **As a** user,
*   **I want** to tap a button on a contest card to set a reliable system alarm for that contest,
*   **so that** I won't forget to attend.

**Acceptance Criteria:**
1.  Each contest card has a clear "Set Reminder" button/icon.
2.  Tapping the button uses the validated native alarm functionality to schedule an alarm for the contest's start time.
3.  The UI on the card updates to confirm that the reminder has been set (e.g., the button changes to "Reminder Set").
4.  The scheduled alarm is persistent and survives app closures and device restarts.
5.  Tapping the "Reminder Set" button again provides an option to cancel the scheduled alarm.
