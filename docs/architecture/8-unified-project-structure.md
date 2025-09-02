# 8. Unified Project Structure

```
ContestReminder/
├── .github/                    # CI/CD workflows
│   └── workflows/
│       └── ci.yaml
├── lib/                        # Main Flutter application code
│   ├── main.dart
│   └── features/
│       └── contest_list/
│           ├── data/
│           ├── presentation/
│           └── models/
├── test/                       # Automated tests
├── assets/                     # Static assets like images or fonts
├── docs/                       # Project documentation (PRD, Architecture, etc.)
│   ├── prd.md
│   └── architecture.md
├── .gitignore
├── pubspec.yaml                # Flutter project dependencies
└── README.md
```

**Rationale:** This structure is clean, standard for a Flutter project, and provides clear separation for application code (`lib`), tests (`test`), assets, and documentation (`docs`). It gives us a solid foundation for the MVP while being flexible enough to grow.

---