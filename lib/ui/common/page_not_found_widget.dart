import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nutrogen/utils/helper.dart';

class PageNotFoundPage extends StatelessWidget {
  const PageNotFoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'ʕ4ᴥ4ʔ',
              textAlign: TextAlign.center,
              style: theme.textTheme.displayLarge,
            ),
            Text(
              'Sorry, we couldn\'t find the page!',
              textAlign: TextAlign.center,
              style: theme.textTheme.headlineSmall,
            ),
            ElevatedButton(
              onPressed: () {
                if (context.canPop()) {
                  context.pop();
                } else {
                  context.go('/a');
                }
              },
              child: const Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }
}
