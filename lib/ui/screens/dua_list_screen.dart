import 'package:dua/framwork/controller/home/HomeController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class AllDuaList extends ConsumerStatefulWidget {
  const AllDuaList({super.key});

  @override
  ConsumerState<AllDuaList> createState() => _DuaListScreenState();
}

class _DuaListScreenState extends ConsumerState<AllDuaList> {
  @override
  void initState() {
    super.initState();
    ref.read(homeProvider.notifier).getAllDua();
  }

  @override
  Widget build(BuildContext context) {
    var result = ref.watch(homeProvider).productList;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: result.isEmpty
            ? const Center(
                child: CircularProgressIndicator(),
              )

            : ListView.builder(
                itemBuilder: (context, index) => DuaItem(
                  name: result[index].duaName,
                  onTap: () {
                    context.pushNamed('details', extra: result[index]);
                  },
                ),
                itemCount: result.length,
              ),
      ),
    );
  }
}

class DuaItem extends StatelessWidget {
  DuaItem({super.key, required this.name, required this.onTap});

  String name;
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
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                name,
                style: const TextStyle(fontSize: 20),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ),
      ),
    );
  }
}


