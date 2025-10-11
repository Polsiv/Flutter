import 'package:fl_componentes/router/app_router.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
 
 const HomeScreen({super.key});
 @override
 Widget build(BuildContext context) {

  final menuOptions = AppRoutes.menuOptions;

  return Scaffold(
     
    appBar: AppBar(
        title: const Text('Componentes en Flutter'),
        elevation: 0,
    ),


    body: ListView.separated(
      itemBuilder: (context, index) => ListTile(
        leading: Icon(menuOptions[index].icon),
        title: Text(menuOptions[index].name),
        onTap:() {
          Navigator.pushNamed(context, menuOptions[index].route);
         },
       ),
       separatorBuilder: (_, __) => Divider(),
       itemCount: menuOptions.length
    )
  );
 }
}
