import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Onboard2 extends StatelessWidget {
  const Onboard2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Gunakan Lottie.asset untuk animasi JSON
                Lottie.asset(
                  'assets/Buy.json',  // Pastikan path-nya benar
                  height: MediaQuery.of(context).size.width > 600 ? 300 : 250,
                  width: MediaQuery.of(context).size.width > 600 ? 300 : 250,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.error, size: 100, color: Colors.red);
                  },
                ),
                const SizedBox(height: 30),
                const Text(
                  'Shop with Ease',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                const Text(
                  'Buy your favorite figures with just a few clicks.',
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
