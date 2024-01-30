import 'package:fake_store_app/data/bloc/store_bloc.dart';
import 'package:fake_store_app/ui/resources/strings.dart';
import 'package:fake_store_app/ui/screens/cart_screen.dart';
import 'package:fake_store_app/ui/screens/details_screen.dart';
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
  void _addToCart(int cartId) {
    context.read<StoreBloc>().add(StoreProductAddedToCart(cartId));
  }

  void _removeFromCart(int cartId) {
    context.read<StoreBloc>().add(StoreProductRemoveFromCart(cartId));
  }

  void _viewCart() {
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionsBuilder: (_, animation, __, child) {
          return SlideTransition(
            position: Tween(begin: const Offset(0, 1), end: Offset.zero)
                .animate(animation),
            child: BlocProvider.value(
              value: context.read<StoreBloc>(),
              child: child,
            ),
          );
        },
        pageBuilder: (_, __, ___) => const CartScreen(),
      ),
    );
  }

  void viewDetails(
    int id,
    String title,
    String image,
    String description,
    dynamic price,
    String category,
  ) {
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionsBuilder: (_, animation, __, child) {
          return SlideTransition(
            position: Tween(begin: const Offset(0, 1), end: Offset.zero)
                .animate(animation),
            child: BlocProvider.value(
              value: context.read<StoreBloc>(),
              child: child,
            ),
          );
        },
        pageBuilder: (_, __, ___) => DetailsScreen(
          id: id,
          title: title,
          image: image,
          description: description,
          price: price,
          category: category,
        ),
      ),
    );
  }

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
                    child: const Text(Strings.buttonBackShopping),
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
                  final inCart = state.cartId.contains(product.id);
                  return InkWell(
                    onTap: () => viewDetails(
                      product.id,
                      product.title,
                      product.image,
                      product.description,
                      product.price,
                      product.category,
                    ),
                    child: Card(
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
                            onPressed: inCart
                                ? () => _removeFromCart(product.id)
                                : () => _addToCart(product.id),
                            style: ButtonStyle(
                              backgroundColor: inCart
                                  ? const MaterialStatePropertyAll<Color>(
                                      Colors.black12,
                                    )
                                  : null,
                            ),
                            child: Row(
                                children: inCart
                                    ? [
                                        const Icon(Icons.remove_shopping_cart),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        const Text(Strings.removeFromCart),
                                      ]
                                    : [
                                        const Icon(Icons.add_shopping_cart),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        const Text(Strings.addToCart),
                                      ]),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
            return const SizedBox();
          },
        ),
      ),
      floatingActionButton: Stack(
        clipBehavior: Clip.none,
        children: [
          FloatingActionButton(
            onPressed: _viewCart,
            child: const Icon(Icons.shopping_cart),
          ),
          BlocBuilder<StoreBloc, StoreState>(
            builder: (context, state) {
              return Positioned(
                bottom: 40,
                right: -4,
                child: CircleAvatar(
                  radius: 12,
                  backgroundColor: Colors.tealAccent,
                  child: Text(
                    state.cartId.length.toString(),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
