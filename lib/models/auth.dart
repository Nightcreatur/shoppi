import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shopping_app/exception/http_exception.dart';

class Auth with ChangeNotifier {
  late String _token;
  late DateTime _expireyTime;
  late String _userId;

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
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signUp(String email, String password) async {
    _authenticate(email, password, 'signUp');
  }

  Future<void> logIn(String email, String password) async {
    _authenticate(email, password, 'signInWithPassword');
  }
}
