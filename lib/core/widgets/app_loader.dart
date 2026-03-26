import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class AppLoader extends StatelessWidget {
  const AppLoader({super.key, this.message, this.fullScreen = false});

  final String? message;
  final bool fullScreen;

  @override
  Widget build(BuildContext context) {
    final loader = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const CircularProgressIndicator(),
        if (message != null) ...[
          const SizedBox(height: 12),
          Text(message!, style: const TextStyle(fontSize: 14)),
        ],
      ],
    );

    if (!fullScreen) {
      return Center(child: loader);
    }

    return Container(
      color: Colors.black.withOpacity(0.2),
      alignment: Alignment.center,
      child: ShadCard(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: loader,
      ),
    );
  }
}
