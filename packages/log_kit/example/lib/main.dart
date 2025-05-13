import 'package:flutter/material.dart';
import 'package:log_kit/log_kit.dart';

void main() {
  // 初始化日志管理器
  LogManager().init(
    debugEnabled: true,
    consoleEnabled: true,
    fileEnabled: true,
    logFilePath: 'logs/app.log',
    tag: 'LogKitExample',
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Log Kit Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _logger = DefaultLogger('MyHomePage');
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
    
    // 记录不同级别的日志
    _logger.debug('Counter incremented to $_counter');
    _logger.info('Counter value: $_counter');
    
    if (_counter > 5) {
      _logger.warning('Counter is getting high: $_counter');
    }
    
    if (_counter > 10) {
      _logger.error(
        'Counter exceeded limit',
        Exception('Counter too high'),
        StackTrace.current,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Log Kit Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
} 