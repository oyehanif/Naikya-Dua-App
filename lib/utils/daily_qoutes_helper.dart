import 'dart:math';
final quotesList = [
  'Namaz qayaam karo !',
  'Nind se bhetar namaz he',
  'ek cup 100 sukh',
];

String getMyQuote() => quotesList[ Random().nextInt(quotesList.length)];
