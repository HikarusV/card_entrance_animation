import 'package:flutter/material.dart';
import 'package:test_anim/card_entrance_anim/test_anim.dart';
import 'package:test_anim/sliding_paralax/sliding_cards.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Menu(),
    );
  }
}

class Menu extends StatelessWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Labs'),
      ),
      body: Column(
        children: const [
          SizedBox(
            height: 20,
          ),
          MenuCard(
            title: 'Card Animation',
            pages: TestAnim(),
          ),
          SizedBox(
            height: 20,
          ),
          SlidingCardsView(),
        ],
      ),
    );
  }
}

class MenuCard extends StatelessWidget {
  const MenuCard({Key? key, required this.title, required this.pages})
      : super(key: key);
  final String title;
  final Widget pages;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.only(
        left: 20,
        right: 20,
        bottom: 20,
      ),
      decoration: const BoxDecoration(
        // color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            spreadRadius: 2,
          )
        ],
      ),
      child: Material(
        color: Colors.white,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => pages,
              ),
            );
          },
          child: Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.all(20),
            child: Text(title),
          ),
        ),
      ),
    );
  }
}
