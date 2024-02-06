import 'package:dua/gsheet/dua_model.dart';
import 'package:dua/utils/utils.dart';
import 'package:flutter/material.dart';

class DuaDetailScreen extends StatelessWidget {
  DuaDetailScreen({super.key, required this.model});

  duaModel model;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    print(model.tarjum);
    return Scaffold(
      appBar: AppBar(
        title: Text(model.duaName),
        actions: [
          PopupMenuButton<String>(
            onSelected: (s) {},
            itemBuilder: (BuildContext context) {
              return {'Save', 'Share'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Stack(
          children: [
            SizedBox(
              height: size.height * .9,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Text('Read This Before When We Are Eating Some',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(
                      height: 20,
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            model.dua,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(model.tarjum, style: const TextStyle(fontSize: 20)),

                    ///This Textview only for give the space become of content overlap
                    SizedBox(
                      height: size.height * 0.1,
                    )
                  ],
                ),
              ),
            ),
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                  ),
                  child: Container(
                    width: size.width,
                    height: size.height * 0.07,
                    margin: const EdgeInsets.fromLTRB(0, 0, 0, 12),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.green),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                            onPressed: () {
                              snake(context,
                                  'Audio feature is currently under construction! Please Stay tune');
                            },
                            icon: const Icon(Icons.play_circle)),
                        IconButton(
                            onPressed: () {
                              snake(context,
                                  'Save feature is currently under construction! Please Stay tune');
                            },
                            icon: const Icon(Icons.bookmark)),
                        IconButton(
                            onPressed: () {
                              snake(context,
                                  'Share feature is currently under construction! Please Stay tune');
                            },
                            icon: const Icon(Icons.share)),
                      ],
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
