class AppConfig {
  // API Configuration
  static const String baseUrl = String.fromEnvironment(
    'BASE_URL',
    defaultValue: 'https://your-hrms-site.com',
  );
  
  static const String apiVersion = 'api/method';
  
  // Endpoints
  static const String loginEndpoint = 'frappe.auth.get_logged_user';
  static const String logoutEndpoint = 'frappe.sessions.clear';
  
  // Push Notification Endpoints
  static const String registerDeviceEndpoint = 'frappe.push_notification.register_device';
  static const String unregisterDeviceEndpoint = 'frappe.push_notification.unregister_device';
  
  // Leave Endpoints
  static const String leaveListEndpoint = 'hrms.hr.doctype.leave_application.leave_application.get_leave_applications';
  static const String leaveCreateEndpoint = 'hrms.hr.doctype.leave_application.leave_application.create_leave_application';
  static const String leaveUpdateEndpoint = 'hrms.hr.doctype.leave_application.leave_application.update_leave_application';
  static const String leaveBalanceEndpoint = 'hrms.hr.doctype.leave_application.leave_application.get_leave_balance';
  
  // Expense Claim Endpoints
  static const String expenseListEndpoint = 'hrms.hr.doctype.expense_claim.expense_claim.get_expense_claims';
  static const String expenseCreateEndpoint = 'hrms.hr.doctype.expense_claim.expense_claim.create_expense_claim';
  
  // Attendance Endpoints
  static const String checkinEndpoint = 'hrms.hr.doctype.employee_checkin.employee_checkin.create_checkin';
  static const String attendanceListEndpoint = 'hrms.hr.doctype.attendance.attendance.get_attendance_list';
  static const String shiftRequestEndpoint = 'hrms.hr.doctype.shift_request.shift_request.create_shift_request';
  
  // Employee Profile Endpoints
  static const String employeeProfileEndpoint = 'hrms.hr.doctype.employee.employee.get_employee_profile';
  
  // Timeout Configuration
  static const Duration connectionTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
  
  // Storage Keys
  static const String userTokenKey = 'user_token';
  static const String userEmailKey = 'user_email';
  static const String userNameKey = 'user_name';
  static const String fcmTokenKey = 'fcm_token';
  static const String employeeIdKey = 'employee_id';
  
  // App Info
  static const String appName = 'HRMS Mobile';
  static const String appVersion = '1.0.0';
  
  // Get full API URL
  static String getApiUrl(String endpoint) {
    return '$baseUrl/$apiVersion/$endpoint';
  }
  
  // Get resource URL
  static String getResourceUrl(String doctype, String name) {
    return '$baseUrl/api/resource/$doctype/$name';
  }
}
