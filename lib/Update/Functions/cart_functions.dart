import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:commerce/Helper/Constance/const_firebase.dart';
import 'package:commerce/Model/cart_model.dart';

class CartFunctions {
  static Future<void> postCart({
    required String name , required String id,
    required String image , required int price
  }) async {
     await fireStore.collection(fireStoreProfile).doc(firebaseId)
        .collection(fireStoreCart).doc(id).set({
      'name': name ,
      'image': image ,
      'id': id ,
      'price': price ,
      'quantity': 1 ,
      'date': Timestamp.now()
    });
  }


  static Future<void> _updateQuantity({required String id,required int quantity}) async {
    return await fireStore.collection(fireStoreProfile).doc(firebaseId)
        .collection(fireStoreCart).doc(id).update({
      'quantity': quantity
    });
  }


  static Stream<DocumentSnapshot<Map<String,dynamic>>> checkCart(String id) {
    return fireStore.collection(fireStoreProfile).doc(firebaseId)
        .collection(fireStoreCart).doc(id).snapshots();
  }


  static Future deleteCart(String id) async {
    return await fireStore.collection(fireStoreProfile).doc(firebaseId)
        .collection(fireStoreCart).doc(id).delete();
  }


  static Stream<QuerySnapshot<Map<String,dynamic>>> fetchCart() {
    return fireStore.collection(fireStoreProfile).doc(firebaseId)
        .collection(fireStoreCart).orderBy('date',descending: true).snapshots();
  }



  static Future<void> increaseQuantity(CartModel cartModel) async {
    int _quantity = cartModel.quantity;

    _quantity++;

    return await _updateQuantity(
        id: cartModel.id ,
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