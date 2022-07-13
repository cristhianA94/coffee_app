import 'package:flutter/material.dart';

import 'package:coffee_app/pages/coffee_detail.dart';
import 'package:coffee_app/models/coffee_model.dart';

import 'package:coffee_app/blocs/coffee_bloc.dart';

import 'package:logger/logger.dart';

class CoffeeList extends StatefulWidget {
  const CoffeeList({
    Key? key,
  }) : super(key: key);

  @override
  State<CoffeeList> createState() => _CoffeeListState();
}

const _duration = Duration(milliseconds: 600);
const double _initialPage = 0.0;

class _CoffeeListState extends State<CoffeeList> {
  // For Logs
  var logger = Logger();

  final pageImagesController =
      PageController(viewportFraction: 0.35, initialPage: _initialPage.toInt());
  final pageTextController = PageController(initialPage: _initialPage.toInt());

  double currentPage = _initialPage;
  double textPage = _initialPage;

  @override
  void initState() {
    // final bloc = CoffeeProvider.of(context)?.bloc;
    // bloc?.init();
    pageImagesController.addListener(_coffeeScrollListener);
    pageTextController.addListener(_txtCoffeeScrollListener);
    super.initState();
  }

  @override
  void dispose() {
    // final bloc = CoffeeProvider.of(context)?.bloc;
    // bloc?.dispose();
    pageImagesController.removeListener(_coffeeScrollListener);
    pageTextController.removeListener(_txtCoffeeScrollListener);
    pageImagesController.dispose();
    pageTextController.dispose();
    super.dispose();
  }

  void _coffeeScrollListener() {
    setState(() {
      currentPage = pageImagesController.page!;
    });
  }

  void _txtCoffeeScrollListener() {
    setState(() {
      textPage = pageTextController.page!;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size sizeScreen = MediaQuery.of(context).size;
    // final bloc = CoffeeProvider.of(context)?.bloc;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(
          color: Colors.black,
        ),
      ),
      body: Stack(
        children: [
          // * Pagination Name and price coffee
          _paginationNamePriceCoffee(sizeScreen),
          // * Shadow bottom
          Positioned(
            left: 0,
            right: 0,
            bottom: -sizeScreen.height * 0.35,
            height: sizeScreen.height * 0.33,
            child: DecoratedBox(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.brown[700]!,
                    blurRadius: 80,
                    offset: Offset.zero,
                    spreadRadius: 110,
                  ),
                ],
              ),
            ),
          ),
          // * Paginacion Imagenes
          // ValueListenableBuilder<double>(
          //   valueListenable: bloc!.currentPage,
          //   builder: (context, currentPage, _) {
          //     return;
          //   },
          // ),
          Transform.scale(
            scale: 1.7,
            alignment: Alignment.bottomCenter,
            child: PageView.builder(
              controller: pageImagesController,
              scrollDirection: Axis.vertical,
              itemCount: coffees.length,
              onPageChanged: (value) {
                // * Permite vincular los 2 pages controllers
                if (value < coffees.length) {
                  pageTextController.animateToPage(value,
                      duration: _duration, curve: Curves.easeOut);
                }
              },
              itemBuilder: (context, index) {
                if (index == 0) {
                  // Espacio en 1º posicion
                  return const SizedBox.shrink();
                }
                // -1 para compensar el antes insertado
                final coffee = coffees[index - 1];
                final result = currentPage - index + 1;
                // Para manejar la posicion con su escala
                // 2 -> 0.2
                // 1 -> 0.6
                // 0 -> 1.0
                final value = -0.4 * result + 1;
                // logger.i(value);
                final opacity = value.clamp(0.0, 1.0);

                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        transitionDuration: const Duration(milliseconds: 650),
                        pageBuilder: (context, animation, _) {
                          return FadeTransition(
                            opacity: animation,
                            child: CoffeeDetail(coffee: coffee),
                          );
                        },
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 25),
                    child: Transform(
                      alignment: Alignment.bottomCenter,
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, 0.001)
                        ..translate(
                            0.0, sizeScreen.height / 2.6 * (1 - value).abs())
                        ..scale(value),
                      child: Opacity(
                        opacity: opacity,
                        child: Hero(
                          tag: coffee.name,
                          child: Image.asset(
                            coffee.image,
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Positioned _paginationNamePriceCoffee(Size sizeScreen) {
    return Positioned(
      left: 0,
      top: 0,
      right: 0,
      height: 100,
      // *Animation Text Face to Top
      child: TweenAnimationBuilder<double>(
        duration: _duration,
        tween: Tween(begin: 1.0, end: 0.0),
        builder: (BuildContext context, value, Widget? child) =>
            Transform.translate(
          offset: Offset(0.0, -100 * value),
          child: child,
        ),
        child:
            // ValueListenableBuilder<double>(
            //   valueListenable: bloc!.textPage,
            //   builder: (context, textPage, _) {
            //     return;
            //   },
            // ),
            Column(
          children: [
            Expanded(
              child: PageView.builder(
                itemCount: coffees.length,
                controller: pageTextController,
                // No permite hacer scroll
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final double opacity =
                      (1 - (index - textPage).abs()).clamp(0.0, 1.0);
                  return Opacity(
                    opacity: opacity,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: sizeScreen.width * 0.2),
                      child: Hero(
                        tag: 'text_${coffees[index].name}',
                        child: Material(
                          child: Text(
                            coffees[index].name,
                            // maxLines: 2,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.w900,
                              // shadows: [
                              //   BoxShadow(
                              //       color: Colors.brown[700]!,
                              //       blurRadius: 10,
                              //       spreadRadius: 10)
                              // ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 15),
            AnimatedSwitcher(
              key: Key(coffees[currentPage.toInt()].name),
              duration: _duration,
              // Tmp Animation que se van
              reverseDuration: Duration(milliseconds: 1000),
              switchInCurve: Curves.easeIn,
              switchOutCurve: Curves.easeOut,
              // transitionBuilder: (child, animation) => ScaleTransition(
              //   scale: animation,
              //   child: Center(child: child),
              // ),
              // transitionBuilder: (child, animation) => RotationTransition(
              //   turns: animation,
              //   child: Center(child: child),
              // ),
              // reverseDuration: Duration(milliseconds: 300),
              // transitionBuilder: (child, animation) => SizeTransition(
              //   sizeFactor: animation,
              //   child: Center(child: child),
              // ),
              child: Text(
                '\$ ${coffees[currentPage.toInt()].price.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 25),
              ),
            )
          ],
        ),
      ),
    );
  }
}
