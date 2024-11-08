import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.blueAccent,
      ),
      home: const MyHomePage(title: ''),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Map> categories = [
    {"name": "Broom", "isChecked": false},
    {"name": "Minced Beef", "isChecked": false},
    {"name": "Sesame Oil", "isChecked": false},
    {"name": "Mouse Trap", "isChecked": false},
    {"name": "Spoons", "isChecked": false},
    {"name": "Cabinet", "isChecked": false},
    {"name": "Apple", "isChecked": false},
    {"name": "Wipes", "isChecked": false},
    {"name": "Puzzle", "isChecked": false},
    {"name": "A4 Paper", "isChecked": false},
    {"name": "Cinnamon", "isChecked": false},
    {"name": "Chili Flakes", "isChecked": false},
    {"name": "Toilet Paper", "isChecked": false},
  ];

  void _deleteItem(int index) {
    setState(() {
      categories.removeAt(index);
    });
  }

  void showOverlay(BuildContext context) {
    late OverlayEntry overlayEntry;
    overlayEntry = OverlayEntry(
      builder: (context) => Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              onTap: () {
                overlayEntry.remove();
              },
              child: Container(
                color: Colors.black.withOpacity(0.5),
              ),
            ),
          ),
          // Pop-up Dialog
          Positioned(
            top: MediaQuery.of(context).size.height * 0.4,
            left: MediaQuery.of(context).size.width * 0.1,
            child: Material(
              color: Colors.transparent,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.24,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Row(
                          children: [
                            Icon(
                              Icons.add_circle_outline,
                              size: 32.0,
                              color: Colors.blueAccent,
                            ),
                            SizedBox(width: 10),
                            Text(
                              "Add New Item",
                              style: TextStyle(
                                fontSize: 24,
                              ),
                            ),
                          ],
                        ),
                        IconButton(
                          icon: const Icon(
                              Icons.close,
                              color: Colors.red,
                              size: 18.0,
                          ),
                          onPressed: () {
                            overlayEntry.remove();
                          },
                        ),
                      ],
                    ),
                    const Divider(
                      color: Colors.black,
                    ),
                    const SizedBox(
                      height: 7.0,
                    ),
                    const TextField(
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blueAccent),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                        border: OutlineInputBorder(),
                        hintText: 'Enter things to the shopping list here!',
                      ),
                      cursorColor: Colors.blueAccent,
                      style: TextStyle(
                        color: Colors.blueAccent
                      ),
                    ),
                    const SizedBox(
                      height: 6.0,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        foregroundColor: Colors.white,
                        minimumSize: const Size.fromHeight(40),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)
                        )
                      ),
                      onPressed: () {},
                      child: const Text(
                        'Save',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
    Overlay.of(context).insert(overlayEntry);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.shopping_cart,
                    size: 40.0,
                    color: Colors.blueAccent,
                  ),
                  SizedBox(
                    width: 14.0,
                  ),
                  Text(
                    "Shopping List",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const Divider(
                color: Colors.black,
              ),
              Column(
                children: categories.asMap().entries.map((entry) {
                  int index = entry.key;
                  Map favorite = entry.value;
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Row(
                      children: [
                        Expanded(
                          child: CheckboxListTile(
                            activeColor: Colors.green,
                            onChanged: (val) {
                              setState(() {
                                favorite['isChecked'] = val ?? false;
                              });
                            },
                            value: favorite['isChecked'],
                            title: Text(
                              favorite['name'] ?? '',
                              style: TextStyle(
                                fontSize: 20,
                                decoration: favorite['isChecked']
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _deleteItem(index),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 100,
        color: Colors.blueAccent,
        child: InkWell(
          onTap: () => showOverlay(context),
          child:
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(top: 3.0),
                child: const Icon(
                  Icons.add_box,
                  color: Colors.white,
                  size: 70.0,
                ),
              ),
              const Text(
                'Add New Item',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}