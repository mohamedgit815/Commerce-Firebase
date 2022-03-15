import 'package:commerce/Helper/Constance/const_colors.dart';
import 'package:commerce/Helper/Constance/const_functions.dart';
import 'package:commerce/Helper/Constance/const_text.dart';
import 'package:commerce/Helper/Widgets/Customs/custom_button.dart';
import 'package:commerce/Helper/Widgets/Customs/custom_widgets.dart';
import 'package:commerce/Helper/Widgets/Defaults/defualt_expandedauth.dart';
import 'package:commerce/Model/cart_model.dart';
import 'package:commerce/Update/Functions/cart_functions.dart';
import 'package:commerce/Update/State/bottombar_state.dart';
import 'package:commerce/Update/State/switch_state.dart';
import 'package:commerce/Views/Main/condition_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MobileCartPage extends ConsumerStatefulWidget {
  const MobileCartPage({Key? key}) : super(key: key);

  @override
  _MobileCartPageState createState() => _MobileCartPageState();
}

class _MobileCartPageState extends ConsumerState<MobileCartPage> with _MixinMobileCart {

  @override
  void initState() {
    super.initState();
    ref.read(_totalPriceProv).count = _totalPrice;
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        backgroundColor: normalWhite,
        centerTitle: true,
        title: CustomText(
          text: '${translateText(textCart, context)}',
          fontSize: 20.0,
          color: lightMainColor,
          fontWeight: FontWeight.bold,
        ),
      ),


      body: LayoutBuilder(
            builder:(context, constraints) => NotificationListener<UserScrollNotification>(
              onNotification: (notification){
                if(notification.direction == ScrollDirection.forward){
                  ref.read(_notificationProv).trueSwitch();
                } else if (notification.direction == ScrollDirection.reverse){
                  ref.read(_notificationProv).falseSwitch();
                }
                return false;
              },
              child: Consumer(
                builder:(context,prov,_)=> prov.watch(_fetchCartProv).when(
                    error: (err,stack)=> errorProvider(err) ,
                    loading: ()=> loadingProvider() ,
                    data: (data) {
                      return AnimatedConditionalBuilder(
                          duration: const Duration(milliseconds: 500),
                          condition: data.docs.isEmpty,
                          builder: (BuildContext context){
                            return Center(child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.remove_shopping_cart_outlined,size: 70.0,),
                                CustomText(
                                    text: '${translateText(textEmptyCart, context)}',
                                  fontSize: 17.0,
                                )
                              ],
                            ));
                          },
                          fallback: (BuildContext context){
                            return Column(
                              children: [
                                Expanded(
                                    flex: 5,
                                    child: Consumer(
                                      builder: (context,prov,_)=>prov.watch(_fetchCartProv).when(
                                          error: (err,stack)=> errorProvider(err) ,
                                          loading: ()=> loadingProvider() ,
                                          data: (data)=> ListView.builder(
                                              itemCount: data.docs.length ,
                                              itemBuilder: (context ,int i ) {
                                                final CartModel _data = CartModel.fromApp(data.docs.elementAt(i).data());
                                                _totalPrice = data.docs.map((e) => e.data()['price'] * e.data()['quantity']).reduce((value, element) => value+element);
                                                ref.read(_totalPriceProv).count = _totalPrice;

                                                return Card(
                                                  color: normalWhite ,
                                                  child: Container(
                                                    height: constraints.maxHeight * 0.22 ,
                                                    width: double.infinity,
                                                    margin: const EdgeInsets.all(10.0) ,
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween ,
                                                      crossAxisAlignment: CrossAxisAlignment.end ,
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
                                                                          image: NetworkImage(_data.image),
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
                                                                  children:  [
                                                                    const Spacer(),
                                                                    Expanded(
                                                                      flex: 2,
                                                                      child: CustomText(
                                                                        text: _data.name.toString(),
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
                                                                        child: FittedBox(
                                                                          fit: BoxFit.scaleDown,
                                                                          child: CustomText(
                                                                            text: 'M + Red' ,
                                                                            fontSize: 15.0,
                                                                            color: normalGrey,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),

                                                                    Expanded(
                                                                      flex: 2,
                                                                      child: AnimatedSwitcher(
                                                                        duration: const Duration(milliseconds: 240),
                                                                        switchOutCurve: Curves.bounceIn,
                                                                        switchInCurve: Curves.bounceIn,
                                                                        child: CustomText(
                                                                          key: ValueKey<int>(_data.price * _data.quantity),
                                                                          text: '\$${_data.price * _data.quantity}' ,
                                                                          fontSize: 17.0,
                                                                        ),
                                                                      ),
                                                                    ) ,

                                                                    const Spacer(),
                                                                  ],
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ) ,

                                                        Expanded(
                                                          child: Column(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            crossAxisAlignment: CrossAxisAlignment.end,
                                                            children: [
                                                              IconButton(
                                                                  onPressed: () async {
                                                                    showDialog(context: context,
                                                                        builder: (context)=>AlertDialog(
                                                                          title: Text( '${translateText(textSure, context)}',),
                                                                          actions: [
                                                                            CustomElevatedButton(onPressed: (){
                                                                              Navigator.pop(context);
                                                                            }, child: Text('${translateText(textNo, context)}')
                                                                            ),
                                                                            CustomElevatedButton(onPressed: () async {
                                                                              await CartFunctions.deleteCart(_data.id);
                                                                              Navigator.pop(context);
                                                                            }, child: Text('${translateText(textYes, context)}')),
                                                                          ],
                                                                        ));
                                                                  }, icon: const Icon(Icons.delete ,)),

                                                              Row(
                                                                children: [

                                                                  Expanded(
                                                                    child: CircleAvatar(
                                                                      backgroundColor: primary ,
                                                                      foregroundColor: normalWhite,
                                                                      child:Transform.translate(
                                                                        offset: const Offset(0,-5),
                                                                        child: IconButton(
                                                                          icon: const Icon(Icons.minimize),
                                                                          onPressed: () async {
                                                                            await CartFunctions.deIncreaseQuantity(_data);
                                                                            ref.read(_totalPriceProv).countState(_totalPrice);
                                                                          },
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),


                                                                  Expanded(
                                                                    child: CircleAvatar(
                                                                        backgroundColor: Colors.transparent ,
                                                                        foregroundColor: normalBlack ,
                                                                        child: AnimatedSwitcher(
                                                                          duration: const Duration(milliseconds: 240),
                                                                          switchOutCurve: Curves.bounceIn,
                                                                          switchInCurve: Curves.bounceIn,
                                                                          child: CustomText(
                                                                            key: ValueKey<int>(_data.quantity),
                                                                            text: '${_data.quantity}',
                                                                          ),
                                                                        )
                                                                    ),
                                                                  ),


                                                                  Expanded(
                                                                    child: CircleAvatar(
                                                                      backgroundColor: primary ,
                                                                      foregroundColor: normalWhite,
                                                                      child:IconButton(
                                                                        icon: const Icon(Icons.add),
                                                                        onPressed: () async {
                                                                          await CartFunctions.increaseQuantity(_data);
                                                                          ref.read(_totalPriceProv).countState(_totalPrice);
                                                                        },
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              )
                                                            ],
                                                          ),
                                                        )

                                                      ],
                                                    ),
                                                  ),
                                                );
                                              })
                                      ),)
                                ) ,

                                Consumer(
                                  builder:(context,provNotification,_)=> AnimatedContainer(
                                    duration: const Duration(milliseconds: 200),
                                   width: double.infinity,
                                   height: !provNotification.watch(_notificationProv).varSwitch ? 0.0 : constraints.maxHeight *0.2,
                                   // visible: provNotification.watch(_notificationProv).varSwitch,
                                    child: Visibility(
                                      visible: provNotification.watch(_notificationProv).varSwitch,
                                      child: Column(
                                        children: [

                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.all(10.0),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  CustomText(
                                                    text: '${translateText(textTotal, context)}' ,
                                                    fontSize: 15.0,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  Consumer(builder:(context,prov,_) {
                                                    return AnimatedSwitcher(
                                                        duration: const Duration(milliseconds: 200),
                                                        switchOutCurve: Curves.bounceIn,
                                                        switchInCurve: Curves.bounceIn,
                                                        child: CustomText(
                                                            key: ValueKey<int>(_totalPrice),
                                                            text: '\$${prov.watch(_totalPriceProv).count.toDouble()}'));
                                                  }),
                                                ],
                                              ),
                                            ),
                                          ),


                                          Expanded(
                                            child: DefaultExpandedAuth(
                                                child: CustomElevatedButton(
                                                  child:  CustomText(text:'${translateText(textCheckOut, context)}',),
                                                  borderRadius: BorderRadius.circular(10.0),
                                                  onPressed: (){},
                                                )
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            );
                          });

                    }
                ),
              ),
            )
        ),

    );
  }
}


mixin _MixinMobileCart {
  final _notificationProv = ChangeNotifierProvider((ref)=>SwitchState());
  final _totalPriceProv = ChangeNotifierProvider((ref)=>BottomBarState());
  final _fetchCartProv = StreamProvider((ref)=>CartFunctions.fetchCart());
  int _totalPrice = 0;
}