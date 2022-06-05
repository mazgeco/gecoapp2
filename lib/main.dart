import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:geco/screens/screens.dart';
import 'package:geco/services/services.dart';

void main() => runApp(const AppState());

class AppState extends StatelessWidget {
  const AppState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
        ChangeNotifierProvider(create: (_) => CasosService())
      ],
      child: const MyApp(),
    );
  }
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Geco App',
      initialRoute: 'checking',
      routes: {
        'login': (_) => const LoginScreen(),
        'checking': (_) => const CheckAuthScreen(),
        'modulos': (_) => const ModulosScreen(),
        'crm': (_) => const CRMScreen(),
        'casos': (_) => const ListaCasosScreen(),
        'proyectos':(_) => const ProyectosScreen(),
        'inventarios':(_) => const InventariosScreen(),
        'restaurante':(_) => const RestauranteScreen()
      },
      scaffoldMessengerKey: NotificationsService.messengerKey
    );
  }
}