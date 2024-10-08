import 'package:flutter/material.dart';
import 'package:shop_catalog/models/shop_item.dart';
import 'package:shop_catalog/pages/account.dart';
import 'package:shop_catalog/pages/favourite.dart';
import 'models/global_data.dart';
import 'pages/catalog.dart';
GlobalData appData = GlobalData();
void main() {
  runApp(const MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int selectedIndex = 0;
  List<Widget> pages = [Catalog(), Favourite(), AccountPage()];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple, brightness: Brightness.dark),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Barbershop App"),
        ),
        body: pages[selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          items:const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.cut), label: "Стрижки"),
            BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Избранные"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Профиль")
          ],
          selectedItemColor: Colors.deepPurple,
          currentIndex: selectedIndex,
          useLegacyColorScheme: true,
          onTap: (int barItemIndex) => {
            setState(() {
              selectedIndex = barItemIndex;
            })
          },
          ),
      ),
    );
  }
}

