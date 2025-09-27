import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../providers/opportunity_provider.dart';
import '../../widgets/opportunity_card.dart';
import '../../utils/colors.dart';
import '../../utils/text_styles.dart';
import '../../utils/responsive_helper.dart';
import '../../data/dummy_data.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  final _searchController = TextEditingController();
  final _refreshController = RefreshController(initialRefresh: false);

  @override
  void dispose() {
    _searchController.dispose();
    _refreshController.dispose();
    super.dispose();
  }

  void _onRefresh() async {
    try {
      await Provider.of<OpportunityProvider>(context, listen: false)
          .refreshOpportunities();
      _refreshController.refreshCompleted();
    } catch (e) {
      print('Error refreshing opportunities: $e');
      _refreshController.refreshFailed();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Unable to refresh opportunities. Please try again.'),
            backgroundColor: AppColors.emergencyRed,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );
      }
    }
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
            _buildFilterChips(context),
            const SizedBox(height: 16),
            Expanded(
              child: _buildOpportunityList(context),
            ),
          ],
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
            'Discover',
            style: AppTextStyles.heading1,
          ),
          const Spacer(),
          IconButton(
            onPressed: () {
              _showFilterBottomSheet(context);
            },
            icon: const Icon(
              Icons.tune,
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
          hintText: 'Search for opportunities or services',
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
        onChanged: (value) {
          Provider.of<OpportunityProvider>(context, listen: false)
              .updateSearchQuery(value);
        },
      ),
    );
  }

  Widget _buildFilterChips(BuildContext context) {
    return Consumer<OpportunityProvider>(
      builder: (context, opportunityProvider, child) {
        return SizedBox(
          height: 40,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: ResponsiveHelper.getHorizontalPadding(context),
            children: [
              _buildFilterChip(
                'Location',
                opportunityProvider.selectedLocation,
                () => _showLocationFilter(context),
              ),
              const SizedBox(width: 12),
              _buildFilterChip(
                'Category',
                opportunityProvider.selectedCategory,
                () => _showCategoryFilter(context),
              ),
              const SizedBox(width: 12),
              _buildFilterChip(
                'Skills',
                opportunityProvider.selectedSkill,
                () => _showSkillFilter(context),
              ),
              const SizedBox(width: 12),
              if (opportunityProvider.selectedLocation != 'All Locations' ||
                  opportunityProvider.selectedCategory != 'All Categories' ||
                  opportunityProvider.selectedSkill != 'All Skills')
                _buildClearFiltersChip(context),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFilterChip(String label, String value, VoidCallback onTap) {
    final isActive = !value.startsWith('All');
    
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? AppColors.primaryGreen : AppColors.inputBackground,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isActive ? AppColors.primaryGreen : AppColors.dividerColor,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              isActive ? value : label,
              style: AppTextStyles.bodySecondaryMedium.copyWith(
                color: isActive ? Colors.black : AppColors.textPrimary,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
            const SizedBox(width: 4),
            Icon(
              Icons.keyboard_arrow_down,
              size: 16,
              color: isActive ? Colors.black : AppColors.textTertiary,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildClearFiltersChip(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Provider.of<OpportunityProvider>(context, listen: false).clearFilters();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.emergencyRed,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.clear,
              size: 16,
              color: Colors.white,
            ),
            const SizedBox(width: 4),
            Text(
              'Clear',
              style: AppTextStyles.bodySecondaryMedium.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOpportunityList(BuildContext context) {
    return Consumer<OpportunityProvider>(
      builder: (context, opportunityProvider, child) {
        if (opportunityProvider.isLoading) {
          return const Center(
            child: CircularProgressIndicator(
              color: AppColors.primaryGreen,
            ),
          );
        }

        final opportunities = opportunityProvider.filteredOpportunities;

        if (opportunities.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.search_off,
                  size: 64,
                  color: AppColors.textTertiary,
                ),
                const SizedBox(height: 16),
                Text(
                  'No opportunities found',
                  style: AppTextStyles.heading4.copyWith(
                    color: AppColors.textTertiary,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Try adjusting your search or filters',
                  style: AppTextStyles.bodySecondary,
                ),
              ],
            ),
          );
        }

        return SmartRefresher(
          controller: _refreshController,
          onRefresh: _onRefresh,
          header: const WaterDropHeader(
            complete: Icon(
              Icons.check,
              color: AppColors.primaryGreen,
            ),
            waterDropColor: AppColors.primaryGreen,
          ),
          child: ListView.builder(
            padding: const EdgeInsets.only(bottom: 100),
            itemCount: opportunities.length,
            itemBuilder: (context, index) {
              final opportunity = opportunities[index];
              return OpportunityCard(
                opportunity: opportunity,
                onApply: () {
                  opportunityProvider.applyToOpportunity(opportunity.id);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Applied to ${opportunity.title}!'),
                      backgroundColor: AppColors.successGreen,
                    ),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }

  void _showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.cardBackground,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Filters',
              style: AppTextStyles.heading3,
            ),
            const SizedBox(height: 24),
            _buildFilterSection('Location', DummyData.locationFilters, (value) {
              Provider.of<OpportunityProvider>(context, listen: false)
                  .updateLocationFilter(value);
            }),
            const SizedBox(height: 16),
            _buildFilterSection('Category', DummyData.categoryFilters, (value) {
              Provider.of<OpportunityProvider>(context, listen: false)
                  .updateCategoryFilter(value);
            }),
            const SizedBox(height: 16),
            _buildFilterSection('Skills', DummyData.skillFilters, (value) {
              Provider.of<OpportunityProvider>(context, listen: false)
                  .updateSkillFilter(value);
            }),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Provider.of<OpportunityProvider>(context, listen: false)
                          .clearFilters();
                      Navigator.pop(context);
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: AppColors.dividerColor),
                    ),
                    child: Text(
                      'Clear All',
                      style: AppTextStyles.buttonMedium.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryGreen,
                    ),
                    child: Text(
                      'Apply',
                      style: AppTextStyles.buttonMedium,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterSection(
    String title,
    List<String> options,
    Function(String) onSelected,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyles.heading4,
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: options.map((option) {
            return GestureDetector(
              onTap: () => onSelected(option),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.inputBackground,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.dividerColor),
                ),
                child: Text(
                  option,
                  style: AppTextStyles.bodySecondaryMedium,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  void _showLocationFilter(BuildContext context) {
    _showFilterDialog(
      context,
      'Select Location',
      DummyData.locationFilters,
      (value) {
        Provider.of<OpportunityProvider>(context, listen: false)
            .updateLocationFilter(value);
      },
    );
  }

  void _showCategoryFilter(BuildContext context) {
    _showFilterDialog(
      context,
      'Select Category',
      DummyData.categoryFilters,
      (value) {
        Provider.of<OpportunityProvider>(context, listen: false)
            .updateCategoryFilter(value);
      },
    );
  }

  void _showSkillFilter(BuildContext context) {
    _showFilterDialog(
      context,
      'Select Skill',
      DummyData.skillFilters,
      (value) {
        Provider.of<OpportunityProvider>(context, listen: false)
            .updateSkillFilter(value);
      },
    );
  }

  void _showFilterDialog(
    BuildContext context,
    String title,
    List<String> options,
    Function(String) onSelected,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.cardBackground,
        title: Text(
          title,
          style: AppTextStyles.heading4,
        ),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: options.length,
            itemBuilder: (context, index) {
              final option = options[index];
              return ListTile(
                title: Text(
                  option,
                  style: AppTextStyles.bodyMedium,
                ),
                onTap: () {
                  onSelected(option);
                  Navigator.pop(context);
                },
              );
            },
          ),
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
