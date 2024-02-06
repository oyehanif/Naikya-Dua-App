import 'package:dua/framwork/controller/home/HomeController.dart';
import 'package:dua/gsheet/dua_model.dart';
import 'package:dua/gsheet/dua_sheets_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'home_screen.dart';

class DuaListScreen extends ConsumerStatefulWidget {
  const DuaListScreen({super.key});

  @override
  ConsumerState<DuaListScreen> createState() => _DuaListScreenState();
}

class _DuaListScreenState extends ConsumerState<DuaListScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(homeProvider.notifier).getAllDua();
  }

  @override
  Widget build(BuildContext context) {
    var result = ref.watch(homeProvider).productList;
    print("Here  : Result   ${result.toString()}");
    return Scaffold(
      appBar: AppBar(
        title: const Text('Duas List'),
      ),
      // body: FutureBuilder(
      //   builder:
      //       (BuildContext context, AsyncSnapshot<List<duaModel>> snapshot) {
      //     if (snapshot.connectionState == ConnectionState.waiting) {
      //       return const Center(
      //           child: CircularProgressIndicator(
      //         color: Colors.green,
      //       ));
      //     } else {
      //       if (snapshot.hasError) {
      //         return Center(child: Text('Error: ${snapshot.error}'));
      //       } else {
      //         return Padding(
      //           padding:
      //               const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
      //           child: GridView.builder(
      //             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      //                 crossAxisCount: 2,
      //                 crossAxisSpacing: 10,
      //                 mainAxisSpacing: 10),
      //             itemBuilder: (context, index) => CategoryItemWidget(
      //                 name: snapshot.data![index].duaName,
      //                 onTap: () {
      //                   context.pushNamed('details',
      //                       extra: snapshot.data![index]);
      //                 }),
      //             itemCount: snapshot.data!.length,
      //             physics: const NeverScrollableScrollPhysics(),
      //             shrinkWrap: true,
      //           ),
      //         ); // snapshot.data  :- get your object which is pass from your downloadData() function
      //       }
      //     }
      //   },
      //   future: DuaSheetsApi.getAllDua(),
      // ),

      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10),
          itemBuilder: (context, index) => CategoryItemWidget(
              name: result[index].duaName,
              onTap: () {
                context.pushNamed('details', extra: result[index]);
              }),
          itemCount: result.length,
         // physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
        ),
      ),
    );
  }
}
