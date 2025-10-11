import 'package:fl_componentes/providers/ricky_morty_provider.dart';
import 'package:fl_componentes/router/app_router.dart';
import 'package:fl_componentes/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'services/services.dart';
import 'package:fl_componentes/providers/heroes_provider.dart';

void main() => runApp( AppState());

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {

    return MultiProvider(providers:[
      ChangeNotifierProvider(create: (_) => RickMortyProvider(), lazy: false,),
      ChangeNotifierProvider(create: ( _ ) => AuthService()),     
      ChangeNotifierProvider(create: (_) => HeroesProvider()),
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
      scaffoldMessengerKey: NotificationsService.messengerKey,

      initialRoute: AppRoutes.initialRoute,

      
      routes: AppRoutes.getAppRoutes(),

    
      onGenerateRoute: AppRoutes.onGenerateRoute,


      theme: AppTheme.lightTheme,

     
    );
  }
}