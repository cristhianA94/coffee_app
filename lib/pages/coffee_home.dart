import 'package:coffee_app/models/coffee_model.dart';
import 'package:coffee_app/pages/coffee_list.dart';
import 'package:flutter/material.dart';

class CoffeeHome extends StatelessWidget {
  const CoffeeHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size sizeScreen = MediaQuery.of(context).size;

    return Scaffold(
        body: GestureDetector(
      // TODO Gesture Drag Arriba
      onVerticalDragUpdate: (details) {
        // TODO primaryDelta! < -20 arrastre largo hacia arriba
        if (details.primaryDelta! < -20) {
          Navigator.of(context).push(
            PageRouteBuilder(
              transitionDuration: const Duration(milliseconds: 650),
              pageBuilder: (context, animation, _) {
                return FadeTransition(
                  opacity: animation,
                  child: const CoffeeList(),
                );
              },
            ),
          );
        }
      },
      child: Stack(
        children: [
          SizedBox.expand(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.brown[700]!,
                    Colors.white,
                  ],
                  stops: const [0.05, 0.8],
                ),
              ),
            ),
          ),
          Positioned(
            height: sizeScreen.height * 0.4,
            left: 0,
            right: 0,
            top: sizeScreen.height * 0.2,
            child: Hero(
              tag: coffees[8].name,
              child: Image.asset(
                coffees[8].image,
                // fit: BoxFit.fitHeight,
              ),
            ),
          ),
          Positioned(
            height: sizeScreen.height * 0.5,
            left: 0,
            right: 0,
            top: sizeScreen.height * 0.28,
            child: Hero(
              tag: coffees[10].name,
              child: Image.asset(
                coffees[10].image,
                // fit: BoxFit.fill,
              ),
            ),
          ),
          Positioned(
            // width: sizeScreen.width * 0.5,
            height: sizeScreen.height,
            left: 0,
            right: 0,
            top: sizeScreen.height * 0.19,
            child: Hero(
              tag: coffees[7].name,
              child: Image.asset(
                coffees[7].image,
                fit: BoxFit.none,
              ),
            ),
          ),
          // *LOGO
          Positioned(
            height: 140,
            left: 0,
            right: 0,
            top: sizeScreen.height * 0.58,
            child: Hero(
              tag: coffees[2].name,
              child: Image.asset(
                'assets/logo.png',
                // fit: BoxFit.none,
              ),
            ),
          ),
          Positioned(
            height: sizeScreen.height,
            left: 0,
            right: 0,
            bottom: -sizeScreen.height * 0.82,
            child: Hero(
              tag: coffees[0].name,
              child: Image.asset(
                coffees[0].image,
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
