import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  static const String supabaseUrl = 'https://mxbetlezivudkvocnkag.supabase.co';
  static const String supabaseAnonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im14YmV0bGV6aXZ1ZGt2b2Nua2FnIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTg4OTUxNjYsImV4cCI6MjA3NDQ3MTE2Nn0.81rPi-BmiKyKsq-rIdRYBd_C06CHh1WUvApc2rtKiEY';
  
  static SupabaseClient get client => Supabase.instance.client;
  
  static Map<String, String> get _headers => {
    'apikey': supabaseAnonKey,
    'Authorization': 'Bearer $supabaseAnonKey',
    'Content-Type': 'application/json',
  };
  
  static Future<void> initialize() async {
    try {
      await Supabase.initialize(
        url: supabaseUrl,
        anonKey: supabaseAnonKey,
      );
      print('Supabase service initialized successfully');
    } catch (e) {
      print('Error initializing Supabase service: $e');
      // Continue without throwing - app should work with local data
    }
  }
  
  // Activities related methods
  static Future<List<Map<String, dynamic>>> getActivities() async {
    try {
      final response = await http.get(
        Uri.parse('$supabaseUrl/rest/v1/activities?order=created_at.desc'),
        headers: _headers,
      );
      
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.cast<Map<String, dynamic>>();
      }
      return [];
    } catch (e) {
      print('Error fetching activities: $e');
      return [];
    }
  }
  
  static Future<bool> createActivity({
    required String title,
    required String description,
    required String organization,
    required DateTime date,
    required String time,
    required String location,
    required String status,
    String? duration,
    String? imageUrl,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$supabaseUrl/rest/v1/activities'),
        headers: _headers,
        body: json.encode({
          'title': title,
          'description': description,
          'organization': organization,
          'date': date.toIso8601String(),
          'time': time,
          'location': location,
          'status': status,
          'duration': duration,
          'image_url': imageUrl,
          'created_at': DateTime.now().toIso8601String(),
        }),
      );
      
      return response.statusCode == 201;
    } catch (e) {
      print('Error creating activity: $e');
      return false;
    }
  }
  
  // Messages related methods
  static Future<List<Map<String, dynamic>>> getConversations() async {
    try {
      final response = await http.get(
        Uri.parse('$supabaseUrl/rest/v1/conversations?order=updated_at.desc'),
        headers: _headers,
      );
      
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.cast<Map<String, dynamic>>();
      }
      return [];
    } catch (e) {
      print('Error fetching conversations: $e');
      return [];
    }
  }
  
  static Future<List<Map<String, dynamic>>> getMessages(String conversationId) async {
    try {
      final response = await http.get(
        Uri.parse('$supabaseUrl/rest/v1/messages?conversation_id=eq.$conversationId&order=created_at.asc'),
        headers: _headers,
      );
      
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.cast<Map<String, dynamic>>();
      }
      return [];
    } catch (e) {
      print('Error fetching messages: $e');
      return [];
    }
  }
  
  static Future<bool> sendMessage({
    required String conversationId,
    required String content,
    required String senderId,
    required String senderType,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$supabaseUrl/rest/v1/messages'),
        headers: _headers,
        body: json.encode({
          'conversation_id': conversationId,
          'content': content,
          'sender_id': senderId,
          'sender_type': senderType,
          'created_at': DateTime.now().toIso8601String(),
        }),
      );
      
      if (response.statusCode == 201) {
        // Update conversation last message
        await http.patch(
          Uri.parse('$supabaseUrl/rest/v1/conversations?id=eq.$conversationId'),
          headers: _headers,
          body: json.encode({
            'last_message': content,
            'updated_at': DateTime.now().toIso8601String(),
          }),
        );
        return true;
      }
      return false;
    } catch (e) {
      print('Error sending message: $e');
      return false;
    }
  }
  
  // Events related methods
  static Future<List<Map<String, dynamic>>> getEvents() async {
    try {
      final response = await http.get(
        Uri.parse('$supabaseUrl/rest/v1/events?order=created_at.desc'),
        headers: _headers,
      );
      
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.cast<Map<String, dynamic>>();
      }
      return [];
    } catch (e) {
      print('Error fetching events: $e');
      return [];
    }
  }
  
  static Future<bool> createEvent({
    required String title,
    required String description,
    required String location,
    required DateTime date,
    required String organizer,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$supabaseUrl/rest/v1/events'),
        headers: _headers,
        body: json.encode({
          'title': title,
          'description': description,
          'location': location,
          'date': date.toIso8601String(),
          'organizer': organizer,
          'created_at': DateTime.now().toIso8601String(),
        }),
      );
      
      return response.statusCode == 201;
    } catch (e) {
      print('Error creating event: $e');
      return false;
    }
  }
}
