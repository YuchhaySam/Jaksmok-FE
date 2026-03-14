// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes, avoid_renaming_method_parameters, constant_identifier_names

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>?> load(String path, Locale locale) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> _en_US = {
  "errors": {
    "global": {
      "no_internet": "No internet connection",
      "unauthorized": "Unauthorized",
      "server_error": "Internal server error",
      "unknown": "Unknown error"
    },
    "auth": {
      "invalid_credential": "Invalid credential"
    },
    "book": {
      "not_found": "Book not found"
    }
  },
  "login": {
    "title": "WELCOME",
    "button": "Login",
    "user": {
      "label": "Username",
      "hint": "Enter username",
      "error": "Username is required"
    },
    "password": {
      "label": "Password",
      "hint": "Enter password",
      "error": "Password is required"
    }
  },
  "home": {
    "title": "HOME",
    "empty_list": "No books avaiable"
  },
  "book_detail": {
    "title": "BOOK DETAIL",
    "country": "Country",
    "language": "Language",
    "pages": "Pages"
  }
};
static const Map<String, Map<String,dynamic>> mapLocales = {"en_US": _en_US};
}
