import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../providers/auth_provider.dart';
import '../../widgets/message_tile.dart';
import '../../models/message.dart';
import '../../utils/colors.dart';
import '../../utils/text_styles.dart';
import '../../utils/responsive_helper.dart';
import '../../data/dummy_data.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  final _searchController = TextEditingController();
  List<ChatConversation> _filteredConversations = [];

  @override
  void initState() {
    super.initState();
    _filteredConversations = DummyData.chatConversations;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterConversations(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredConversations = DummyData.chatConversations;
      } else {
        _filteredConversations = DummyData.chatConversations
            .where((conversation) =>
                conversation.organizationName
                    .toLowerCase()
                    .contains(query.toLowerCase()) ||
                conversation.lastMessage.content
                    .toLowerCase()
                    .contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            _buildSearchBar(context),
            const SizedBox(height: 16),
            _buildFilterTabs(context),
            const SizedBox(height: 16),
            Expanded(
              child: _buildConversationList(context),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showNewMessageDialog(context);
        },
        backgroundColor: AppColors.primaryGreen,
        child: const Icon(
          Icons.add,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: ResponsiveHelper.getHorizontalPadding(context).copyWith(
        top: 16,
        bottom: 16,
      ),
      child: Row(
        children: [
          Text(
            'Messages',
            style: AppTextStyles.heading1,
          ),
          const Spacer(),
          IconButton(
            onPressed: () {
              // TODO: Implement message settings
            },
            icon: const Icon(
              Icons.more_vert,
              color: AppColors.textPrimary,
              size: 28,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return Padding(
      padding: ResponsiveHelper.getHorizontalPadding(context),
      child: TextField(
        controller: _searchController,
        style: AppTextStyles.inputText,
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.inputBackground,
          hintText: 'Search conversations',
          hintStyle: AppTextStyles.inputHint,
          prefixIcon: const Icon(
            Icons.search,
            color: AppColors.textTertiary,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(
              color: AppColors.primaryGreen,
              width: 2,
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
        ),
        onChanged: _filterConversations,
      ),
    );
  }

  Widget _buildFilterTabs(BuildContext context) {
    return Padding(
      padding: ResponsiveHelper.getHorizontalPadding(context),
      child: Row(
        children: [
          _buildFilterTab('All', true),
          const SizedBox(width: 12),
          _buildFilterTab('Unread', false),
          const SizedBox(width: 12),
          _buildFilterTab('Organizations', false),
          const SizedBox(width: 12),
          _buildFilterTab('Volunteers', false),
        ],
      ),
    );
  }

  Widget _buildFilterTab(String label, bool isActive) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isActive ? AppColors.primaryGreen : AppColors.inputBackground,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: AppTextStyles.bodySecondaryMedium.copyWith(
          color: isActive ? Colors.black : AppColors.textSecondary,
          fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
        ),
      ),
    );
  }

  Widget _buildConversationList(BuildContext context) {
    if (_filteredConversations.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.chat_bubble_outline,
              size: 64,
              color: AppColors.textTertiary,
            ),
            const SizedBox(height: 16),
            Text(
              'No conversations found',
              style: AppTextStyles.heading4.copyWith(
                color: AppColors.textTertiary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Start a conversation with an organization',
              style: AppTextStyles.bodySecondary,
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 100),
      itemCount: _filteredConversations.length,
      itemBuilder: (context, index) {
        final conversation = _filteredConversations[index];
        return MessageTile(
          conversation: conversation,
          onTap: () {
            _openChatScreen(context, conversation);
          },
        );
      },
    );
  }

  void _openChatScreen(BuildContext context, ChatConversation conversation) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatScreen(conversation: conversation),
      ),
    );
  }

  void _showNewMessageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.cardBackground,
        title: Text(
          'New Message',
          style: AppTextStyles.heading4,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Search organizations...',
                filled: true,
                fillColor: AppColors.inputBackground,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                prefixIcon: const Icon(
                  Icons.search,
                  color: AppColors.textTertiary,
                ),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: ListView.builder(
                itemCount: 3, // Sample organizations
                itemBuilder: (context, index) {
                  final orgNames = ['Green Earth Foundation', 'Hope Center', 'Community Kitchen'];
                  final orgImages = [
                    'https://images.unsplash.com/photo-1559827260-dc66d52bef19?w=100',
                    'https://images.unsplash.com/photo-1582213782179-e0d53f98f2ca?w=100',
                    'https://images.unsplash.com/photo-1488521787991-ed7bbaae773c?w=100',
                  ];
                  
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: CachedNetworkImageProvider(orgImages[index]),
                    ),
                    title: Text(
                      orgNames[index],
                      style: AppTextStyles.bodyMedium,
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Started conversation with ${orgNames[index]}'),
                          backgroundColor: AppColors.successGreen,
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: AppTextStyles.link,
            ),
          ),
        ],
      ),
    );
  }
}

class ChatScreen extends StatefulWidget {
  final ChatConversation conversation;

  const ChatScreen({
    super.key,
    required this.conversation,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _messageController = TextEditingController();
  final _scrollController = ScrollController();

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.cardBackground,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back,
            color: AppColors.textPrimary,
          ),
        ),
        title: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage: CachedNetworkImageProvider(
                widget.conversation.organizationAvatar,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.conversation.organizationName,
                    style: AppTextStyles.heading4,
                  ),
                  Text(
                    'Online',
                    style: AppTextStyles.captionSmall.copyWith(
                      color: AppColors.successGreen,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              // TODO: Implement video call
            },
            icon: const Icon(
              Icons.videocam,
              color: AppColors.textPrimary,
            ),
          ),
          IconButton(
            onPressed: () {
              // TODO: Implement voice call
            },
            icon: const Icon(
              Icons.call,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: _buildMessageList(),
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildMessageList() {
    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.all(16),
      itemCount: widget.conversation.messages.length,
      itemBuilder: (context, index) {
        final message = widget.conversation.messages[index];
        final isMe = message.senderId == DummyData.sampleUser.id;
        
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          child: Row(
            mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (!isMe) ...[
                CircleAvatar(
                  radius: 16,
                  backgroundImage: CachedNetworkImageProvider(
                    widget.conversation.organizationAvatar,
                  ),
                ),
                const SizedBox(width: 8),
              ],
              Flexible(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: isMe ? AppColors.primaryGreen : AppColors.inputBackground,
                    borderRadius: BorderRadius.circular(16).copyWith(
                      bottomLeft: isMe ? const Radius.circular(16) : const Radius.circular(4),
                      bottomRight: isMe ? const Radius.circular(4) : const Radius.circular(16),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        message.content,
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: isMe ? Colors.black : AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        message.formattedTime,
                        style: AppTextStyles.captionSmall.copyWith(
                          color: isMe ? Colors.black54 : AppColors.textTertiary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (isMe) ...[
                const SizedBox(width: 8),
                Consumer<AuthProvider>(
                  builder: (context, authProvider, child) {
                    return CircleAvatar(
                      radius: 16,
                      backgroundImage: CachedNetworkImageProvider(
                        authProvider.currentUser?.profileImageUrl ?? 
                        DummyData.sampleUser.profileImageUrl!,
                      ),
                    );
                  },
                ),
              ],
            ],
          ),
        );
      },
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: AppColors.cardBackground,
        border: Border(
          top: BorderSide(color: AppColors.dividerColor),
        ),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              // TODO: Implement attachment
            },
            icon: const Icon(
              Icons.attach_file,
              color: AppColors.textSecondary,
            ),
          ),
          Expanded(
            child: TextField(
              controller: _messageController,
              style: AppTextStyles.inputText,
              decoration: InputDecoration(
                hintText: 'Type a message...',
                hintStyle: AppTextStyles.inputHint,
                filled: true,
                fillColor: AppColors.inputBackground,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
              maxLines: null,
            ),
          ),
          const SizedBox(width: 8),
          Container(
            decoration: const BoxDecoration(
              color: AppColors.primaryGreen,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              onPressed: () {
                if (_messageController.text.trim().isNotEmpty) {
                  // TODO: Send message
                  _messageController.clear();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Message sent!'),
                      backgroundColor: AppColors.successGreen,
                    ),
                  );
                }
              },
              icon: const Icon(
                Icons.send,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
