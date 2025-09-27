class Activity {
  final String id;
  final String title;
  final String organization;
  final DateTime date;
  final String time;
  final String? duration;
  final ActivityStatus status;
  final String? location;
  final String? description;
  final String? imageUrl;
  final String opportunityId;
  final int hoursLogged;

  Activity({
    required this.id,
    required this.title,
    required this.organization,
    required this.date,
    required this.time,
    this.duration,
    required this.status,
    this.location,
    this.description,
    this.imageUrl,
    required this.opportunityId,
    this.hoursLogged = 0,
  });

  factory Activity.fromJson(Map<String, dynamic> json) {
    return Activity(
      id: json['id'],
      title: json['title'],
      organization: json['organization'],
      date: DateTime.parse(json['date']),
      time: json['time'],
      duration: json['duration'],
      status: ActivityStatus.values.firstWhere(
        (e) => e.toString().split('.').last == json['status'],
      ),
      location: json['location'],
      description: json['description'],
      imageUrl: json['image_url'],
      opportunityId: json['opportunity_id'],
      hoursLogged: json['hours_logged'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'organization': organization,
      'date': date.toIso8601String(),
      'time': time,
      'duration': duration,
      'status': status.toString().split('.').last,
      'location': location,
      'description': description,
      'image_url': imageUrl,
      'opportunity_id': opportunityId,
      'hours_logged': hoursLogged,
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

  bool get isUpcoming => date.isAfter(DateTime.now());
  bool get isPast => date.isBefore(DateTime.now());
}

enum ActivityStatus {
  confirmed,
  pending,
  upcoming,
  completed,
  cancelled,
}

extension ActivityStatusExtension on ActivityStatus {
  String get displayName {
    switch (this) {
      case ActivityStatus.confirmed:
        return 'Confirmed';
      case ActivityStatus.pending:
        return 'Pending';
      case ActivityStatus.upcoming:
        return 'Upcoming';
      case ActivityStatus.completed:
        return 'Completed';
      case ActivityStatus.cancelled:
        return 'Cancelled';
    }
  }
}
