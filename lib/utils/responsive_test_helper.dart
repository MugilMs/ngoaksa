import 'package:flutter/material.dart';
import 'responsive_helper.dart';

class ResponsiveTestHelper {
  // Test different screen sizes
  static const List<Size> testSizes = [
    Size(320, 568), // iPhone SE
    Size(375, 667), // iPhone 8
    Size(375, 812), // iPhone X
    Size(414, 896), // iPhone 11 Pro Max
    Size(390, 844), // iPhone 12/13
    Size(428, 926), // iPhone 14 Pro Max
    Size(768, 1024), // iPad
    Size(1024, 1366), // iPad Pro
  ];

  static const List<String> deviceNames = [
    'iPhone SE',
    'iPhone 8',
    'iPhone X',
    'iPhone 11 Pro Max',
    'iPhone 12/13',
    'iPhone 14 Pro Max',
    'iPad',
    'iPad Pro',
  ];

  // Test responsive breakpoints
  static void testBreakpoints() {
    for (int i = 0; i < testSizes.length; i++) {
      final size = testSizes[i];
      final deviceName = deviceNames[i];
      
      debugPrint('=== Testing $deviceName (${size.width}x${size.height}) ===');
      
      // Test breakpoint detection
      final breakpoint = ResponsiveHelper.getBreakpoint(size.width);
      debugPrint('Breakpoint: $breakpoint');
      
      // Test responsive values
      final padding = ResponsiveHelper.getResponsivePadding(size.width);
      debugPrint('Padding: $padding');
      
      final fontSize = ResponsiveHelper.getResponsiveFontSize(null, 16, screenWidth: size.width);
      debugPrint('Font Size (base 16): $fontSize');
      
      final buttonHeight = ResponsiveHelper.getButtonHeight(null, screenWidth: size.width);
      debugPrint('Button Height: $buttonHeight');
      
      debugPrint('');
    }
  }

  // Widget to test responsive design visually
  static Widget buildResponsiveTestWidget() {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Responsive Test'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTestSection('Screen Info'),
            _buildScreenInfoWidget(),
            const SizedBox(height: 24),
            
            _buildTestSection('Typography'),
            _buildTypographyTest(),
            const SizedBox(height: 24),
            
            _buildTestSection('Spacing'),
            _buildSpacingTest(),
            const SizedBox(height: 24),
            
            _buildTestSection('Components'),
            _buildComponentTest(),
          ],
        ),
      ),
    );
  }

  static Widget _buildTestSection(String title) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.blue.shade100,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  static Widget _buildScreenInfoWidget() {
    return Builder(
      builder: (context) {
        final size = MediaQuery.of(context).size;
        final breakpoint = ResponsiveHelper.getBreakpoint(size.width);
        
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Screen Width: ${size.width.toStringAsFixed(0)}px'),
                Text('Screen Height: ${size.height.toStringAsFixed(0)}px'),
                Text('Breakpoint: $breakpoint'),
                Text('Is Mobile: ${ResponsiveHelper.isMobile(context)}'),
                Text('Is Tablet: ${ResponsiveHelper.isTablet(context)}'),
                Text('Is Desktop: ${ResponsiveHelper.isDesktop(context)}'),
              ],
            ),
          ),
        );
      },
    );
  }

  static Widget _buildTypographyTest() {
    return Builder(
      builder: (context) {
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Heading 1',
                  style: TextStyle(
                    fontSize: ResponsiveHelper.getResponsiveFontSize(context, 32),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Heading 2',
                  style: TextStyle(
                    fontSize: ResponsiveHelper.getResponsiveFontSize(context, 24),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Body Text',
                  style: TextStyle(
                    fontSize: ResponsiveHelper.getResponsiveFontSize(context, 16),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Caption',
                  style: TextStyle(
                    fontSize: ResponsiveHelper.getResponsiveFontSize(context, 12),
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static Widget _buildSpacingTest() {
    return Builder(
      builder: (context) {
        final padding = ResponsiveHelper.getResponsivePadding(MediaQuery.of(context).size.width);
        
        return Card(
          child: Padding(
            padding: EdgeInsets.all(padding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Responsive Padding: ${padding}px'),
                const SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.blue.shade200,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(
                    child: Text('Content with responsive padding'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static Widget _buildComponentTest() {
    return Builder(
      builder: (context) {
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: double.infinity,
                  height: ResponsiveHelper.getButtonHeight(context),
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text('Responsive Button'),
                  ),
                ),
                const SizedBox(height: 16),
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: ResponsiveHelper.getGridCrossAxisCount(context),
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  children: List.generate(6, (index) {
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.green.shade200,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text('Item ${index + 1}'),
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Performance testing utilities
  static void measureBuildTime(String name, VoidCallback build) {
    final stopwatch = Stopwatch()..start();
    build();
    stopwatch.stop();
    debugPrint('$name build time: ${stopwatch.elapsedMilliseconds}ms');
  }

  static Widget buildPerformanceTestList({
    required int itemCount,
    required String testName,
  }) {
    return Builder(
      builder: (context) {
        final stopwatch = Stopwatch()..start();
        
        final widget = ListView.builder(
          itemCount: itemCount,
          itemBuilder: (context, index) {
            return ListTile(
              leading: CircleAvatar(child: Text('$index')),
              title: Text('Item $index'),
              subtitle: Text('Test item for $testName'),
            );
          },
        );
        
        stopwatch.stop();
        debugPrint('$testName list ($itemCount items) build time: ${stopwatch.elapsedMilliseconds}ms');
        
        return widget;
      },
    );
  }
}
