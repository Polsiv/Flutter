import 'package:flutter/material.dart';

class Listview1Screen extends StatelessWidget {

 const Listview1Screen({super.key});


 final options = const [
   'Megaman',
   'Metal Gear',
   'Super Smash',
   'Final Fantasy',
 ];

 @override
 Widget build(BuildContext context) {

  
   return Scaffold(
     appBar: AppBar(title: const Text('ListView Tipo1')),
     body: ListView(
      children:  [
        ...options.map(
          (juego) => ListTile(
            leading: Icon(Icons.access_time_sharp),
            title: Text(juego),
            trailing: Icon(Icons.arrow_forward_ios_outlined),
          ),
        ),
      ],
     )
   );
 }
}
