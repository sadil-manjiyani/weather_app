import 'package:flutter/material.dart';
import 'package:weather_app/utils/colors.dart';

class DefaultButton extends StatefulWidget {
  const DefaultButton({Key? key, this.onTap, required this.child}) : super(key: key);
  final void Function()? onTap;
  final Widget child;

  @override
  State<DefaultButton> createState() => _DefaultButtonState();
}

class _DefaultButtonState extends State<DefaultButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Material(
        color: Colors.transparent,
        elevation: 2,
        child: Ink(
          decoration: const BoxDecoration(
            color: buttonColor,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 8),
          child: Center(
              child: widget.child
          ),
        ),
      ),
    );
  }
}
