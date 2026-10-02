<img width="695" height="256" alt="image" src="https://github.com/user-attachments/assets/ebeea90b-c61e-47e3-ba5d-d43d74470037" /># Self-Attendance & Management System - Database Architecture

An advanced relational database developed using **MySQL** for a student and trainee self-attendance tracking system, featuring robust data engineering, geo-verification, and secure role-based access control.

---

## 🚀 Project Overview
**End-to-End Database Lifecycle:** Designed the complete relational schema from scratch—starting from business requirements analysis and ERD modeling, to structural normalization, constraint definition, and SQL implementation.

The system is designed for educational and training environments to enable trainees to record their attendance and departure autonomously. It ensures high reliability, strict operational rule-checking, and a scalable foundation capable of integrating seamlessly with other enterprise systems.

---

## 🛠️ Tech Stack & Tools
* **Relational Database:** MySQL (Tables, Foreign Key Constraints, Views, Triggers, and Stored Logics).
* **File Management (NoSQL Concept):** Server-side file handling for excuse documents and attachments.
* **Database Modeling & Design:** Dbdiagram.io for Entity-Relationship Diagram (ERD) architecture.

---

## ✨ Key Features & Architectural Highlights

### 1. Data Normalization & Scalability
* Applied rigorous **Normalization** principles to eliminate data redundancy, optimize query performance, and maintain data integrity across all relational tables.
* Engineered a flexible, future-proof database architecture that successfully facilitated the later integration of an external module due to its robust foundational design.

### 2. Smart Geo-fencing & Attendance Logic
* **Geospatial Validation:** Utilizes branch-specific coordinates (Latitude & Longitude) alongside radius boundaries (`radius_meters`) to verify that trainees are physically within the designated branch zone during check-in.
* **Automated Time Rules:** Compares check-in timestamps against scheduled batch timings to automatically evaluate attendance states (present, late, absent) via `attendance_v2`.
* **Excuse Management:** Dedicated relational tracking (`attendance_excuse`) to handle excuse requests, document attachments, and approval workflows.

### 3. Advanced Security & RBAC
* Implemented a comprehensive **Role-Based Access Control (RBAC)** architecture linking `roles` to granular `permissions` through a junction table (`role_permissions`).
* Enforced data validation and strict function-level permissions to maximize system security and data privacy.

### 4. Comprehensive Auditing & Traceability
* Integrated mandatory audit columns across core tables beyond basic business requirements to ensure full accountability, tracking metadata such as:
  * `created_at`
  * `created_by`

---

## 📊 Database Schema (ERD)
The entity-relationship diagram illustrates the structural layout and relational integrity across branches, users, sessions, and attendance modules.

---

## 📂 Repository Files & Documentation
* [View Database Schema Script (SQL)](https://github.com/Laila-MIS/Self-Attendance_System/blob/main/Self-Attendance_Schema.sql)
* [View the ERD Diagram PDF](https://github.com/Laila-MIS/Self-Attendance_System/blob/main/ERD_Self-Attendance_System.pdf)
