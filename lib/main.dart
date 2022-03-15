import 'package:commerce/Helper/Constance/const_firebase.dart';
import 'package:commerce/Helper/Constance/const_functions.dart';
import 'package:commerce/Helper/Constance/const_state.dart';
import 'package:commerce/Helper/Constance/const_theme.dart';
import 'package:commerce/Helper/Widgets/Customs/custom_widgets.dart';
import 'package:commerce/Views/Auth/Login/main_login_screen.dart';
import 'package:commerce/Views/Main/app_localizations.dart';
import 'package:commerce/Views/Main/bottom_bar.dart';
import 'package:commerce/Views/Main/condition_builder.dart';
import 'package:commerce/Views/Main/routes_builder.dart';
import 'package:commerce/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';



Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  runApp( const ProviderScope(child: MyApp()));

}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'ShopApp' ,
        restorationScopeId: 'root' ,
        supportedLocales: const [
          Locale("en",""),
          Locale("ar",""),
        ] ,
        localizationsDelegates: const [
          AppLocalization.delegate ,
          GlobalWidgetsLocalizations.delegate ,
          GlobalMaterialLocalizations.delegate ,
          GlobalCupertinoLocalizations.delegate
        ],
        localeResolutionCallback: ( currentLocal , supportedLocal ) {
          if( currentLocal != null ){
            for( Locale loopLocal in supportedLocal ) {
              if( currentLocal.languageCode == loopLocal.languageCode ){
                return currentLocal;
              }
            }
          }
          return supportedLocal.first ;
        },
        theme: themeLight ,
        darkTheme: themeDark ,
        themeMode: ThemeMode.light ,
        locale: !ref.watch(langProv).lang ? const Locale('ar','') : const Locale('en','') ,
        home: OfflineBuilder(
          connectivityBuilder: (BuildContext context,ConnectivityResult connectivity,Widget child) {
            final bool _connected = connectivity == ConnectivityResult.none;
            FlutterNativeSplash.remove();

            return AnimatedConditionalBuilder(
                 condition: _connected,
                 builder: (BuildContext context){
                   return Scaffold(
                     body: GestureDetector(
                       onTap: (){
                         setState(() {

                         });
                       },
                       child: Column(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children:  const [
                            Center(child: Icon(Icons.wifi_off,size: 50.0,)),
                            Center(child: CustomText(text: 'Check your Internet',fontSize: 18.0,)),
                         ],
                       ),
                     ),
                   );
                 },
                 fallback: (BuildContext context){
                   return Consumer(builder:(context,prov,_)=> prov.watch(_saveUser).when(
                       error: (err,stack)=> errorProvider(err) ,
                       loading: ()=> Shimmer.fromColors(
                           child: Container(
                             color: Colors.grey.shade500 ,
                             height: double.infinity ,
                             width: double.infinity
                           ),
                           baseColor: Colors.grey.shade100,
                           highlightColor: Colors.grey.shade500
                       ) ,
                     data: (data)=>AnimatedConditionalBuilder(
                       condition: data == null,
                       builder: (BuildContext context)=> const MainLoginScreen(),
                       fallback: (BuildContext context)=> const MainBottomBarScreen(),
                     )
                   ));
                 }
             );


          },
          child:  Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const <Widget>[
               Text(
                'There are no Buttons to Push :)',
              ),
               Text(
                'Just turn off your Internet.',
              ),
            ],
          ),
        ),
        debugShowCheckedModeBanner: false ,
        routes: RouteBuilder.routes
    );
  }
}

final _saveUser = StreamProvider((ref)=>firebaseAuth.authStateChanges());