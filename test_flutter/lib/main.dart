import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:test_flutter/bloc/home/home_bloc.dart';
import 'package:test_flutter/ui/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
      home: LoaderOverlay(
          child: BlocProvider(
    create: (context) => HomeBloc(),
    child: homePageContainer(),
  ))));
}
