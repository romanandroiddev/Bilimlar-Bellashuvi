import 'dart:ffi';

import 'package:flutter/material.dart';

class Destination{
  const Destination(this.title, this.icon);
  final String title;
  final IconData icon;
}


const List<Destination> navGraph = <Destination>[
  Destination('Home', Icons.home),
  Destination('Business', Icons.person),
  Destination('School', Icons.settings),
];