import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Flutter Jalan!")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/image/silver.png", width: 150),
            const SizedBox(height: 20),
            const Text("Halo Nar", style: TextStyle(fontSize: 20)),
          ],
        ),
      ),
    );
  }
}
