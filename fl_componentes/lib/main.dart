import 'package:flutter/material.dart';
import 'package:fl_componentes/screens/screens.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'Material App',

      //home: HomeScreen()

      initialRoute: 'home',

      routes: {
        'home': (BuildContext context) => const HomeScreen(),
        'alert': (BuildContext context) => const AlertScreen(),
        'card': (BuildContext context) => const CardScreen(),
        'listview1': (BuildContext context) => const Listview1Screen(),
        'listview2': (BuildContext context) => const Listview2Screen(),
      },

      onGenerateRoute: (settings) {
        //print(settings);

        return MaterialPageRoute(builder: (context) => const AlertScreen());
      },

      /*
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Material App Bar'),
        ),
        body: const Center(
          child: Text('Hola Mundo...'),
        ),
      ),
      */
    );
  }
}
