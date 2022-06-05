import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:geco/screens/screens.dart';
import 'package:geco/services/auth_service.dart';

class CheckAuthScreen extends StatelessWidget {
  const CheckAuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final authService = Provider.of<AuthService>(context, listen: false);

    const boxDecoration = BoxDecoration(
      color: Color(0xff036077)
    );

    return Scaffold(
      body: Container(
        decoration: boxDecoration,
        child: FutureBuilder(
          future: authService.readToken(),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot){
            if(!snapshot.hasData) return const Page();

            if(snapshot.data == '') {
              Future.microtask(() {
                Navigator.pushReplacement(context, PageRouteBuilder(
                  pageBuilder: (_,__,___) => const LoginScreen(),
                  transitionDuration: const Duration(seconds: 0)
                ));
              });
            } else {
              Future.microtask(() {
              Navigator.pushReplacement(context, PageRouteBuilder(
                pageBuilder: (_,__,___) => const ModulosScreen(),
                transitionDuration: const Duration(seconds: 0)
              ));
            });
            }
            return const Page();
          },
        )
      ),
    );
  }
}


class Page extends StatelessWidget {
  const Page({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: const Icon(Icons.hourglass_top, size: 60, color: Colors.white),
    );
  }
}