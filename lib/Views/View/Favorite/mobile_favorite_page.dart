import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:commerce/Helper/Constance/const_colors.dart';
import 'package:commerce/Helper/Constance/const_functions.dart';
import 'package:commerce/Helper/Constance/const_text.dart';
import 'package:commerce/Helper/Widgets/Customs/custom_button.dart';
import 'package:commerce/Helper/Widgets/Customs/custom_widgets.dart';
import 'package:commerce/Model/foods_model.dart';
import 'package:commerce/Update/Functions/cart_functions.dart';
import 'package:commerce/Update/Functions/favorite_function.dart';
import 'package:commerce/Views/Main/condition_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class MobileFavoritePage extends ConsumerStatefulWidget {
  const MobileFavoritePage({Key? key}) : super(key: key);

  @override
  _MobileCartPageState createState() => _MobileCartPageState();
}

class _MobileCartPageState extends ConsumerState<MobileFavoritePage> with MixinMobileFavorite {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: normalWhite,
        centerTitle: true,
        title:  CustomText(
          text: '${translateText(textFavorite, context)}',
          fontSize: 20.0,
          color: lightMainColor,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: LayoutBuilder(
        builder:(context, constraints) => Column(
          children: [
            Expanded(
                child: Consumer(
                  builder:(context,prov,_)=> prov.watch(fetchFavoriteProv).when(
                      error: (err,stack)=>errorProvider(err) ,
                      loading: ()=>loadingProvider() ,
                      data: (data) {
                        return AnimatedConditionalBuilder(
                            condition: data.docs.isEmpty,
                            builder: (context){
                              return Center(child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children:  [
                                  const Icon(Icons.remove_shopping_cart_outlined,size: 70.0),

                                  CustomText(
                                    text: '${translateText(textEmptyFav, context)}',
                                    fontSize: 17.0,
                                  )
                                ],
                              ));
                            },
                            fallback: (context){
                              return ListView.builder(
                                  itemCount: data.docs.length ,
                                  itemBuilder: (context , int i ) {
                                    return Builder(
                                        builder: (context) {
                                          return _buildAnimatedList(
                                            constraints:constraints,
                                            index: i ,
                                            data: data ,
                                          );
                                        }
                                    );
                                  });
                            });
                      }
                  ),
                )
            ),
          ],
        ),
      ),
    );
  }


}


class MixinMobileFavorite {
  final fetchFavoriteProv = StreamProvider((ref)=>FavoriteFunction.fetchFavorite());

  Card _buildAnimatedList({
    required BoxConstraints constraints,
    required QuerySnapshot<Map<String,dynamic>> data ,
    required int index ,
  }) {
    final FoodsModel _foodsModel = FoodsModel.fromApp(data.docs.elementAt(index).data());
    return Card(
      color: normalWhite ,
      child: Container(
        height: constraints.maxHeight * 0.22 ,
        width: double.infinity,
        margin: const EdgeInsets.all(10.0) ,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              flex: 2,
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Container(
                      margin: const EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          image: DecorationImage(
                              image: NetworkImage(_foodsModel.image) ,
                              fit: BoxFit.cover
                          )
                      ),

                    ),
                  ),


                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Spacer(),
                        Expanded(
                          flex: 2,
                          child: CustomText(
                            text: _foodsModel.name.toString(),
                            fontSize: 17.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const Expanded(
                          flex: 2,
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: 7.0,bottom: 7.0
                            ),
                            child: CustomText(
                              text: 'M + Red' ,
                              fontSize: 15.0,
                              color: normalGrey,
                            ),
                          ),
                        ),

                        Expanded(
                          flex: 2,
                          child: CustomText(
                            text: '\$${_foodsModel.price}' ,
                            fontSize: 17.0,
                          ),
                        ) ,

                        const Spacer(),
                      ],
                    ),
                  )
                ],
              ),
            ),

            Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end ,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween ,
                  children: [
                    Builder(
                        builder: (context) {
                          return IconButton(
                              onPressed: (){
                                showDialog(context: context, builder: (context)=>AlertDialog(
                                  title: Text( '${translateText(textSure, context)}',),
                                  actions: [
                                    CustomElevatedButton(onPressed: (){
                                      Navigator.pop(context);
                                    }, child: Text('${translateText(textNo, context)}')),
                                    CustomElevatedButton(onPressed: () async {
                                     // removeAnimatedList(constraints: constraints, data: data, index: index);
                                      await FavoriteFunction.deleteFavorite(_foodsModel.id);
                                       Navigator.pop(context);
                                    }, child: Text('${translateText(textYes, context)}')),
                                  ],
                                ));
                              },
                              icon: const Icon(Icons.favorite,color: Colors.red)
                          );
                        }
                    ) ,


                    Builder(
                        builder: (context) {
                          return CustomElevatedButton(
                              onPressed: () async {
                                return await CartFunctions.postCart(
                                    name: _foodsModel.name,
                                    id: _foodsModel.id,
                                    image: _foodsModel.image,
                                    price: _foodsModel.price
                                ).then((value) {
                                  customSnackBar(text: 'The ${_foodsModel.name} Added', context: context);
                                });
                              },
                              child: CustomText(
                                text: '${translateText(textAddCart, context)}',
                              ));
                        }
                    )
                  ],
                )
            )

          ],
        ),
      ),
    );
  }

}