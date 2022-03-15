import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:commerce/Helper/Constance/const_firebase.dart';

class FoodsModel {
  final String name, image,id;
  final int price;

  const FoodsModel({required this.name,required this.image,required this.price,required this.id});

  factory FoodsModel.fromApp(Map<String,dynamic>map){
    return FoodsModel(
        name: map['name'] ,
        image: map['image'] ,
        price: map['price'] ,
        id: map['id']
    );
  }

}

class FetchFoods {

   static Future<QuerySnapshot<Map<String,dynamic>>> fetchDataFood() async {
    return await fireStore.collection(fireStoreFoods).get();
}

   static Future<QuerySnapshot<Map<String,dynamic>>> fetchDataMeat() async {
     return await fireStore.collection(fireStoreMeat).get();
   }

   static Future<QuerySnapshot<Map<String,dynamic>>> fetchDataVegetables() async {
     return await fireStore.collection(fireStoreVegetables).get();
   }
}