import 'dart:ffi';

import 'package:dua/framwork/controller/home/HomeController.dart';
import 'package:dua/framwork/controller/quran/QuranController.dart';
import 'package:dua/route/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class QuranParaListScreen extends ConsumerStatefulWidget {
  const QuranParaListScreen({super.key});

  @override
  ConsumerState<QuranParaListScreen> createState() =>
      _QuranParaListScreenState();
}

class _QuranParaListScreenState extends ConsumerState<QuranParaListScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(quranProvider.notifier).getQuranList();
  }

  @override
  Widget build(BuildContext context) {
    var result = ref.watch(quranProvider).quranList;
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text('Quran Majid')),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: result.isEmpty
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemBuilder: (context, index) => QuranItem(
                  no: index + 1,
                  name: result[index].name,
                  onTap: () {
                    //context.pushNamed('details', extra: type);
                  },
                ),
                itemCount: result.length,
              ),
      ),
    );
  }
}

class QuranItem extends StatelessWidget {
  QuranItem(
      {super.key, required this.name, required this.no, required this.onTap});

  String name;
  int no;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        width: double.infinity,
        height: 75,
        child: Card(
          margin: const EdgeInsets.all(5),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.green,
                    )),
                child: Text(no.toString()),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    name,
                    style: const TextStyle(fontSize: 20),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
