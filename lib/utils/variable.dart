import 'package:flutter/material.dart';
import 'package:flutterfirebase/screens/library.dart';

import '../inside screens/FacultyPage.dart';

const webScreenSize = 600;

List<Widget> homeScreenItems = [
  const libraryDept(),
  const facultyPage(),
  const Text('notifications'),
];
