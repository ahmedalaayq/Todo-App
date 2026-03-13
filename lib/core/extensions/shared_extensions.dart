import 'package:flutter/material.dart';
extension Capitalize on String {
  String get capitalizeEachWord {
    return split(' ')
        .map(
          (e) => e.trim().isNotEmpty
              ? e[0].toUpperCase() + e.substring(1).toLowerCase()
              : '',
        )
        .join(' ');
  }
}
extension Navigation<T> on BuildContext {

  Future<T?> push(Widget route) {
    return Navigator.push(
      this,
      MaterialPageRoute(builder: (_) => route),
    );
  }

  Future<T?> pushReplacement(Widget route) {
    return Navigator.pushReplacement(
      this,
      MaterialPageRoute(builder: (_) => route),
    );
  }

  Future<T?> pushAndRemoveUntil({
    required Widget navigationRoute,
    String? stopRouteName,
  }) {
    return Navigator.pushAndRemoveUntil(
      this,
      MaterialPageRoute(builder: (_) => navigationRoute),
      stopRouteName != null
          ? ModalRoute.withName(stopRouteName)
          : (route) => false,
    );
  }

  void pop<T>([T? result]) {
    Navigator.pop(this, result);
  }

  Future<T?> pushNamed(String routeName) {
    return Navigator.pushNamed(this, routeName);
  }

  Future<T?> pushReplacementNamed(String routeName) {
    return Navigator.pushReplacementNamed(this, routeName);
  }

  Future<T?> pushNamedAndRemoveUntil({
    required String routeName,
    String? stopRouteName,
  }) {
    return Navigator.pushNamedAndRemoveUntil(
      this,
      routeName,
      stopRouteName != null
          ? ModalRoute.withName(stopRouteName)
          : (route) => false,
    );
  }
}