import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:commerce/Helper/Constance/const_colors.dart';
import 'package:commerce/Helper/Constance/const_functions.dart';
import 'package:commerce/Helper/Constance/const_text.dart';
import 'package:commerce/Helper/Widgets/Customs/custom_widgets.dart';
import 'package:commerce/Helper/Widgets/Defaults/default_home_image.dart';
import 'package:commerce/Model/cart_model.dart';
import 'package:commerce/Model/foods_model.dart';
import 'package:commerce/Update/State/bottombar_state.dart';
import 'package:commerce/Views/Main/condition_builder.dart';
import 'package:commerce/Views/View/Home/DetailsHome/main_details_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';


class MobileHomePage extends ConsumerStatefulWidget {
  const MobileHomePage({Key? key}) : super(key: key);

  @override
  _MobileHomePageState createState() => _MobileHomePageState();
}

class _MobileHomePageState extends ConsumerState<MobileHomePage>
    with _MobileHomeMixin{


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder:(context, constraints) => RefreshIndicator(
          onRefresh: () async {
            if( ref.read(_selectedProv).count == 0 ) {
              return await ref.refresh(_fetchVegetablesProv);
            } else if ( ref.read(_selectedProv).count == 1 ) {
              return await ref.refresh(_fetchMeatProv);
            } else if( ref.read(_selectedProv).count ==2 ) {
              return await ref.refresh(_fetchFoodsProv);
            }
          },
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            children: [
              SizedBox(height: constraints.maxHeight * 0.04,),


              SizedBox(
                height: constraints.maxHeight * 0.24,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal ,
                  itemCount: _selectedWidgets.length ,
                  itemBuilder: ( BuildContext context , int i ) {
                    return Consumer(
                      builder:(context,prov,_)=> GestureDetector(
                        key: ValueKey('${_selectedWidgets.elementAt(i)['id']}') ,
                        onTap: (){
                          prov.read(_selectedProv).countState(i);
                        },
                        child: AnimatedContainer(
                          duration: _duration,
                          key: ValueKey('${_selectedWidgets.elementAt(i)['id']}') ,
                          width: constraints.maxWidth * 0.3 ,
                          margin: const EdgeInsets.all(5.0) ,
                          decoration: BoxDecoration(
                              color: ref.watch(_selectedProv).count == i ? lightMainColor: normalWhite ,
                              borderRadius: BorderRadius.circular(10.0),
                              boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade300,
                                spreadRadius: 1.0,
                                blurRadius: 5.0
                              )
                            ]
                          ) ,
                          child: Column(
                              key: ValueKey('${_selectedWidgets.elementAt(i)['id']}') ,
                            children:   [

                              Expanded(
                                  flex: 4,
                                  child:  CircleAvatar(
                                    key: ValueKey('${_selectedWidgets.elementAt(i)['id']}') ,
                                    radius: 42.0,
                                    backgroundColor: normalWhite,
                                    child: CircleAvatar(
                                      key: ValueKey('${_selectedWidgets.elementAt(i)['id']}') ,
                                      radius: 40.0,
                                      backgroundImage: AssetImage(_selectedWidgets.elementAt(i)['image']),
                                    ),
                                  )),


                              Expanded(
                                  key: ValueKey('${_selectedWidgets.elementAt(i)['id']}') ,
                                  child: AnimatedConditionalBuilder(
                                    condition: _selectedWidgets.elementAt(i)['title'] == 'Vegetables',
                                    builder: (context)=> CustomText(
                                        key: ValueKey('${_selectedWidgets.elementAt(i)['id']}') ,
                                        text: '${translateText(textVegetables, context)}',
                                      style: TextStyle(
                                          color: ref.read(_selectedProv).count == i ? normalWhite : normalBlack
                                      ),
                                    ),
                                    fallback: (context)=>AnimatedConditionalBuilder(
                                        condition: _selectedWidgets.elementAt(i)['title'] == 'Meat',
                                        builder: (context)=> CustomText(
                                          key: ValueKey('${_selectedWidgets.elementAt(i)['id']}') ,
                                          text: '${translateText(textMeat, context)}',
                                          style: TextStyle(
                                              color: ref.read(_selectedProv).count == i ? normalWhite : normalBlack
                                          ),
                                        ),
                                      fallback: (context)=> CustomText(
                                        key: ValueKey('${_selectedWidgets.elementAt(i)['id']}') ,
                                        text: '${translateText(textOther, context)}',
                                        style: TextStyle(
                                            color: ref.read(_selectedProv).count == i ? normalWhite : normalBlack
                                        ),
                                      ),
                                    ),
                                  ) ,
                              )
                            ],
                          ) ,
                        ),
                      ),
                    );
                  } ,
                ),
              ) ,


              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: CustomText(
                      text: 'Popular',
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    )),
              ) ,


              AnimatedConditionalBuilder(
                duration: _duration,
                condition: ref.read(_selectedProv).count == 0,
                builder: (context) {
                  return buildDataHome(
                      data: _fetchVegetablesProv,
                      constraints: constraints ,
                      storageKey: 'FetchVegetablesProvKey'
                  );
                },
                fallback:(context)=> AnimatedConditionalBuilder(
                    duration: _duration,
                    condition: ref.read(_selectedProv).count == 1,
                    builder: (context) {
                      return buildDataHome(
                          data: _fetchMeatProv,
                          constraints: constraints ,
                          storageKey: 'FetchMeatProvKey'
                      );
                    },
                    fallback: (BuildContext context) {
                      return buildDataHome(
                          data: _fetchFoodsProv,
                          constraints: constraints ,
                          storageKey: 'FetchFoodsProv'
                      );
                    }
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}

mixin _MobileHomeMixin {
  final _fetchFoodsProv = FutureProvider((ref)=>FetchFoods.fetchDataFood());
  final _fetchMeatProv = FutureProvider((ref)=>FetchFoods.fetchDataMeat());
  final _fetchVegetablesProv = FutureProvider((ref)=>FetchFoods.fetchDataVegetables());
  final _selectedProv = ChangeNotifierProvider((ref)=>BottomBarState());
  final Duration _duration = const Duration(milliseconds: 400);

  Consumer buildDataHome({
    required FutureProvider<QuerySnapshot<Map<String,dynamic>>> data,
    required BoxConstraints constraints,
    required String storageKey
  }) {
    return Consumer(
      builder:(context,prov,_)=> prov.watch(data).when(
          error: (err,stack)=>errorProvider(err) ,

          loading: (){
            return Shimmer.fromColors(
              baseColor: Colors.grey.shade500,
              highlightColor: Colors.grey.shade100 ,
              child: CarouselSlider(
                options: CarouselOptions(
                  height: constraints.maxHeight * 0.6,
                  enlargeCenterPage: true,
                  disableCenter: true ,
                  viewportFraction: 0.75 ,
                ), items: const [
                Material(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                )
              ],
              ),
            );
          },

          data: (data)=> AnimatedConditionalBuilder(
              condition: data.docs.isEmpty,
              builder: (BuildContext context){
                return GestureDetector(
                  onTap: (){},
                  child: const CustomText(
                    text: 'Not Found Data' ,
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                );
              },
              fallback: (BuildContext context){
                return CarouselSlider.builder(
                  key: PageStorageKey<String>(storageKey),
                  options: CarouselOptions(
                    height: constraints.maxHeight * 0.6,
                    enlargeCenterPage: true,
                    disableCenter: true ,
                    viewportFraction: 0.75 ,
                  ),
                  itemCount: data.docs.length ,
                  itemBuilder: (BuildContext context , int i , int l) {
                    final CartModel _data = CartModel.fromApp(data.docs.elementAt(i).data());

                    return GestureDetector(
                      onTap: () async {
                        Navigator.of(context).pushNamed(MainDetailsHomeScreen.detailsHome,arguments: _data);},
                      child: DefaultHomeImage(
                          tag: _data.id ,
                          id: _data.id ,
                          image: _data.image ,
                          name: _data.name ,
                          price: _data.price ,
                          borderRadius: 15.0 ,
                          length: 0,
                          hide: true
                      ),
                    );
                  },
                );
              }
          )
      ),
    );
  }


  final List<Map<String,dynamic>> _selectedWidgets = <Map<String,dynamic>>[
    <String,String>{
      'id':'1',
      'title':'Vegetables',
      'image':'assets/images/Vegetables.jpg',
    } ,

    <String,String>{
      'id':'2',
      'title':'Meat',
      'image':'assets/images/Meat.jpg',
    } ,

    <String,String>{
      'id':'3',
      'title':'Other',
      'image':'assets/images/Other.jpg',
    }
  ];
}