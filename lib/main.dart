import 'package:flutter/material.dart';
import 'package:stickers/pages/selecao_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'World Cup 2022',
      routes: {
        'selecaoPage': (context) => SelecaoPage(title: 'World Cup 2022'),
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SelecaoPage(title: 'World Cup 2022'),
    );
  }
}
