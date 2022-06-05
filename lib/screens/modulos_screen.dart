import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:geco/services/auth_service.dart';
import 'package:geco/widgets/background.dart';
import 'package:geco/widgets/card_table.dart';
import 'package:geco/widgets/page_title.dart';

class ModulosScreen extends StatelessWidget {
  const ModulosScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final authService = Provider.of<AuthService>(context, listen: false);

    return Scaffold(
      body: Stack(
        children: [
          //Background
          const Background(),
          //Home body scroll pad
          _HomeBody()
        ],
      ),
      floatingActionButton: _boton(context, authService),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat
    );
  }

  Widget _boton(BuildContext context, AuthService authService) {
    return FloatingActionButton(
      elevation: 0,
      backgroundColor: const Color.fromRGBO(62, 66, 107, 0.7),
      child: const Icon(Icons.exit_to_app_sharp, size: 30),
      onPressed: () {
        authService.logout();
        Navigator.pushReplacementNamed(context, 'login');
      },
    );
  }
}

class _HomeBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      children: const [
        SizedBox(height: 20),
        //Títulos
        PageTitle(),
        SizedBox(height: 40),
        //Card Table
        CardTable()
      ],
    ));
  }
}
