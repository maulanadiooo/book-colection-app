// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    Key? key,
    required this.text,
    this.canGoback = true,
    this.icon,
    this.sizeIcon = 14,
    this.ontapIcon,
  }) : super(key: key);

  final String text;
  final bool canGoback;
  final IconData? icon;
  final double sizeIcon;
  final void Function()? ontapIcon;

  @override
  Widget build(
    BuildContext context,
  ) {
    return Container(
      height: 44,
      width: double.infinity,
      margin: const EdgeInsets.only(
        top: 8,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          (canGoback)
              ? GestureDetector(
                  onTap: () {
                    bool canPop = Navigator.canPop(context);
                    if (canPop) {
                      Navigator.pop(context);
                    }
                  },
                  child: Container(
                    width: 35,
                    height: 35,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: Colors.grey.withOpacity(0.6),
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.arrow_back,
                        size: 26,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                )
              : (icon != null)
                  ? const SizedBox(
                      width: 35,
                    )
                  : const SizedBox(),
          const Spacer(),
          Text(
            text,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.black87,
              fontWeight: FontWeight.w700,
            ),
          ),
          const Spacer(),
          ((canGoback && icon != null) || (canGoback == false && icon != null))
              ? GestureDetector(
                  onTap: ontapIcon,
                  child: Container(
                    width: 35,
                    height: 35,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: Colors.grey.withOpacity(0.3),
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: Center(child: Icon(icon!)),
                  ),
                )
              : (canGoback && icon == null)
                  ? const SizedBox(
                      width: 35,
                    )
                  : const SizedBox(),
        ],
      ),
    );
  }
}
