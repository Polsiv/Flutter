import 'package:fl_componentes/screens/screens.dart';
import 'package:flutter/material.dart';


class HomeScreen extends StatelessWidget {
 
 const HomeScreen({super.key});
  @override
 Widget build(BuildContext context) {
   return Scaffold(
     
     appBar: AppBar(
       title: const Text('Componentes en Flutter'),
       elevation: 0,
     ),


     body: ListView.separated(
       itemBuilder: (context, index) => ListTile(
         leading: Icon(Icons.lock_clock,color: Colors.red,),
         title: Text('Nombre de Ruta N'),
         onTap:() {
           //Ojo con GetX

           final route = MaterialPageRoute(
            builder:(context) => Listview1Screen(),);


           //Navigator.push(context, route);


           //Navigator.pushReplacement(context, route);


           Navigator.pushNamed(context, 'listview2');


         },
       ),
       separatorBuilder: (_, __) => Divider(),
       itemCount: 6)
     /*
     body: const Center(
        child: Text('HomeScreen'),
     ),
     */
   );
 }
}
