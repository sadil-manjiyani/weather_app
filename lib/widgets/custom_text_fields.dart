import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weather_app/utils/colors.dart';
import 'package:weather_app/widgets/space.dart';

class  CustomTextField extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  final TextInputType? textType;
  final Icon? prefixIcon;
  final  List<TextInputFormatter>? inputFormatters;
  final String? error;
  final void Function(String)? onChanged;
  final bool? enabled;

  const  CustomTextField({
    Key? key,
    required this.hint,
    required this.controller,
    this.textType,
    this.prefixIcon,
    this.inputFormatters,
    this.error,
    this.onChanged, 
    this.enabled,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
                border: Border.all(
                    color: error == null || error == "" ? Colors.black87 : Colors.red, width: 1),
            ),
            child: TextFormField(
              enabled: enabled,
              onChanged: onChanged,
              inputFormatters: inputFormatters,
              controller: controller,
              keyboardType: textType,
              textCapitalization: TextCapitalization.words,
              textAlignVertical: TextAlignVertical.center,
              style: const TextStyle(
                color: textColor,
                fontWeight: FontWeight.w400,

              ),
               cursorColor: textColor,
              decoration: InputDecoration(
                border: InputBorder.none,
                prefix: prefixIcon,
                hintText: hint,
                counterText: "",
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: 10),
                hintStyle: const TextStyle(
                  color: textColorSecondary,
                  fontWeight: FontWeight.w400,
                  fontSize: 13,
                ),
              ),
              textAlign: TextAlign.left,
            ),
          ),
          addVerticalSpace(5),
          if (error != null && error != "")
            Text(
              error!,
              style: const TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.w500,
                fontSize: 10,
              ),
            ),
        ],
      ),
    );
  }
}