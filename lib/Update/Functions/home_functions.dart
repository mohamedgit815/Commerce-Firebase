import 'package:commerce/Helper/Constance/const_firebase.dart';
import 'package:commerce/Model/cart_model.dart';

class HomeFunctions {
  static Future<void> _updateQuantity({required String id,required int quantity}) async {
    return await fireStore.collection(fireStoreFoods).doc(id).update({
      'quantity': quantity
    });
  }

  static Future<void> increaseQuantity(CartModel cartModel) async {
    int _quantity = cartModel.quantity;
    _quantity++;
    return await _updateQuantity(
        id: cartModel.id,
        quantity: _quantity
    );
  }


  static deIncreaseQuantity(CartModel cartModel) async {
    int _quantity = cartModel.quantity;
    if(cartModel.quantity == 1){
      return;
    } else {
      _quantity--;
    }

    await _updateQuantity(
        id: cartModel.id,
        quantity: _quantity
    );
  }
}