import 'package:flutter/material.dart';

const double _initialPage = 0.0;

class CoffeeBloc {
  final pageController =
      PageController(viewportFraction: 0.35, initialPage: _initialPage.toInt());
  final pageTextController = PageController(initialPage: _initialPage.toInt());

  final currentPage = ValueNotifier<double>(_initialPage);
  final textPage = ValueNotifier<double>(_initialPage);

  void init() {
    currentPage.value = _initialPage;
    textPage.value = _initialPage;
    pageController.addListener(_coffeeScrollListener);
    pageTextController.addListener(_txtCoffeeScrollListener);
  }

  void dispose() {
    pageController.removeListener(_coffeeScrollListener);
    pageTextController.removeListener(_txtCoffeeScrollListener);
    pageController.dispose();
    pageTextController.dispose();
  }

  void _coffeeScrollListener() {
    currentPage.value = pageController.page!;
  }

  void _txtCoffeeScrollListener() {
    textPage.value = pageTextController.page!;
  }
}

class CoffeeProvider extends InheritedWidget {
  final CoffeeBloc? bloc;

  CoffeeProvider({required this.bloc, required Widget child})
      : super(child: child);

  static CoffeeProvider? of(BuildContext context) =>
      context.findAncestorWidgetOfExactType<CoffeeProvider>();

  @override
  bool updateShouldNotify(covariant CoffeeProvider oldWidget) => false;
}
