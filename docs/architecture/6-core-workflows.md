# 6. Core Workflows

## 6.1. Set Contest Reminder (Corrected)

This diagram shows the sequence of events when a user sets a reminder for a contest.

```mermaid
sequenceDiagram
    participant User
    participant ContestReminder App
    participant CLIST.by API
    participant Native Alarm Service

    User->>ContestReminder App: Launches App
    ContestReminder App->>CLIST.by API: GET /api/v4/contest/ (upcoming)
    CLIST.by API-->>ContestReminder App: Returns list of contests
    ContestReminder App->>User: Displays contest list
    User->>ContestReminder App: Taps 'Set Reminder'
    ContestReminder App->>Native Alarm Service: Schedule alarm for contest start time
    Native Alarm Service-->>ContestReminder App: Alarm scheduled successfully
    ContestReminder App->>User: Updates UI to show 'Reminder Set'
```

## 6.2. Cancel Contest Reminder

This diagram shows the sequence for canceling a previously set reminder.

```mermaid
sequenceDiagram
    participant User
    participant ContestReminder App
    participant Native Alarm Service

    User->>ContestReminder App: Taps 'Reminder Set' button
    ContestReminder App->>User: Shows 'Cancel Reminder?' confirmation
    User->>ContestReminder App: Confirms cancellation
    ContestReminder App->>Native Alarm Service: Cancel alarm for contest
    Native Alarm Service-->>ContestReminder App: Alarm canceled successfully
    ContestReminder App->>User: Updates UI to 'Set Reminder'
```

---