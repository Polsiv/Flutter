import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'router/app_router.dart';
import 'providers/heroes_provider.dart';
import 'providers/multimedia_provider.dart';
import 'services/multimedia_service.dart'; // import del servicio
import 'core/http_client.dart'; // necesario para pasarlo al service

void main() {
  runApp(const AppState());
}

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<HeroesProvider>(
          create: (_) => HeroesProvider(),
          lazy: false,
        ),
        ChangeNotifierProvider<MultimediaProvider>(
          create: (_) => MultimediaProvider(MultimediaService(HttpClient())),
          lazy: true,
        ),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Héroes App',
      debugShowCheckedModeBanner: false,
      onGenerateRoute: AppRoutes.onGenerateRoute,
      initialRoute: AppRoutes.initialRoute,
      theme: ThemeData(
        colorSchemeSeed: Colors.deepPurple,
        useMaterial3: true,
      ),
    );
  }
}
