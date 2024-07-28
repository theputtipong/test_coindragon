import 'package:flutter/material.dart';

import '../main.dart';

class ContentView extends StatelessWidget {
  final int contentId;
  const ContentView({super.key, required this.contentId});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) => navigatorKey.currentState?.pop(),
      child: Scaffold(
        body: Center(
          child: Text(
            'Content View $contentId',
          ),
        ),
      ),
    );
  }
}
