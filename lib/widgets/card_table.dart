import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:geco/services/auth_service.dart';
import 'package:provider/provider.dart';

class CardTable extends StatelessWidget {
  const CardTable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final authService = Provider.of<AuthService>(context, listen: false);

    return Table(
      children: [
        TableRow(children: [
          _SingleCard(
            color: (authService.modulosAuth.contains('CRM'))
            ? Colors.blue
            : Colors.grey, 
            icon: Icons.volunteer_activism, 
            text: 'CRM',
            onPressed: (){
              if(authService.modulosAuth.contains('CRM')){
                Navigator.pushReplacementNamed(context, 'crm');
              }
            }
          ),
          _SingleCard(
            color: (authService.modulosAuth.contains('RES'))
            ? Colors.deepPurple
            : Colors.grey,
            icon: Icons.calendar_today, 
            text: 'Proyectos',
            onPressed: (){
              if(authService.modulosAuth.contains('RES')){
                Navigator.pushReplacementNamed(context, 'proyectos');
              }
            }
          )
          
        ]),
        TableRow(children: [
          _SingleCard(
            color: (authService.modulosAuth.contains('INV'))
            ? Colors.purple
            : const Color(0Xff979797), 
            icon: Icons.inventory_rounded, 
            text: 'Inventarios',
            onPressed: (){
              if(authService.modulosAuth.contains('INV')){
                Navigator.pushReplacementNamed(context, 'inventarios');
              }
            }
          ),
          _SingleCard(
            color: (authService.modulosAuth.contains('RST'))
            ? Colors.green
            : const Color(0Xff979797), 
            icon: Icons.restaurant, 
            text: 'Restaurante',
            onPressed: (){
              if(authService.modulosAuth.contains('RST')){
                Navigator.pushReplacementNamed(context, 'restaurante');
              }
            }
          )
        ])
      ],
    );
  }
}

class _SingleCard extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String text;
  final Function onPressed;

  const _SingleCard(
      {Key? key, required this.icon, required this.color, required this.text, required this.onPressed})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    var column = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          backgroundColor: color,
          child: IconButton(
            icon: Icon(icon),
            iconSize: 40,
            color: Colors.white,
            onPressed: (){
              onPressed();
            },
          ),
          radius: 40,
        ),
        const SizedBox(height: 10),
        Text(
          text,
          style: TextStyle(color: color, fontSize: 18),
        )
      ],
    );
    return _CardBackground(child: column);
  }
}

class _CardBackground extends StatelessWidget {
  final Widget child;
  const _CardBackground({Key? key, required this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(
            height: 140,
            decoration: BoxDecoration(
                //color: const Color(0xffb6dde0),
                color: Colors.white60,
                borderRadius: BorderRadius.circular(20)),
            child: child,
          ),
        ),
      ),
    );
  }
}
