// ignore_for_file: library_private_types_in_public_api

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

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({super.key});

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  String _text = "Initial Text";

  @override
  void initState() {
    super.initState();
    _fetchUpdatedText();
  }

  Future<void> _fetchUpdatedText() async {
    // Simulate a delay and update the text
    final updatedText = await Future.delayed(
      const Duration(seconds: 3),
      () => "Text Updated!",
    );
    if (mounted) {
      setState(() {
        _text = updatedText;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          _text,
          style: const TextStyle(fontSize: 24),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: _fetchUpdatedText,
          child: const Text('Update Text'),
        ),
      ],
    );
  }
}
