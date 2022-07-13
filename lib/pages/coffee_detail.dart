import 'package:coffee_app/models/coffee_model.dart';
import 'package:flutter/material.dart';

class CoffeeDetail extends StatefulWidget {
  const CoffeeDetail({Key? key, required this.coffee}) : super(key: key);

  final Coffee coffee;

  @override
  State<CoffeeDetail> createState() => _CoffeeDetailState();
}

class _CoffeeDetailState extends State<CoffeeDetail> {
  late Coffee coffee;

  @override
  void initState() {
    coffee = widget.coffee;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size sizeScreen = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(
          color: Colors.black,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: sizeScreen.width * 0.2),
            child: Hero(
              tag: 'text_${coffee.name}',
              child: Material(
                child: Text(
                  coffee.name,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      BoxShadow(
                          color: Colors.brown[700]!,
                          blurRadius: 10,
                          spreadRadius: 10)
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
          // * Image
          SizedBox(
            height: sizeScreen.height * 0.4,
            child: Stack(
              children: [
                // * Image
                Positioned.fill(
                  child: Hero(
                    tag: coffee.name,
                    child: Image.asset(
                      coffee.image,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
                Positioned(
                  left: sizeScreen.width * 0.05,
                  bottom: 0,
                  // *Animation Price
                  child: TweenAnimationBuilder<double>(
                    duration: const Duration(milliseconds: 700),
                    tween: Tween(begin: 1.0, end: 0.0),
                    builder:
                        (BuildContext context, double value, Widget? child) {
                      return Transform.translate(
                        offset: Offset(200 * value, -540 * value),
                        child: child,
                      );
                    },
                    child: Text(
                      '\$ ${coffee.price.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 50,
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        shadows: [
                          BoxShadow(
                            color: Colors.black45,
                            blurRadius: 20,
                            spreadRadius: 40,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
