import 'package:flutter/material.dart';
import 'package:not_hesaplama/constant/app_constants.dart';
import 'package:not_hesaplama/widgets/ortalama_hesaplama_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Sabitler.anaRenk,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: OrtalamaHesaplama(),
    );
  }
}
