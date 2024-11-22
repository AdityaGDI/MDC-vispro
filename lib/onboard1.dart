import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Onboard1 extends StatelessWidget {
  const Onboard1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center( // Menggunakan Center untuk memastikan seluruh konten berada di tengah
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,  // Menjaga agar semua widget dalam Column terpusat secara vertikal
            crossAxisAlignment: CrossAxisAlignment.center, // Menjaga agar semua widget dalam Column terpusat secara horizontal
            children: [
              // Menggunakan Align untuk memastikan animasi berada di tengah
              Align(
                alignment: Alignment.center, // Menyusun widget Lottie di tengah
                child: Container(
                  height: MediaQuery.of(context).size.width > 600 ? 300 : 250,
                  width: MediaQuery.of(context).size.width > 600 ? 300 : 250,
                  child: Lottie.asset(
                    'assets/Bacot.json',
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(Icons.error, size: 100, color: Colors.red);
                    },
                  ),
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                'Welcome to FigureStore',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              const Text(
                'Explore a wide range of action figures and collectibles.',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
