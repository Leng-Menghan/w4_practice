import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: Home()),
    ),
  );
}

enum CardType {
  red(color: Colors.red),
  blue(color: Colors.blue),
  yellow(color: Colors.yellow),
  green(color: Colors.green);

  final Color color;
  const CardType({required this.color});
}

class ColorService extends ChangeNotifier{
  final Map<CardType, int> colorCount = {
    for(CardType type in CardType.values) type: 0,
  };

  void onTapIncrement(CardType type){
    colorCount[type] = colorCount[type]! + 1;
    notifyListeners();
  }

  int getCount(CardType type) => colorCount[type]!;
  
}

ColorService colorService = ColorService();

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _currentIndex == 0
          ? ColorTapsScreen()
          : StatisticsScreen(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.tap_and_play),
            label: 'Taps',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Statistics',
          ),
        ],
      ),
    );
  }
}

class ColorTapsScreen extends StatelessWidget {
  const ColorTapsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Color Taps')),
      body: Column(
        children: [
          ...CardType.values.map((c) => ColorTap(type: c)),
        ],
      ),
    );
  }
}

class ColorTap extends StatelessWidget {
  final CardType type;
  const ColorTap({
    super.key,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => colorService.onTapIncrement(type),
      child: Container(
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: type.color,
          borderRadius: BorderRadius.circular(10),
        ),
        width: double.infinity,
        height: 100,
        child: Center(
          child: ListenableBuilder(
            listenable: colorService,
            builder: (context, child) => Text(
              'Taps: ${colorService.getCount(type)}',
              style: TextStyle(fontSize: 24, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Statistics')),
      body: Center(
        child: ListenableBuilder(
          listenable: colorService,
          builder:(context, child) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ...CardType.values.map((c) => 
                Text('Number of $c = ${colorService.getCount(c)}', style: TextStyle(fontSize: 24)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
