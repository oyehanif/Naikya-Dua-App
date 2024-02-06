import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: InkWell(onTap:() => context.pushNamed("languageSelection"),child: const Text('Naikya')),
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
                  child: const Center(child: Text('Namaz qayaam karo !'))),
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
                itemBuilder: (context, index) =>
                    CategoryItemWidget(name: list[index], onTap: (){
                      list[index] == 'Dua' ? context.pushNamed('duaList') : context.pushNamed('test',pathParameters: {'test': list[index],});
                    }),
                itemCount: list.length,
                physics:const NeverScrollableScrollPhysics(),
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
  'Dua',
  'Qalms',
  'Namaz Alert',
  'Qibla Finder',
  'MP3 Quran',
  'Tasbih'
];

class CategoryItemWidget extends StatelessWidget {
  const CategoryItemWidget({super.key, required this.name, required this.onTap});

  final String name;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
          decoration: const BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Center(child: Text(name))),
    );
  }
}
