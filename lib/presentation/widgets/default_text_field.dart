 import 'package:bmi/styles/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DefaultTextField extends StatefulWidget {
  final String hintText;
  final String labelText;
  IconData? prefixIcon;
  IconData? suffixIcon;
  bool isPass;
  String value;
  int? lines;
  Color? hintColor;
  TextInputType textInputType;
  bool isEnabled;
  TextEditingController controller = TextEditingController();

  DefaultTextField(
      {required this.hintText,
      required this.controller,
      this.hintColor = Colors.grey,
      this.isPass = false,
      this.isEnabled = true,
      required this.textInputType,
      this.labelText = "",
      this.value = '',
      this.prefixIcon,
      this.suffixIcon,
      this.lines = 1,
      Key? key})
      : super(key: key);

  @override
  State<DefaultTextField> createState() => _DefaultTextFieldState();
}

class _DefaultTextFieldState extends State<DefaultTextField> {
  bool isChecked = true;

  @override
  Widget build(BuildContext context) {
    return widget.isPass == false
        ? Container(
            padding: const EdgeInsets.symmetric(
              vertical: 0,
              horizontal: 0,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Material(
              borderRadius: BorderRadius.circular(15),
              elevation: 0.0,
               color: Colors.transparent ,
               child: TextFormField(
                textInputAction: TextInputAction.next,
                style: GoogleFonts.almarai(
                  fontSize: 15.0,
                  color: Colors.white,
                ),
                 decoration: InputDecoration(
                     hintText: widget.hintText,
                     hintStyle: GoogleFonts.almarai(
                       fontSize: 15.0,
                       color: widget.hintColor,
                       fontWeight: FontWeight.w200,
                     ),
                     border: InputBorder.none,
                     enabledBorder: OutlineInputBorder(
                         borderRadius: BorderRadius.circular(
                           12,
                         ),
                         borderSide: const BorderSide(color: ColorsManager.greenBlue)),
                     focusedBorder: OutlineInputBorder(
                         borderRadius: BorderRadius.circular(12),
                         borderSide: const BorderSide(color: ColorsManager.greenBlue)),
                     errorBorder: OutlineInputBorder(
                       borderRadius: BorderRadius.circular(12),
                     ),
                     errorStyle: GoogleFonts.almarai(
                       fontSize: 13.0,
                       color: Colors.red,
                     ),
                     prefixIcon: Icon(
                       widget.prefixIcon,
                       color: ColorsManager.greenBlue,
                     ),
                     suffixIcon: widget.isPass == true
                         ? IconButton(
                       onPressed: () {
                         setState(() {
                           isChecked = !isChecked;
                         });
                       },
                       icon: isChecked == true
                           ? const Icon(
                         Icons.visibility_off,
                         color: ColorsManager.greenBlue,
                       )
                           : const Icon(
                         Icons.visibility,
                         color: ColorsManager.greenBlue,
                       ),
                     )
                         : IconButton(
                       onPressed: () {},
                       icon: widget.suffixIcon != null
                           ? Icon(
                         widget.suffixIcon,
                         color: ColorsManager.greenBlue,
                       )
                           : const SizedBox(
                         height: 1,
                         width: 1,
                       ),
                     )),
                maxLines: widget.lines,
                keyboardType: widget.textInputType,
                controller: widget.controller,
                enabled: widget.isEnabled,
                onChanged: (value) {
                  widget.value = value;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Required Field';
                  }
                  return null;
                },
              ),
            ),
          )
        : Container(
            padding: const EdgeInsets.symmetric(
              vertical: 0,
              horizontal: 0,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7),
            ),

            child: Material(
              borderRadius: BorderRadius.circular(15),
              elevation: 0.0,
              color: Colors.transparent ,
               child: TextFormField(
                textInputAction: TextInputAction.done,
                style: GoogleFonts.almarai(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w200,
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                    hintText: widget.hintText,
                    hintStyle: GoogleFonts.almarai(
                        fontSize: 15.0,
                      color: widget.hintColor,
                      fontWeight: FontWeight.w200,
                    ),
                    border: InputBorder.none,
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          12,
                        ),
                        borderSide: const BorderSide(color: ColorsManager.greenBlue)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: ColorsManager.greenBlue)),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    errorStyle: GoogleFonts.almarai(
                      fontSize: 13.0,
                      color: Colors.red,
                    ),
                     prefixIcon: Icon(
                      widget.prefixIcon,
                      color: ColorsManager.greenBlue,
                    ),
                    suffixIcon: widget.isPass == true
                        ? IconButton(
                      onPressed: () {
                        setState(() {
                          isChecked = !isChecked;
                        });
                      },
                      icon: isChecked == true
                          ? const Icon(
                        Icons.visibility_off,
                        color: ColorsManager.greenBlue,
                      )
                          : const Icon(
                        Icons.visibility,
                        color: ColorsManager.greenBlue,
                      ),
                    )
                        : IconButton(
                      onPressed: () {},
                      icon: widget.suffixIcon != null
                          ? Icon(
                        widget.suffixIcon,
                        color: ColorsManager.greenBlue,
                      )
                          : const SizedBox(
                        height: 1,
                        width: 1,
                      ),
                    )),
                keyboardType: widget.textInputType,
                controller: widget.controller,
                enabled: widget.isEnabled,
                obscureText: isChecked,
                onChanged: (value) {
                  widget.value = value;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Required Field';
                  }
                  return null;
                },
              ),
            ),
    );
  }
}
