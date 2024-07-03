import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ignore: must_be_immutable
class CustomTextField extends StatefulWidget {
  final TextEditingController? textEditingController;
  final String placeholderText;
  final IconData? icon;
  final TextInputFormatter? inputFormat;
  final TextInputType? keyboardType;
  final void Function(String)? onChange;
  final String? Function(String?)? validator;
  const CustomTextField(
      {this.textEditingController,
      super.key,
      required this.placeholderText,
      this.icon,
      this.onChange,
      this.inputFormat,
      this.keyboardType,
      this.validator});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        controller: widget.textEditingController,
        keyboardType: widget.keyboardType ?? TextInputType.name,
        inputFormatters: [
          widget.inputFormat ?? FilteringTextInputFormatter.singleLineFormatter
        ],
        validator: widget.validator,
        onChanged: widget.onChange,
        decoration: InputDecoration(
          enabled: true,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          filled: true,
          hintText: widget.placeholderText,
          hintStyle: const TextStyle(
              color: Color.fromARGB(255, 142, 142, 142),
              fontWeight: FontWeight.w500,
              fontSize: 14),
          prefixIcon: widget.icon != null
              ? Icon(widget.icon, color: Colors.white)
              : null,
          fillColor: Colors.white,
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color.fromARGB(255, 177, 177, 177)),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color.fromARGB(255, 177, 177, 177)),
              borderRadius: BorderRadius.all(Radius.circular(10))),
        ),
      ),
    );
  }
}
