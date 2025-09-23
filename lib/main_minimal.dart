import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/simple_auth_provider.dart';
import 'utils/colors.dart';

void main() {
  runApp(const NGOConnectMinimal());
}

class NGOConnectMinimal extends StatelessWidget {
  const NGOConnectMinimal({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SimpleAuthProvider(),
      child: MaterialApp(
        title: 'NGO Connect',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: AppColors.backgroundColor,
          fontFamily: 'SF Pro Display',
          textTheme: const TextTheme(
            headlineLarge: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0F172A),
            ),
            headlineMedium: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: Color(0xFF0F172A),
            ),
            bodyLarge: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
              color: Color(0xFF0F172A),
            ),
            bodyMedium: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.normal,
              color: Color(0xFF64748B),
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: AppColors.inputBackground,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColors.dividerColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColors.primaryGreen, width: 2),
            ),
            labelStyle: TextStyle(color: AppColors.textSecondary),
            hintStyle: TextStyle(color: AppColors.textSecondary),
          ),
        ),
        home: const MinimalAuthWrapper(),
      ),
    );
  }
}

class MinimalAuthWrapper extends StatelessWidget {
  const MinimalAuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SimpleAuthProvider>(
      builder: (context, authProvider, child) {
        if (authProvider.isLoading) {
          return Scaffold(
            backgroundColor: AppColors.backgroundColor,
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    color: AppColors.primaryGreen,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Loading...',
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        if (!authProvider.isLoggedIn) {
          return const MinimalLoginScreen();
        }

        return const MinimalHomeScreen();
      },
    );
  }
}

class MinimalLoginScreen extends StatefulWidget {
  const MinimalLoginScreen({super.key});

  @override
  State<MinimalLoginScreen> createState() => _MinimalLoginScreenState();
}

class _MinimalLoginScreenState extends State<MinimalLoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Container(
        decoration: BoxDecoration(
          gradient: AppColors.backgroundGradient,
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Logo and Title
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: AppColors.primaryGreen.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.volunteer_activism,
                        size: 60,
                        color: AppColors.primaryBlue,
                      ),
                    ),
                    const SizedBox(height: 32),
                    
                    Text(
                      'NGO Connect',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 8),
                    
                    Text(
                      'Connect with opportunities to make a difference',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 48),
                    
                    // Email Field
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(color: AppColors.textPrimary),
                      decoration: InputDecoration(
                        labelText: 'Email Address',
                        hintText: 'Enter your email',
                        prefixIcon: Icon(Icons.email_outlined, color: AppColors.textSecondary),
                      ),
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Please enter your email';
                        }
                        if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value!)) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    
                    // Password Field
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      style: TextStyle(color: AppColors.textPrimary),
                      decoration: InputDecoration(
                        labelText: 'Password',
                        hintText: 'Enter your password',
                        prefixIcon: Icon(Icons.lock_outline, color: AppColors.textSecondary),
                      ),
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Please enter your password';
                        }
                        if (value!.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 32),
                    
                    // Sign In Button
                    Consumer<SimpleAuthProvider>(
                      builder: (context, authProvider, child) {
                        return Container(
                          height: 56,
                          decoration: BoxDecoration(
                            gradient: AppColors.primaryGradient,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.primaryGreen.withOpacity(0.3),
                                blurRadius: 12,
                                offset: const Offset(0, 6),
                              ),
                            ],
                          ),
                          child: ElevatedButton(
                            onPressed: authProvider.isLoading ? null : _signIn,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            child: authProvider.isLoading
                                ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    ),
                                  )
                                : Text(
                                    'Sign In',
                                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18,
                                    ),
                                  ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    
                    // Divider
                    Row(
                      children: [
                        Expanded(child: Divider(color: AppColors.dividerColor)),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            'or',
                            style: TextStyle(color: AppColors.textSecondary),
                          ),
                        ),
                        Expanded(child: Divider(color: AppColors.dividerColor)),
                      ],
                    ),
                    const SizedBox(height: 20),
                    
                    // Google Sign In Button
                    SizedBox(
                      height: 56,
                      child: OutlinedButton.icon(
                        onPressed: () async {
                          final authProvider = Provider.of<SimpleAuthProvider>(context, listen: false);
                          await authProvider.signInWithGoogle();
                        },
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: AppColors.dividerColor, width: 1.5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          backgroundColor: AppColors.cardBackground,
                        ),
                        icon: Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Icon(
                            Icons.g_mobiledata,
                            color: Colors.red,
                            size: 20,
                          ),
                        ),
                        label: Text(
                          'Continue with Google',
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    
                    // Demo Instructions
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.primaryGreen.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: AppColors.primaryGreen.withOpacity(0.3),
                        ),
                      ),
                      child: Column(
                        children: [
                          Icon(
                            Icons.info_outline,
                            color: AppColors.primaryBlue,
                            size: 20,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Demo Mode',
                            style: TextStyle(
                              color: AppColors.primaryBlue,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Enter any email and password to continue',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _signIn() async {
    if (!_formKey.currentState!.validate()) return;
    
    final authProvider = Provider.of<SimpleAuthProvider>(context, listen: false);
    final success = await authProvider.signIn(
      _emailController.text.trim(),
      _passwordController.text,
    );
    
    if (!success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Sign in failed. Please try again.'),
          backgroundColor: AppColors.emergencyRed,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      );
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}

class MinimalHomeScreen extends StatefulWidget {
  const MinimalHomeScreen({super.key});

  @override
  State<MinimalHomeScreen> createState() => _MinimalHomeScreenState();
}

class _MinimalHomeScreenState extends State<MinimalHomeScreen> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();

  final List<Widget> _pages = [
    const HomeTab(),
    const DiscoverTab(),
    const ActivitiesTab(),
    const MessagesTab(),
    const ProfileTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        children: _pages,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          boxShadow: [
            BoxShadow(
              color: AppColors.shadowColor,
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
            _pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.transparent,
          elevation: 0,
          selectedItemColor: AppColors.primaryBlue,
          unselectedItemColor: AppColors.textSecondary,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search_outlined),
              activeIcon: Icon(Icons.search),
              label: 'Discover',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today_outlined),
              activeIcon: Icon(Icons.calendar_today),
              label: 'Activities',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat_bubble_outline),
              activeIcon: Icon(Icons.chat_bubble),
              label: 'Messages',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              activeIcon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: const Text('NGO Connect'),
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome to NGO Connect!',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Connect with opportunities to make a difference',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            
            Text(
              'Featured Opportunities',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 16),
            
            _buildOpportunityCard(
              'Beach Cleanup Drive',
              'Ocean Conservation NGO',
              'Marina Beach, Chennai',
              'Environment',
            ),
            const SizedBox(height: 12),
            
            _buildOpportunityCard(
              'Teaching Kids Programming',
              'Code for Change',
              'Anna Nagar, Chennai',
              'Education',
            ),
            const SizedBox(height: 12),
            
            _buildOpportunityCard(
              'Food Distribution',
              'Helping Hands Foundation',
              'T. Nagar, Chennai',
              'Community',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOpportunityCard(String title, String org, String location, String category) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFb7e4c7),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.dividerColor),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowColor,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            org,
            style: TextStyle(
              fontSize: 14,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.location_on, size: 16, color: AppColors.textSecondary),
              const SizedBox(width: 4),
              Text(
                location,
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.textSecondary,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFa3d9b1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  category,
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.primaryBlue,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class DiscoverTab extends StatefulWidget {
  const DiscoverTab({super.key});

  @override
  State<DiscoverTab> createState() => _DiscoverTabState();
}

class _DiscoverTabState extends State<DiscoverTab> {
  final TextEditingController _searchController = TextEditingController();
  String selectedCategory = 'All';
  
  final List<String> categories = [
    'All', 'Environment', 'Education', 'Healthcare', 'Community', 'Animals', 'Elderly Care'
  ];

  final List<Map<String, dynamic>> opportunities = [
    {
      'title': 'Beach Cleanup Drive',
      'organization': 'Ocean Conservation NGO',
      'location': 'Marina Beach, Chennai',
      'category': 'Environment',
      'participants': 45,
      'date': 'Dec 15, 2024',
      'image': Icons.waves,
      'urgent': false,
    },
    {
      'title': 'Teaching Kids Programming',
      'organization': 'Code for Change',
      'location': 'Anna Nagar, Chennai',
      'category': 'Education',
      'participants': 12,
      'date': 'Dec 18, 2024',
      'image': Icons.computer,
      'urgent': false,
    },
    {
      'title': 'Emergency Food Distribution',
      'organization': 'Helping Hands Foundation',
      'location': 'T. Nagar, Chennai',
      'category': 'Community',
      'participants': 28,
      'date': 'Dec 12, 2024',
      'image': Icons.food_bank,
      'urgent': true,
    },
    {
      'title': 'Animal Shelter Care',
      'organization': 'Paws & Hearts',
      'location': 'Velachery, Chennai',
      'category': 'Animals',
      'participants': 15,
      'date': 'Dec 20, 2024',
      'image': Icons.pets,
      'urgent': false,
    },
    {
      'title': 'Senior Citizen Health Camp',
      'organization': 'Golden Years Care',
      'location': 'Mylapore, Chennai',
      'category': 'Healthcare',
      'participants': 8,
      'date': 'Dec 22, 2024',
      'image': Icons.health_and_safety,
      'urgent': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final filteredOpportunities = opportunities.where((opp) {
      final matchesCategory = selectedCategory == 'All' || opp['category'] == selectedCategory;
      final matchesSearch = _searchController.text.isEmpty || 
          opp['title'].toLowerCase().contains(_searchController.text.toLowerCase()) ||
          opp['organization'].toLowerCase().contains(_searchController.text.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: const Text('Discover'),
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Container(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              onChanged: (value) => setState(() {}),
              decoration: InputDecoration(
                hintText: 'Search opportunities...',
                prefixIcon: Icon(Icons.search, color: AppColors.textSecondary),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: Icon(Icons.clear, color: AppColors.textSecondary),
                        onPressed: () {
                          _searchController.clear();
                          setState(() {});
                        },
                      )
                    : null,
                filled: true,
                fillColor: AppColors.cardBackground,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          
          // Category Filter
          Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                final isSelected = selectedCategory == category;
                return Container(
                  margin: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    label: Text(category),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        selectedCategory = category;
                      });
                    },
                    backgroundColor: AppColors.cardBackground,
                    selectedColor: AppColors.primaryBlueOpacity10,
                    labelStyle: TextStyle(
                      color: isSelected ? AppColors.primaryBlue : AppColors.textSecondary,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                    ),
                    side: BorderSide(
                      color: isSelected ? AppColors.primaryBlue : AppColors.dividerColor,
                    ),
                  ),
                );
              },
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Opportunities List
          Expanded(
            child: filteredOpportunities.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search_off,
                          size: 64,
                          color: AppColors.textSecondary,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No opportunities found',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Try adjusting your search or filters',
                          style: TextStyle(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: filteredOpportunities.length,
                    itemBuilder: (context, index) {
                      return _buildOpportunityCard(filteredOpportunities[index]);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildOpportunityCard(Map<String, dynamic> opportunity) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.dividerColor),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowColor,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with image and urgent badge
          Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: AppColors.primaryBlueOpacity10,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    opportunity['image'],
                    color: AppColors.primaryBlue,
                    size: 30,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              opportunity['title'],
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ),
                          if (opportunity['urgent'])
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Text(
                                'URGENT',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        opportunity['organization'],
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          // Details
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(Icons.location_on, size: 16, color: AppColors.textSecondary),
                    const SizedBox(width: 4),
                    Text(
                      opportunity['location'],
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.calendar_today, size: 16, color: AppColors.textSecondary),
                    const SizedBox(width: 4),
                    Text(
                      opportunity['date'],
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const Spacer(),
                    Icon(Icons.people, size: 16, color: AppColors.textSecondary),
                    const SizedBox(width: 4),
                    Text(
                      '${opportunity['participants']} joined',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Action buttons
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: AppColors.primaryBlue),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Learn More',
                      style: TextStyle(color: AppColors.primaryBlue),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.cardBackground,
                      foregroundColor: AppColors.textPrimary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('Join Now'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}

class ActivitiesTab extends StatefulWidget {
  const ActivitiesTab({super.key});

  @override
  State<ActivitiesTab> createState() => _ActivitiesTabState();
}

class _ActivitiesTabState extends State<ActivitiesTab> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Map<String, dynamic>> upcomingActivities = [
    {
      'title': 'Beach Cleanup Drive',
      'organization': 'Ocean Conservation NGO',
      'date': 'Dec 15, 2024',
      'time': '6:00 AM - 10:00 AM',
      'location': 'Marina Beach, Chennai',
      'status': 'confirmed',
      'image': Icons.waves,
      'participants': 45,
    },
    {
      'title': 'Teaching Kids Programming',
      'organization': 'Code for Change',
      'date': 'Dec 18, 2024',
      'time': '2:00 PM - 6:00 PM',
      'location': 'Anna Nagar, Chennai',
      'status': 'pending',
      'image': Icons.computer,
      'participants': 12,
    },
  ];

  final List<Map<String, dynamic>> completedActivities = [
    {
      'title': 'Food Distribution',
      'organization': 'Helping Hands Foundation',
      'date': 'Nov 28, 2024',
      'time': '9:00 AM - 1:00 PM',
      'location': 'T. Nagar, Chennai',
      'status': 'completed',
      'image': Icons.food_bank,
      'participants': 28,
      'hours': 4,
      'certificate': true,
    },
    {
      'title': 'Tree Plantation Drive',
      'organization': 'Green Earth Initiative',
      'date': 'Nov 15, 2024',
      'time': '7:00 AM - 11:00 AM',
      'location': 'Guindy National Park',
      'status': 'completed',
      'image': Icons.park,
      'participants': 67,
      'hours': 4,
      'certificate': true,
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: const Text('My Activities'),
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: Colors.white,
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: const [
            Tab(text: 'Upcoming'),
            Tab(text: 'Completed'),
            Tab(text: 'Stats'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildUpcomingTab(),
          _buildCompletedTab(),
          _buildStatsTab(),
        ],
      ),
    );
  }

  Widget _buildUpcomingTab() {
    return upcomingActivities.isEmpty
        ? _buildEmptyState(
            icon: Icons.event_available,
            title: 'No Upcoming Activities',
            subtitle: 'Join volunteer opportunities to see them here',
          )
        : ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: upcomingActivities.length,
            itemBuilder: (context, index) {
              return _buildActivityCard(upcomingActivities[index], isUpcoming: true);
            },
          );
  }

  Widget _buildCompletedTab() {
    return completedActivities.isEmpty
        ? _buildEmptyState(
            icon: Icons.check_circle_outline,
            title: 'No Completed Activities',
            subtitle: 'Your completed volunteer work will appear here',
          )
        : ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: completedActivities.length,
            itemBuilder: (context, index) {
              return _buildActivityCard(completedActivities[index], isUpcoming: false);
            },
          );
  }

  Widget _buildStatsTab() {
    final totalHours = completedActivities.fold<int>(0, (sum, activity) => sum + ((activity['hours'] ?? 0) as int));
    final totalActivities = completedActivities.length;
    final certificates = completedActivities.where((activity) => activity['certificate'] == true).length;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Stats Cards
          Row(
            children: [
              Expanded(
                child: _buildStatCard('Total Hours', '$totalHours', Icons.access_time, Colors.blue),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildStatCard('Activities', '$totalActivities', Icons.volunteer_activism, Colors.green),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildStatCard('Certificates', '$certificates', Icons.card_membership, Colors.orange),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildStatCard('Impact Score', '${totalHours * 10}', Icons.trending_up, Colors.purple),
              ),
            ],
          ),
          
          const SizedBox(height: 24),
          
          // Achievements Section
          Text(
            'Achievements',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 16),
          
          _buildAchievementCard(
            'First Volunteer',
            'Completed your first volunteer activity',
            Icons.star,
            const Color(0xFFFFD700),
            true,
          ),
          const SizedBox(height: 12),
          _buildAchievementCard(
            'Environment Hero',
            'Participated in 2+ environmental activities',
            Icons.eco,
            Colors.green,
            true,
          ),
          const SizedBox(height: 12),
          _buildAchievementCard(
            '10 Hour Milestone',
            'Complete 10 hours of volunteer work',
            Icons.timer,
            Colors.blue,
            totalHours >= 10,
          ),
        ],
      ),
    );
  }

  Widget _buildActivityCard(Map<String, dynamic> activity, {required bool isUpcoming}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFb7e4c7),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.dividerColor),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowColor,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: AppColors.primaryBlueOpacity10,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    activity['image'],
                    color: AppColors.primaryBlue,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        activity['title'],
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      Text(
                        activity['organization'],
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                if (isUpcoming)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: activity['status'] == 'confirmed' ? Colors.green : Colors.orange,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      activity['status'].toUpperCase(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                if (!isUpcoming && activity['certificate'] == true)
                  const Icon(Icons.card_membership, color: Color(0xFFFFD700), size: 24),
              ],
            ),
            
            const SizedBox(height: 12),
            
            Row(
              children: [
                Icon(Icons.calendar_today, size: 16, color: AppColors.textSecondary),
                const SizedBox(width: 4),
                Text(
                  activity['date'],
                  style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
                ),
                const SizedBox(width: 16),
                Icon(Icons.access_time, size: 16, color: AppColors.textSecondary),
                const SizedBox(width: 4),
                Text(
                  activity['time'],
                  style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
                ),
              ],
            ),
            
            const SizedBox(height: 8),
            
            Row(
              children: [
                Icon(Icons.location_on, size: 16, color: AppColors.textSecondary),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    activity['location'],
                    style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
                  ),
                ),
              ],
            ),
            
            if (!isUpcoming && activity['hours'] != null) ...[
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.timer, size: 16, color: AppColors.textSecondary),
                  const SizedBox(width: 4),
                  Text(
                    '${activity['hours']} hours completed',
                    style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
                  ),
                ],
              ),
            ],
            
            if (isUpcoming) ...[
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: AppColors.primaryBlue),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'View Details',
                        style: TextStyle(color: AppColors.primaryBlue),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text('Cancel'),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFb7e4c7),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.dividerColor),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 32),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAchievementCard(String title, String description, IconData icon, Color color, bool unlocked) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: unlocked ? const Color(0xFFb7e4c7) : const Color(0xFFb7e4c7).withOpacity(0.5),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: unlocked ? color : AppColors.dividerColor),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: unlocked ? color.withOpacity(0.2) : AppColors.dividerColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Icon(
              icon,
              color: unlocked ? color : AppColors.textSecondary,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: unlocked ? AppColors.textPrimary : AppColors.textSecondary,
                  ),
                ),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          if (unlocked)
            Icon(Icons.check_circle, color: color, size: 24),
        ],
      ),
    );
  }

  Widget _buildEmptyState({required IconData icon, required String title, required String subtitle}) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 64, color: AppColors.textSecondary),
          const SizedBox(height: 16),
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}

class MessagesTab extends StatefulWidget {
  const MessagesTab({super.key});

  @override
  State<MessagesTab> createState() => _MessagesTabState();
}

class _MessagesTabState extends State<MessagesTab> {
  final List<Map<String, dynamic>> conversations = [
    {
      'name': 'Ocean Conservation NGO',
      'lastMessage': 'Thank you for joining our beach cleanup! Details attached.',
      'time': '2 min ago',
      'unread': 2,
      'avatar': Icons.waves,
      'isOrganization': true,
      'online': true,
    },
    {
      'name': 'Code for Change',
      'lastMessage': 'Looking forward to seeing you at the programming session!',
      'time': '1 hour ago',
      'unread': 0,
      'avatar': Icons.computer,
      'isOrganization': true,
      'online': false,
    },
    {
      'name': 'Volunteer Group Chat',
      'lastMessage': 'Sarah: Has anyone been to Marina Beach before?',
      'time': '3 hours ago',
      'unread': 5,
      'avatar': Icons.group,
      'isOrganization': false,
      'online': true,
    },
    {
      'name': 'Helping Hands Foundation',
      'lastMessage': 'Certificate for food distribution event is ready!',
      'time': 'Yesterday',
      'unread': 0,
      'avatar': Icons.food_bank,
      'isOrganization': true,
      'online': false,
    },
    {
      'name': 'Green Earth Initiative',
      'lastMessage': 'Great job on the tree plantation! 🌱',
      'time': '2 days ago',
      'unread': 0,
      'avatar': Icons.park,
      'isOrganization': true,
      'online': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: const Text('Messages'),
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: conversations.isEmpty
          ? _buildEmptyState()
          : Column(
              children: [
                // Quick Actions
                Container(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Expanded(
                        child: _buildQuickAction(
                          'Find NGOs',
                          Icons.search,
                          AppColors.primaryBlue,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildQuickAction(
                          'Join Groups',
                          Icons.group_add,
                          Colors.green,
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Messages List
                Expanded(
                  child: ListView.builder(
                    itemCount: conversations.length,
                    itemBuilder: (context, index) {
                      return _buildConversationTile(conversations[index]);
                    },
                  ),
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppColors.primaryBlue,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildQuickAction(String title, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 8),
          Text(
            title,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConversationTile(Map<String, dynamic> conversation) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFb7e4c7),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.dividerColor.withOpacity(0.5)),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Stack(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: conversation['isOrganization'] 
                    ? const Color(0xFFa3d9b1) 
                    : Colors.grey.withOpacity(0.2),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Icon(
                conversation['avatar'],
                color: conversation['isOrganization'] 
                    ? AppColors.primaryBlue 
                    : AppColors.textSecondary,
                size: 24,
              ),
            ),
            if (conversation['online'])
              Positioned(
                right: 2,
                bottom: 2,
                child: Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                ),
              ),
          ],
        ),
        title: Row(
          children: [
            Expanded(
              child: Text(
                conversation['name'],
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: AppColors.textPrimary,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Text(
              conversation['time'],
              style: TextStyle(
                fontSize: 12,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  conversation['lastMessage'],
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
              if (conversation['unread'] > 0)
                Container(
                  margin: const EdgeInsets.only(left: 8),
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: AppColors.primaryBlue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    '${conversation['unread']}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
        ),
        onTap: () {
          // Navigate to chat screen
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.chat_bubble_outline,
            size: 64,
            color: AppColors.textSecondary,
          ),
          const SizedBox(height: 16),
          Text(
            'No Messages Yet',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Start connecting with NGOs and volunteers',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFb7e4c7),
              foregroundColor: AppColors.textPrimary,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            icon: const Icon(Icons.search),
            label: const Text('Find NGOs'),
          ),
        ],
      ),
    );
  }
}

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              final authProvider = Provider.of<SimpleAuthProvider>(context, listen: false);
              authProvider.signOut();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFFb7e4c7),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.dividerColor),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: const Color(0xFFa3d9b1),
                    child: Icon(
                      Icons.person,
                      size: 30,
                      color: AppColors.primaryBlue,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Demo User',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        Text(
                          'Volunteer',
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            _buildMenuOption(Icons.person_outline, 'Edit Profile'),
            _buildMenuOption(Icons.settings_outlined, 'Settings'),
            _buildMenuOption(Icons.help_outline, 'Help & Support'),
            _buildMenuOption(Icons.info_outline, 'About'),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuOption(IconData icon, String title) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(icon, color: AppColors.textSecondary),
        title: Text(
          title,
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 16,
          ),
        ),
        trailing: Icon(Icons.chevron_right, color: AppColors.textSecondary),
        onTap: () {},
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        tileColor: const Color(0xFFb7e4c7),
      ),
    );
  }
}
