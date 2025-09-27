# NGO Connect - Complete Setup Guide

## 🚀 Quick Start

### 1. Prerequisites
- Flutter SDK (>=3.0.0)
- Dart SDK
- Android Studio / VS Code
- Git

### 2. Project Setup
```bash
# Clone the repository
git clone <your-repo-url>
cd ngoaksa

# Install dependencies
flutter pub get

# Run the app
flutter run
```

## 🗄️ Database Setup (Supabase)

### Step 1: Create Supabase Project
1. Go to [https://supabase.com](https://supabase.com)
2. Sign up/Login to your account
3. Click "New Project"
4. Choose your organization
5. Fill in project details:
   - Name: `ngo-connect`
   - Database Password: (choose a strong password)
   - Region: (choose closest to your location)
6. Click "Create new project"

### Step 2: Get Project Credentials
1. Go to Project Settings → API
2. Copy the following:
   - **Project URL**: `https://your-project-id.supabase.co`
   - **Anon Key**: `eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...`

### Step 3: Update App Configuration
The credentials are already configured in the app:
- **Project URL**: `https://mxbetlezivudkvocnkag.supabase.co`
- **Anon Key**: `eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im14YmV0bGV6aXZ1ZGt2b2Nua2FnIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTg4OTUxNjYsImV4cCI6MjA3NDQ3MTE2Nn0.81rPi-BmiKyKsq-rIdRYBd_C06CHh1WUvApc2rtKiEY`

If you want to use your own Supabase project, update these in `lib/services/supabase_service.dart`.

### Step 4: Create Database Tables
1. Go to your Supabase project dashboard
2. Click on "SQL Editor" in the sidebar
3. Copy the entire content from `supabase_schema.sql`
4. Paste it in the SQL editor
5. Click "Run" to execute the schema

This will create all necessary tables:
- `users` - User profiles
- `activities` - User activities
- `events` - Admin events
- `conversations` - Chat conversations
- `messages` - Chat messages
- `opportunities` - Volunteer opportunities
- `event_participants` - Event participation tracking

## 📱 App Features Overview

### 🔐 Authentication
- **Login Screen**: Email/password login with back navigation
- **Register Screen**: User registration with role selection and back navigation
- **Role Types**: Volunteer, Organization, Admin

### 👤 User Roles

#### 🎓 Student/Volunteer Access
- View available events created by admins
- Join events and track participation
- Browse volunteer opportunities
- Chat with organizations
- Track volunteer activities and hours

#### 👨‍💼 Admin Access
- Create new events with form validation
- Events automatically sync to Supabase database
- Events appear in student dashboard immediately
- Manage event details (title, description, location, date)

### 📊 Main Screens

#### 🏠 Home Dashboard
- Featured volunteer opportunities
- User impact statistics
- Trending causes
- Emergency/urgent needs

#### 🔍 Discover
- Browse volunteer opportunities
- Search and filter functionality
- Location and category filters

#### 📅 Activities
- **Upcoming**: Future volunteer activities
- **Completed**: Past activities with hours logged
- **Applications**: Pending applications
- Activity management and tracking

#### 💬 Messages
- Real-time chat with organizations
- Conversation search and filtering
- Enhanced chat interface with avatars
- Multiple conversation support

#### 👤 Profile
- User information and statistics
- Settings and preferences
- Account management

## 🎨 UI/UX Features

### 🌙 Design System
- **Dark Theme**: Modern dark green gradient
- **Responsive**: Works on all screen sizes
- **Animations**: Smooth transitions and micro-interactions
- **Typography**: Consistent text styles throughout

### 🎯 Interactive Elements
- **Back Navigation**: Added to login and register screens
- **Form Validation**: Real-time validation on all forms
- **Loading States**: Progress indicators for async operations
- **Success Feedback**: Confirmation messages for actions

## 🔧 Technical Implementation

### 📦 Dependencies
```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.2
  provider: ^6.0.5
  supabase_flutter: ^2.3.4
  cached_network_image: ^3.3.1
```

### 🏗️ Architecture
- **State Management**: Provider pattern
- **Database**: Supabase integration
- **Navigation**: Custom routes with back navigation
- **Models**: Comprehensive data models for all entities

### 📁 Project Structure
```
lib/
├── data/
│   └── dummy_data.dart          # Enhanced dummy data
├── models/
│   ├── activity.dart            # Activity model with hours logging
│   ├── message.dart             # Enhanced message/conversation models
│   ├── opportunity.dart         # Volunteer opportunities
│   └── user.dart               # User profiles
├── providers/
│   ├── auth_provider.dart       # Authentication state
│   ├── events_provider.dart     # Events management
│   └── opportunity_provider.dart # Opportunities state
├── screens/
│   ├── auth/
│   │   ├── login_screen.dart    # Login with back button
│   │   └── register_screen.dart # Register with back button
│   ├── activities/
│   │   └── activities_screen.dart # Enhanced activities page
│   ├── messages/
│   │   └── messages_screen.dart  # Enhanced messages page
│   ├── admin_page.dart          # Admin event creation
│   └── student_page.dart        # Student event viewing
├── services/
│   └── supabase_service.dart    # Database integration
└── utils/
    ├── colors.dart              # App color scheme
    ├── text_styles.dart         # Typography system
    └── responsive_helper.dart    # Responsive utilities
```

## 🧪 Testing the App

### 1. Admin Flow
1. Navigate to Admin Dashboard
2. Fill out the event creation form:
   - Event Title: "Community Cleanup"
   - Description: "Help clean up the local park"
   - Location: "Central Park"
   - Date: Select future date
3. Click "Post Event"
4. Event should be created and saved to Supabase

### 2. Student Flow
1. Navigate to Student Dashboard
2. View events loaded from Supabase
3. Click "Join Event" on any event
4. Participation should be tracked

### 3. Activities Page
1. Navigate to Activities
2. View tabs: Upcoming, Completed, Applications
3. Each tab shows relevant activities with dummy data
4. Test activity management features

### 4. Messages Page
1. Navigate to Messages
2. View enhanced conversation list
3. Click on any conversation to open chat
4. Test search functionality

### 5. Authentication
1. Test login screen with back navigation
2. Test register screen with back navigation
3. Verify role selection works

## 🐛 Troubleshooting

### Common Issues

#### 1. Supabase Connection Error
```
Error: Failed to connect to Supabase
```
**Solution**: Verify your project URL and anon key in `supabase_service.dart`

#### 2. Database Schema Error
```
Error: Table doesn't exist
```
**Solution**: Make sure you've run the complete `supabase_schema.sql` script

#### 3. Flutter Dependencies
```
Error: Package not found
```
**Solution**: Run `flutter pub get` and ensure all dependencies are installed

#### 4. Build Errors
```
Error: Gradle build failed
```
**Solution**: 
- Run `flutter clean`
- Run `flutter pub get`
- Try `flutter run` again

## 📈 Next Steps

### Immediate Improvements
1. **Real-time Updates**: Implement real-time listeners for events
2. **User Authentication**: Connect Supabase auth with the app
3. **Image Upload**: Add image support for events and profiles
4. **Push Notifications**: Notify users of new events

### Advanced Features
1. **Geolocation**: Location-based event discovery
2. **Calendar Integration**: Sync events with device calendar
3. **Social Features**: User reviews and ratings
4. **Analytics**: Track user engagement and impact

## 🤝 Support

If you encounter any issues:
1. Check the troubleshooting section above
2. Verify your Supabase setup is complete
3. Ensure all dependencies are properly installed
4. Check the console for detailed error messages

---

**Happy Coding! 🚀**

Built with ❤️ using Flutter and Supabase
