import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:commerce/Helper/Constance/const_firebase.dart';

class FavoriteFunction {
  static Future<void> postFavorite({
    required String name , required String id,
    required String image , required int price
}) async {
    return await fireStore.collection(fireStoreProfile).doc(firebaseId).collection(fireStoreFavorite).doc(id).set({
      'name': name ,
      'image': image ,
      'id': id ,
      'price': price ,
      'date': Timestamp.now()
    });
  }


 static Stream<DocumentSnapshot<Map<String,dynamic>>> checkFavorite(String id) {
    return fireStore.collection(fireStoreProfile).doc(firebaseId)
        .collection(fireStoreFavorite).doc(id).snapshots();
  }


  static Future deleteFavorite(String id) async {
    return await fireStore.collection(fireStoreProfile).doc(firebaseId)
        .collection(fireStoreFavorite).doc(id).delete();
  }


  static Stream<QuerySnapshot<Map<String,dynamic>>> fetchFavorite() {
    return fireStore.collection(fireStoreProfile).doc(firebaseId)
        .collection(fireStoreFavorite).orderBy('date',descending: true).snapshots();
  }
}