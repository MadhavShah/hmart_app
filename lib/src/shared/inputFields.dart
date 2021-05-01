import 'package:flutter/material.dart';
import './colors.dart';
import './styles.dart';

Container martTextInput(String hintText,
    {onTap, onChanged, onEditingComplete, onSubmitted,TextEditingController controller}) {
  return Container(
    margin: EdgeInsets.only(top: 13),
    child: TextFormField(
      onTap: onTap,
      validator: (val){
        if(val.length==0)
          return 'Enter Valid Length';
        return null;
      },
      onChanged: onChanged,
      onEditingComplete: onEditingComplete,
      // onSubmitted: onSubmitted,
      controller: controller,
      cursorColor: primaryColor,
      style: inputFieldTextStyle,
      decoration: InputDecoration(
          hintText: hintText,
          hintStyle: inputFieldHintTextStyle,
          focusedBorder: inputFieldFocusedBorderStyle,
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          border: inputFieldDefaultBorderStyle),
    ),
  );
}

Container martNumberInput(String hintText,
    {onTap, onChanged, onEditingComplete, onSubmitted,TextEditingController controller}) {
  return Container(
    margin: EdgeInsets.only(top: 13),
    child: TextFormField(
      onTap: onTap,
      onChanged: onChanged,
      keyboardType: TextInputType.number,
      onEditingComplete: onEditingComplete,
      validator: (val){
        if(val.length==0)
          return 'Enter Valid Length';
        return null;
      },
      // onSubmitted: onSubmitted,
      controller: controller,
      cursorColor: primaryColor,
      style: inputFieldTextStyle,
      decoration: InputDecoration(
          hintText: hintText,
          hintStyle: inputFieldHintTextStyle,
          focusedBorder: inputFieldFocusedBorderStyle,
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          border: inputFieldDefaultBorderStyle),
    ),
  );
}

Container martEmailInput(String hintText,
    {onTap, onChanged, onEditingComplete, onSubmitted,TextEditingController controller}) {
  return Container(
    margin: EdgeInsets.only(top: 13),
    child: TextFormField(
      onTap: onTap,
      onChanged: onChanged,
      onEditingComplete: onEditingComplete,
      // onSubmitted: onSubmitted,
      validator: (val){
        if(val.length==0)
          return 'Enter Valid Length';
        return null;
      },
      controller: controller,
      keyboardType: TextInputType.emailAddress,
      cursorColor: primaryColor,
      style: inputFieldTextStyle,
      decoration: InputDecoration(
          hintText: hintText,
          hintStyle: inputFieldHintTextStyle,
          focusedBorder: inputFieldFocusedBorderStyle,
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          border: inputFieldDefaultBorderStyle),
    ),
  );
}


Container martPasswordInput(String hintText,
    {onTap, onChanged, onEditingComplete, onSubmitted, TextEditingController controller}) {
  return Container(
    margin: EdgeInsets.only(top: 13),
    child: TextFormField(
      onTap: onTap,
      onChanged: onChanged,
      onEditingComplete: onEditingComplete,
      // onSubmitted: onSubmitted,
      validator: (val){
        if(val.length<8)
          return 'password length must be greater then 8';
        return null;
      },
      obscureText: true,
      cursorColor: primaryColor,
      style: inputFieldHintPaswordTextStyle,
      controller: controller,
      decoration: InputDecoration(
          hintText: hintText,
          hintStyle: inputFieldHintPaswordTextStyle,
          focusedBorder: inputFieldFocusedBorderStyle,
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          border: inputFieldDefaultBorderStyle),
    ),
  );
}
