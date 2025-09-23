import '../models/user.dart';
import '../models/opportunity.dart';
import '../models/activity.dart';
import '../models/message.dart';

class AppImages {
  // Opportunity images
  static const String treePlanting = "https://images.unsplash.com/photo-1542601906990-b4d3fb778b09";
  static const String communityGarden = "https://images.unsplash.com/photo-1416879595882-3373a0480b5b";
  static const String animalShelter = "https://images.unsplash.com/photo-1601758228041-f3b2795255f1";
  static const String foodBank = "https://images.unsplash.com/photo-1593113616828-6f22bde97302";
  static const String financialWorkshop = "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d";
  
  // Cause category images
  static const String environmental = "https://images.unsplash.com/photo-1542273917363-3b1817f69a2d";
  static const String animalWelfare = "https://images.unsplash.com/photo-1425082661705-1834bfd09dca";
  static const String education = "https://images.unsplash.com/photo-1427504494785-3a9ca7044f45";
  static const String healthcare = "https://images.unsplash.com/photo-1559757148-5c350d0d3c56";
  
  // Profile avatars
  static const String userAvatar = "https://images.unsplash.com/photo-1494790108755-2616b612b786";
  static const String ngoLogo1 = "https://images.unsplash.com/photo-1582213782179-e0d53f98f2ca";
  static const String ngoLogo2 = "https://images.unsplash.com/photo-1559757175-0eb30cd8c063";
}

class DummyData {
  // Featured Opportunities
  static List<Opportunity> get featuredOpportunities => [
    Opportunity(
      id: '1',
      title: "Tree Plantation Drive",
      description: "Join us in our mission to increase our city's greenery and also planting 1,278 trees and we need your support to plant 56 thousand",
      organization: "GreenLife Foundation",
      location: "Central Park, Downtown",
      date: DateTime.now().add(const Duration(days: 7)),
      time: "9:00 AM - 2:00 PM",
      imageUrl: AppImages.treePlanting,
      type: OpportunityType.volunteer,
      rating: 4.8,
      reviewCount: 156,
      skills: ['Environmental Care', 'Physical Work'],
      isUrgent: false,
      createdAt: DateTime.now().subtract(const Duration(days: 3)),
    ),
    Opportunity(
      id: '2',
      title: "Emergency Food Distribution",
      description: "Urgent need for volunteers to help distribute food packages to families affected by recent floods",
      organization: "Food Security Network",
      location: "Community Center, East District",
      date: DateTime.now().add(const Duration(days: 2)),
      time: "10:00 AM - 4:00 PM",
      imageUrl: AppImages.foodBank,
      type: OpportunityType.volunteer,
      rating: 4.9,
      reviewCount: 89,
      skills: ['Organization', 'Communication'],
      isUrgent: true,
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
    ),
  ];

  // User Stats
  static Map<String, int> get userStats => {
    "hoursVolunteered": 25,
    "servicesAccessed": 8,
  };

  // Trending Causes
  static List<Cause> get trendingCauses => [
    Cause(
      id: '1',
      name: "Environmental Cleanup",
      imageUrl: AppImages.environmental,
      description: "Help protect our planet through various environmental initiatives",
    ),
    Cause(
      id: '2',
      name: "Animal Shelter Support",
      imageUrl: AppImages.animalWelfare,
      description: "Care for abandoned and rescued animals",
    ),
    Cause(
      id: '3',
      name: "Education Support",
      imageUrl: AppImages.education,
      description: "Help provide quality education to underprivileged children",
    ),
    Cause(
      id: '4',
      name: "Healthcare Assistance",
      imageUrl: AppImages.healthcare,
      description: "Support healthcare initiatives in underserved communities",
    ),
  ];

  // Discover Opportunities
  static List<Opportunity> get discoverOpportunities => [
    Opportunity(
      id: '3',
      title: "Assist at the Community Garden",
      description: "Come help us maintain our community garden and teach sustainable farming practices to local residents",
      organization: "Green Gardens Initiative",
      location: "Downtown Community Center",
      date: DateTime.now().add(const Duration(days: 15)),
      time: "9:00 AM - 12:00 PM",
      imageUrl: AppImages.communityGarden,
      type: OpportunityType.volunteer,
      rating: 4.8,
      reviewCount: 124,
      skills: ['Gardening', 'Teaching', 'Sustainability'],
      createdAt: DateTime.now().subtract(const Duration(days: 5)),
    ),
    Opportunity(
      id: '4',
      title: "Financial Literacy Workshop for Youth",
      description: "Help teach financial literacy skills to young adults in our community",
      organization: "Community Builders NGO",
      location: "Youth Center, North District",
      date: DateTime.now().add(const Duration(days: 10)),
      time: "2:00 PM - 5:00 PM",
      imageUrl: AppImages.financialWorkshop,
      type: OpportunityType.workshop,
      rating: 4.7,
      reviewCount: 67,
      skills: ['Teaching', 'Finance', 'Communication'],
      createdAt: DateTime.now().subtract(const Duration(days: 7)),
    ),
    Opportunity(
      id: '5',
      title: "Help at the Animal Shelter",
      description: "Assist with daily care activities for rescued animals including feeding, cleaning, and socialization",
      organization: "Paws & Claws Shelter",
      location: "Animal Rescue Center, West Side",
      date: DateTime.now().add(const Duration(days: 5)),
      time: "8:00 AM - 1:00 PM",
      imageUrl: AppImages.animalShelter,
      type: OpportunityType.volunteer,
      rating: 4.9,
      reviewCount: 203,
      skills: ['Animal Care', 'Cleaning', 'Patience'],
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
    ),
  ];

  // Upcoming Activities
  static List<Activity> get upcomingActivities => [
    Activity(
      id: '1',
      title: "Volunteer at the local food bank",
      organization: "Food Security Network",
      date: DateTime.now(),
      time: "2:00 PM - 5:00 PM",
      duration: "3 hours",
      status: ActivityStatus.confirmed,
      location: "Downtown Food Bank",
      opportunityId: '2',
    ),
    Activity(
      id: '2',
      title: "Assist at the animal shelter",
      organization: "Paws & Claws Shelter",
      date: DateTime.now().add(const Duration(days: 1)),
      time: "9:00 AM - 1:00 PM",
      duration: "4 hours",
      status: ActivityStatus.confirmed,
      location: "Animal Rescue Center",
      opportunityId: '5',
    ),
    Activity(
      id: '3',
      title: "Community Garden Workshop",
      organization: "Green Gardens Initiative",
      date: DateTime.now().add(const Duration(days: 3)),
      time: "10:00 AM - 2:00 PM",
      duration: "4 hours",
      status: ActivityStatus.pending,
      location: "Community Center",
      opportunityId: '3',
    ),
  ];

  // Past Activities
  static List<Activity> get pastActivities => [
    Activity(
      id: '4',
      title: "Beach Cleanup Drive",
      organization: "Ocean Conservation Society",
      date: DateTime.now().subtract(const Duration(days: 7)),
      time: "8:00 AM - 12:00 PM",
      duration: "4 hours",
      status: ActivityStatus.completed,
      location: "Sunset Beach",
      opportunityId: '6',
    ),
    Activity(
      id: '5',
      title: "Elderly Care Visit",
      organization: "Senior Support Network",
      date: DateTime.now().subtract(const Duration(days: 14)),
      time: "3:00 PM - 6:00 PM",
      duration: "3 hours",
      status: ActivityStatus.completed,
      location: "Sunshine Senior Center",
      opportunityId: '7',
    ),
  ];

  // Chat Conversations
  static List<ChatConversation> get conversations => [
    ChatConversation(
      id: '1',
      organization: "Green Earth Initiative",
      lastMessage: "Thank you for your interest! We'll contact you with more details about the tree planting event.",
      timestamp: DateTime.now().subtract(const Duration(hours: 2)),
      unreadCount: 2,
      avatarUrl: AppImages.ngoLogo1,
      messages: [
        Message(
          id: '1',
          conversationId: '1',
          content: "Hi! I'm interested in volunteering for the tree plantation drive.",
          timestamp: DateTime.now().subtract(const Duration(hours: 3)),
          sender: MessageSender.user,
        ),
        Message(
          id: '2',
          conversationId: '1',
          content: "Thank you for your interest! We'll contact you with more details about the tree planting event.",
          timestamp: DateTime.now().subtract(const Duration(hours: 2)),
          sender: MessageSender.organization,
        ),
      ],
    ),
    ChatConversation(
      id: '2',
      organization: "Community Support Network",
      lastMessage: "The workshop starts at 2 PM tomorrow. Please bring a notebook.",
      timestamp: DateTime.now().subtract(const Duration(days: 1)),
      unreadCount: 0,
      avatarUrl: AppImages.ngoLogo2,
      messages: [
        Message(
          id: '3',
          conversationId: '2',
          content: "What should I bring to the financial literacy workshop?",
          timestamp: DateTime.now().subtract(const Duration(days: 1, hours: 2)),
          sender: MessageSender.user,
        ),
        Message(
          id: '4',
          conversationId: '2',
          content: "The workshop starts at 2 PM tomorrow. Please bring a notebook.",
          timestamp: DateTime.now().subtract(const Duration(days: 1)),
          sender: MessageSender.organization,
        ),
      ],
    ),
    ChatConversation(
      id: '3',
      organization: "Hopeful Hands",
      lastMessage: "Thanks for helping with the community event! Your contribution made a real difference.",
      timestamp: DateTime.now().subtract(const Duration(days: 3)),
      unreadCount: 0,
      avatarUrl: AppImages.ngoLogo1,
      messages: [
        Message(
          id: '5',
          conversationId: '3',
          content: "Thanks for helping with the community event! Your contribution made a real difference.",
          timestamp: DateTime.now().subtract(const Duration(days: 3)),
          sender: MessageSender.organization,
        ),
      ],
    ),
  ];

  // Sample User
  static User get sampleUser => User(
    id: 'user_1',
    email: 'volunteer@example.com',
    fullName: 'Alex Johnson',
    profileImageUrl: AppImages.userAvatar,
    role: UserRole.volunteer,
    createdAt: DateTime.now().subtract(const Duration(days: 30)),
  );

  // Filter Options
  static List<String> get locationFilters => [
    'All Locations',
    'Downtown',
    'North District',
    'South District',
    'East District',
    'West District',
  ];

  static List<String> get categoryFilters => [
    'All Categories',
    'Environmental',
    'Education',
    'Healthcare',
    'Animal Welfare',
    'Community Support',
    'Emergency Relief',
  ];

  static List<String> get skillFilters => [
    'All Skills',
    'Teaching',
    'Organization',
    'Communication',
    'Physical Work',
    'Animal Care',
    'Gardening',
    'Finance',
  ];
}
