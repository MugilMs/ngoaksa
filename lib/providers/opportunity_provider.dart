import 'package:flutter/foundation.dart';
import '../models/opportunity.dart';
import '../data/dummy_data.dart';

class OpportunityProvider extends ChangeNotifier {
  List<Opportunity> _allOpportunities = [];
  List<Opportunity> _filteredOpportunities = [];
  Map<String, bool> _appliedOpportunities = {};
  bool _isLoading = false;
  
  // Filter states
  String _selectedLocation = 'All Locations';
  String _selectedCategory = 'All Categories';
  String _selectedSkill = 'All Skills';
  String _searchQuery = '';

  List<Opportunity> get allOpportunities => _allOpportunities;
  List<Opportunity> get filteredOpportunities => _filteredOpportunities;
  List<Opportunity> get featuredOpportunities => DummyData.featuredOpportunities;
  Map<String, bool> get appliedOpportunities => _appliedOpportunities;
  bool get isLoading => _isLoading;
  
  String get selectedLocation => _selectedLocation;
  String get selectedCategory => _selectedCategory;
  String get selectedSkill => _selectedSkill;
  String get searchQuery => _searchQuery;

  OpportunityProvider() {
    _loadOpportunities();
  }

  Future<void> _loadOpportunities() async {
    _isLoading = true;
    notifyListeners();

    try {
      // Simulate API call delay
      await Future.delayed(const Duration(milliseconds: 500));
      
      _allOpportunities = [
        ...DummyData.featuredOpportunities,
        ...DummyData.discoverOpportunities,
      ];
      _filteredOpportunities = List.from(_allOpportunities);
    } catch (e) {
      debugPrint('Error loading opportunities: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> refreshOpportunities() async {
    await _loadOpportunities();
  }

  void applyToOpportunity(String opportunityId) {
    _appliedOpportunities[opportunityId] = true;
    notifyListeners();
  }

  bool hasApplied(String opportunityId) {
    return _appliedOpportunities[opportunityId] ?? false;
  }

  void updateSearchQuery(String query) {
    _searchQuery = query;
    _applyFilters();
  }

  void updateLocationFilter(String location) {
    _selectedLocation = location;
    _applyFilters();
  }

  void updateCategoryFilter(String category) {
    _selectedCategory = category;
    _applyFilters();
  }

  void updateSkillFilter(String skill) {
    _selectedSkill = skill;
    _applyFilters();
  }

  void clearFilters() {
    _selectedLocation = 'All Locations';
    _selectedCategory = 'All Categories';
    _selectedSkill = 'All Skills';
    _searchQuery = '';
    _applyFilters();
  }

  void _applyFilters() {
    _filteredOpportunities = _allOpportunities.where((opportunity) {
      // Search query filter
      if (_searchQuery.isNotEmpty) {
        final query = _searchQuery.toLowerCase();
        if (!opportunity.title.toLowerCase().contains(query) &&
            !opportunity.description.toLowerCase().contains(query) &&
            !opportunity.organization.toLowerCase().contains(query)) {
          return false;
        }
      }

      // Location filter
      if (_selectedLocation != 'All Locations') {
        if (!opportunity.location.contains(_selectedLocation)) {
          return false;
        }
      }

      // Category filter (simplified mapping)
      if (_selectedCategory != 'All Categories') {
        // This would normally be based on opportunity categories
        // For demo, we'll use a simple mapping
        if (_selectedCategory == 'Environmental' && 
            !opportunity.title.toLowerCase().contains('tree') &&
            !opportunity.title.toLowerCase().contains('garden') &&
            !opportunity.title.toLowerCase().contains('environment')) {
          return false;
        }
      }

      // Skill filter
      if (_selectedSkill != 'All Skills') {
        if (!opportunity.skills.contains(_selectedSkill)) {
          return false;
        }
      }

      return true;
    }).toList();

    notifyListeners();
  }

  List<Opportunity> getUrgentOpportunities() {
    return _allOpportunities.where((opportunity) => opportunity.isUrgent).toList();
  }

  List<Opportunity> getOpportunitiesByType(OpportunityType type) {
    return _allOpportunities.where((opportunity) => opportunity.type == type).toList();
  }
}
