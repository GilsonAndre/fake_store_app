
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fake_store_app/data/bloc/store_bloc.dart';
import 'package:fake_store_app/ui/resources/strings.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({
    Key? key,
    required this.id,
    required this.title,
    required this.image,
    required this.description,
    required this.price,
    required this.category,
  }) : super(key: key);

  final int id;
  final String title;
  final String image;
  final String description;
  final dynamic price;
  final String category;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.appName),
        backgroundColor: Colors.green,
      ),
      body: BlocBuilder<StoreBloc, StoreState>(
        builder: (context, state) {
          return ListView(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(widget.category),
                      Text(widget.price.toString()),
                    ],
                  ),
                  Text(widget.title),
                  Image.network(widget.image),
                  //Text(products.description),
                  Text(widget.description),
                  OutlinedButton(
                    onPressed: () {},
                    child: const Text(Strings.buttonBuy),
                  ),
                  OutlinedButton(
                    onPressed: () {
                      context
                          .read<StoreBloc>()
                          .add(StoreProductAddedToCart(widget.id));
                    },
                    child: const Text(Strings.addToCart),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
