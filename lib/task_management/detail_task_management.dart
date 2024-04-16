import 'package:flutter/material.dart';

class DetailTaskManagement extends StatefulWidget {
  final String? nama;
  const DetailTaskManagement({super.key, this.nama});

  @override
  State<DetailTaskManagement> createState() => _DetailTaskManagementState();
}

class _DetailTaskManagementState extends State<DetailTaskManagement> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Task ${widget.nama}'),
      ),
      body: Center(
        child: TextButton(
          child: const Text('KE HALAMAN PAYMENT'),
          onPressed: () {

          },
        ),
      ),
    );
  }
}
