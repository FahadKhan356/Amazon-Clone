import 'dart:convert';

import 'package:amazon_clone_1/constants/Utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void ErrorHandling({
  required BuildContext context,
  required http.Response response,
  required void onsuccess(),
}) {
  switch (response.statusCode) {
    case 200:
      onsuccess();
      break;
    case 400:
      showSnackbar(context, jsonDecode(response.body)['msg']);
      break;
    case 500:
      showSnackbar(context, jsonDecode(response.body)['error']);
      break;
    default:
      showSnackbar(context, response.body);
  }
}
