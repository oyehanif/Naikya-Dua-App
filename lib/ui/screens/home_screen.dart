import 'package:dua/utils/daily_qoutes_helper.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../models/CategoryItemModel.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: InkWell(
            onTap: () => context.pushNamed("languageSelection"),
            child: const Text('Naikya')),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: mediaQuery.width,
              height: mediaQuery.height * .30,
              decoration: const BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40))),
              child: Container(
                  width: mediaQuery.width,
                  height: mediaQuery.height * .30,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  margin: EdgeInsets.all(mediaQuery.width * .10),
                  child: Center(child: Text(getMyQuote()))),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(24, 10, 0, 0),
              child: Text('Categorys',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10),
                itemBuilder: (context, index) => CategoryItemWidget(
                    model: list[index],
                    onTap: () {
                      if (list[index].name == 'Dua') {
                        context.pushNamed('duaList');
                      } else if (list[index].name == 'Qalmas') {
                        context.pushNamed('qalmas');
                      } else {
                        context.pushNamed('test', pathParameters: {
                          'test': list[index].name,
                        });
                      }
                    }),
                itemCount: list.length,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
              ),
            )
          ],
        ),
      ),
    );
  }
}

List list = [
  CategoryItemModel('Dua', 'Dua', 'dua.webp'),
  CategoryItemModel('Qalmas', 'Qalmas', 'qalma1.webp'),
  CategoryItemModel('MP3 Quran', 'MP3 Quran', 'quran.webp'),
  CategoryItemModel('Tasbih', 'Tasbih', 'tasbhi.webp'),
];

class CategoryItemWidget extends StatelessWidget {
  final CategoryItemModel model;

  const CategoryItemWidget(
      {super.key, required this.model, required this.onTap});

  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return test(model: model, onTap: onTap);
    //   InkWell(
    //   onTap: onTap,
    //   child: Container(
    //     decoration: BoxDecoration(
    //         image: DecorationImage(
    //           image: AssetImage('assets/${model.imageAssetsName}'),
    //           fit: BoxFit.fill,
    //         ),
    //         color: Colors.green,
    //         borderRadius: const BorderRadius.all(Radius.circular(10))),
    //     child: Row(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       crossAxisAlignment: CrossAxisAlignment.end,
    //       children: [
    //         Text(
    //           model.name,
    //           style: const TextStyle(color: Colors.white),
    //         )
    //       ],
    //     ),
    //   ),
    // );
  }
}

class test extends StatelessWidget {
  const test({super.key, required this.model, required this.onTap});

  final Function() onTap;
  final CategoryItemModel model;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Card(
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      clipBehavior: Clip.hardEdge,
      elevation: 16,
      child: InkWell(
        onTap: onTap,
        child: Stack(
          children: [
            Image.asset(
              'assets/${model.imageAssetsName}',
              fit: BoxFit.cover,
              height: 200,
              width: width,
            ),
            Positioned(
              left: 0,
              bottom: 0,
              right: 0,
              child: Container(
                color: Colors.black54,
                // padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 44),
                child: Text(
                  model.name,
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
