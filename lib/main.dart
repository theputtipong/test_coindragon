import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:test_coindragon/feat_cart/cart_view.dart';
// import 'package:test_coindragon/feat_cart/cart_viewmodel.dart';
import 'approute.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() {
  runApp(
    MaterialApp(
      // home: ChangeNotifierProvider(
      //   create: (context) => CounterViewModel(),
      //   child: const HomeView(),
      // ),
      home: Navigator(
        key: navigatorKey,
        initialRoute: Approute.routeHome,
        onGenerateRoute: Approute.onGenerateRoute,
      ),
      // home: ChangeNotifierProvider(
      //   create: (context) => CartViewModel(),
      //   child: const CartView(),
      // ),
    ),
  );
}

// class HomeView extends StatelessWidget {
//   const HomeView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final counter = Provider.of<CounterViewModel>(context, listen: false);
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Text(
//               'You have pushed the button this many times:',
//             ),
//             Consumer<CounterViewModel>(
//               builder: (_, value, __) => Text(
//                 counter._counter.toString(),
//               ),
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: counter.incrementCounter,
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }

// class CounterViewModel with ChangeNotifier {
//   int _counter = 0;

//   incrementCounter() {
//     _counter++;
//     notifyListeners();
//   }
// }
