//import 'package:fl_componentes/models/menu_option.dart';
import 'package:flutter/material.dart';
import 'package:fl_componentes/screens/screens.dart';
import 'package:fl_componentes/models/models.dart';

class AppRoutes {
  static const initialRoute = 'login';

  static final menuOptions = <MenuOption>[

    MenuOption(route: 'listview1', name: 'List View Tipo 1',screen: const Listview1Screen(),icon: Icons.list, ),
    MenuOption(route: 'listview2', name: 'List View Tipo 2',screen: const Listview2Screen(),icon: Icons.list_alt_outlined, ),
    MenuOption(route: 'alert', name: 'Alerta',screen: const AlertScreen(),icon: Icons.align_vertical_bottom, ),
    MenuOption(route: 'card', name: 'Tarjetas',screen: const CardScreen(),icon: Icons.credit_card,  ),
    MenuOption(route: 'prueba', name: 'Prueba',screen: const PruebaScreen(),icon: Icons.access_alarm, ),
    MenuOption(route: 'login', name: 'Login', screen: const LoginScreen(),icon: Icons.login, ),
    MenuOption(route: 'usuario', name: 'Usuario',screen: const UsuarioScreen(),icon: Icons.person, ),
    MenuOption(route: 'registro', name: 'Registro', screen : const RegisterScreen(), icon: Icons.app_registration,),
    MenuOption(route: 'listar_heroes', name: 'Heroes', screen : const HeroesListScreen(), icon: Icons.app_registration,),
  ];


  static Map<String, Widget Function(BuildContext)> getAppRoutes(){

    Map<String, Widget Function(BuildContext)> appRoutes = {};

    appRoutes.addAll({ 'home' : ( BuildContext context ) => const HomeScreen() });
    appRoutes.addAll({ 'login1' : ( BuildContext context ) => const Login1Screen() });

    for (final option in menuOptions){
      appRoutes.addAll({option.route: (BuildContext context) => option.screen});
    }

    return appRoutes;
  }

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case 'heroes_detalle':
      final heroId = settings.arguments as int;
      return MaterialPageRoute(
        builder: (_) => HeroDetailScreen(heroId: heroId),
      );

    default:
      return MaterialPageRoute(
        builder: (_) => const AlertScreen(),
      );
  }
}

}
