import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'dart:developer' as dev;

// Get current route path
String currentPath(BuildContext context) {
  final GoRouter router = GoRouter.of(context);
  final currentPath = router.routeInformationProvider.value.uri.toString();
  return currentPath;
}

bool showLeadingBackButton(BuildContext context) {
  final String path = currentPath(context);
  dev.log(path);
  // canPop() is the correct GoRouter API: it returns true whenever there is
  // at least one route below the current one that can be popped to.
  return GoRouter.of(context).canPop();
}

