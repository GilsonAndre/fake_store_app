import 'package:fake_store_app/data/bloc/store_bloc.dart';
import 'package:fake_store_app/ui/resources/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.appName),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: BlocBuilder<StoreBloc, StoreState>(
          builder: (context, state) {
            return const Column(
              children: [],
            );
         },
        ),
      ),
    );
  }
}
