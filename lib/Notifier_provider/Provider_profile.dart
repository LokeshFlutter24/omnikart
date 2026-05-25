import 'dart:io';

import 'package:flutter/material.dart';
import '../Services/Services_api/profile_api.dart';
import '../View_Models/Profile_model.dart';
import '../connectivity_service/connectivity_service.dart';

class ProfileProvider extends ChangeNotifier {
  bool isLoading = false;
  List<profilemodel> users = [];
  String errorMessage = '';

  final ConnectivityService _connectivityService;

  ProfileProvider(this._connectivityService) {
    // ✅ Internet status monitor करो
    _connectivityService.addListener(_onConnectivityChanged);
  }

  // ✅ Internet status change detect करो
  void _onConnectivityChanged() {
    if (_connectivityService.isConnected) {
      print('📡 Internet Back! Fetching data...');
      errorMessage = '';
      fetchUsers();
    } else {
      print('📡 Internet Gone!');
      errorMessage = 'No Internet Connection';
      notifyListeners();
    }
  }

  // ✅ User profile fetch करो
  Future<void> fetchUsers() async {
    // Internet check करो पहले
    if (!_connectivityService.isConnected) {
      errorMessage = 'No Internet Connection';
      notifyListeners();
      return;
    }

    isLoading = true;
    errorMessage = '';
    notifyListeners();

    try {
      // ✅ API call करो
      final userList = await ProfileApi.fetchUsersList();

      if (userList.isNotEmpty) {
        users = userList;
        errorMessage = '';
      } else {
        users = [];
        errorMessage = 'No users found';
      }
    } on SocketException {
      errorMessage = 'No Internet Connection';
      users = [];
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _connectivityService.removeListener(_onConnectivityChanged);
    super.dispose();
  }
}