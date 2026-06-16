# 🏥 Varg Medical Platform - College Project

A comprehensive medical platform featuring AI-powered symptom checking and blood bank connectivity. Built with modern web technologies to demonstrate full-stack development skills.

## ✨ Features

### 🤖 AI Symptom Checker
- **Natural Language Processing**: Uses spaCy for intelligent symptom extraction
- **Machine Learning**: Scikit-learn Random Forest for condition prediction
- **Confidence Scoring**: Provides reliability metrics for predictions
- **Personalized Recommendations**: Age and gender-aware health advice

### 🩸 Blood Bank Locator
- **Interactive Maps**: Leaflet integration for location visualization
- **Real-time Search**: Find nearby blood banks with availability
- **Contact Information**: Direct access to phone numbers and websites
- **Distance Calculation**: Sort results by proximity

### ❤️ Blood Connector
- **Smart Matching**: Algorithm connects donors with recipients
- **Urgency Levels**: Priority-based notification system
- **Multi-channel Alerts**: SMS and email notifications via Twilio/SendGrid
- **Community Network**: Build a network of life-saving donors

### 👥 Donor Network
- **Registration System**: Easy donor onboarding process
- **Availability Tracking**: Flexible scheduling options
- **Blood Type Filtering**: Efficient donor matching
- **Analytics Dashboard**: Track donation impact

## 🛠 Tech Stack

### Frontend
- **Framework**: Next.js 15 (React 19)
- **Styling**: Tailwind CSS 4
- **UI Components**: Shadcn/ui
- **Mapping**: Leaflet
- **Deployment**: Vercel

### Backend
- **Language**: Python 3.11
- **Framework**: FastAPI
- **Database**: Supabase (PostgreSQL)
- **AI/ML**: Scikit-learn + spaCy
- **Notifications**: Twilio SendGrid
- **Deployment**: Render

## 🚀 Quick Start

### Option 1: Automated Setup (Recommended)

**For Linux/Mac:**
```bash
chmod +x setup.sh
./setup.sh
```

**For Windows:**
```cmd
setup.bat
```

### Option 1B: Complete Validation + Run (Windows)

Run this to install dependencies, validate frontend/backend, and start both servers:

```cmd
COMPLETE-PROJECT.bat
```

### Option 2: Manual Setup

#### Backend Setup
```bash
cd backend
python -m venv venv
source venv/bin/activate  # Windows: venv\Scripts\activate
pip install -r requirements.txt
python -m spacy download en_core_web_sm
cp env.example .env  # Edit with your credentials
uvicorn main:app --reload
```

#### Frontend Setup
```bash
cd frontend
npm install
cp env.local.example .env.local  # Edit with backend URL
npm run dev
```

## 📁 Project Structure

```
medical-platform/
├── frontend/                 # Next.js application
│   ├── src/
│   │   ├── app/             # App router pages
│   │   │   ├── api/         # API routes
│   │   │   ├── page.tsx     # Home page
│   │   │   ├── symptom-checker/
│   │   │   ├── blood-banks/
│   │   │   ├── blood-connector/
│   │   │   └── donors/
│   │   ├── components/      # Reusable components
│   │   └── lib/            # Utilities
│   ├── package.json
│   └── tailwind.config.js
├── backend/                 # FastAPI application
│   ├── main.py             # Main application
│   ├── ai_symptom_checker.py
│   ├── database.py
│   ├── notifications.py
│   ├── requirements.txt
│   └── render.yaml
├── docs/                   # Documentation
│   ├── database-schema.sql
│   └── README.md
├── setup.sh               # Linux/Mac setup script
├── setup.bat              # Windows setup script
└── README.md
```

## 🔧 Environment Variables

### Backend (.env)
```env
SUPABASE_URL=your_supabase_url_here
SUPABASE_KEY=your_supabase_anon_key_here
TWILIO_ACCOUNT_SID=your_twilio_account_sid
TWILIO_AUTH_TOKEN=your_twilio_auth_token
TWILIO_PHONE_NUMBER=your_twilio_phone_number
SENDGRID_API_KEY=your_sendgrid_api_key
API_SECRET_KEY=your_secret_key_here
ENVIRONMENT=development
ALLOWED_ORIGINS=http://localhost:3000,https://your-frontend-domain.vercel.app
```

### Frontend (.env.local)
```env
BACKEND_URL=http://localhost:8000
```

## 🗄 Database Setup

1. **Create Supabase project** at [supabase.com](https://supabase.com)
2. **Run database schema**:
   ```sql
   -- Copy contents from docs/database-schema.sql
   -- Run in Supabase SQL editor
   ```
3. **Update environment variables** with your Supabase credentials

## 🚀 Deployment

### Backend (Render)
1. Connect GitHub repository to Render
2. Create new Web Service:
   - Build Command: `pip install -r requirements.txt`
   - Start Command: `uvicorn main:app --host 0.0.0.0 --port $PORT`
3. Add environment variables
4. Deploy

### Frontend (Vercel)
1. Connect GitHub repository to Vercel
2. Set build settings:
   - Framework: Next.js
   - Build Command: `npm run build`
3. Add environment variables:
   - `BACKEND_URL`: Your Render backend URL
4. Deploy

## 📊 API Endpoints

### Symptom Analysis
- `POST /api/symptoms/analyze`
  - Input: `{symptoms: string, age?: number, gender?: string}`
  - Output: `{possible_conditions: [], confidence_scores: [], recommendations: []}`

### Blood Banks
- `GET /api/blood-banks?latitude=40.7128&longitude=-74.0060`
  - Output: Array of blood bank locations

### Blood Requests
- `POST /api/blood-request`
  - Input: `{blood_type: string, location: string, urgency: string, contact_info: string, additional_notes?: string}`
  - Output: `{message: string, request_id: string, notifications_sent: number}`

### Donors
- `GET /api/donors?blood_type=O+&location=New York`
  - Output: `{donors: [], total: number}`
- `POST /api/donors/register`
  - Input: `{name: string, blood_type: string, location: string, phone: string, email: string, availability: string}`
  - Output: `{message: string, donor_id: string}`

## 🤖 AI/ML Implementation

### Symptom Checker Algorithm
1. **Text Preprocessing**: spaCy for tokenization and POS tagging
2. **Feature Extraction**: TF-IDF vectorization of symptoms
3. **Classification**: Random Forest for multi-label classification
4. **Recommendation Generation**: Rule-based health advice

### Training Data
- Simplified dataset for demonstration
- Production would use real medical data (with proper permissions)
- Consider established datasets like MIMIC-III

## 🔒 Security & Privacy

### Data Protection
- **Encryption**: All sensitive data encrypted in transit and at rest
- **Authentication**: JWT tokens for API access
- **Rate Limiting**: Prevent abuse of AI endpoints
- **Input Validation**: Sanitize all user inputs

### Privacy Considerations
- **HIPAA Compliance**: Consider healthcare data regulations
- **Data Anonymization**: Remove PII from analytics
- **Consent Management**: Clear data usage policies

## 📈 Performance Optimization

### Backend
- **Caching**: Redis for frequently accessed data
- **Database Indexing**: Optimized queries
- **Async Processing**: Background tasks for notifications

### Frontend
- **Code Splitting**: Lazy load components
- **Image Optimization**: Next.js automatic optimization
- **CDN**: Global content delivery

## 🐛 Troubleshooting

### Common Issues
1. **spaCy Model Not Found**: `python -m spacy download en_core_web_sm`
2. **CORS Errors**: Check `ALLOWED_ORIGINS` in backend `.env`
3. **Database Connection**: Verify Supabase credentials
4. **Notification Failures**: Check Twilio/SendGrid credentials

## 📚 Documentation

- **Complete Documentation**: `docs/README.md`
- **Database Schema**: `docs/database-schema.sql`
- **API Documentation**: Available at `http://localhost:8000/docs` when running

## 🤝 Contributing

1. Fork the repository
2. Create feature branch: `git checkout -b feature/amazing-feature`
3. Commit changes: `git commit -m 'Add amazing feature'`
4. Push to branch: `git push origin feature/amazing-feature`
5. Open Pull Request

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🆘 Support

For questions and support:
- **Documentation**: Check `docs/README.md`
- **Issues**: Create GitHub issues for bugs
- **Discussions**: Use GitHub Discussions for questions

## 🙏 Acknowledgments

- **Next.js Team**: For the amazing React framework
- **FastAPI Team**: For the high-performance Python framework
- **Supabase Team**: For the excellent database platform
- **Shadcn/ui**: For the beautiful component library
- **Open Source Community**: For all the amazing tools and libraries

---

**Built with ❤️ for the medical community**
