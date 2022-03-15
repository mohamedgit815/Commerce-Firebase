import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';

final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
final FirebaseStorage fireStorage = FirebaseStorage.instance;
final String firebaseId = FirebaseAuth.instance.currentUser!.uid;
final FirebaseFirestore fireStore = FirebaseFirestore.instance;
final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;



// FireStore Variable
const String fireStoreUser = 'User';
const String fireStoreProfile = 'Profile';
const String fireStoreFoods = 'Food';
const String fireStoreMeat = 'Meat';
const String fireStoreVegetables = 'Vegetables';
const String fireStoreFavorite = 'Favorite';
const String fireStoreCart = 'Cart';