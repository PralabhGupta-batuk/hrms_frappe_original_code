import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../services/api_client.dart';
import '../services/notification_service.dart';
import '../config/app_config.dart';

class AuthProvider with ChangeNotifier {
  final ApiClient _apiClient = ApiClient();
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  
  bool _isAuthenticated = false;
  bool _isLoading = false;
  String? _userEmail;
  String? _userName;
  String? _employeeId;
  String? _errorMessage;
  
  bool get isAuthenticated => _isAuthenticated;
  bool get isLoading => _isLoading;
  String? get userEmail => _userEmail;
  String? get userName => _userName;
  String? get employeeId => _employeeId;
  String? get errorMessage => _errorMessage;
  
  AuthProvider() {
    _checkAuthStatus();
  }
  
  Future<void> _checkAuthStatus() async {
    _isLoading = true;
    notifyListeners();
    
    try {
      final token = await _storage.read(key: AppConfig.userTokenKey);
      final email = await _storage.read(key: AppConfig.userEmailKey);
      final name = await _storage.read(key: AppConfig.userNameKey);
      final empId = await _storage.read(key: AppConfig.employeeIdKey);
      
      if (token != null && email != null) {
        _isAuthenticated = true;
        _userEmail = email;
        _userName = name;
        _employeeId = empId;
      }
    } catch (e) {
      _errorMessage = 'Error checking auth status: ${e.toString()}';
    }
    
    _isLoading = false;
    notifyListeners();
  }
  
  Future<bool> login(String username, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    
    try {
      final result = await _apiClient.login(username, password);
      
      if (result['success'] == true) {
        // Store user credentials
        await _storage.write(key: AppConfig.userEmailKey, value: username);
        await _storage.write(key: AppConfig.userTokenKey, value: 'token_placeholder');
        
        // Fetch user profile to get employee ID and name
        await _fetchUserProfile(username);
        
        _isAuthenticated = true;
        _userEmail = username;
        
        // Initialize notifications
        await NotificationService.initialize();
        
        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        _errorMessage = result['message'] ?? 'Login failed';
        _isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      _errorMessage = 'Login error: ${e.toString()}';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }
  
  Future<void> _fetchUserProfile(String email) async {
    try {
      final result = await _apiClient.callMethod(
        AppConfig.employeeProfileEndpoint,
        args: {'user': email},
      );
      
      if (result['success'] == true) {
        final data = result['data'];
        _userName = data['employee_name'];
        _employeeId = data['name'];
        
        await _storage.write(key: AppConfig.userNameKey, value: _userName);
        await _storage.write(key: AppConfig.employeeIdKey, value: _employeeId);
      }
    } catch (e) {
      debugPrint('Error fetching user profile: $e');
    }
  }
  
  Future<void> logout() async {
    _isLoading = true;
    notifyListeners();
    
    try {
      await _apiClient.logout();
      await NotificationService.unregisterToken();
      await _storage.deleteAll();
      
      _isAuthenticated = false;
      _userEmail = null;
      _userName = null;
      _employeeId = null;
    } catch (e) {
      _errorMessage = 'Logout error: ${e.toString()}';
    }
    
    _isLoading = false;
    notifyListeners();
  }
  
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
