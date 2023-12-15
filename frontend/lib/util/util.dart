import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frontend/providers.dart/is_loading_provider.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
    ),
  );
}

void httpErrorHandle({
  required http.Response response,
  required BuildContext context,
  required VoidCallback onSuccess,
}) {
  final isLoadingProvider =
      Provider.of<isLoadinProvider>(context, listen: false);
  switch (response.statusCode) {
    case 200:
      //Future.delayed(Duration(seconds: 2));
      if (isLoadingProvider.isloading == true) {
        isLoadingProvider.changeStatus();
      }
      onSuccess();

      break;
    case 400:
      //Future.delayed(Duration(seconds: 2));
      isLoadingProvider.changeStatus();
      showSnackBar(context, jsonDecode(response.body)['error']);
      break;
    case 500:
      //Future.delayed(Duration(seconds: 2));
      isLoadingProvider.changeStatus();
      showSnackBar(context, jsonDecode(response.body)['error']);
      break;
    default:
      showSnackBar(context, response.body);
  }
}

void httpErrorHandlerWithoutContext({
  required http.Response response,
  required BuildContext context,
  required VoidCallback onSuccess,
}) {
  final isLoadingProvider =
      Provider.of<isLoadinProvider>(context, listen: false);
  switch (response.statusCode) {
    case 200:
      //Future.delayed(Duration(seconds: 2));
      onSuccess();

      break;
    case 400:
      //Future.delayed(Duration(seconds: 2));

      break;
    case 500:
      //Future.delayed(Duration(seconds: 2));

      break;
    default:
      showSnackBar(context, response.body);
  }
}
