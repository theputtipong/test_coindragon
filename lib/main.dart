// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:get/get.dart';

final navigatorKey = GlobalKey<NavigatorState>();

final layOut = Get.find<LayoutController>();

enum ScreenSize { small, normal, large, extraLarge }

ScreenSize getSize(BuildContext context) {
  final deviceWidth = MediaQuery.sizeOf(context).shortestSide;
  if (deviceWidth > 900) return ScreenSize.extraLarge;
  if (deviceWidth > 600) return ScreenSize.large;
  if (deviceWidth > 300) return ScreenSize.normal;
  return ScreenSize.small;
}

void main() {
  runApp(
    const MaterialApp(
      home: ShowMySimpleAnimation(),
      //   home: ChangeNotifierProvider(
      //     create: (context) => CounterViewModel(),
      //     child: const HomeView(),
      //   ),
      // home: Navigator(
      //   key: navigatorKey,
      //   initialRoute: Approute.routeHome,
      //   onGenerateRoute: Approute.onGenerateRoute,
      // ),
      // home: ChangeNotifierProvider(
      //   create: (context) => CartViewModel(),
      //   child: const CartView(),
      // ),
    ),
    // GetMaterialApp(
    //   initialBinding: BindingsBuilder(
    //     () {
    //       Get.lazyPut<LayoutController>(() => LayoutController());
    //     },
    //   ),
    //   initialRoute: Approute.routeHome,
    //   getPages: Approute.routeList,
    // ),
  );
}

// // class HomeView extends StatelessWidget {
// class HomeView extends GetResponsiveView<LayoutController> {
//   HomeView({super.key});

//   @override
//   Widget builder() {
//     return Scaffold(
//       body: handleScrWithPlatform(),
//     );
//   }

//   handleScrWithPlatform() {
//     if (GetPlatform.isMobile) {
//       return const Center(
//         child: Text(
//           'this screen style support with mobile',
//         ),
//       );
//     } else {
//       //GetPlatform.isDesktop
//       return const Center(
//         child: Text(
//           'this screen style support with desktop',
//         ),
//       );
//     }
//   }
// }

class ShowMySimpleAnimation extends StatefulWidget {
  const ShowMySimpleAnimation({super.key});

  @override
  _ShowMySimpleAnimationState createState() => _ShowMySimpleAnimationState();
}

class _ShowMySimpleAnimationState extends State<ShowMySimpleAnimation> {
  bool selected = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: context.mediaQuery.size.width,
        height: context.mediaQuery.size.height,
        child: Stack(alignment: Alignment.center, children: [
          AnimatedPositioned(
            width: selected ? 200.0 : 50.0,
            height: selected ? 50.0 : 200.0,
            top: selected ? 50.0 : 150.0,
            duration: const Duration(seconds: 2),
            curve: Curves.fastOutSlowIn,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selected = !selected;
                });
              },
              child: const ColoredBox(
                color: Colors.blue,
                child: Center(child: Text('Tap me')),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

// class CounterViewModel with ChangeNotifier {
//   int _counter = 0;

//   incrementCounter() {
//     _counter++;
//     notifyListeners();
//   }
// }

// Future<void> initUniLinks(BuildContext context) async {
//   try {
//     await getInitialLink();
//     linkStream.listen((String? link) {
//       SchedulerBinding.instance.addPostFrameCallback((_) {
//         if (link != null) {
//           Navigator.pushNamed(context, Approute.content, arguments: int.parse(link));
//         }
//       });
//     }, onError: (err) {});
//   } on PlatformException {
//     if (kDebugMode) {
//       print("PlatformException");
//     }
//   }
// }

// class ButtonTxtAndIcon extends StatelessWidget {
//   final Color? buttonColor;
//   final double? buttonHeight;
//   final double? buttonWidth;
//   final String? text;
//   final TextStyle? textStyle;
//   final IconData? icon;
//   final double? iconSize;
//   final Color? iconColor;
//   final VoidCallback? onTap;
//   const ButtonTxtAndIcon(
//       {super.key,
//       this.buttonColor,
//       this.buttonHeight,
//       this.buttonWidth,
//       this.text,
//       this.textStyle,
//       this.icon,
//       this.iconSize,
//       this.iconColor,
//       this.onTap});

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: onTap,
//       child: Container(
//         color: buttonColor ?? Colors.blue,
//         height: buttonHeight,
//         width: buttonWidth,
//         padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//         child: Row(
//           children: [
//             Icon(
//               icon ?? Icons.broken_image,
//               color: iconColor ?? Colors.white,
//               size: iconSize ?? 10,
//             ),
//             Text(
//               text ?? '',
//               style: textStyle,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class LayoutController extends GetxController {
  var screenWidth = 0.0.obs;
  var screenHeight = 0.0.obs;

  void updateDimensions(double width, double height) {
    screenWidth.value = width;
    screenHeight.value = height;
  }
}
