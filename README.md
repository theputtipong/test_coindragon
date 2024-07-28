# Widget Lifecycle

---

## Explain the lifecycle of a StatefulWidget. What are the key lifecycle methods you need to be aware of, and when do you use them?

1.createState
When a new "StatefulWidget" is created "createState" is called after that before "initState"
is called.
2.initState
This function is called only once in the lifecycle and the method will have a context
available (though it is not recommended to use it because some data may still be
initializing).
3.didChangeDependencies
This function is called after "initState" completes and will be called again whenever the
data that affects the widget is updated.
4.didUpdateWidget
This function is called when the parent widget changes and requires the widget to re-draw
the UI will used when want to compare the oldWidget parameter with the current widget to
see if there are any differences.
5.build
Used to create the widget and if you want it to re-build you can do so by calling "setState".
6.deactivate
Called when an object is removed from the tree before dispose is called.
7.dispose
Called when a widget is about to disappear from the screen.
Should be overridden to clean up resources (e.g., listeners, controllers).

---

## Given the following scenario, which lifecycle method would you use and why?

### You need to fetch data from an API when the widget is first created but not on subsequent rebuilds.

I will use initState because it runs only once when the StatefulWidget is first created.

@override
void initState() {
// TODO: implement fetch API function
super.initState();
}

---

# State Management

---

## Consider you are using the Provider package. How would you structure your app to manage the state of a shopping cart? Describe your approach and the classes you would create.

about feat cart i will create 3 class like MVVM (Disregard the counting class productmodel and class store because a part that complements the cart.)

1. class model cart for manage object
   - in this class i will use it to handle store and in store i will use it to handle product with display on view.
2. class view for display with STL
   - in this class i will use it to display what i have in cart.
   - view by group store with total price and total quantity for each store.
   - and user can selected store or product to pay with this bill or not.
3. class viewmodel (controller) with handle every action
   - in this class i will use it to handle cart function add , remove , payType , deliveryType (express , normal or other) or selected store or product to pay per bill.
   - function cal total price and total quantity only user selected store or product to pay per bill.

code example

---

## Explain the concept of ChangeNotifier and why it is used in Flutter state management. Provide an example of how you would implement it in a simple counter app.

ChangeNotifier It is a class that notifies changes to its listeners in other words If something is ChangeNotifier You can subscribe to its changes.

We use it because if we want to change the value in a specific widget ChangeNotifier can be do but using setStage will re-render with build method.

code example
void main() {
runApp(
MaterialApp(
home: ChangeNotifierProvider(
create: (context) => CounterViewModel(),
child: const HomeView(),
),
),
);
}

class HomeView extends StatelessWidget {
const HomeView({super.key});

@override
Widget build(BuildContext context) {
final counter = Provider.of<CounterViewModel>(context, listen: false);
return Scaffold(
body: Center(
child: Column(
mainAxisAlignment: MainAxisAlignment.center,
children: [
const Text(
'You have pushed the button this many times:',
),
Consumer<CounterViewModel>(
builder: (_, value, __) => Text(
counter._counter.toString(),
),
),
],
),
),
floatingActionButton: FloatingActionButton(
onPressed: counter.incrementCounter,
child: const Icon(Icons.add),
),
);
}
}

class CounterViewModel with ChangeNotifier {
int \_counter = 0;

incrementCounter() {
\_counter++;
notifyListeners();
}
}

# Performance Optimization

---

## You notice that your Flutter app is janky and has performance issues. What steps would you take to diagnose and improve the app's performance?

run app with profile mode and view with Flutter DevTools

- If it about performance
  1 Analyze CPU and mem usage looking for unusual resource usage such as mem management or heavy computation when opening problematic pages.
  2 Look at ListView or others as a builder or not.
  3 Declare variables correctly: const,final

- If it about jerky
  1 Check that the frame rate of the page where the problem was found, whether it is abnormal with other pages or not
  2 See if it's because of the gif or animation.

---

## Explain the difference between RepaintBoundary and RenderObject. How do you use RepaintBoundary to optimize performance in a Flutter application?

RenderObject is Flutter low-level rendering system that manages the layout and drawing of widgets within the render tree, but RepaintBoundary ensures that only subtrees within it bounds are repainted for improving render performance.

I might use RepaintBoundary for widget animations or widgets that change frequently (either with lag or when action is taken) inside a complex widget.

---

# Navigation and Routing

---

## Describe how you would implement deep linking in a Flutter application. What are the key components involved, and how would you handle different routes?

For example, an app content. In the case where we define a deep link to be able to open content via an id, when the user clicks on the specified url link, there will be an option to open the app, consisting of scheme = "https" host = "yourhostname.com" pathPattern = "/content/.\*" and if we want to manage the path to various pages, we will create a function to check before running the app. I will use the lib uni_links2 to check the param of the url before routing to various points.

//lib uni_links2
code example

void main() {
runApp(
MaterialApp(
home: ChangeNotifierProvider(
create: (context) => CounterViewModel(),
child: const HomeView(),
),
),
);
}

class HomeView extends StatelessWidget {
const HomeView({super.key});

@override
Widget build(BuildContext context) {
final counter = Provider.of<CounterViewModel>(context, listen: false);
initUniLinks(context);
return Scaffold(
body: Center(
child: Column(
mainAxisAlignment: MainAxisAlignment.center,
children: [
const Text(
'You have pushed the button this many times:',
),
Consumer<CounterViewModel>(
builder: (_, value, __) => Text(
counter._counter.toString(),
),
),
],
),
),
floatingActionButton: FloatingActionButton(
onPressed: counter.incrementCounter,
child: const Icon(Icons.add),
),
);
}
}

class CounterViewModel with ChangeNotifier {
int \_counter = 0;

incrementCounter() {
\_counter++;
notifyListeners();
}
}

Future<void> initUniLinks(BuildContext context) async {
try {
await getInitialLink();
linkStream.listen((String? link) {
SchedulerBinding.instance.addPostFrameCallback((\_) {
if (link != null) {
Navigator.pushNamed(context, Approute.content, arguments: int.parse(link));
}
});
}, onError: (err) {});
} on PlatformException {
if (kDebugMode) {
print("PlatformException");
}
}
}

---

## Explain how you would manage navigation state in a complex app with nested navigators. What are some best practices to follow?

i will create class approute and declare routename and function onGenerateRoute.
i use class becuase it easy when review code for MA or improve
and this best practice

code example

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
}

final navigatorKey = GlobalKey<NavigatorState>();
void main() {
runApp(
MaterialApp(
home: Navigator(
key: navigatorKey,
initialRoute: Approute.routeHome,
onGenerateRoute: Approute.onGenerateRoute,
),
),
);
}

class ContentView extends StatelessWidget {
final int contentId;
const ContentView({super.key, required this.contentId});
@override
Widget build(BuildContext context) {
return PopScope(
onPopInvoked: (didPop) => navigatorKey.currentState?.pop(),
child: Scaffold(
body: Center(
child: Text(
'Content View $contentId',
),
),
),
);
}
}

## PS. I usually with GoRoute lib or Get lib because it's a lot more time-saving and easy to MA later.

# Custom Widgets and UI

---

## You are tasked with creating a custom reusable widget for a button that has an icon and text, with customizable colors and sizes. How would you implement this? Provide a code example.

I'm not sure if the color and size is for any widget part so i let it be included for all parts, buttons, text, and icons.

code example

class ButtonTxtAndIcon extends StatelessWidget {
final Color? buttonColor;
final double? buttonHeight;
final double? buttonWidth;
final String? text;
final TextStyle? textStyle;
final IconData? icon;
final double? iconSize;
final Color? iconColor;
final VoidCallback? onTap;
const ButtonTxtAndIcon(
{super.key,
this.buttonColor,
this.buttonHeight,
this.buttonWidth,
this.text,
this.textStyle,
this.icon,
this.iconSize,
this.iconColor,
this.onTap});

@override
Widget build(BuildContext context) {
return InkWell(
onTap: onTap,
child: Container(
color: buttonColor ?? Colors.blue,
height: buttonHeight,
width: buttonWidth,
padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
child: Row(
children: [
Icon(
icon ?? Icons.broken_image,
color: iconColor ?? Colors.white,
size: iconSize ?? 10,
),
Text(
text ?? '',
style: textStyle,
),
],
),
),
);
}
}

---

## Explain how you would implement a responsive layout in Flutter to support different screen sizes and orientations, including tablets and foldable devices.

i will use Get lib to handle this case for check from tablet and foldable or mobile

code example
final scrWidth = Get.size.width;
final scrHeight = Get.size.height;

---

# Animations

---

## Describe the differences between implicit and explicit animations in Flutter. Provide an example of when you would use each type and why.

---

## You need to create a complex animation that involves multiple elements moving and changing size simultaneously. How would you approach this in Flutter? Explain your solution and provide a code example if possible.

---

# Testing / QC

---

## How do you write a unit test for a function that fetches data from an API in Flutter? Describe the process and provide a code example.

---

## Explain the concept of widget testing in Flutter. How would you test a widget that has a button which, when pressed, fetches data and displays it? Provide a code example.

---

# Coin Dragon Code Analysis

## 1. getWallet() vs getWalletStream()

### 1. Based on the above code sample, what can you tell me about the difference between getWallet() and getWalletStream()? What are good reasons to use one over the other?

---

## 2. Erroneous Widget

### 2. Identify the mistake in the above code and explain why it is incorrect.

---

## 3. Asynchronous setState sample

### 3. Identify the potential issue in the above code and explain why it is incorrect. Provide a solution to fix the issue.

---

## 4.1 WSConnector Class (use of WebSocketChannel library)

### 4.1 Can you briefly describe what you see in the above code snippet?

### 4.2 Can you explain the above code? What is \_initWsConnection()'s function? What happens when \_wsConnector.start() is executed?

---
