import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:desktop_window/desktop_window.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:udemy_flutter/layout/news_app/cubit/cubit.dart';
import 'package:udemy_flutter/layout/news_app/news_layout.dart';
import 'package:udemy_flutter/layout/shop_app/cubit/cubit.dart';
import 'package:udemy_flutter/layout/shop_app/shop_layout.dart';
import 'package:udemy_flutter/layout/social_app/cubit/cubit.dart';
import 'package:udemy_flutter/layout/social_app/social_layout.dart';
import 'package:udemy_flutter/modules/native_code.dart';
import 'package:udemy_flutter/modules/shop_app/login/shop_login_screen.dart';
import 'package:udemy_flutter/modules/shop_app/on_boarding/on_boarding_screen.dart';
import 'package:udemy_flutter/modules/social_app/social_login/social_login_screen.dart';
import 'package:udemy_flutter/shared/bloc_observer.dart';
import 'package:udemy_flutter/shared/components/components.dart';
import 'package:udemy_flutter/shared/components/constants.dart';
import 'package:udemy_flutter/shared/cubit/cubit.dart';
import 'package:udemy_flutter/shared/cubit/states.dart';
import 'package:udemy_flutter/shared/network/local/cache_helper.dart';
import 'package:udemy_flutter/shared/network/remote/dio_helper.dart';
import 'package:udemy_flutter/shared/styles/themes.dart';

import 'modules/shop_app/products/products_screen.dart';

// Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   print('on background message');
//   print(message.data.toString());
//   showToast(text: 'on background message', state: ToastStates.SUCCESS);
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

    if (Platform.isWindows) await DesktopWindow.setMinWindowSize(Size(650, 650));

  // await Firebase.initializeApp();
  // var token = await FirebaseMessaging.instance.getToken();
  // print(token);
  //
  // FirebaseMessaging.onMessage.listen((event) {
  //   print('on message');
  //   print(event.data.toString());
  //   showToast(text: 'on message', state: ToastStates.SUCCESS);
  // });
  //
  // FirebaseMessaging.onMessageOpenedApp.listen((event) {
  //   print('on message Opened App');
  //   print(event.data.toString());
  //   showToast(text: 'on message Opened App', state: ToastStates.SUCCESS);
  // });
  //
  // FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  bool? isDark = CacheHelper.getData(key: 'isDark');
  // bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
  // token = CacheHelper.getData(key: 'token');
  uId = CacheHelper.getData(key: 'uId');
  // print('token: ${token}');
  late Widget widget;

  if (uId != null) {
    widget = SocialLayout();
  } else {
    widget = SocialLoginScreen();
  }
  // if (onBoarding != null) {
  //   if (token != null) {
  //     widget = ShopLayout();
  //   } else {
  //     widget = ShopLoginScreen();
  //   }
  // } else {
  //   widget = OnBoardingScreen();
  // }
  // print(onBoarding);

  runApp(MyApp(isDark: isDark, startWidget: widget));
}

class MyApp extends StatelessWidget {
  final bool? isDark;
  final Widget? startWidget;

  MyApp({required this.isDark, required this.startWidget});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => NewsCubit()..getBusiness()),
        BlocProvider(
            create: (context) => ShopCubit()
              ..getHomeData()
              ..getCategories()
              ..getFavorites()
              ..getUserData()),
        BlocProvider(
            create: (context) => AppCubit()
              ..changeMode(
                fromShared: isDark,
              )),
        BlocProvider(
            create: (context) => SocialCubit()
              ..getUserData()
              ..getPosts()),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode:
                AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            home:
            ProductsScreen(),
            // ScreenTypeLayout(
            //   mobile: NewsLayout(),
            //   desktop: Text('data'),
            //   breakpoints: ScreenBreakpoints(
            //     desktop: 600,
            //     tablet: 300,
            //     watch: 300,
            //   ),
            // ),

            // Directionality(
            //   textDirection: TextDirection.ltr,
            //   child: startWidget!,
            // ),
          );
        },
      ),
    );
  }
}
