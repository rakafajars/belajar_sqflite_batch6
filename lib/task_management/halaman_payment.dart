import 'package:belajar_sq_flite/task_management/success_page.dart';
import 'package:flutter/material.dart';

class HalamanPayment extends StatefulWidget {
  const HalamanPayment({super.key});

  @override
  State<HalamanPayment> createState() => _HalamanPaymentState();
}

class _HalamanPaymentState extends State<HalamanPayment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Halaman Payment'),
      ),
      body: Center(
        child: TextButton(
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => SuccessPage()),
              (route) => false,
            );
          },
          child: const Text(
            'Sukses Payment',
          ),
        ),
      ),
    );
  }
}
