
class CartModel {
  final String name, image,id;
  final int price , quantity;

  const CartModel({required this.name,
    required this.image,
    required this.price,
    required this.id ,
    required this.quantity
  });

  factory CartModel.fromApp(Map<String,dynamic>map){
    return CartModel(
        name: map['name'] ,
        image: map['image'] ,
        price: map['price'] ,
        id: map['id'],
        quantity: map['quantity']
    );
  }

}