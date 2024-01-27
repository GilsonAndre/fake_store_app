import 'package:fake_store_app/data/bloc/store_bloc.dart';
import 'package:fake_store_app/data/models/product_model.dart';
import 'package:fake_store_app/ui/resources/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final hasEmpty = context.select<StoreBloc, bool>(
      (bloc) => bloc.state.cartId.isEmpty,
    );
    final inCart = context.select<StoreBloc, List<ProductModel>>(
      (bloc) => bloc.state.products
          .where((product) => bloc.state.cartId.contains(product.id))
          .toList(),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.appName),
        backgroundColor: Colors.green,
      ),
      body: hasEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(Strings.cartEmpty),
                  OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(Strings.buttonBackShopping),
                  )
                ],
              ),
            )
          : Center(
              child: BlocBuilder<StoreBloc, StoreState>(
                builder: (context, state) {
                  return GridView.builder(
                    itemCount: inCart.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    itemBuilder: (context, index) {
                      final product = inCart[index];
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
                              onPressed: () {
                                context.read<StoreBloc>().add(
                                      StoreProductRemoveFromCart(product.id),
                                    );
                              },
                              style: const ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll<Color>(
                                  Colors.black12,
                                ),
                              ),
                              child: const Row(
                                children: [
                                  Icon(Icons.remove_shopping_cart),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(Strings.removeFromCart),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
    );
  }
}
