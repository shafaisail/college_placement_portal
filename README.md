# AI-Powered College Placement Portal (PlacementPro AI)

> **Production-grade full-stack MERN + Python FastAPI platform automating campus recruitment, resume analysis, eligibility verification, interview pipelines, and institutional accreditation analytics.**

---

## 1. Project Overview

The **AI-Powered College Placement Portal** is an end-to-end institutional web application designed to connect **Students**, **Corporate Recruiters**, and **Training & Placement Cell (TPO) Administrators**.

Unlike superficial prototypes, this platform contains:
- **Strict Backend-Enforced Eligibility Checks**: Automatic real-time validation of minimum CGPA thresholds, eligible departments, graduation batches, and maximum backlogs before applications can be submitted.
- **Explainable AI Resume Analyzer**: An objective rubric-based scoring microservice (out of 100) using **PyMuPDF**, analyzing technical depth, section completeness, action verbs, and quantifiable impact.
- **Weighted Job Compatibility Matcher**: Algorithmic job ranking combining **TF-IDF Semantic Cosine Similarity** and multi-factor weighted scoring (Skills 45%, Vector Sim 25%, Academic CGPA 15%, Department 10%, Experience 5%).
- **Recruiter Candidate Management**: Job posting CRUD, resume viewing, candidate shortlisting, interview round scheduling (virtual video links, location, timestamps), and offer extension.
- **Placement Analytics & Audit Reporting**: Dynamic MongoDB aggregation pipelines feeding Recharts visualizations (Bar, Line, Area, Pie) and one-click **CSV/Printable reports** for NAAC, NIRF, and NBA compliance reviews.
- **One-Click Windows Launcher**: Pre-configured `start.bat` and `stop.bat` scripts for seamless local development.

---

## 2. Technologies Used

### Frontend
- **React.js 18** (Vite build tool)
- **Tailwind CSS** (Custom theme: Navy `#0F172A`, Blue `#2563EB`, Cyan `#06B6D4`)
- **React Router DOM v6** (Nested routes & role-based guards)
- **Axios** (Centralized API client with JWT interceptors)
- **Recharts** (Interactive bar, area, and donut charts)
- **Lucide React** (Consistent iconography)
- **React Hot Toast** (User action notifications)
- **React Context API** (`AuthContext` with session persistence)

### Backend
- **Node.js & Express.js** (MVC architecture)
- **MongoDB Atlas & Mongoose** (Relational schemas, compound unique indexes, aggregation pipelines)
- **JSON Web Tokens (JWT)** & **bcryptjs** (Stateless authentication & password hashing)
- **Multer** (Validated PDF resume and avatar file uploads)
- **Helmet, CORS & Express Rate Limit** (Enterprise security hardening)

### AI Microservice
- **Python 3.10+ & FastAPI**
- **PyMuPDF (fitz) & pypdf** (PDF byte text extraction)
- **scikit-learn** (TF-IDF Vectorizer & Cosine Similarity)
- **NumPy & Pydantic** (Vector operations and request schemas)

---

## 3. System Architecture & Folder Structure

```
mern-pro/
├── index.html                   # Root browser launcher & service health checker
├── start.bat                    # One-click Windows startup script
├── stop.bat                     # Windows clean process terminator
├── package.json                 # Root script runner (dev, build, test)
├── .gitignore                   # Complete git ignore rules
├── .env.example                 # Environment configuration template
├── README.md                    # Project documentation
├── PROJECT_AUDIT.md             # Architecture audit & gap analysis
│
├── frontend/                    # Vite + React 18 SPA
│   ├── index.html
│   ├── vite.config.js
│   ├── tailwind.config.js
│   ├── postcss.config.js
│   ├── package.json
│   └── src/
│       ├── main.jsx
│       ├── App.jsx
│       ├── index.css
│       ├── components/          # Navbar, Sidebar, Header, StatCard, JobCard, etc.
│       ├── layouts/             # StudentLayout, CompanyLayout, AdminLayout
│       ├── context/             # AuthContext.jsx
│       ├── services/            # api.js, authService.js, jobService.js, etc.
│       └── pages/
│           ├── public/          # LandingPage, StudentLogin, CompanyLogin, AdminLogin, JobsExplore
│           ├── student/         # Dashboard, Profile, Jobs, Details, Applications, Interviews, Resume, Match
│           ├── company/         # Dashboard, Profile, ManageJobs, CreateJob, EditJob, Applicants, Interviews
│           └── admin/           # Dashboard, Students, Companies, Jobs, Analytics, Reports
│
├── backend/                     # Node.js + Express API
│   ├── server.js
│   ├── package.json
│   ├── config/db.js             # Resilient Mongoose connection handler
│   ├── models/                  # Student, Admin, Company, Job, Application, Interview, Notification, Resume
│   ├── controllers/             # Express controllers implementing business logic
│   ├── routes/                  # Express API route endpoints
│   ├── middleware/              # authMiddleware, roleMiddleware, uploadMiddleware, errorMiddleware
│   ├── services/                # aiClient.js, notificationService.js
│   ├── utils/seedAdmin.js       # Secure initial administrator setup script
│   ├── uploads/                 # Uploaded resumes and student avatars
│   └── tests/                   # Backend unit and validation test suite
│
└── ai-service/                  # Python FastAPI Microservice
    ├── app.py                   # FastAPI application & REST endpoints
    ├── requirements.txt
    ├── services/
    │   ├── resume_analyzer.py   # PDF text extraction & 100-pt rubric scorer
    │   ├── skill_extractor.py   # NLP dictionary of 300+ technical & soft skills
    │   ├── job_matcher.py       # TF-IDF cosine similarity & query term coverage
    │   └── recommendation_engine.py # Strict eligibility + 5-factor weighted ranking
    └── tests/test_ai_service.py # Unit tests for skill extraction & matching
```

---

## 4. Quick Start on Windows (One-Click)

### Prerequisites
1. **Node.js** (v18 or higher) — [Download Node.js](https://nodejs.org/)
2. **Python** (v3.10 or higher) with pip — [Download Python](https://www.python.org/)
3. **MongoDB** (Local instance running at `mongodb://127.0.0.1:27017` or free **MongoDB Atlas Cluster**)

### Launching the Application
Simply **double-click** `start.bat` in the project root directory.

The script automatically:
1. Verifies that Node.js and Python are installed.
2. Generates initial environment `.env` files from templates if missing.
3. Installs backend, frontend, and Python AI packages if needed.
4. Ensures the default Admin account is seeded into the database.
5. Launches the Express Backend on port `5000`.
6. Launches the Python AI Service on port `8000`.
7. Launches the React Frontend on port `5173`.
8. Automatically opens `http://localhost:5173` in your default browser.

### Stopping the Application
Double-click `stop.bat` to safely terminate all project processes on ports `5000`, `8000`, and `5173`.

---

## 5. Manual Terminal Setup & Commands

If you prefer to run services manually from PowerShell or terminal:

### A. Python AI Microservice (Port 8000)
```powershell
cd ai-service
pip install -r requirements.txt
python app.py
```
*Health check:* `http://localhost:8000/health`  
*Interactive Swagger API Docs:* `http://localhost:8000/docs`

### B. Express Backend (Port 5000)
```powershell
cd backend
npm install
node utils/seedAdmin.js
npm run dev
```
*API Base:* `http://localhost:5000/api`  
*Health Check:* `http://localhost:5000/api/health`

### C. Vite React Frontend (Port 5173)
```powershell
cd frontend
npm install
npm run dev
```
*Web Application:* `http://localhost:5173`

---

## 6. Environment Configuration & MongoDB Atlas Setup

A template `.env.example` is provided in the project root. Copy it to `backend/.env`:

```env
PORT=5000
NODE_ENV=development

# MongoDB Atlas Connection String
MONGODB_URI=mongodb+srv://<username>:<password>@cluster0.mongodb.net/placement_portal?retryWrites=true&w=majority

# JWT Token Secret
JWT_SECRET=super_secret_placement_portal_jwt_token_key_change_in_production
JWT_EXPIRE=7d

# Microservice URLs
AI_SERVICE_URL=http://localhost:8000
FRONTEND_URL=http://localhost:5173

# Initial Seed Admin Account
ADMIN_NAME=Head TPO Officer
ADMIN_EMAIL=admin@placement.edu
ADMIN_PASSWORD=AdminPass@2026
ADMIN_DEPARTMENT=Training & Placement Cell
```

### Setting Up Free MongoDB Atlas
1. Sign in to [MongoDB Atlas](https://www.mongodb.com/cloud/atlas).
2. Create a free **M0 Sandbox** cluster.
3. Under **Database Access**, create a user with read/write permissions.
4. Under **Network Access**, add `0.0.0.0/0` (Allow access from anywhere).
5. Click **Connect** -> **Drivers (Node.js)** and copy the connection string into `backend/.env` as `MONGODB_URI`.

---

## 7. Default Credentials & Role Access

| Role | Portal URL | Default Credentials | Description |
|------|------------|---------------------|-------------|
| **Student** | `/student/login` | Register via `/student/register` | Upload resumes, get AI score, apply for jobs, track interview rounds. |
| **Company** | `/company/login` | Register via `/company/register` (or demo: `recruiting@google.com` / `Password123!`) | Post jobs with eligibility criteria, review applicants, schedule interviews. |
| **Admin / TPO** | `/admin/login` | `admin@placement.edu` / `AdminPass@2026` | Institutional management, student directory, recruiter approvals, placement reports. |

### How to Create or Reset Admin Accounts
Admin accounts cannot be registered publicly to prevent unauthorized privilege escalation. To seed or reset the default administrator, run:
```powershell
cd backend
node utils/seedAdmin.js
```

---

## 8. REST API Reference

### Authentication
- `POST /api/auth/register-student`: Student account registration
- `POST /api/auth/login-student`: Student sign in
- `POST /api/companies/register`: Recruiter company registration
- `POST /api/companies/login`: Recruiter sign in
- `POST /api/auth/login-admin`: Administrator sign in
- `GET /api/auth/me`: Fetch authenticated user profile

### Students
- `GET /api/students/profile`: Get logged in student academic profile & stats
- `PUT /api/students/profile`: Update skills, projects, certifications, CGPA
- `GET /api/students`: Admin/Recruiter directory search & filter
- `DELETE /api/students/:id`: Admin toggle account active status

### Jobs & Eligibility
- `POST /api/jobs`: Post a job opening with eligibility criteria (Company/Admin)
- `GET /api/jobs`: Browse jobs with query filters & automated eligibility evaluation
- `GET /api/jobs/my-jobs`: Get company's posted jobs with live applicant counts
- `GET /api/jobs/:id`: Single job details & student eligibility checklist
- `PUT /api/jobs/:id`: Update job posting
- `DELETE /api/jobs/:id`: Delete or close job posting

### Applications & Recruitment Pipeline
- `POST /api/applications`: Submit application (Enforces CGPA, department, year, backlog limits)
- `GET /api/applications/my-applications`: Get student's application history
- `GET /api/applications/job/:jobId`: Get all candidate applications for a job opening
- `PUT /api/applications/:id/status`: Update status (`Shortlisted`, `Selected`, `Rejected`)
- `PUT /api/applications/:id/withdraw`: Student self-withdrawal

### AI Services
- `POST /api/resume/upload`: Upload PDF resume, extract text via PyMuPDF, calculate 100-pt rubric score
- `GET /api/resume/analyze`: Retrieve detailed rubric breakdown, strengths & suggestions
- `GET /api/resume/recommendations`: Retrieve ranked AI job recommendations

### Interviews & Notifications
- `POST /api/interviews`: Schedule interview round with virtual meeting link
- `GET /api/interviews`: List scheduled interviews
- `PUT /api/interviews/:id/reschedule`: Reschedule interview
- `PUT /api/interviews/:id/cancel`: Cancel interview
- `GET /api/notifications`: Retrieve unread notification count & list
- `PUT /api/notifications/:id/read`: Mark notification as read
- `PUT /api/notifications/read-all`: Mark all notifications as read

### Analytics & Reports
- `GET /api/analytics/overview`: Real MongoDB aggregation placement metrics & chart data
- `GET /api/analytics/export-report`: Export verified placement dataset for CSV/accreditation

---

## 9. Automated Testing

All test suites verify functionality against real logic and models:

### Backend Tests
```powershell
cd backend
npm test
```
*Verifies bcrypt password hashing, JWT token generation & verification, role-based permission guard logic, and student hard eligibility evaluation engines.*

### AI Service Tests
```powershell
cd ai-service
python -m unittest tests/test_ai_service.py
```
*Verifies NLP skill extraction, resume rubric quality scoring, TF-IDF cosine similarity job matching, strict eligibility constraints, and multi-factor recommendation ranking.*

### Frontend Production Build Test
```powershell
cd frontend
npm run build
```
*Verifies error-free Vite production compilation, TypeScript/JSX syntax, Tailwind styling, and optimized vendor chunk splitting.*

---

## 10. License
This project is developed for college campus placement automation and institutional career development cells.
