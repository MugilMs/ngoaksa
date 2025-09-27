class ChatConversation {
  final String id;
  final String organization;
  final String organizationName;
  final String organizationAvatar;
  final String lastMessage;
  final DateTime timestamp;
  final int unreadCount;
  final String? avatarUrl;
  final List<Message> messages;

  ChatConversation({
    required this.id,
    required this.organization,
    String? organizationName,
    String? organizationAvatar,
    required this.lastMessage,
    required this.timestamp,
    this.unreadCount = 0,
    this.avatarUrl,
    this.messages = const [],
  }) : organizationName = organizationName ?? organization,
       organizationAvatar = organizationAvatar ?? avatarUrl ?? '';

  factory ChatConversation.fromJson(Map<String, dynamic> json) {
    return ChatConversation(
      id: json['id'],
      organization: json['organization'],
      lastMessage: json['last_message'],
      timestamp: DateTime.parse(json['timestamp']),
      unreadCount: json['unread_count'] ?? 0,
      avatarUrl: json['avatar_url'],
      messages: (json['messages'] as List<dynamic>?)
          ?.map((m) => Message.fromJson(m))
          .toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'organization': organization,
      'last_message': lastMessage,
      'timestamp': timestamp.toIso8601String(),
      'unread_count': unreadCount,
      'avatar_url': avatarUrl,
      'messages': messages.map((m) => m.toJson()).toList(),
    };
  }

  String get formattedTimestamp {
    final now = DateTime.now();
    final difference = now.difference(timestamp);
    
    if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else {
      return '${timestamp.day}/${timestamp.month}/${timestamp.year}';
    }
  }
}

class Message {
  final String id;
  final String conversationId;
  final String content;
  final DateTime timestamp;
  final MessageSender sender;
  final String senderId;
  final MessageType type;
  final bool isRead;

  Message({
    required this.id,
    required this.conversationId,
    required this.content,
    required this.timestamp,
    required this.sender,
    String? senderId,
    this.type = MessageType.text,
    this.isRead = false,
  }) : senderId = senderId ?? id;

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'],
      conversationId: json['conversation_id'],
      content: json['content'],
      timestamp: DateTime.parse(json['timestamp']),
      sender: MessageSender.values.firstWhere(
        (e) => e.toString().split('.').last == json['sender'],
      ),
      senderId: json['sender_id'],
      type: MessageType.values.firstWhere(
        (e) => e.toString().split('.').last == json['type'],
      ),
      isRead: json['is_read'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'conversation_id': conversationId,
      'content': content,
      'timestamp': timestamp.toIso8601String(),
      'sender': sender.toString().split('.').last,
      'sender_id': senderId,
      'type': type.toString().split('.').last,
      'is_read': isRead,
    };
  }

  String get formattedTime {
    return '${timestamp.hour.toString().padLeft(2, '0')}:${timestamp.minute.toString().padLeft(2, '0')}';
  }
}

enum MessageSender {
  user,
  organization,
}

enum MessageType {
  text,
  image,
  file,
}
