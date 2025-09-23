import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class PerformanceUtils {
  // Image caching and optimization
  static Widget optimizedNetworkImage({
    required String imageUrl,
    double? width,
    double? height,
    BoxFit fit = BoxFit.cover,
    Widget? placeholder,
    Widget? errorWidget,
    BorderRadius? borderRadius,
  }) {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.zero,
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        width: width,
        height: height,
        fit: fit,
        memCacheWidth: width?.round(),
        memCacheHeight: height?.round(),
        maxWidthDiskCache: 800,
        maxHeightDiskCache: 600,
        placeholder: (context, url) => placeholder ?? _buildImagePlaceholder(width, height),
        errorWidget: (context, url, error) => errorWidget ?? _buildImageError(width, height),
        fadeInDuration: const Duration(milliseconds: 300),
        fadeOutDuration: const Duration(milliseconds: 100),
      ),
    );
  }

  static Widget _buildImagePlaceholder(double? width, double? height) {
    return Container(
      width: width,
      height: height,
      color: Colors.grey[300],
      child: const Center(
        child: CircularProgressIndicator(strokeWidth: 2),
      ),
    );
  }

  static Widget _buildImageError(double? width, double? height) {
    return Container(
      width: width,
      height: height,
      color: Colors.grey[200],
      child: const Icon(
        Icons.error_outline,
        color: Colors.grey,
      ),
    );
  }

  // Lazy loading list builder
  static Widget buildLazyList<T>({
    required List<T> items,
    required Widget Function(BuildContext, T, int) itemBuilder,
    ScrollController? controller,
    EdgeInsets? padding,
    bool shrinkWrap = false,
    ScrollPhysics? physics,
  }) {
    return ListView.builder(
      controller: controller,
      padding: padding,
      shrinkWrap: shrinkWrap,
      physics: physics,
      itemCount: items.length,
      cacheExtent: 500, // Cache items 500 pixels outside viewport
      itemBuilder: (context, index) {
        if (index >= items.length) return const SizedBox.shrink();
        return itemBuilder(context, items[index], index);
      },
    );
  }

  // Debounced search
  static void debounce({
    required VoidCallback callback,
    Duration delay = const Duration(milliseconds: 500),
  }) {
    Timer? timer;
    timer?.cancel();
    timer = Timer(delay, callback);
  }

  // Memory-efficient grid builder
  static Widget buildOptimizedGrid<T>({
    required List<T> items,
    required Widget Function(BuildContext, T, int) itemBuilder,
    required int crossAxisCount,
    double mainAxisSpacing = 8.0,
    double crossAxisSpacing = 8.0,
    double childAspectRatio = 1.0,
    EdgeInsets? padding,
  }) {
    return GridView.builder(
      padding: padding,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        mainAxisSpacing: mainAxisSpacing,
        crossAxisSpacing: crossAxisSpacing,
        childAspectRatio: childAspectRatio,
      ),
      itemCount: items.length,
      cacheExtent: 300,
      itemBuilder: (context, index) {
        return itemBuilder(context, items[index], index);
      },
    );
  }

  // Optimized text rendering
  static Widget buildOptimizedText(
    String text, {
    TextStyle? style,
    int? maxLines,
    TextOverflow? overflow,
    TextAlign? textAlign,
  }) {
    return Text(
      text,
      style: style,
      maxLines: maxLines,
      overflow: overflow ?? TextOverflow.ellipsis,
      textAlign: textAlign,
      softWrap: maxLines != 1,
    );
  }

  // Preload images for better performance
  static Future<void> preloadImages(
    BuildContext context,
    List<String> imageUrls,
  ) async {
    final futures = imageUrls.map((url) {
      return precacheImage(CachedNetworkImageProvider(url), context);
    });
    await Future.wait(futures);
  }

  // Memory usage monitoring (debug only)
  static void logMemoryUsage(String tag) {
    assert(() {
      debugPrint('[$tag] Memory usage check');
      return true;
    }());
  }

  // Efficient list updates
  static List<T> updateListItem<T>(
    List<T> list,
    int index,
    T newItem,
  ) {
    if (index < 0 || index >= list.length) return list;
    final newList = List<T>.from(list);
    newList[index] = newItem;
    return newList;
  }

  // Batch operations for better performance
  static Future<List<R>> batchProcess<T, R>(
    List<T> items,
    Future<R> Function(T) processor, {
    int batchSize = 10,
  }) async {
    final results = <R>[];
    
    for (int i = 0; i < items.length; i += batchSize) {
      final batch = items.skip(i).take(batchSize);
      final batchResults = await Future.wait(
        batch.map(processor),
      );
      results.addAll(batchResults);
      
      // Small delay to prevent blocking the UI
      if (i + batchSize < items.length) {
        await Future.delayed(const Duration(milliseconds: 1));
      }
    }
    
    return results;
  }
}

// Timer utility for debouncing
class Timer {
  static Timer? _timer;
  
  Timer(Duration duration, VoidCallback callback) {
    _timer?.cancel();
    _timer = Timer._(duration, callback);
  }
  
  Timer._(Duration duration, VoidCallback callback) {
    Future.delayed(duration, callback);
  }
  
  void cancel() {
    _timer = null;
  }
}
