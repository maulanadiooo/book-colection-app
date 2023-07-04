import 'package:booking_book/reuseable/button.dart';
import 'package:flutter/material.dart';

Future<dynamic> modalDialogGlobal({
  required BuildContext context,
  Size? size,
  String? title,
  String? contentBody,
  String? buttonText,
  void Function()? tapButton,
  void Function()? tapButtonCancel,
  void Function()? tapButtonCustomButton,
  bool isActiveCancelButton = false,
  String cancelButtonText = "Batal",
  bool isCustomSecondButton = false,
  String customSecondButtonText = '',
  Widget? customBody,
  bool scrollViewActive = false,
  bool dismissAble = false,
}) async {
  return showDialog(
    context: context,
    barrierDismissible: dismissAble,
    builder: (BuildContext ctxDialog) => AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15))),
      content: (customBody == null)
          ? Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title!,
                  style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                      fontSize: 14),
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  contentBody!,
                  style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                      fontSize: 16),
                ),
                const SizedBox(
                  height: 42,
                ),
                InkWell(
                  onTap: () {
                    tapButton!();
                  },
                  child: CustomButton(
                    text: buttonText!,
                  ),
                ),
                (isActiveCancelButton)
                    ? Container(
                        margin: const EdgeInsets.only(
                          top: 10,
                        ),
                        child: InkWell(
                          onTap: tapButtonCancel,
                          child: CustomButton(
                            text: cancelButtonText,
                            colorButton: Colors.transparent,
                            colorText: Colors.black,
                          ),
                        ),
                      )
                    : const SizedBox(),
                (isCustomSecondButton)
                    ? Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          InkWell(
                            onTap: tapButtonCustomButton,
                            child: CustomButton(
                              text: customSecondButtonText,
                            ),
                          ),
                        ],
                      )
                    : const SizedBox()
              ],
            )
          : Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                customBody,
              ],
            ),
    ),
  );
}
