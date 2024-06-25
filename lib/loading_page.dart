import 'package:flutter/material.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('images/logo.png', width: 100, height: 100),
            const SizedBox(height: 20),
            const Text('KASHIRO',
                style: TextStyle(fontSize: 24, color: Colors.black)),
          ],
        ),
      ),
    );
  }
}
