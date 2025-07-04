# 📚 Blog Application

A responsive Blog Web Application built with:

- **Backend:** Django Rest Framework (DRF)
- **Frontend:** Flutter Web

---

## 📝 Project Description

This project demonstrates how to connect Django Rest Framework APIs with a Flutter frontend web application.  
It allows users to interact with blog content via REST APIs and a responsive web interface.

---

## 🚀 Features

✅ User Login / Logout  
✅ Public Post List  
✅ Post Detail View  
✅ Create New Post (authenticated users only)  
✅ Responsive Web Interface (built in Flutter Web)

---

## 🔗 API Endpoints

| Endpoint               | Method | Auth Required | Description         |
| ---------------------- | ------ | ------------- | ------------------- |
| `/api/login/`          | POST   | No            | Login, get token    |
| `/api/posts/`          | GET    | No            | List all posts      |
| `/api/posts/<id>/`     | GET    | No            | View post detail    |
| `/api/posts/`          | POST   | Yes (Token)   | Create new post     |

---

## 📂 Project Structure

```text
Blog Application/
├── django/    # Django Rest Framework backend
└── blog_flutter/   # Flutter frontend (web)


---

## 👨‍💻 Developed by

**Saheen Usman M**  



