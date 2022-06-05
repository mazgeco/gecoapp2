import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:geco/providers/login_form_provider.dart';
import 'package:geco/widgets/login_background.dart';
import 'package:geco/widgets/card_container.dart';
import 'package:geco/ui/input_decorations.dart';
import 'package:geco/services/services.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoginBackground(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 210),
              CardContainer(
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    const Text('Login', style: TextStyle(fontSize: 35, color: Colors.blueAccent)),
                    ChangeNotifierProvider(
                      create: (_) => LoginFormProvider(),
                      child: _LoginForm()
                    )
                  ],
                )
              )
            ],
          ),
      ),)
    );
  }
}

class _LoginForm extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final loginForm = Provider.of<LoginFormProvider>(context);

    return Form(
      key: loginForm.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          TextFormField(
            autocorrect: false,
            decoration: InputDecorations.authInputDecoration(
                hintText: 'usuario', 
                labelText: 'Usuario',
                prefixIcon:  Icons.person
            ),
            onChanged: (value) => loginForm.usuario = value,
            validator: (value) {
              return (value != null && value.isNotEmpty) 
                ? null
                : 'El usuario no puede estar vacío para el login';
            }
          ),
          TextFormField(
            autocorrect: false,
            obscureText: true,
            decoration: InputDecorations.authInputDecoration(
              hintText: '*********',
              labelText: 'Contraseña',
              prefixIcon: Icons.lock
            ),
            onChanged: (value) => loginForm.password = value,
            validator: (value) {
              return (value != null && value.isNotEmpty)
                ? null
                : 'La contraseña no puede estar vacía';
            }
          ),
          TextFormField(
            autocorrect: false,
            obscureText: true,
            maxLength: 4,
            decoration: InputDecorations.authInputDecoration(
              hintText: '****',
              labelText: 'PIN',
              prefixIcon: Icons.pin
            ),
            onChanged: (value) => loginForm.pin = value,
            validator: (value) {
              String pattern = r'^([0-9])*$';
              RegExp regExp  = RegExp(pattern);
              return (value != null && value.length == 4 && regExp.hasMatch(value))
              ? null
              : 'El valor ingresado no luce como un PIN';
            }
          ),
          const SizedBox(height: 10),
          MaterialButton(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            disabledColor: Colors.grey,
            elevation: 0,
            color: Colors.blueAccent,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
              child: const Text(
                'Ingresar',
                style: TextStyle(color: Colors.white)
              )
            ),  
            onPressed: loginForm.isLoading 
                ? null 
                : () async {
                //Como estoy dentro de un método hay que poner el listen en false
                final authService = Provider.of<AuthService>(context, listen: false);
                FocusScope.of(context).unfocus();
                if(!loginForm.isValidForm()) return;
                loginForm.isLoading = true;
                
                String? errorMessage = await authService.login(loginForm.usuario, loginForm.password, loginForm.pin);

                if(errorMessage == '' || errorMessage == null){
                  Navigator.pushReplacementNamed(context, 'modulos');
                }else{
                  NotificationsService.showSnackBar(errorMessage);
                  loginForm.isLoading = false;
                }
              }
          )
        ],
      )
    );
  }
}