import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:safe/constants/environment.dart';
import 'package:safe/di/app.module.dart';
import 'package:safe/widgets/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  await Firebase.initializeApp(options: firebaseOptions);
  runApp(App());
}
