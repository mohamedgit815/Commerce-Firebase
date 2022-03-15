import 'package:commerce/Helper/Constance/const_functions.dart';
import 'package:commerce/Helper/Constance/const_widgets.dart';
import 'package:commerce/Helper/Widgets/Customs/custom_button.dart';
import 'package:commerce/Helper/Widgets/Customs/custom_widgets.dart';
import 'package:commerce/Helper/Widgets/Defaults/default_home_image.dart';
import 'package:commerce/Model/cart_model.dart';
import 'package:commerce/Update/Functions/cart_functions.dart';
import 'package:commerce/Update/Functions/favorite_function.dart';
import 'package:commerce/Update/State/switch_state.dart';
import 'package:commerce/Views/Main/condition_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MobileDetailsHomePage extends StatefulWidget {
  final CartModel cartModel;
  const MobileDetailsHomePage({Key? key,required this.cartModel}) : super(key: key);

  @override
  _MobileDetailsHomePageState createState() => _MobileDetailsHomePageState();
}

class _MobileDetailsHomePageState extends State<MobileDetailsHomePage> {
  @override
  Widget build(BuildContext context) {
    final _checkFavoriteProv = StreamProvider((ref)=>FavoriteFunction.checkFavorite(widget.cartModel.id));
    final _checkCartProv = StreamProvider((ref)=>CartFunctions.checkCart(widget.cartModel.id));


    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: DefaultHomeImage(
              tag: widget.cartModel.id ,
              image: widget.cartModel.image ,
              name: widget.cartModel.name ,
              price: widget.cartModel.price ,
              id: widget.cartModel.id,
              borderRadius: 0.0 ,
              hide: false, length:  0,
            )
          ) ,


          Row(
            children: [

              Expanded(
                  child: Consumer(
                    builder:(context,prov,_)=> prov.watch(_checkCartProv).when(
                        error: (err,stack)=>errorProvider(err),
                        loading: ()=>loadingProvider(),
                      data: (data)=> AnimatedConditionalBuilder(
                        condition: !data.exists,
                        builder:(context) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CustomElevatedButton(
                              size: const Size(double.infinity,40),
                              onPressed: () async {
                                await CartFunctions.postCart(
                                    name: widget.cartModel.name,
                                    id: widget.cartModel.id,
                                    image: widget.cartModel.image,
                                    price: widget.cartModel.price
                                );
                              },
                              child: const CustomText(
                                text: 'Add to Cart',
                                fontSize: 20.0,
                              )
                        ),
                          );
                        },
                        fallback:(context) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CustomElevatedButton(
                                size: const Size(double.infinity,40),
                                onPressed: () async {
                                return await CartFunctions.deleteCart(widget.cartModel.id);
                              },
                              child: const CustomText(text: 'Remove From Cart',
                                fontSize: 20.0,
                              )
                        ),
                          );
                        },
                      ),
                    )
                  )
              ) ,


              Consumer(
                builder:(context,prov,_)=> prov.watch(_checkFavoriteProv).when(
                    error: (err,stack)=> errorProvider(err) ,
                    loading: ()=> loadingProvider() ,
                  data: (check)=> AnimatedConditionalBuilder(
                    condition: check.exists ,
                    builder: (BuildContext context){
                      return ConstWidgets.iconButtonVisibility(
                          ref: prov, icon: Icons.favorite, state: _favoriteProv ,
                          color: Colors.red,
                          onPressed: () async {
                              return await FavoriteFunction.deleteFavorite(widget.cartModel.id);
                          }
                      );
                    },
                    fallback: (BuildContext context){
                      return ConstWidgets.iconButtonVisibility(
                          ref: prov, icon: Icons.favorite_outline, state: _favoriteProv,
                          color: Colors.red ,
                          onPressed: () async {
                            return await FavoriteFunction.postFavorite(
                                name: widget.cartModel.name ,
                                id: widget.cartModel.id ,
                                image: widget.cartModel.image ,
                                price: widget.cartModel.price
                            );
                          }
                      );
                    },
                  )
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

final _favoriteProv = ChangeNotifierProvider<SwitchState>((ref)=>SwitchState());
