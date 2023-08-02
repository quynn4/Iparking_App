import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ipacking_app/http_overrides.dart';
import 'package:ipacking_app/src/app.dart';
import 'package:ipacking_app/src/shared/blocs_app/supervisor_bloc.dart';
import 'injection_container.dart' as inject;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();

  // Plugin must be initialized before using
  await inject.init();
  Bloc.observer = SupervisorBloc();

  runApp(const MyApp());
}
