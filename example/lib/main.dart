import 'package:flutter/material.dart';
import 'package:lightspeed/lightspeed.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _controller = HomeController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            BuildController<HomeState>(
              actions: {
                Initialize: (state) => Text('${state.value}', style: Theme.of(context).textTheme.headline4?.copyWith(color: Colors.blue)),
                Increment: (state) => Text('${state.value}', style: Theme.of(context).textTheme.headline4?.copyWith(color: Colors.green)),
                Decrement: (state) => Text('${state.value}', style: Theme.of(context).textTheme.headline4?.copyWith(color: Colors.red)),
              },
              controller: _controller,
              buildWhen: (state) => state.value < 5,
            ),
            _controller.build<HomeState>(actions: {
              Initialize: (state) => Text('${state.value}', style: Theme.of(context).textTheme.headline4?.copyWith(color: Colors.blue)),
              Increment: (state) => Text('${state.value}', style: Theme.of(context).textTheme.headline4?.copyWith(color: Colors.green)),
              Decrement: (state) => Text('${state.value}', style: Theme.of(context).textTheme.headline4?.copyWith(color: Colors.red)),
            }),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: _controller.increment,
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
          const SizedBox(width: 20),
          FloatingActionButton(
            onPressed: _controller.decrement,
            tooltip: 'Decrement',
            child: const Icon(Icons.remove),
          ),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class HomeController extends ValueNotifier<HomeState> {
  HomeController() : super(Initialize());

  void increment() => value = Increment(value.value + 1);
  void decrement() => value = Decrement(value.value - 1);
}

abstract class HomeState {
  final int value;

  HomeState(this.value);
}

class Initialize extends HomeState {
  Initialize() : super(0);
}

class Increment extends HomeState {
  Increment(int value) : super(value);
}

class Decrement extends HomeState {
  Decrement(int value) : super(value);
}
