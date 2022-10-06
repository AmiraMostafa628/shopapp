import 'package:all_tests/modules/shop_app/login/loginScreen.dart';
import 'package:all_tests/shared/components/components.dart';
import 'package:all_tests/shared/network/local/cache_helper.dart';
import 'package:all_tests/shared/network/style/color.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingModel
{
  final String image;
  final String title;
  final String body;

  OnBoardingModel(
      {
        required this.image,
        required this.title,
        required this.body,
      });

}
class OnBoardingScreen extends StatefulWidget
{
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List <OnBoardingModel> onBoarding =
  [
    OnBoardingModel(
      image: 'assets/images/onboard_1.jpg',
      title: 'You don\'t have to go shopping',
      body:  'In past you had to go shopping but it waste your time',
    ),
    OnBoardingModel(
      image: 'assets/images/onboard2.jpg',
      title: 'Now the life is easy',
      body:  'You can buy anything without going out your home anymore',
    ),
    OnBoardingModel(
      image: 'assets/images/onboard3.jpg',
      title: 'Your order will come to your home',
      body:  'It\'s easy now, you will receive your order faster by using drones delivery',
    ),

  ];

  var boardController = PageController();

  bool isLast =false;

  void  submit(){
    CacheHelper.saveData(key: 'onBoarding', value: true);
    navigateAndFinish(context,ShopLoginScreen());
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          defaultTextButten(
              function: submit,
              text: 'Skip',
            color: defaultColor
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Flexible(
              child:  PageView.builder(
                controller: boardController,
                physics: BouncingScrollPhysics(),
                onPageChanged: (int index)
                {
                  if(index==onBoarding.length-1)
                  {
                    setState(() {
                      isLast=true;
                    });
                  }
                  else
                  {
                    setState(() {
                      isLast=false;
                    });
                  }

                },

                itemBuilder: (context,index)=>buildBoardingItem(onBoarding[index]),
                itemCount: onBoarding.length,
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                    controller: boardController,
                    effect: ExpandingDotsEffect(
                      dotColor: Colors.grey,
                      activeDotColor:defaultColor,
                      dotHeight: 10,
                      expansionFactor: 4, // space between them
                      dotWidth: 10,
                      spacing: 5.0,
                    ),
                    count: onBoarding.length),
                Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if(isLast)
                    {
                      submit();
                    }
                    else
                    {
                      boardController.nextPage(duration: Duration(
                        milliseconds: 750,
                      ), curve: Curves.fastLinearToSlowEaseIn);
                    }
                  },
                  backgroundColor: defaultColor,
                  child: Icon(Icons.arrow_forward_ios),)
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(OnBoardingModel model)=>Center(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Image(
              image: AssetImage('${model.image}')
          ),
        ),

       Text(
         '${model.title}',
         style: TextStyle(
           fontSize: 24.0,
         ),
       ),
       SizedBox(
         height: 10.0,
       ),
       Text(
         '${model.body}',
         style: TextStyle(
           fontSize: 14.0,
         ),
       ),
        SizedBox(
          height: 30.0,
        ),

      ],
    ),
  );
}
