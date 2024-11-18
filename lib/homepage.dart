import 'package:flutter/material.dart';

import 'exam_form_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Ujian Online ITTS'),
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text('Selamat datang di aplikasi Ujian Online ITTS!'),
              const SizedBox(height: 20),
              const Image(
                  height: 150,
                  width: 150,
                  image: AssetImage('assets/itts_logo.png')),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Navigate to the form page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ExamFormPage()),
                  );
                },
                child: const Text('Mulai Ujian'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
