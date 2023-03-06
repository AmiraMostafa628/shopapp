import 'package:all_tests/models/shop_model/cart_model.dart';
import 'package:all_tests/shared/cubit/shop_cubit.dart';
import 'package:all_tests/shared/network/style/color.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:toast/toast.dart';

import 'constant.dart';

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  double radius = 10.0,
  required Function function,
  required String text,
}) =>
    Container(
      width: width,
      height: 40.0,
      child: MaterialButton(
        onPressed: (){
          function();
        },
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 17
          ),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: background,
      ),
    );

Widget defaultTextButten({
  required Function function,
  required String text,
  Color color = Colors.blue,

})=>TextButton(
    onPressed: (){function();},
    child: Text(
        text,
      style: TextStyle(
        color: color
      ),
    )

);

Widget defaultFormField ({
  required TextEditingController controller,
  required TextInputType type,
  FormFieldValidator? validate,
  Function? onSubmit,
  required String label,
  required IconData prefix,
  IconData? suffix,
  bool isPassword =false,
  Function? suffixPressed,
  bool isClickable = true,
  Color? color,
  Color? iconColor,
  double radius = 20.0,
}

) => TextFormField(
  controller: controller,
  style: TextStyle(
      color: color,
    fontSize: 16,
    height: 1.2,
  ),

  keyboardType:type ,
  obscureText: isPassword,
  onFieldSubmitted:(s){
    onSubmit!(s);
  },
  validator: (value) {
    return validate!(value);
  },
  enabled: isClickable,

  decoration: InputDecoration(
    labelText: label,
    labelStyle: TextStyle(
        color: color,
         fontSize: 14,
    ) ,
    prefixIcon: Icon(
      prefix,
      color: color,),
    suffixIcon: suffix!= null ? IconButton(
      onPressed: () {
        suffixPressed!();
      },
      icon:Icon(suffix),color: iconColor,) : null ,
    border:OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius)
    ),

  ),



);

void NavigateTo(context,Widget)=>Navigator.push(
    context,
    MaterialPageRoute(
      builder:(context) => Widget,
    )
);

void navigateAndFinish(context,Widget) => Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder:(context) => Widget,
    ),
        (route) => false);

void showToast(
    {
      required text,
      required ToastState state,

    }
)=>Toast.show(
      text,
      duration: 5,
      gravity: Toast.bottom,
      textStyle: TextStyle(fontSize: 16),
      backgroundColor: chooseToastColor(state),

);

enum ToastState {SUCCESS,ERROR,WARNING}

Color chooseToastColor(ToastState state)
{
  Color? color;

  switch(state)
  {
    case ToastState.SUCCESS:
       color = Colors.green;
       break;
    case ToastState.ERROR:
       color = Colors.red;
       break;
    case ToastState.WARNING:
       color = Colors.amber;
       break;
  }
  return color;
}

void showSnackBar(
    context,
    {
      required text,
      required ToastState state,

    }
    )
{
  final snackBar=  SnackBar(
      content: Text('$text'),
      backgroundColor:chooseToastColor(state),

    );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);

}

Widget myDivider() =>Padding(
  padding: const EdgeInsetsDirectional.only(start: 10.0),
  child: Container(
    width: double.infinity,
    height: 1.0,
    color: Colors.grey[300],
  ),
);

Widget buildListItem(
    model,
    context,
    {
      bool isfavScreen=true,
      bool iscartScreen=true,

    }
    )=>Padding(
  padding: const EdgeInsets.all(20.0),
  child: Container(
    height: 120,
    child: Row(
      children: [
        Stack(
          alignment:AlignmentDirectional.bottomStart ,
          children: [
            Image(
              image: NetworkImage('${model.image}'),
              width: 120,
              height: 120,

            ),
            if(model.discount !=0 && isfavScreen||model.discount !=0 && iscartScreen)
              Container(
                color: Colors.red,
                padding: EdgeInsets.symmetric(horizontal: 5.0),
                child: Text(
                  'discount',
                  style: TextStyle(
                      fontSize: 8.0,
                      color: Colors.white
                  ),
                ),
              )
          ],
        ),
        SizedBox(
          width: 20,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${model.name}',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 15.0,
                    height: 1.4,
                    color: ShopCubit.get(context).isDark? Colors.white:HexColor('333739'),
                ),

              ),
              Spacer(),
              Row(
                children: [
                  Text(
                    '${model.price}',
                    style: TextStyle(
                      fontSize: 12.0,
                      color: defaultColor,
                    ),

                  ),
                  SizedBox(
                    width: 5.0,),
                  if(model.discount !=0 && isfavScreen||model.discount !=0 && iscartScreen)
                    Text(
                      '${model.oldPrice}',
                      style: TextStyle(
                          fontSize: 10.0,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough
                      ),


                    ),
                  Spacer(),
                  if(isfavScreen)
                      IconButton(onPressed:(){
                   ShopCubit.get(context).changeFavorites(model.id);
                  },
                      icon: CircleAvatar(
                          radius: 15.0,
                          backgroundColor:ShopCubit.get(context).favorites[model.id] ? defaultColor: Colors.grey,
                          child: Icon(
                            Icons.favorite_border,
                            size: 14.0,
                            color: Colors.white,
                          )
                      )),
                  if(iscartScreen)
                    IconButton(onPressed:(){
                      ShopCubit.get(context).changeCart(model.id);
                    },
                        icon: CircleAvatar(
                            radius: 15.0,
                            backgroundColor:ShopCubit.get(context).cart
                            [model.id] ? defaultColor: Colors.grey,
                            child: Icon(
                              Icons.shopping_cart,
                              size: 14.0,
                              color: Colors.white,
                            )
                        )),
                ],
              ),
            ],
          ),
        )

      ],
    ),
  ),
);
