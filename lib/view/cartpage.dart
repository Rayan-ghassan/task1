import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task1/models/product.dart';
import '../controller/cartCubit.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart"),
      ),
      body: BlocBuilder<CartCubit, Map<Product, int>>(
        builder: (context, cartItems) {
          // If cart is empty
          if (cartItems.isEmpty) {
            return Center(child: Text("Your cart is empty."));
          } else {
            return ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final product = cartItems.keys.elementAt(index);
                final quantity = cartItems[product]!;

                return Card(
                  margin: EdgeInsets.all(10),
                  child: ListTile(
                    leading: Image.network(product.image, width: 50, height: 50),
                    title: Text(product.title),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Price: \$${product.price}"),
                        Text("Quantity: $quantity"),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.remove),
                          onPressed: () {
                            context.read<CartCubit>().removeFromCart(product);
                          },
                        ),
                        Text("$quantity"), // Displays current quantity
                        IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () {
                            context.read<CartCubit>().addToCart(product); // Increase quantity
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Display the total price of the cart
            Text(
              "Total: \$${context.read<CartCubit>().getTotalPrice().toStringAsFixed(2)}",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            ElevatedButton(
              onPressed: () {
                // Proceed to checkout or any other action
              },
              child: Text("Checkout"),
            ),
          ],
        ),
      ),
    );
  }
}