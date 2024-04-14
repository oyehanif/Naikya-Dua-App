import 'package:dua/framwork/controller/home/HomeController.dart';
import 'package:dua/route/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class AllDuaList extends ConsumerStatefulWidget {
   AllDuaList({super.key,required this.isAllDua,this.isQalmas = false});

  bool isAllDua;
  bool isQalmas = false;

  @override
  ConsumerState<AllDuaList> createState() => _DuaListScreenState();
}

class _DuaListScreenState extends ConsumerState<AllDuaList> {
  @override
  void initState() {
    super.initState();
    widget.isQalmas ? ref.read(homeProvider.notifier).getALlQalmas() : ref.read(homeProvider.notifier).getAllDua();
  }

  @override
  Widget build(BuildContext context) {
    var result = widget.isQalmas ? ref.watch(homeProvider).qalmasList : widget.isAllDua ?  ref.watch(homeProvider).allDuaList : ref.watch(homeProvider).favDuaList;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: result.isEmpty ? widget.isAllDua ? const Center(
                child: CircularProgressIndicator(),
              ) : const Padding(
                padding: EdgeInsets.all(16.0),
                child: Center(child: Text("There is no favorite dua yet GoTo > All Duas > Click on your Fav Dua > Click on save to see"),),
              )

            : ListView.builder(
                itemBuilder: (context, index) => DuaItem(
                  name: result[index].duaName,
                  onTap: () {
                    final type = MyDuaDetailCustomType(model: result[index], isQalmas: widget.isQalmas, isClick: (){
                      widget.isQalmas ? ref.read(homeProvider.notifier).getALlQalmas() : ref.read(homeProvider.notifier).getAllDua();
                    });
                    // context.pushNamed('details', extra: result[index]);
                    context.pushNamed('details', extra: type);
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


