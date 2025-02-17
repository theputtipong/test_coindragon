import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_coindragon/content_view.dart';
import 'package:test_coindragon/feat_cart/cart_view.dart';

import 'main.dart';

class Approute {
  static const routeHome = '/';
  static const content = '/content/';

  static Route onGenerateRoute(RouteSettings settings) {
    late Widget page;
    switch (settings.name) {
      case Approute.routeHome:
        page = const CartView();
      case Approute.content:
        page = ContentView(
          contentId: settings.arguments as int,
        );
      default:
        throw Exception('Unknown route: ${settings.name}');
    }

    return MaterialPageRoute<dynamic>(
      builder: (context) {
        return page;
      },
      settings: settings,
    );
  }

  // static List<GetPage> get routeList => [
  //       GetPage(
  //         name: Approute.routeHome,
  //         page: () => HomeView(),
  //         binding: BindingsBuilder(
  //           () {
  //             Get.put(LayoutController());
  //           },
  //         ),
  //       ),
  //     ];
}
