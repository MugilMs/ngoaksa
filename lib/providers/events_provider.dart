import 'package:flutter/material.dart';

class Event {
  final String id;
  final String title;
  final String description;
  final String location;
  final DateTime date;
  final String organizer;
  final int participants;
  final int maxParticipants;
  final DateTime createdAt;

  Event({
    required this.id,
    required this.title,
    required this.description,
    required this.location,
    required this.date,
    required this.organizer,
    required this.participants,
    required this.maxParticipants,
    required this.createdAt,
  });

  String get formattedDate {
    return '${date.day}/${date.month}/${date.year}';
  }
}

class EventsProvider extends ChangeNotifier {
  final List<Event> _events = [
    Event(
      id: '1',
      title: 'Beach Cleanup Drive',
      description: 'Join us for a community beach cleanup to protect marine life and keep our beaches beautiful.',
      location: 'Marina Beach, Chennai',
      date: DateTime.now().add(const Duration(days: 5)),
      organizer: 'Ocean Conservation Society',
      participants: 45,
      maxParticipants: 100,
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
    ),
    Event(
      id: '2',
      title: 'Food Distribution for Homeless',
      description: 'Help us distribute meals to homeless individuals in the city. Every helping hand makes a difference.',
      location: 'Central Park, Chennai',
      date: DateTime.now().add(const Duration(days: 10)),
      organizer: 'Helping Hands NGO',
      participants: 23,
      maxParticipants: 50,
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
    ),
    Event(
      id: '3',
      title: 'Tree Plantation Drive',
      description: 'Be part of our mission to plant 1000 trees this month. Help us create a greener future.',
      location: 'Guindy National Park',
      date: DateTime.now().add(const Duration(days: 15)),
      organizer: 'Green Earth Foundation',
      participants: 67,
      maxParticipants: 80,
      createdAt: DateTime.now().subtract(const Duration(hours: 12)),
    ),
  ];

  List<Event> get events => List.unmodifiable(_events);

  List<Event> get recentEvents {
    final sortedEvents = List<Event>.from(_events);
    sortedEvents.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return sortedEvents.take(5).toList();
  }

  void addEvent({
    required String title,
    required String description,
    required String location,
    required DateTime date,
    String organizer = 'Admin',
  }) {
    final newEvent = Event(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      description: description,
      location: location,
      date: date,
      organizer: organizer,
      participants: 0,
      maxParticipants: 100,
      createdAt: DateTime.now(),
    );

    _events.insert(0, newEvent); // Add to beginning for newest first
    notifyListeners();
  }

  void joinEvent(String eventId) {
    final eventIndex = _events.indexWhere((event) => event.id == eventId);
    if (eventIndex != -1) {
      final event = _events[eventIndex];
      if (event.participants < event.maxParticipants) {
        _events[eventIndex] = Event(
          id: event.id,
          title: event.title,
          description: event.description,
          location: event.location,
          date: event.date,
          organizer: event.organizer,
          participants: event.participants + 1,
          maxParticipants: event.maxParticipants,
          createdAt: event.createdAt,
        );
        notifyListeners();
      }
    }
  }

  Event? getEventById(String id) {
    try {
      return _events.firstWhere((event) => event.id == id);
    } catch (e) {
      return null;
    }
  }
}
