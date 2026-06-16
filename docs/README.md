# Medical Platform - Complete Documentation

## Overview

This is a comprehensive medical platform built as a college project that demonstrates modern web development, AI/ML integration, and real-world application development skills. The platform features AI-powered symptom checking and blood bank connectivity.

## Architecture

### Tech Stack

#### Frontend
- **Framework**: Next.js 15 (React 19)
- **Styling**: Tailwind CSS 4
- **UI Components**: Shadcn/ui
- **Mapping**: Leaflet
- **Deployment**: Vercel

#### Backend
- **Language**: Python 3.11
- **Framework**: FastAPI
- **Database**: Supabase (PostgreSQL)
- **AI/ML**: Scikit-learn + spaCy
- **Notifications**: Twilio SendGrid
- **Deployment**: Render

## Project Structure

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
└── README.md
```

## Features

### 1. AI Symptom Checker
- **Technology**: spaCy for NLP + Scikit-learn for classification
- **Features**:
  - Natural language symptom input
  - AI-powered condition prediction
  - Confidence scoring
  - Personalized recommendations
  - Age and gender consideration

### 2. Blood Bank Locator
- **Technology**: Interactive maps with Leaflet
- **Features**:
  - Location-based search
  - Real-time availability
  - Contact information
  - Operating hours
  - Distance calculation

### 3. Blood Connector
- **Technology**: Smart matching algorithm
- **Features**:
  - Blood request submission
  - Donor registration
  - Urgency-based prioritization
  - Real-time notifications
  - SMS and email alerts

### 4. Donor Network
- **Technology**: Community management system
- **Features**:
  - Donor registration
  - Availability tracking
  - Blood type filtering
  - Location-based matching
  - Donation history

## Setup Instructions

### Prerequisites

1. **Node.js** (v18 or higher)
2. **Python** (v3.11 or higher)
3. **Git**
4. **Supabase Account** (free tier)
5. **Twilio Account** (free tier)
6. **SendGrid Account** (free tier)

### Backend Setup

1. **Navigate to backend directory**:
   ```bash
   cd backend
   ```

2. **Create virtual environment**:
   ```bash
   python -m venv venv
   source venv/bin/activate  # On Windows: venv\Scripts\activate
   ```

3. **Install dependencies**:
   ```bash
   pip install -r requirements.txt
   ```

4. **Install spaCy model**:
   ```bash
   python -m spacy download en_core_web_sm
   ```

5. **Set up environment variables**:
   ```bash
   cp env.example .env
   # Edit .env with your credentials
   ```

6. **Run the backend**:
   ```bash
   uvicorn main:app --reload
   ```

### Frontend Setup

1. **Navigate to frontend directory**:
   ```bash
   cd frontend
   ```

2. **Install dependencies**:
   ```bash
   npm install
   ```

3. **Set up environment variables**:
   ```bash
   cp env.local.example .env.local
   # Edit .env.local with your backend URL
   ```

4. **Run the frontend**:
   ```bash
   npm run dev
   ```

### Database Setup

1. **Create Supabase project**:
   - Go to [supabase.com](https://supabase.com)
   - Create a new project
   - Note your project URL and anon key

2. **Run database schema**:
   - Copy the contents of `docs/database-schema.sql`
   - Run it in your Supabase SQL editor

3. **Update environment variables**:
   - Add your Supabase URL and key to backend `.env`

## Environment Variables

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

## API Endpoints

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

## Deployment

### Backend (Render)

1. **Connect GitHub repository** to Render
2. **Create new Web Service**:
   - Build Command: `pip install -r requirements.txt`
   - Start Command: `uvicorn main:app --host 0.0.0.0 --port $PORT`
3. **Add environment variables** in Render dashboard
4. **Deploy**

### Frontend (Vercel)

1. **Connect GitHub repository** to Vercel
2. **Set build settings**:
   - Framework: Next.js
   - Build Command: `npm run build`
3. **Add environment variables**:
   - `BACKEND_URL`: Your Render backend URL
4. **Deploy**

### Database (Supabase)

1. **Create new project** in Supabase
2. **Run database schema** from `docs/database-schema.sql`
3. **Get project URL and anon key**
4. **Update backend environment variables**

## AI/ML Implementation

### Symptom Checker Algorithm

1. **Text Preprocessing**:
   - Use spaCy for tokenization and POS tagging
   - Extract medical terms and symptoms
   - Normalize text input

2. **Feature Extraction**:
   - TF-IDF vectorization of symptoms
   - Age and gender features
   - Symptom frequency analysis

3. **Classification**:
   - Random Forest classifier
   - Multi-label classification
   - Confidence scoring

4. **Recommendation Generation**:
   - Rule-based recommendations
   - Severity-based suggestions
   - General health advice

### Training Data

The system uses a simplified dataset for demonstration. In production, you would:

1. **Collect real medical data** (with proper permissions)
2. **Use established medical datasets** (e.g., MIMIC-III)
3. **Implement data augmentation** techniques
4. **Regular model retraining**

## Security Considerations

### Data Protection
- **Encryption**: All sensitive data encrypted in transit and at rest
- **Authentication**: JWT tokens for API access
- **Rate Limiting**: Prevent abuse of AI endpoints
- **Input Validation**: Sanitize all user inputs

### Privacy
- **HIPAA Compliance**: Consider healthcare data regulations
- **Data Anonymization**: Remove PII from analytics
- **Consent Management**: Clear data usage policies
- **Audit Logging**: Track all data access

## Performance Optimization

### Backend
- **Caching**: Redis for frequently accessed data
- **Database Indexing**: Optimized queries
- **Async Processing**: Background tasks for notifications
- **Load Balancing**: Multiple backend instances

### Frontend
- **Code Splitting**: Lazy load components
- **Image Optimization**: Next.js automatic optimization
- **CDN**: Global content delivery
- **Caching**: Browser and API caching

## Monitoring and Analytics

### Metrics to Track
- **User Engagement**: Page views, session duration
- **AI Accuracy**: Symptom prediction success rate
- **Blood Requests**: Fulfillment rate, response time
- **Donor Activity**: Registration, donation frequency

### Tools
- **Application Monitoring**: Sentry for error tracking
- **Analytics**: Google Analytics or similar
- **Database Monitoring**: Supabase built-in analytics
- **Performance**: Core Web Vitals tracking

## Future Enhancements

### Short Term
- **Mobile App**: React Native version
- **Real-time Chat**: WebSocket integration
- **Advanced AI**: GPT integration for better recommendations
- **Multi-language**: Internationalization support

### Long Term
- **Telemedicine**: Video consultation integration
- **IoT Integration**: Wearable device data
- **Blockchain**: Secure medical records
- **Machine Learning**: Continuous model improvement

## Troubleshooting

### Common Issues

1. **spaCy Model Not Found**:
   ```bash
   python -m spacy download en_core_web_sm
   ```

2. **CORS Errors**:
   - Check `ALLOWED_ORIGINS` in backend `.env`
   - Ensure frontend URL is included

3. **Database Connection**:
   - Verify Supabase credentials
   - Check database schema is applied

4. **Notification Failures**:
   - Verify Twilio/SendGrid credentials
   - Check API rate limits

### Debug Mode

Enable debug logging:
```python
# In backend/main.py
logging.basicConfig(level=logging.DEBUG)
```

## Contributing

1. **Fork the repository**
2. **Create feature branch**: `git checkout -b feature/amazing-feature`
3. **Commit changes**: `git commit -m 'Add amazing feature'`
4. **Push to branch**: `git push origin feature/amazing-feature`
5. **Open Pull Request**

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Support

For questions and support:
- **Documentation**: Check this README and code comments
- **Issues**: Create GitHub issues for bugs
- **Discussions**: Use GitHub Discussions for questions

## Acknowledgments

- **Next.js Team**: For the amazing React framework
- **FastAPI Team**: For the high-performance Python framework
- **Supabase Team**: For the excellent database platform
- **Shadcn/ui**: For the beautiful component library
- **Open Source Community**: For all the amazing tools and libraries
