# Eye Club Project Status

## Project Identity

Project Name:
climb_coach

Product Name:
Eye Club

Purpose:
مدیریت باشگاه سنگنوردی، ورزشکاران، سانس‌ها، ارزیابی عملکرد و برنامه تمرینی.

---

# Current Release State

Last Completed Sprint:
Sprint - Sessions & Session Members Foundation

Git Commit:
f66245f

Status:
Stable

---

# Architecture

Framework:
Flutter

Database:
SQLite

Architecture Style:
Feature Based + Repository Pattern

Main Layers:

lib/
 ├── app
 │    ├── routes.dart
 │    └── navigation
 │
 ├── core
 │    ├── database
 │    ├── design
 │    ├── utils
 │    └── widgets
 │
 └── features
      ├── athletes
      ├── sessions
      ├── session_members
      ├── movements
      ├── assessments
      └── dashboard

---

# Completed Features

## Athletes

Implemented:

- Athlete registration
- Athlete list
- Athlete profile foundation
- Dynamic fields infrastructure


## Sessions

Implemented:

- Create session
- Save session in SQLite
- Session repository
- Session controller
- Session list
- Session card
- Session detail page


## Session Members

Implemented:

- Session members table
- Repository
- Controller
- Detail model with athlete join
- Display athlete list inside session
- Member type badge:
    - NORMAL
    - MAKEUP
    - GUEST


---

# Database

Current Version:

6


Main Tables:

athletes

sessions

session_members

attendance

assessment_results

movements

custom_fields

athlete_values


---

# Important Data Value Points

## Athlete Data

Future analytics:

- age
- height
- weight
- gender
- custom fields
- training history


## Session Data

Future analytics:

- attendance rate
- session capacity usage
- athlete consistency
- makeup usage


## Session Member Data

High value:

- permanent membership relation
- session loyalty
- attendance patterns


## Attendance

Reserved for:

- attendance history
- performance correlation
- coach reports


---

# Current Design Decisions

## Sessions

Supported concepts:

1. Permanent sessions
   Example:
   Every Monday 18:00

2. Temporary sessions
   Example:
   Special session on 1405/05/20


Permanent sessions:
- have weekday
- repeat weekly


Temporary sessions:
- have exact date
- archived after completion


---

# Next Sprint

## Sprint: Session Management Upgrade

Goals:

1. Replace current session tab

Current:
List of sessions

New:

7-day calendar view:

Example:

Today: Tuesday

Display:

Tuesday
Wednesday
Thursday
Friday
Saturday
Sunday
Monday


Features:

- official holidays highlighted red
- sessions still displayed on holidays
- coach decides cancellation


---

## Weekly Session Templates

Each weekday contains:

- session cards
- add session button


Session card:

Target:
6 cards visible on phone screen


---

## Capacity System

Rules:

Normal capacity:

capacity field


Available:

capacity - active members


Makeup + Guest:

Cannot exceed remaining capacity


---

# Future Sprint

Athlete Development

Features:

- complete athlete profile
- training programs
- assign programs
- movement history
- progress analysis


---

# Development Rule

Before every sprint:

1. Update this file.

After every APK/Git release:

1. Update:
   - completed features
   - database version
   - architecture decisions
   - next roadmap

