import 'package:flutter/material.dart';
import '../utils/colors.dart';
import '../utils/text_styles.dart';

class ExceptionCard extends StatelessWidget {
  final String title;
  final String message;
  final String? solution;
  final IconData icon;
  final VoidCallback? onRetry;
  final VoidCallback? onDismiss;

  const ExceptionCard({
    super.key,
    required this.title,
    required this.message,
    this.solution,
    this.icon = Icons.error_outline,
    this.onRetry,
    this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.emergencyRed.withOpacity(0.3),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowColor,
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with icon and title
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.emergencyRed.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  icon,
                  color: AppColors.emergencyRed,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: AppTextStyles.heading4.copyWith(
                    color: AppColors.emergencyRed,
                  ),
                ),
              ),
              if (onDismiss != null)
                IconButton(
                  onPressed: onDismiss,
                  icon: const Icon(
                    Icons.close,
                    color: AppColors.textTertiary,
                    size: 20,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 16),
          
          // Error message
          Text(
            message,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          
          // Solution (if provided)
          if (solution != null) ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.primaryGreen.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: AppColors.primaryGreen.withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.lightbulb_outline,
                    color: AppColors.primaryGreen,
                    size: 16,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Solution: $solution',
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.primaryGreen,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
          
          // Action buttons
          if (onRetry != null) ...[
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: onDismiss,
                  child: Text(
                    'Dismiss',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                      fontSize: 14,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: onRetry,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryGreen,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                  ),
                  child: Text(
                    'Try Again',
                    style: AppTextStyles.bodyMedium.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

// Helper class to show exception cards as dialogs
class ExceptionHandler {
  static void showExceptionDialog(
    BuildContext context, {
    required String title,
    required String message,
    String? solution,
    IconData icon = Icons.error_outline,
    VoidCallback? onRetry,
  }) {
    if (!context.mounted) return;
    
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: ExceptionCard(
          title: title,
          message: message,
          solution: solution,
          icon: icon,
          onRetry: onRetry != null ? () {
            Navigator.of(context).pop();
            onRetry();
          } : null,
          onDismiss: () => Navigator.of(context).pop(),
        ),
      ),
    );
  }

  static void showExceptionSnackBar(
    BuildContext context, {
    required String title,
    required String message,
    String? solution,
    VoidCallback? onRetry,
  }) {
    if (!context.mounted) return;
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              message,
              style: const TextStyle(color: Colors.white),
            ),
            if (solution != null) ...[
              const SizedBox(height: 8),
              Text(
                'Solution: $solution',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.9),
                  fontSize: 12,
                ),
              ),
            ],
          ],
        ),
        backgroundColor: AppColors.emergencyRed,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        action: onRetry != null ? SnackBarAction(
          label: 'Retry',
          textColor: Colors.white,
          onPressed: onRetry,
        ) : null,
        duration: const Duration(seconds: 6),
      ),
    );
  }

  // Common exception types with predefined messages
  static void handleNetworkException(BuildContext context, {VoidCallback? onRetry}) {
    showExceptionDialog(
      context,
      title: 'Network Connection Error',
      message: 'Unable to connect to the server. Please check your internet connection.',
      solution: 'Make sure you have a stable internet connection and try again.',
      icon: Icons.wifi_off,
      onRetry: onRetry,
    );
  }

  static void handleDatabaseException(BuildContext context, {VoidCallback? onRetry}) {
    showExceptionDialog(
      context,
      title: 'Database Connection Failed',
      message: 'Unable to connect to the database. The app will continue with cached data.',
      solution: 'Check your internet connection or try refreshing the page.',
      icon: Icons.storage,
      onRetry: onRetry,
    );
  }

  static void handleAuthException(BuildContext context, {VoidCallback? onRetry}) {
    showExceptionDialog(
      context,
      title: 'Authentication Error',
      message: 'There was a problem with your login credentials.',
      solution: 'Please check your email and password, then try logging in again.',
      icon: Icons.lock_outline,
      onRetry: onRetry,
    );
  }

  static void handleValidationException(BuildContext context, String field) {
    showExceptionSnackBar(
      context,
      title: 'Validation Error',
      message: 'Please check the $field field and try again.',
      solution: 'Make sure all required fields are filled correctly.',
    );
  }

  static void handleGenericException(BuildContext context, String error, {VoidCallback? onRetry}) {
    showExceptionDialog(
      context,
      title: 'Unexpected Error',
      message: 'An unexpected error occurred: $error',
      solution: 'Try refreshing the app or restart if the problem persists.',
      icon: Icons.bug_report,
      onRetry: onRetry,
    );
  }
}
