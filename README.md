# NGO Connect - Flutter Mobile Application

A comprehensive Flutter mobile application that connects NGOs, volunteers, and service seekers to create meaningful impact in communities.

## 🌟 Features

### Core Functionality
- **User Authentication**: Secure login/registration with role-based access (NGO, Volunteer, Service Seeker)
- **Opportunity Discovery**: Browse and search volunteer opportunities with advanced filtering
- **Activity Tracking**: Monitor volunteer hours, completed activities, and impact metrics
- **Real-time Messaging**: Chat system for communication between organizations and volunteers
- **Profile Management**: Comprehensive user profiles with skills, bio, and achievements

### UI/UX Highlights
- **Modern Dark Theme**: Sleek dark green gradient design with consistent color palette
- **Responsive Design**: Optimized for all screen sizes from mobile to tablet
- **Smooth Animations**: Micro-interactions, page transitions, and loading animations
- **Intuitive Navigation**: Custom bottom navigation with 5 main sections

## 🏗️ Architecture

### Project Structure
```
lib/
├── data/           # Dummy data and mock services
├── models/         # Data models (User, Opportunity, Activity, Message)
├── providers/      # State management with Provider pattern
├── screens/        # UI screens organized by feature
├── utils/          # Utilities (colors, text styles, responsive helpers)
└── widgets/        # Reusable custom widgets
```

### Key Components
- **State Management**: Provider pattern for reactive state updates
- **Navigation**: Custom page routes with smooth transitions
- **Caching**: Optimized image loading with cached_network_image
- **Performance**: Lazy loading, memory optimization, and efficient rendering

## 🎨 Design System

### Color Palette
- **Primary Green**: #38E07B (main brand color)
- **Background**: #111714 (dark theme base)
- **Cards**: #1C2620 (elevated surfaces)
- **Text**: White/gray hierarchy for readability

### Typography
- **Headings**: Bold weights for hierarchy
- **Body Text**: Optimized for readability
- **Interactive Elements**: Clear button and link styles

## 📱 Screens

1. **Authentication**
   - Login with email/password and Google Sign-in
   - Registration with role selection
   - Form validation and error handling

2. **Home Dashboard**
   - Featured opportunities
   - User impact statistics
   - Trending causes
   - Emergency/urgent needs

3. **Discover**
   - Search and filter opportunities
   - Location, category, and skill filters
   - Pull-to-refresh functionality

4. **Activities**
   - Tabbed view (Upcoming, Completed, Applications)
   - Activity management and tracking
   - Hours logging and sharing

5. **Messages**
   - Conversation list with organizations
   - Real-time chat interface
   - Message search and filtering

6. **Profile**
   - User information and statistics
   - Settings and preferences
   - Account management

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (>=3.0.0)
- Dart SDK
- iOS Simulator or Android Emulator

### Installation
1. Clone the repository
2. Install dependencies:
   ```bash
   flutter pub get
   ```
3. Run the app:
   ```bash
   flutter run
   ```

### Dependencies
- `provider`: State management
- `cached_network_image`: Optimized image loading
- `shared_preferences`: Local data persistence
- `pull_to_refresh`: Enhanced list interactions
- `animations`: Smooth UI transitions

## 🎯 Current Status

### ✅ Completed Features
- Complete UI implementation for all screens
- Authentication flow with state management
- Responsive design system
- Custom widgets and animations
- Performance optimizations
- Comprehensive dummy data

### 🔄 In Development
- Backend integration
- Real-time messaging
- Push notifications
- Advanced search algorithms

## 🧪 Testing

The app includes:
- Responsive design testing utilities
- Performance monitoring helpers
- Widget tests for core components
- Cross-device compatibility testing

## 🎨 Animations & Interactions

- **Page Transitions**: Slide, fade, scale, and bounce animations
- **Loading States**: Shimmer effects and skeleton screens
- **Button Interactions**: Scale and ripple effects
- **List Animations**: Staggered item appearances
- **Success Feedback**: Animated confirmations

## 📊 Performance Features

- **Image Optimization**: Automatic resizing and caching
- **Lazy Loading**: Efficient list rendering
- **Memory Management**: Optimized widget lifecycle
- **Debounced Search**: Reduced API calls
- **Batch Processing**: Efficient data operations

## 🔧 Development Tools

- **Responsive Testing**: Built-in screen size testing
- **Performance Monitoring**: Memory and build time tracking
- **Animation Utilities**: Reusable animation helpers
- **Debug Helpers**: Comprehensive logging and error handling

## 📈 Future Enhancements

- Real backend integration (Supabase/Firebase)
- Advanced filtering and search
- Geolocation services
- Push notifications
- Offline support
- Multi-language support

## 🤝 Contributing

This is a demo application showcasing Flutter development best practices, responsive design, and modern UI/UX patterns for social impact applications.

---

**Built with ❤️ using Flutter**

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
