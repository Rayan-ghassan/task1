import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task1/models/product.dart';

class CartCubit extends Cubit<Map<Product, int>> {
  CartCubit() : super({});

  // Add a product to the cart
  void addToCart(Product product) {
    final currentCart = Map<Product, int>.from(state);
    if (currentCart.containsKey(product)) {
      currentCart[product] = currentCart[product]! + 1; // Increase quantity
    } else {
      currentCart[product] = 1; // Add new product with quantity 1
    }
    emit(currentCart); // Emit the updated cart state
  }

  // Remove a product from the cart
  void removeFromCart(Product product) {
    final currentCart = Map<Product, int>.from(state);
    if (currentCart.containsKey(product)) {
      if (currentCart[product]! > 1) {
        currentCart[product] = currentCart[product]! - 1; // Decrease quantity
      } else {
        currentCart.remove(product); // Remove product if quantity is 1
      }
    }
    emit(currentCart); // Emit the updated cart state
  }

  bool isInCart(Product product) {
    return state.containsKey(product); // Returns true if the product exists in the cart
  }

  // Get the total price of the cart
  double getTotalPrice() {
    double total = 0.0;
    state.forEach((product, quantity) {
      total += product.price * quantity; // Calculate total price
    });
    return total;
  }
}