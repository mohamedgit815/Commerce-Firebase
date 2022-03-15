class UserModel {
  final String first , last , email , image , id , bio , token;

  UserModel({
    required this.bio , required this.first , required this.last ,
    required this.email, required this.image, required this.id ,
    required this.token
  });

  factory UserModel.fromApp(Map<String,dynamic>map){
    return UserModel(
      first: map['first'],
      last: map['last'],
      email: map['email'] ,
      image: map['image'],
      id: map['id'] ,
      bio: map['bio'] ,
      token: map['token']
    );
  }

  Map<String,dynamic> toApp()=>{
    'first' : first ,
    'last' : last ,
    'email' : email ,
    'image' : image ,
    'id' : id ,
    'bio': bio ,
    'token': token
  };
}