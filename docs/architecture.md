# EYE CLUB Architecture

---

# Brand

UOG

---

# Product

EYE CLUB

---

# Architecture

Clean Architecture

Feature First

MVVM (Controller)

Repository Pattern

SQLite Local First

Cloud Ready

---

# Main Products

Coach App

Wall Tablet

Cloud Dashboard

---

# Core Modules

Athletes

Movements

Assessments

Programs

Reports

Nutrition

Attendance

Settings

Users

Synchronization

AI

---

# Feature Structure

feature/

data/

domain/

presentation/

---

# Rules

Every feature is isolated.

Every feature owns its repository.

Every feature owns its models.

UI never accesses Database directly.

Repositories are the only data source.

---

# Navigation

Dashboard

↓

Feature

↓

Details

↓

Editor

---

# UI Principles

Maximum 3 taps to any important data.

Coach First.

Fast Workflow.

Large Touch Targets.

Dark Mode Ready.

Tablet Ready.

---

# Naming

snake_case files

PascalCase classes

camelCase variables

---

# File Size

Max 300 lines per file.

Split Widgets early.

---

# Database

UUID ids

Soft Delete

created_at

updated_at

Future Sync Ready

---

# Future

Offline First

Cloud Sync

AI Analysis

Coach Dashboard

Wall Tablet

Athlete Portal
