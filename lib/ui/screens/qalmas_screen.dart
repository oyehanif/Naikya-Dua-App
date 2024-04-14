import 'package:dua/ui/screens/dua_list_screen.dart';
import 'package:flutter/material.dart';

class QalmasScreen extends StatelessWidget {
  const QalmasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(centerTitle: true,title: const Text('Qalmas')),body: AllDuaList(isAllDua: true,isQalmas: true,));
  }
}
