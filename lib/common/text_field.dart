import 'package:flutter/material.dart';

import '../utils/color_res.dart';

class CommonTextField extends StatelessWidget {
  final TextEditingController? controller;

  final int? maxLines;
  final String? hintText;
  final TextStyle? hintStyle;
  final Widget prefixIcon;
  final Widget? prefix;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final TextInputAction textInputAction;

  final void Function(String)? onChange;

  const CommonTextField({
    Key? key,
    this.controller,
    this.onChange,
    this.hintText,
    required this.prefixIcon,
    this.suffixIcon,
    this.hintStyle,
    this.prefix,
    this.keyboardType,
    this.maxLines,
    required this.textInputAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      maxLines: maxLines,
      onChanged: onChange,
      controller: controller,
      textInputAction: textInputAction,
      decoration: InputDecoration(
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(width: 2, color: colorRes.blue),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(width: 2, color: colorRes.grey),
        ),
        errorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(width: 1, color: Colors.red)),
        prefix: prefix,
        hintText: hintText,
        hintStyle: hintStyle,
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: colorRes.grey),
          borderRadius: BorderRadius.circular(
            10,
          ),
        ),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
      ),
    );
  }
}

class PasswordField extends StatelessWidget {
  final TextEditingController controller;
  final Widget? prefix;
  final bool isprefix;
  final Widget? sufix;
  final bool issufix;
  final bool? isclick;
  final VoidCallback? ontap;
  final String? hintText;
  final Widget? child;
  final void Function(String)? onChange;

  PasswordField(
      {Key? key,
      required this.controller,
      this.prefix,
      required this.isprefix,
      this.sufix,
      required this.issufix,
      this.isclick,
      this.ontap,
      this.hintText,
      this.child,
      this.onChange})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ValueNotifier _visiblePassword = ValueNotifier<bool>(true);

    return ValueListenableBuilder(
      valueListenable: _visiblePassword,
      builder: (context, value, child) => TextFormField(
        keyboardType: TextInputType.visiblePassword,
        obscureText: value,
        controller: controller,
        onChanged: onChange,
        decoration: InputDecoration(
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(width: 2, color: colorRes.blue),
          ),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(width: 2, color: colorRes.grey),
          ),
          errorBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(width: 1, color: Colors.red)),
          hintText: hintText,
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: colorRes.grey),
            borderRadius: BorderRadius.circular(
              10,
            ),
          ),
          prefixIcon: isprefix
              ? IconButton(
                  iconSize: 18,
                  icon: const Icon(
                    Icons.lock_open,
                    color: colorRes.grey,
                  ),
                  onPressed: () {},
                )
              : const SizedBox(),
          suffixIcon: issufix
              ? IconButton(
                  color: colorRes.blue,
                  iconSize: 18,
                  onPressed: () =>
                      _visiblePassword.value = !_visiblePassword.value,
                  icon: value
                      ? const Icon(
                          Icons.visibility_off,
                          color: colorRes.grey,
                        )
                      : const Icon(
                          Icons.visibility_rounded,
                          color: colorRes.blue,
                        ),
                )
              : const SizedBox(),
        ),
      ),
    );
  }
}
