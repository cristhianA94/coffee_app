import 'package:coffee_app/blocs/coffee_bloc.dart';
import 'package:coffee_app/pages/coffee_home.dart';
import 'package:flutter/material.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  runApp(MainCoffeeApp());
}

class MainCoffeeApp extends StatefulWidget {
  @override
  State<MainCoffeeApp> createState() => _MainCoffeeAppState();
}

class _MainCoffeeAppState extends State<MainCoffeeApp> {
  final bloc = CoffeeBloc();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      // home: CoffeeProvider(
      //   child: const CoffeeHome(),
      //   bloc: bloc,
      // ),
      home: const CoffeeHome(),
    );
  }
}
