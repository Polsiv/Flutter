//import 'package:fl_componentes/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:fl_componentes/router/app_router.dart';


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

         
         //leading: Icon(Icons.lock_clock,color: Colors.red,),
         leading: Icon(menuOptions[index].icon,color: Colors.red,),

         //title: Text('Nombre de Ruta NN'),
         title: Text(menuOptions[index].name),

         onTap:() {
           //Ojo con GetX

           //final route = MaterialPageRoute(
           // builder:(context) => Listview1Screen(),);


           //Navigator.push(context, route);


           //Navigator.pushReplacement(context, route);


           //Navigator.pushNamed(context, 'listview2');
           Navigator.pushNamed(context, menuOptions[index].route);


         },
       ),
       separatorBuilder: (_, __) => Divider(),
       //itemCount: 6
       itemCount: menuOptions.length)
     /*
     body: const Center(
        child: Text('HomeScreen'),
     ),
     */
   );
 }
}
