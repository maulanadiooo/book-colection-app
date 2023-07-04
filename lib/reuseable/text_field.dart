import 'package:flutter/material.dart';

class InputTextField extends StatefulWidget {
  const InputTextField({
    Key? key,
    required this.controller,
    required this.labelText,
    this.secure = false,
    this.enabled = true,
    this.showCounter = false,
    this.inputType = TextInputType.text,
    this.maxLines = 1,
    this.maxLength = 100,
    this.marginActive = false,
    this.isError = false,
    this.hintText = '',
    this.labelColor,
    this.isSuffixActive = false,
    this.suffixIcon,
    this.onSuffixPress,
    this.onChanged,
    this.borderSideActive = true,
    this.marginTop,
    this.ontapTextField,
    this.hinTextColor,
    this.fillColorCustom,
  }) : super(key: key);

  final TextEditingController controller;
  final String labelText;
  final bool secure;
  final bool enabled;
  final bool showCounter;
  final TextInputType inputType;
  final int maxLines;
  final int? maxLength;
  final bool marginActive;
  final bool isError;
  final String hintText;
  final Color? labelColor;
  final bool isSuffixActive;
  final IconData? suffixIcon;
  final void Function()? onSuffixPress;
  final void Function(String val)? onChanged;
  final bool borderSideActive;
  final double? marginTop;
  final void Function()? ontapTextField;
  final Color? hinTextColor;
  final Color? fillColorCustom;

  @override
  State<InputTextField> createState() => _InputTextFieldState();
}

class _InputTextFieldState extends State<InputTextField> {
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.ontapTextField,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: (widget.marginActive) ? 20 : 0,
        ),
        margin: EdgeInsets.only(
          top: (widget.marginTop != null) ? widget.marginTop! : 0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(
                bottom: 12,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    widget.labelText,
                    style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            TextField(
              focusNode: _focusNode,
              maxLength: widget.maxLength,
              maxLines: widget.maxLines,
              enabled: widget.enabled,
              onChanged: widget.onChanged,
              obscureText: widget.secure,
              keyboardType: widget.inputType,
              textInputAction: TextInputAction.done,
              controller: widget.controller,
              decoration: InputDecoration(
                filled: true,
                fillColor: _isFocused
                    ? Colors.white
                    : (widget.enabled)
                        ? Colors.grey[100]
                        : (widget.fillColorCustom != null)
                            ? widget.fillColorCustom
                            : Colors.grey.withOpacity(0.7),
                hintText: widget.hintText,
                hintStyle: const TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                    fontWeight: FontWeight.w400),
                counterText: (widget.showCounter) ? null : "",
                enabledBorder: (widget.borderSideActive)
                    ? OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 1,
                            color: (widget.isError) ? Colors.red : Colors.grey),
                        borderRadius: BorderRadius.circular(15),
                      )
                    : null,
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(width: 2, color: Colors.blue),
                  borderRadius: BorderRadius.circular(15),
                ),
                disabledBorder: (widget.borderSideActive)
                    ? OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 1, color: Colors.grey),
                        borderRadius: BorderRadius.circular(15),
                      )
                    : null,
                suffixIcon: (widget.isSuffixActive)
                    ? IconButton(
                        onPressed: widget.onSuffixPress,
                        icon: Icon(
                          widget.suffixIcon,
                          color: Colors.grey,
                        ),
                      )
                    : null,
              ),
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: (widget.enabled) ? Colors.black : Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
