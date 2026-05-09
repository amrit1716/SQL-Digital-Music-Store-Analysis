# 🎵 Digital Music Store Analysis — SQL Project

## 📌 Overview
This is a practice project built while learning SQL, analyzing a digital music store database to answer real business questions around sales, customers, genres, and artists using **MySQL & MySQL Workbench** on the well-known **Chinook Dataset**.

---

## Tools Used
- MySQL
- MySQL Workbench

---

## Database Schema
![Schema Diagram](schema_diagram.png)

---

## Business Questions Answered

### 🟢 Basic
| # | Question |
|---|---|
| Q1 | Who is the senior most employee based on job title? |
| Q2 | Which countries have the most invoices? |
| Q3 | What are the top 3 values of total invoice? |
| Q4 | Which city has generated the highest invoice total? (for a promotional Music Festival) |
| Q5 | Who is the best customer — the one who has spent the most? |

### 🟡 Intermediate
| # | Question |
|---|---|
| Q6 | Find all Rock Music listeners — return email, name & genre, ordered alphabetically |
| Q7 | Which artists have written the most Rock music? (Top 10) |
| Q8 | Which tracks are longer than the average song length? |
| Q9 | How much has each customer spent on each artist? |

### 🔴 Advanced
| # | Question |
|---|---|
| Q10 | How much did each customer spend on the best-selling artist only? |
| Q11 | What is the most popular genre in each country? (handles ties) |
| Q12 | Who is the top spending customer in each country? (handles ties) |

---

## Key SQL Concepts Used
- Joins (INNER JOIN across 6+ tables)
- Aggregate Functions (SUM, COUNT)
- GROUP BY & ORDER BY
- Subqueries
- CTEs (WITH clause)
- Window Functions (ROW_NUMBER with PARTITION BY)
- LIMIT & filtering logic for tie-handling

---

## Dataset
The dataset used is the **Chinook Database** — a sample database representing a digital media store, including tables for artists, albums, tracks, invoices, and customers.

Dataset is included as a `.zip` file in this repository.

---

## Project Status
✅ Completed — open to feedback and improvements.
