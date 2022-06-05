import 'package:flutter/material.dart';

class InventariosScreen extends StatelessWidget {
  const InventariosScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inventarios'),
        backgroundColor: Colors.blueAccent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: (){
            //authService.logout();
            Navigator.pushReplacementNamed(context, 'modulos');
          }
        ),
      ),
      body: Container()
    );
  }
}