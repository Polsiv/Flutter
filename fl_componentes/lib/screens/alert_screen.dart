import 'package:flutter/material.dart';

class AlertScreen extends StatelessWidget {
   
  const AlertScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        title: const Text('Alert'),
        backgroundColor: Colors.red,
      ),

      body: Center(
         child: Text('AlertScreen'),
      ),
    );
  }
}