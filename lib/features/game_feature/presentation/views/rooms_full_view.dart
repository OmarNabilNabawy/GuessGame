import 'package:flutter/material.dart';
import 'package:guess/constants.dart';

class RoomsFullView extends StatelessWidget {
  const RoomsFullView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'This Room Is Full',
              style: TextStyle(fontSize: 28),
            ),
            const SizedBox(
              height: 5,
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: TextButton.styleFrom(foregroundColor: kPrimaryColor),
              child: const Text(
                'Try Again In Another Room',
                style: TextStyle(fontSize: 16),
              ),
            )
          ],
        ),
      ),
    );
  }
}
