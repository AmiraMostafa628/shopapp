import 'package:flutter/material.dart';

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  bool isUpperCase = true,
  double radius = 3.0,
  required Function function,
  required String text,
}) =>
    Container(
      width: width,
      height: 50.0,
      child: MaterialButton(
        onPressed: (){
          function();
        },
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(
            color: Colors.white,
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
})=>TextButton(
    onPressed: (){function();},
    child: Text(
        text.toUpperCase())
);

Widget defaultFormField ({
  required TextEditingController controller,
  required TextInputType type,
  Function? onSubmit,
  Function? onChange,
  Function? onTap,
  FormFieldValidator? validate,
  required String label,
  required IconData prefix,
  IconData? suffix,
  bool isPassword =false,
  Function? suffixPressed,
  bool isClickable = true,
}


) => TextFormField(
  controller: controller,
  onFieldSubmitted:(s){
    onSubmit!(s);
  },
  onChanged:(s){
    onChange!(s);
  },
  keyboardType:type ,
  obscureText: isPassword,
  onTap: (){
    onTap!();
  },
  validator: validate,
  enabled: isClickable,
  decoration: InputDecoration(
    labelText: label,
    prefixIcon: Icon(prefix),
    suffixIcon: suffix!= null ? IconButton(
        onPressed: () {
          suffixPressed!();
        },
        icon:Icon(suffix)) : null ,
    border:OutlineInputBorder(),
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
