# Dream Hire 🧑‍💼✨  
A Flutter Job Listing App.

https://github.com/user-attachments/assets/b9bf7813-4b0b-4403-9465-f515fc052c42

## 📱 Overview

**Dream Hire** is a remote job listing app that fetches job data from the [Remotive API](https://remotive.com/api/remote-jobs). It demonstrates the use of:

- ✅ Clean Architecture
- ✅ BLoC for state management
- ✅ Dio for API calls
- ✅ Freezed for model generation
- ✅ Theming with light and dark modes
- ✅ GitHub Actions for APK generation

---

## ✨ Features

- **Home Screen:** Lists all available remote jobs.
- **Search Screen:** Allows users to search for jobs by keywords.
- **Saved Jobs Screen:** Lets users bookmark jobs and view them later.
- **Profile Screen:** Toggle between Light and Dark themes.

---

## 📦 Tech Stack

| Tool       | Description                            |
|------------|----------------------------------------|
| **Flutter**| App development framework              |
| **Dio**    | For fetching job data from REST API    |
| **Freezed**| For immutable model classes            |
| **BLoC**   | State management (Bloc)                |
| **ThemeData** | Consistent theming across the app   |
| **GitHub Actions** | CI/CD workflow to generate APK |

---

## 🖥️ API Used

- Base URL: [https://remotive.com/api/remote-jobs](https://remotive.com/api/remote-jobs)
- Used for fetching remote job listings.

⚠️ **Note:** The **search endpoint** may occasionally return a `400 Bad Request` error. This appears to be an intermittent issue with the API itself.

---

## 🎨 Theming

The app supports both **Light** and **Dark** themes. You can toggle the theme from the **Profile** screen.

---

## 🔖 Bookmarking

Jobs can be saved to a "Saved Jobs" list using the bookmark icon.

---

## 📦 APK Build

This project uses **GitHub Actions** to automatically build the APK.

---

