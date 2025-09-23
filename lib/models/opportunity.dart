class Opportunity {
  final String id;
  final String title;
  final String description;
  final String organization;
  final String location;
  final DateTime date;
  final String? time;
  final String imageUrl;
  final OpportunityType type;
  final double? rating;
  final int? reviewCount;
  final List<String> skills;
  final bool isUrgent;
  final DateTime createdAt;

  Opportunity({
    required this.id,
    required this.title,
    required this.description,
    required this.organization,
    required this.location,
    required this.date,
    this.time,
    required this.imageUrl,
    required this.type,
    this.rating,
    this.reviewCount,
    this.skills = const [],
    this.isUrgent = false,
    required this.createdAt,
  });

  factory Opportunity.fromJson(Map<String, dynamic> json) {
    return Opportunity(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      organization: json['organization'],
      location: json['location'],
      date: DateTime.parse(json['date']),
      time: json['time'],
      imageUrl: json['image_url'],
      type: OpportunityType.values.firstWhere(
        (e) => e.toString().split('.').last == json['type'],
      ),
      rating: json['rating']?.toDouble(),
      reviewCount: json['review_count'],
      skills: List<String>.from(json['skills'] ?? []),
      isUrgent: json['is_urgent'] ?? false,
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'organization': organization,
      'location': location,
      'date': date.toIso8601String(),
      'time': time,
      'image_url': imageUrl,
      'type': type.toString().split('.').last,
      'rating': rating,
      'review_count': reviewCount,
      'skills': skills,
      'is_urgent': isUrgent,
      'created_at': createdAt.toIso8601String(),
    };
  }

  String get formattedDate {
    final now = DateTime.now();
    final difference = date.difference(now).inDays;
    
    if (difference == 0) return 'Today';
    if (difference == 1) return 'Tomorrow';
    if (difference == -1) return 'Yesterday';
    
    return '${date.day}/${date.month}/${date.year}';
  }
}

enum OpportunityType {
  volunteer,
  service,
  event,
  workshop,
}

extension OpportunityTypeExtension on OpportunityType {
  String get displayName {
    switch (this) {
      case OpportunityType.volunteer:
        return 'VOLUNTEER';
      case OpportunityType.service:
        return 'SERVICE';
      case OpportunityType.event:
        return 'EVENT';
      case OpportunityType.workshop:
        return 'WORKSHOP';
    }
  }
}

class Cause {
  final String id;
  final String name;
  final String imageUrl;
  final String? description;

  Cause({
    required this.id,
    required this.name,
    required this.imageUrl,
    this.description,
  });

  factory Cause.fromJson(Map<String, dynamic> json) {
    return Cause(
      id: json['id'],
      name: json['name'],
      imageUrl: json['image_url'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image_url': imageUrl,
      'description': description,
    };
  }
}
