import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task1/controller/cartCubit.dart';
import 'package:task1/controller/productCubit.dart';
import 'package:task1/models/product.dart';
import 'package:task1/view/cartpage.dart';
import 'package:task1/view/productDetails.dart';

class ProductListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Product List",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              Icons.shopping_cart,
              size: 30,
              color: Colors.black,
            ),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => CartScreen()),
            ),
          ),
        ],
      ),
      body: BlocBuilder<ProductCubit, List<Product>>(
        builder: (context, products) {
          return products.isEmpty
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];

                    return BlocBuilder<CartCubit, Map<Product,int>>(
                      builder: (context, cartItems) {
                        bool isAdded =
                            context.read<CartCubit>().isInCart(product);

                        return Card(
                          child: ListTile(
                            leading: Image.network(product.image,
                                width: 80, height: 80),
                            title: Text(product.title,style: TextStyle(fontWeight: FontWeight.w500),),
                            subtitle: Column(
                              children: [
                                Text(product.shortDescription),
                                Text("\$${product.price}"),
                              ]
                            ),
                            trailing:Column(
                             mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: isAdded ? Colors.green : Colors.grey, // Green if added, Blue if not
                                  ),
                                  child: Text(isAdded ? "Added" : "Add to Cart"),
                                  onPressed: () {
                                    if (isAdded) {
                                      context.read<CartCubit>().removeFromCart(product);
                                    } else {
                                      context.read<CartCubit>().addToCart(product);
                                    }
                                  },
                                ),
                              ),
                               SizedBox(height: 8), // Adds space between the buttons
                              Expanded(
                                child: ElevatedButton(
                                  child: Text("Details"),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (_) => ProductDetailScreen(product)),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                          ),
                        );
                      },
                    );
                  },
                );
        },
      ),
    );
  }
}
