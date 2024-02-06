import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LanguageSelectionScreen extends StatefulWidget {
  const LanguageSelectionScreen({super.key});

  @override
  State<LanguageSelectionScreen> createState() => _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen> {
  String? _selectedValue;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: const Text('Select Language'),),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Please Selected Language for Duas',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),),
            DropdownButton<String>(
              hint: _selectedValue == null ? const Text('Select Language') : Text(_selectedValue!) ,
              isExpanded: true,
              items: <String>['English', 'Arabic', 'Gujarati', 'Hindi'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (_) {
                setState(() {
                  _selectedValue = _;
                });
              },
            ),

            const SizedBox(height: 40),

            const Text('Please Selected Language for Dua name and tarjuma',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),),
            DropdownButton<String>(
              hint: _selectedValue == null ? const Text('Select Language') : Text(_selectedValue!) ,
              isExpanded: true,
              items: <String>['English', 'Arabic', 'Gujarati', 'Hindi'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (_) {
                setState(() {
                  _selectedValue = _;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
