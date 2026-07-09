# Branching Strategy - Melior

## Branches
- `main` — production-ready code, protected, requires PR + review
- `develop` — integration branch for tested features
- `feature/<name>` — new features, branched from develop
- `hotfix/<name>` — urgent production fixes, branched from main

## Rules
1. No direct pushes to `main` or `develop`
2. All changes via Pull Request
3. Minimum 1 approval required before merge
4. CI checks (lint, test, security scan) must pass before merge
5. Squash merge preferred for clean history
