import 'package:fake_store_app/data/bloc/store_bloc.dart';
import 'package:fake_store_app/ui/resources/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        body: BlocProvider(
          create: (context) => StoreBloc(),
          child: const _StoreScreenView(),
        ),
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
    return Scaffold(
      body: Center(
        child: BlocBuilder<StoreBloc, StoreState>(
          builder: (context, state) {
            if (state.productStatus == StoreResquest.initial) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(Strings.welcome),
                  OutlinedButton(
                    onPressed: () {
                      context.read<StoreBloc>().add(StoreProductRequest());
                    },
                    child: const Text(Strings.buttonInitial),
                  ),
                ],
              );
            }

            if (state.productStatus == StoreResquest.requestInProgress) {
              return const CircularProgressIndicator();
            }

            if (state.productStatus == StoreResquest.requestError) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(Strings.errorMessage),
                  OutlinedButton(
                    onPressed: () {
                      context.read<StoreBloc>().add(StoreProductRequest());
                    },
                    child: const Text(Strings.buttonError),
                  ),
                ],
              );
            }
            if (state.productStatus == StoreResquest.requestSucess) {
              return GridView.builder(
                itemCount: state.products.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemBuilder: (context, index) {
                  final product = state.products[index];
                  return Card(
                    child: Column(
                      children: [
                        Expanded(
                          flex: 4,
                          child: Image.network(
                            product.image,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            product.title,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        OutlinedButton(
                          onPressed: () {},
                          child: const Row(
                            children: [
                              Icon(Icons.add_shopping_cart),
                              SizedBox(width: 5,),
                              Text(Strings.addToCart),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
