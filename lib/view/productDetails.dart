import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task1/controller/cartCubit.dart';
import 'package:task1/models/product.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;
  ProductDetailScreen(this.product);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(product.title)),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Image.network(product.image),
            Text(
              product.description,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20,),
            Text("\$${product.price}", style: TextStyle(fontSize: 20)),

          ],
        ),
      ),
    );
  }
}
