import 'package:commerce/Helper/Constance/const_colors.dart';
import 'package:commerce/Helper/Constance/const_functions.dart';
import 'package:commerce/Helper/Widgets/Customs/custom_widgets.dart';
import 'package:commerce/Update/Functions/favorite_function.dart';
import 'package:commerce/Views/Main/condition_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class DefaultHomeImage extends ConsumerWidget {
  final String tag ,image , name , id;
  final int price , length;
  final double borderRadius;
  final bool hide;



  const DefaultHomeImage({Key? key,
    required this.tag,
    required this.image,
    required this.name,
    required this.price ,
    required this.borderRadius ,
    required this.hide ,
    required this.id ,
    required this.length
  }) : super(key: key);
  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final _checkFavoriteProv = StreamProvider((ref)=>FavoriteFunction.checkFavorite(id));
        return Hero(
          tag: tag.toString() ,
          child: Container(
            width: double.infinity ,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(borderRadius) ,
                image: DecorationImage(
                  image: NetworkImage(image) ,
                  fit: BoxFit.cover ,
                  onError: (err,n)=> const Icon(Icons.add,size: 100,),
                )
            ),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(borderRadius),
                  boxShadow:  [
                    BoxShadow(
                        spreadRadius: 0.0 ,
                        blurRadius: 0.0 ,
                        color: normalBlack.withOpacity(0.25)
                    ),
                  ]
              ),
              child: Column(
                 mainAxisAlignment: MainAxisAlignment.end,
                 crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                 Padding(
                   padding: const EdgeInsets.only(
                       left: 8.0
                   ),
                   child: CustomText(
                     text: name ,
                     color: normalWhite ,
                     fontSize: 20.0 ,
                   ),
                 ) ,


                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: CustomText(
                         text: '\$ $price' ,
                         color: normalWhite,
                         fontSize: 20.0,
                       ),
                     ),

                     Visibility(
                       visible: hide ,
                       child: Padding(
                         padding: const EdgeInsets.all(8.0),
                         child: Consumer(
                           builder:(context,prov,_)=> prov.watch(_checkFavoriteProv).when(
                               error: (err,stack)=> errorProvider(err) ,
                               loading: ()=> loadingProvider() ,
                             data: (check)=> AnimatedConditionalBuilder(
                                 condition: !check.exists,
                                 builder: (context){
                                   return GestureDetector(
                                     onTap: () async {
                                       await FavoriteFunction.postFavorite(
                                           name: name ,
                                           id: id ,
                                           image: image ,
                                           price: price
                                       );

                                     },

                                     child: CircleAvatar(
                                         backgroundColor: normalBlack.withOpacity(0.4),
                                         child: const Icon(Icons. favorite_outline,color: normalWhite)),
                                   );
                                 },
                                 fallback: (context){
                                   return GestureDetector(
                                     onTap: () async {
                                        await FavoriteFunction.deleteFavorite(id);
                                     },

                                     child: const CircleAvatar(
                                       backgroundColor: Colors.red,
                                         child: Icon(Icons.favorite_outline,color: normalWhite)),
                                   );
                                 })
                           ),
                         ),
                       ),
                     ),
                   ],
                 )

                ],
              ),
            ) ,
          ),
        );
  }
}