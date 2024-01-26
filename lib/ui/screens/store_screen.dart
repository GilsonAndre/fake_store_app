import 'package:fake_store_app/ui/resources/strings.dart';
import 'package:flutter/material.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text(Strings.appName),
          backgroundColor: Colors.green,
        ),
        body: const _StoreScreenView(),
      ),
    );
  }
}

class _StoreScreenView extends StatefulWidget {
  const _StoreScreenView();

  @override
  State<_StoreScreenView> createState() => __StoreScreenViewState();
}

class __StoreScreenViewState extends State<_StoreScreenView> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Text('Hello'),
    );
  }
}
