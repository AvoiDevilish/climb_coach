# ARCHITECTURE_DECISIONS.md

# Eye Club — Architecture Decision Records (ADR)

آخرین بروزرسانی: Sprint 3.17

---

# ADR-001

## رابطه Session ، SessionMember و Attendance

### وضعیت

Deferred

### تصمیم

```
Athlete
      │
      ▼
SessionMember
      │
      ▼
Attendance
```

Attendance در نسخه‌های اولیه می‌تواند ساده باشد، اما قبل از شروع Feature کامل حضور و غیاب باید به SessionMember متصل شود، نه مستقیماً به Athlete.

### دلیل

* پشتیبانی از ورزشکار مهمان
* پشتیبانی از جبرانی
* انتقال ورزشکار بین سانس‌ها
* توسعه‌پذیری گزارش‌ها

---

# ADR-002

## پشتیبانی از چند مربی

### وضعیت

Planned (Version 3)

### تصمیم

مدل Session از همین امروز برای coach_id آماده می‌شود.

در نسخه فعلی هر مربی برنامه را مستقل روی گوشی خود اجرا می‌کند.

در نسخه‌های آینده همه مربیان از طریق Sync به یک باشگاه متصل خواهند شد.

---

# ADR-003

## Session Template

### وضعیت

Planned

### تصمیم

Session واقعی و برنامه هفتگی از هم جدا خواهند شد.

```
SessionTemplate

↓

Session
```

### دلیل

مربی نباید هر هفته سانس‌ها را از ابتدا ایجاد کند.

---

# ADR-004

## تقویم هفتگی مربی

### وضعیت

Backlog

### تصمیم

در تب مدیریت سانس‌ها یک نوار مینیمال از هفت روز آینده نمایش داده شود.

اطلاعات هر روز:

* تعداد سانس
* ساعات کاری
* تعطیلی
* رویداد مهم

---

# ADR-005

## رویدادهای رسمی باشگاه

### وضعیت

Backlog

### تصمیم

رویدادها توسط مربیان ثبت شوند.

نمونه:

* مسابقه
* آزمون
* اردو
* تعطیلی

همراه با یادآور.

---

# ADR-006

## سیستم جبرانی

### وضعیت

Approved

### تصمیم

سانس جبرانی ثابت وجود ندارد.

ورزشکار جبرانی در سانس‌هایی ثبت می‌شود که ظرفیت آزاد دارند.

ظرفیت آزاد به صورت پویا محاسبه می‌شود.

---

# ADR-007

## Snapshot تاریخی

### وضعیت

Approved

### تصمیم

گزارش‌های گذشته نباید با تغییر ظرفیت یا قوانین سانس تغییر کنند.

اطلاعات هر جلسه باید مستقل باقی بماند.

---

# ADR-008

## قانون توسعه دیتابیس

### وضعیت

Approved

### قانون

هیچ Feature جدیدی اجازه تغییر جدول‌های اصلی را ندارد.

جدول‌های اصلی:

* athletes
* sessions
* attendance

Featureهای جدید فقط از طریق جدول‌های مستقل و Foreign Key توسعه پیدا می‌کنند.

---

# ADR-009

## مدیریت حضور مربیان

### وضعیت

Future

### تصمیم

نسخه فعلی:

هر مربی مستقل.

نسخه آینده:

```
Club

↓

Coach

↓

Sessions

↓

Sync
```

---

# ADR-010

## سیستم عضویت در سانس

### وضعیت

Approved

```
Athlete

↓

SessionMember

↓

Session
```

نوع عضویت:

* NORMAL
* MAKEUP
* GUEST
* TRIAL
* PRIVATE

بدون تغییر ساختار دیتابیس.

---

# ADR-011

## تعداد کل ورزشکاران

### وضعیت

Backlog

در داشبورد مربی خلاصه‌ای از تعداد کل ورزشکاران نمایش داده شود.

---

# ADR-012

## فلسفه توسعه Eye Club

هدف پروژه ساخت یک نرم‌افزار قابل توسعه برای سال‌های آینده است.

اولویت‌ها:

1. توسعه‌پذیری
2. پایداری معماری
3. Migration حداقلی
4. جداسازی مسئولیت‌ها
5. قابلیت Sync در آینده
6. قابلیت افزودن Feature بدون بازطراحی

# Development Rules

این قوانین در تمام طول پروژه رعایت می‌شوند.

---

## Rule 01

هیچ Feature جدیدی بدون بررسی ADRها پیاده‌سازی نمی‌شود.

---

## Rule 02

هر تغییر معماری باید یک ADR جدید دریافت کند.

---

## Rule 03

قبل از تغییر Database ابتدا Domain بررسی می‌شود.

---

## Rule 04

هیچ جدول اصلی بدون دلیل بسیار مهم تغییر نمی‌کند.

---

## Rule 05

Migrationها همیشه افزایشی هستند.

Rollback انجام نمی‌شود.

---

## Rule 06

هر Sprint باید در پایان Stable باشد.

---

## Rule 07

اول زیرساخت، بعد UI.

---

## Rule 08

اگر دو راه‌حل وجود داشت، راه‌حلی انتخاب می‌شود که پنج سال بعد نیز قابل توسعه باشد، حتی اگر امروز کمی زمان بیشتری بگیرد.

Eye Club Scheduling Model v1

Scheduling consists of:

1. SessionTemplate
- Weekly recurring sessions
- Fixed weekday/time
- Capacity settings

2. SessionTemplateMember
- Permanent athlete membership
- Automatically appears in weekly sessions

3. SessionOccurrence
- Real date instance
- Attendance belongs here

4. SessionMember
- Actual participants
- Makeup and guest handling

Rules:
- Holidays do not delete sessions.
- Coach decides cancellation.
- Guest + Makeup cannot exceed available capacity.
- Completed sessions remain editable and archived.

## Scheduling Decision v1

Current product:
Eye Club

Database prepared for multi coach,
but current UI supports one coach.

Session concept:

- Permanent sessions will be modeled as weekly templates.
- Temporary sessions will be single occurrences.
- Permanent athletes belong to templates.
- Actual attendance belongs to occurrences.

Data priority:
Scheduling data is considered analytics data.

