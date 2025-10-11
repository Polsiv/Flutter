import 'package:fl_componentes/providers/ricky_morty_provider.dart';
import 'package:fl_componentes/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(AppState());

class AppState extends StatelessWidget {
    const AppState({super.key});

    @override
    Widget build(BuildContext context) {
        return MultiProvider(
            providers:
            [
              ChangeNotifierProvider(create: (_) => RickMortyProvider(), lazy: false,),
            ],
        child: MyApp(),
        );
    }
}

class MyApp extends StatelessWidget {

    const MyApp({super.key});

    @override
    Widget build(BuildContext context) {
    
        return MaterialApp(

          debugShowCheckedModeBanner: false,
          title: 'Material App',
          initialRoute: AppRoutes.initialRoute,
          routes: AppRoutes.getAppRoutes(),
          onGenerateRoute: AppRoutes.onGenerateRoute,
          theme: ThemeData.light().copyWith(
              primaryColor: Colors.indigo,
              appBarTheme: AppBarTheme(
                  backgroundColor: Colors.green,
                  elevation:0
              )
          ),
        );
    }
}


