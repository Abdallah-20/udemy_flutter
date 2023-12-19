import '../../modules/shop_app/login/shop_login_screen.dart';
import '../network/local/cache_helper.dart';
import 'components.dart';

void singOut (context){
  CacheHelper.removeData(key: 'token').then((value) {
    navigateAndFinish(
      context,
      ShopLoginScreen(),
    );
  });

}

void printFullText(String text){
  final pattern = RegExp('.{1,800}');
  pattern.allMatches(text).forEach((element) => print(element.group(0)));
}

String? token;

String? uId;