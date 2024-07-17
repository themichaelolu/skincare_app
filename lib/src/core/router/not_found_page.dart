// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';

/// Simple not found screen used for 404 errors (page not found on web)
class NotFoundScreen extends StatelessWidget {
  /// Creates a new not found screen
  const NotFoundScreen({super.key, this.error, this.goHome,});
  final Exception? error;
  final VoidCallback? goHome;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                error != null ? '404 - Page not found!' : error.toString(),
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32.0),
              ElevatedButton(
                onPressed: () => goHome?.call(),
                child: const Text('Go Home'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
