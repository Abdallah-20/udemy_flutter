import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:udemy_flutter/modules/shop_app/login/shop_login_screen.dart';
import 'package:udemy_flutter/shared/components/components.dart';
import 'package:udemy_flutter/shared/network/local/cache_helper.dart';
import 'package:udemy_flutter/shared/styles/colors.dart';

class BoardingModel {
  final String image;
  final String title;
  final String body;

  BoardingModel({
    required this.image,
    required this.title,
    required this.body,
  });
}

class OnBoardingScreen extends StatefulWidget {
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardController = PageController();
  bool isLast = false;

  List<BoardingModel> boarding = [
    BoardingModel(
        image: 'assets/images/on_boarding_1.png',
        title: 'On Board Title 1',
        body: 'On Board Body 1'),
    BoardingModel(
        image: 'assets/images/on_boarding_1.png',
        title: 'On Board Title 2',
        body: 'On Board Body 2'),
    BoardingModel(
        image: 'assets/images/on_boarding_1.png',
        title: 'On Board Title 3',
        body: 'On Board Body 3'),
  ];

  void submit() {
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
      navigateAndFinish(
        context,
        ShopLoginScreen(),
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          defaultTextButton(function: submit, text: 'skip',),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: boardController,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) =>
                    buildBoardingItem(boarding[index]),
                itemCount: boarding.length,
                onPageChanged: (int index) {
                  if (index == boarding.length - 1) {
                    isLast = true;
                  } else {
                    isLast = false;
                  }
                },
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardController,
                  count: boarding.length,
                  effect: ExpandingDotsEffect(
                    activeDotColor: defultColor,
                    dotColor: Colors.grey,
                    dotHeight: 10,
                    expansionFactor: 4,
                    dotWidth: 10,
                    spacing: 5,
                  ),
                ),
                Spacer(),
                FloatingActionButton(
                  onPressed: () {

                    if (isLast) {
                      submit();
                    } else {
                      boardController.nextPage(
                        duration: Duration(milliseconds: 750),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    }
                  },
                  child: Icon(Icons.arrow_forward_ios),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(BoardingModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image(image: AssetImage(model.image)),
          ),
          SizedBox(
            height: 30.0,
          ),
          Text(
            model.title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25.0,
            ),
          ),
          SizedBox(
            height: 15.0,
          ),
          Text(
            model.body,
            style: TextStyle(
              fontSize: 15.0,
            ),
          ),
          SizedBox(
            height: 15.0,
          ),

          // PageView.builder(
          //   itemBuilder: (context, index) {},
          // ),
        ],
      );

}
