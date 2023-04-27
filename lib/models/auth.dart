import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_app/exception/http_exception.dart';

class Auth with ChangeNotifier {
  String? _token;
  DateTime? _expiryTime;
  String? _userId;
  Timer? authTimer;

  bool get isAuth {
    return token != null;
  }

  String? get userID {
    return _userId;
  }

  String? get token {
    if (_expiryTime != null &&
        _expiryTime!.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
  }

  Future<void> logout() async {
    _token = null;
    _expiryTime = null;
    _userId = null;
    if (authTimer != null) {
      authTimer!.cancel();
      authTimer = null;
    }
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('userData');
    notifyListeners();
  }

  void autoLogout() {
    if (authTimer != null) {
      authTimer!.cancel();
    } else {}
    final timeToExpire = _expiryTime!.difference(DateTime.now()).inSeconds;
    Timer(Duration(seconds: timeToExpire), logout);
  }

  Future<void> _authenticate(
      String email, String password, String method) async {
    final url = Uri.https(
      'identitytoolkit.googleapis.com',
      '/v1/accounts:$method',
      {'key': 'AIzaSyCbHsB7yBS86XljG1netJR1Px5TkYMDTn0'},
    );
    try {
      final reponse = await http.post(
        url,
        body: json.encode(
          {
            'email': email,
            'password': password,
            'returnSecureToken': true,
          },
        ),
      );

      final responseData = json.decode(reponse.body);

      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
      _token = responseData['idToken'];
      _userId = responseData['localId'];
      _expiryTime = DateTime.now().add(
        Duration(
          seconds: int.parse(responseData['expiresIn']),
        ),
      );
      autoLogout();

      notifyListeners();
      final pref = await SharedPreferences.getInstance();

      final userData = json.encode({
        'token': _token,
        'userId': _userId,
        'expiryDate': _expiryTime!.toIso8601String(),
      });
      pref.setString('userData', userData);
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> autoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }
    final extractionData =
        json.decode(prefs.getString('userData')!) as Map<String, dynamic>;
    final expiryDate = DateTime.parse(extractionData['expiryDate']);

    if (expiryDate.isBefore(DateTime.now())) {
      return false;
    }
    _token = extractionData['token'];
    _userId = extractionData['userId'];
    _expiryTime = expiryDate;
    notifyListeners();
    autoLogout();
    return true;
  }

  Future<void> signUp(String email, String password) async {
    return _authenticate(email, password, 'signUp');
  }

  Future<void> logIn(String email, String password) async {
    return _authenticate(email, password, 'signInWithPassword');
  }
}
