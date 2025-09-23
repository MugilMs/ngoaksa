import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/message.dart';
import '../utils/colors.dart';
import '../utils/text_styles.dart';
import '../utils/responsive_helper.dart';

class MessageTile extends StatelessWidget {
  final ChatConversation conversation;
  final VoidCallback? onTap;

  const MessageTile({
    super.key,
    required this.conversation,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: ResponsiveHelper.getHorizontalPadding(context).copyWith(
          top: 12,
          bottom: 12,
        ),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: AppColors.dividerColor,
              width: 0.5,
            ),
          ),
        ),
        child: Row(
          children: [
            _buildAvatar(),
            const SizedBox(width: 12),
            Expanded(
              child: _buildContent(),
            ),
            _buildTrailing(),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatar() {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: AppColors.primaryGreenOpacity20,
          width: 1,
        ),
      ),
      child: ClipOval(
        child: conversation.avatarUrl != null
            ? CachedNetworkImage(
                imageUrl: conversation.avatarUrl!,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  color: AppColors.inputBackground,
                  child: const Icon(
                    Icons.business,
                    color: AppColors.textSecondary,
                    size: 24,
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  color: AppColors.inputBackground,
                  child: const Icon(
                    Icons.business,
                    color: AppColors.textSecondary,
                    size: 24,
                  ),
                ),
              )
            : Container(
                color: AppColors.inputBackground,
                child: const Icon(
                  Icons.business,
                  color: AppColors.textSecondary,
                  size: 24,
                ),
              ),
      ),
    );
  }

  Widget _buildContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          conversation.organization,
          style: AppTextStyles.heading4,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 4),
        Text(
          conversation.lastMessage,
          style: AppTextStyles.bodySecondaryMedium,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget _buildTrailing() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          conversation.formattedTimestamp,
          style: AppTextStyles.captionSmall,
        ),
        if (conversation.unreadCount > 0) ...[
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: const BoxDecoration(
              color: AppColors.primaryGreen,
              shape: BoxShape.circle,
            ),
            child: Text(
              conversation.unreadCount.toString(),
              style: AppTextStyles.captionSmall.copyWith(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ],
    );
  }
}
