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
    "organizationsHelped": 5,
    "impactScore": 92,
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

  // User Activities (combining upcoming, completed, and pending)
  static List<Activity> get userActivities => [
    // Upcoming Activities
    Activity(
      id: '1',
      title: "Volunteer at the local food bank",
      description: "Help distribute food packages to families in need",
      organization: "Food Security Network",
      date: DateTime.now().add(const Duration(days: 1)),
      time: "2:00 PM - 5:00 PM",
      duration: "3 hours",
      status: ActivityStatus.upcoming,
      location: "Downtown Food Bank",
      opportunityId: '2',
      imageUrl: AppImages.foodBank,
    ),
    Activity(
      id: '2',
      title: "Assist at the animal shelter",
      description: "Help with daily care activities for rescued animals",
      organization: "Paws & Claws Shelter",
      date: DateTime.now().add(const Duration(days: 3)),
      time: "9:00 AM - 1:00 PM",
      duration: "4 hours",
      status: ActivityStatus.upcoming,
      location: "Animal Rescue Center",
      opportunityId: '5',
      imageUrl: AppImages.animalShelter,
    ),
    Activity(
      id: '3',
      title: "Community Garden Workshop",
      description: "Learn and teach sustainable farming practices",
      organization: "Green Gardens Initiative",
      date: DateTime.now().add(const Duration(days: 5)),
      time: "10:00 AM - 2:00 PM",
      duration: "4 hours",
      status: ActivityStatus.upcoming,
      location: "Community Center",
      opportunityId: '3',
      imageUrl: AppImages.communityGarden,
    ),
    // Completed Activities
    Activity(
      id: '4',
      title: "Beach Cleanup Drive",
      description: "Environmental cleanup initiative at the local beach",
      organization: "Ocean Conservation Society",
      date: DateTime.now().subtract(const Duration(days: 7)),
      time: "8:00 AM - 12:00 PM",
      duration: "4 hours",
      status: ActivityStatus.completed,
      location: "Sunset Beach",
      opportunityId: '6',
      imageUrl: AppImages.environmental,
      hoursLogged: 4,
    ),
    Activity(
      id: '5',
      title: "Elderly Care Visit",
      description: "Spend time with elderly residents and provide companionship",
      organization: "Senior Support Network",
      date: DateTime.now().subtract(const Duration(days: 14)),
      time: "3:00 PM - 6:00 PM",
      duration: "3 hours",
      status: ActivityStatus.completed,
      location: "Sunshine Senior Center",
      opportunityId: '7',
      imageUrl: AppImages.healthcare,
      hoursLogged: 3,
    ),
    Activity(
      id: '6',
      title: "Tree Plantation Drive",
      description: "Plant trees to increase the city's greenery",
      organization: "GreenLife Foundation",
      date: DateTime.now().subtract(const Duration(days: 21)),
      time: "9:00 AM - 2:00 PM",
      duration: "5 hours",
      status: ActivityStatus.completed,
      location: "Central Park",
      opportunityId: '1',
      imageUrl: AppImages.treePlanting,
      hoursLogged: 5,
    ),
    // Pending Applications
    Activity(
      id: '7',
      title: "Financial Literacy Workshop",
      description: "Help teach financial skills to young adults",
      organization: "Community Builders NGO",
      date: DateTime.now().add(const Duration(days: 10)),
      time: "2:00 PM - 5:00 PM",
      duration: "3 hours",
      status: ActivityStatus.pending,
      location: "Youth Center",
      opportunityId: '4',
      imageUrl: AppImages.financialWorkshop,
    ),
    Activity(
      id: '8',
      title: "Emergency Food Distribution",
      description: "Urgent volunteer opportunity for flood relief",
      organization: "Food Security Network",
      date: DateTime.now().add(const Duration(days: 2)),
      time: "10:00 AM - 4:00 PM",
      duration: "6 hours",
      status: ActivityStatus.pending,
      location: "Community Center, East District",
      opportunityId: '2',
      imageUrl: AppImages.foodBank,
    ),
  ];

  // Upcoming Activities
  static List<Activity> get upcomingActivities => userActivities
      .where((activity) => activity.status == ActivityStatus.upcoming)
      .toList();

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
  static List<ChatConversation> get chatConversations => [
    ChatConversation(
      id: '1',
      organization: "Green Earth Initiative",
      organizationName: "Green Earth Initiative",
      organizationAvatar: AppImages.ngoLogo1,
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
          senderId: 'user_1',
        ),
        Message(
          id: '2',
          conversationId: '1',
          content: "Thank you for your interest! We'll contact you with more details about the tree planting event.",
          timestamp: DateTime.now().subtract(const Duration(hours: 2)),
          sender: MessageSender.organization,
          senderId: 'org_1',
        ),
      ],
    ),
    ChatConversation(
      id: '2',
      organization: "Community Support Network",
      organizationName: "Community Support Network",
      organizationAvatar: AppImages.ngoLogo2,
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
          senderId: 'user_1',
        ),
        Message(
          id: '4',
          conversationId: '2',
          content: "The workshop starts at 2 PM tomorrow. Please bring a notebook.",
          timestamp: DateTime.now().subtract(const Duration(days: 1)),
          sender: MessageSender.organization,
          senderId: 'org_2',
        ),
      ],
    ),
    ChatConversation(
      id: '3',
      organization: "Hopeful Hands",
      organizationName: "Hopeful Hands",
      organizationAvatar: AppImages.ngoLogo1,
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
          senderId: 'org_3',
        ),
      ],
    ),
    ChatConversation(
      id: '4',
      organization: "Food Security Network",
      organizationName: "Food Security Network",
      organizationAvatar: AppImages.ngoLogo2,
      lastMessage: "We have an urgent need for volunteers this weekend. Can you help?",
      timestamp: DateTime.now().subtract(const Duration(hours: 5)),
      unreadCount: 1,
      avatarUrl: AppImages.ngoLogo2,
      messages: [
        Message(
          id: '6',
          conversationId: '4',
          content: "We have an urgent need for volunteers this weekend. Can you help?",
          timestamp: DateTime.now().subtract(const Duration(hours: 5)),
          sender: MessageSender.organization,
          senderId: 'org_4',
        ),
      ],
    ),
    ChatConversation(
      id: '5',
      organization: "Animal Rescue Center",
      organizationName: "Animal Rescue Center",
      organizationAvatar: AppImages.ngoLogo1,
      lastMessage: "The puppies you helped rescue are doing great! Thank you so much.",
      timestamp: DateTime.now().subtract(const Duration(days: 2)),
      unreadCount: 0,
      avatarUrl: AppImages.ngoLogo1,
      messages: [
        Message(
          id: '7',
          conversationId: '5',
          content: "How are the puppies I helped rescue last week?",
          timestamp: DateTime.now().subtract(const Duration(days: 2, hours: 1)),
          sender: MessageSender.user,
          senderId: 'user_1',
        ),
        Message(
          id: '8',
          conversationId: '5',
          content: "The puppies you helped rescue are doing great! Thank you so much.",
          timestamp: DateTime.now().subtract(const Duration(days: 2)),
          sender: MessageSender.organization,
          senderId: 'org_5',
        ),
      ],
    ),
    ChatConversation(
      id: '6',
      organization: "Education First",
      organizationName: "Education First",
      organizationAvatar: AppImages.ngoLogo2,
      lastMessage: "We have a new tutoring program starting next month. Are you interested?",
      timestamp: DateTime.now().subtract(const Duration(hours: 8)),
      unreadCount: 3,
      avatarUrl: AppImages.ngoLogo2,
      messages: [
        Message(
          id: '9',
          conversationId: '6',
          content: "Hi! I saw your tutoring program and I'm interested in helping.",
          timestamp: DateTime.now().subtract(const Duration(hours: 10)),
          sender: MessageSender.user,
          senderId: 'user_1',
        ),
        Message(
          id: '10',
          conversationId: '6',
          content: "That's wonderful! What subjects are you comfortable teaching?",
          timestamp: DateTime.now().subtract(const Duration(hours: 9)),
          sender: MessageSender.organization,
          senderId: 'org_6',
        ),
        Message(
          id: '11',
          conversationId: '6',
          content: "I can help with Math and Science for middle school students.",
          timestamp: DateTime.now().subtract(const Duration(hours: 8, minutes: 30)),
          sender: MessageSender.user,
          senderId: 'user_1',
        ),
        Message(
          id: '12',
          conversationId: '6',
          content: "Perfect! We have a new tutoring program starting next month. Are you interested?",
          timestamp: DateTime.now().subtract(const Duration(hours: 8)),
          sender: MessageSender.organization,
          senderId: 'org_6',
        ),
      ],
    ),
    ChatConversation(
      id: '7',
      organization: "Clean Water Initiative",
      organizationName: "Clean Water Initiative",
      organizationAvatar: AppImages.ngoLogo1,
      lastMessage: "Thank you for your donation! Every contribution helps us provide clean water to communities in need.",
      timestamp: DateTime.now().subtract(const Duration(days: 1, hours: 3)),
      unreadCount: 0,
      avatarUrl: AppImages.ngoLogo1,
      messages: [
        Message(
          id: '13',
          conversationId: '7',
          content: "I'd like to make a donation to support your clean water projects.",
          timestamp: DateTime.now().subtract(const Duration(days: 1, hours: 4)),
          sender: MessageSender.user,
          senderId: 'user_1',
        ),
        Message(
          id: '14',
          conversationId: '7',
          content: "Thank you for your donation! Every contribution helps us provide clean water to communities in need.",
          timestamp: DateTime.now().subtract(const Duration(days: 1, hours: 3)),
          sender: MessageSender.organization,
          senderId: 'org_7',
        ),
      ],
    ),
    ChatConversation(
      id: '8',
      organization: "Youth Mentorship Program",
      organizationName: "Youth Mentorship Program",
      organizationAvatar: AppImages.ngoLogo2,
      lastMessage: "Your mentee Sarah has shown great improvement in her studies. Thank you for your dedication!",
      timestamp: DateTime.now().subtract(const Duration(hours: 12)),
      unreadCount: 1,
      avatarUrl: AppImages.ngoLogo2,
      messages: [
        Message(
          id: '15',
          conversationId: '8',
          content: "How is Sarah doing in the mentorship program?",
          timestamp: DateTime.now().subtract(const Duration(hours: 13)),
          sender: MessageSender.user,
          senderId: 'user_1',
        ),
        Message(
          id: '16',
          conversationId: '8',
          content: "Your mentee Sarah has shown great improvement in her studies. Thank you for your dedication!",
          timestamp: DateTime.now().subtract(const Duration(hours: 12)),
          sender: MessageSender.organization,
          senderId: 'org_8',
        ),
      ],
    ),
    ChatConversation(
      id: '9',
      organization: "Disaster Relief Foundation",
      organizationName: "Disaster Relief Foundation",
      organizationAvatar: AppImages.ngoLogo1,
      lastMessage: "We need urgent volunteers for flood relief operations. Can you help this weekend?",
      timestamp: DateTime.now().subtract(const Duration(minutes: 30)),
      unreadCount: 2,
      avatarUrl: AppImages.ngoLogo1,
      messages: [
        Message(
          id: '17',
          conversationId: '9',
          content: "Hi! I heard about the recent floods. How can I help?",
          timestamp: DateTime.now().subtract(const Duration(hours: 2)),
          sender: MessageSender.user,
          senderId: 'user_1',
        ),
        Message(
          id: '18',
          conversationId: '9',
          content: "Thank you for reaching out! We're coordinating relief efforts in the affected areas.",
          timestamp: DateTime.now().subtract(const Duration(hours: 1, minutes: 30)),
          sender: MessageSender.organization,
          senderId: 'org_9',
        ),
        Message(
          id: '19',
          conversationId: '9',
          content: "We need volunteers to help distribute food and supplies. Are you available?",
          timestamp: DateTime.now().subtract(const Duration(hours: 1)),
          sender: MessageSender.organization,
          senderId: 'org_9',
        ),
        Message(
          id: '20',
          conversationId: '9',
          content: "Yes, I can volunteer this weekend. What time should I be there?",
          timestamp: DateTime.now().subtract(const Duration(minutes: 45)),
          sender: MessageSender.user,
          senderId: 'user_1',
        ),
        Message(
          id: '21',
          conversationId: '9',
          content: "We need urgent volunteers for flood relief operations. Can you help this weekend?",
          timestamp: DateTime.now().subtract(const Duration(minutes: 30)),
          sender: MessageSender.organization,
          senderId: 'org_9',
        ),
      ],
    ),
    ChatConversation(
      id: '10',
      organization: "Senior Care Network",
      organizationName: "Senior Care Network",
      organizationAvatar: AppImages.ngoLogo2,
      lastMessage: "The seniors really enjoyed your visit last week. Would you like to schedule another visit?",
      timestamp: DateTime.now().subtract(const Duration(days: 1, hours: 6)),
      unreadCount: 0,
      avatarUrl: AppImages.ngoLogo2,
      messages: [
        Message(
          id: '22',
          conversationId: '10',
          content: "I'd love to volunteer at the senior center. What activities do you need help with?",
          timestamp: DateTime.now().subtract(const Duration(days: 2)),
          sender: MessageSender.user,
          senderId: 'user_1',
        ),
        Message(
          id: '23',
          conversationId: '10',
          content: "We need help with reading sessions, games, and just spending time with our residents.",
          timestamp: DateTime.now().subtract(const Duration(days: 1, hours: 20)),
          sender: MessageSender.organization,
          senderId: 'org_10',
        ),
        Message(
          id: '24',
          conversationId: '10',
          content: "That sounds perfect! I love reading and playing board games.",
          timestamp: DateTime.now().subtract(const Duration(days: 1, hours: 18)),
          sender: MessageSender.user,
          senderId: 'user_1',
        ),
        Message(
          id: '25',
          conversationId: '10',
          content: "Wonderful! Can you come this Thursday at 2 PM?",
          timestamp: DateTime.now().subtract(const Duration(days: 1, hours: 16)),
          sender: MessageSender.organization,
          senderId: 'org_10',
        ),
        Message(
          id: '26',
          conversationId: '10',
          content: "Yes, I'll be there! Should I bring anything?",
          timestamp: DateTime.now().subtract(const Duration(days: 1, hours: 14)),
          sender: MessageSender.user,
          senderId: 'user_1',
        ),
        Message(
          id: '27',
          conversationId: '10',
          content: "Just bring yourself and a smile! We have all the games and books here.",
          timestamp: DateTime.now().subtract(const Duration(days: 1, hours: 12)),
          sender: MessageSender.organization,
          senderId: 'org_10',
        ),
        Message(
          id: '28',
          conversationId: '10',
          content: "The seniors really enjoyed your visit last week. Would you like to schedule another visit?",
          timestamp: DateTime.now().subtract(const Duration(days: 1, hours: 6)),
          sender: MessageSender.organization,
          senderId: 'org_10',
        ),
      ],
    ),
    ChatConversation(
      id: '11',
      organization: "Tech for Good",
      organizationName: "Tech for Good",
      organizationAvatar: AppImages.ngoLogo1,
      lastMessage: "We're launching a new coding bootcamp for underprivileged youth. Interested in teaching?",
      timestamp: DateTime.now().subtract(const Duration(hours: 4)),
      unreadCount: 1,
      avatarUrl: AppImages.ngoLogo1,
      messages: [
        Message(
          id: '29',
          conversationId: '11',
          content: "I saw your post about teaching coding to kids. I'm a software developer and would love to help!",
          timestamp: DateTime.now().subtract(const Duration(hours: 6)),
          sender: MessageSender.user,
          senderId: 'user_1',
        ),
        Message(
          id: '30',
          conversationId: '11',
          content: "That's fantastic! What programming languages are you comfortable with?",
          timestamp: DateTime.now().subtract(const Duration(hours: 5)),
          sender: MessageSender.organization,
          senderId: 'org_11',
        ),
        Message(
          id: '31',
          conversationId: '11',
          content: "I'm proficient in Python, JavaScript, and Java. I also have experience with mobile app development.",
          timestamp: DateTime.now().subtract(const Duration(hours: 4, minutes: 30)),
          sender: MessageSender.user,
          senderId: 'user_1',
        ),
        Message(
          id: '32',
          conversationId: '11',
          content: "Perfect! We're launching a new coding bootcamp for underprivileged youth. Interested in teaching?",
          timestamp: DateTime.now().subtract(const Duration(hours: 4)),
          sender: MessageSender.organization,
          senderId: 'org_11',
        ),
      ],
    ),
    ChatConversation(
      id: '12',
      organization: "Women Empowerment Initiative",
      organizationName: "Women Empowerment Initiative",
      organizationAvatar: AppImages.ngoLogo2,
      lastMessage: "Thank you for your interest! Our next workshop is on entrepreneurship for women. Would you like to facilitate?",
      timestamp: DateTime.now().subtract(const Duration(hours: 18)),
      unreadCount: 0,
      avatarUrl: AppImages.ngoLogo2,
      messages: [
        Message(
          id: '33',
          conversationId: '12',
          content: "I'm passionate about women's rights and empowerment. How can I get involved?",
          timestamp: DateTime.now().subtract(const Duration(days: 1)),
          sender: MessageSender.user,
          senderId: 'user_1',
        ),
        Message(
          id: '34',
          conversationId: '12',
          content: "We run workshops on financial literacy, entrepreneurship, and leadership skills for women.",
          timestamp: DateTime.now().subtract(const Duration(hours: 22)),
          sender: MessageSender.organization,
          senderId: 'org_12',
        ),
        Message(
          id: '35',
          conversationId: '12',
          content: "I have experience in business consulting. I'd love to help with the entrepreneurship workshops!",
          timestamp: DateTime.now().subtract(const Duration(hours: 20)),
          sender: MessageSender.user,
          senderId: 'user_1',
        ),
        Message(
          id: '36',
          conversationId: '12',
          content: "Thank you for your interest! Our next workshop is on entrepreneurship for women. Would you like to facilitate?",
          timestamp: DateTime.now().subtract(const Duration(hours: 18)),
          sender: MessageSender.organization,
          senderId: 'org_12',
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
    bio: 'Passionate volunteer dedicated to making a positive impact in the community. I love environmental conservation, helping animals, and supporting education initiatives.',
    skills: ['Environmental Care', 'Teaching', 'Animal Care', 'Organization', 'Communication'],
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
