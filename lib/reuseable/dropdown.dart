// import 'package:dropdown_button2/dropdown_button2.dart';
// import 'package:flutter/material.dart';

// class DropdownCustom extends StatefulWidget {
//   const DropdownCustom({
//     super.key,
//     required this.selectedValue,
//     this.onSelected,
//     this.items,
//     this.hintText = "",
//   });

//   final String selectedValue;
//   final void Function(String selected)? onSelected;
//   final List<DropdownMenuItem<String>>? items;
//   final String hintText;

//   @override
//   State<DropdownCustom> createState() => _DropdownCustomState();
// }

// class _DropdownCustomState extends State<DropdownCustom> {
//   final FocusNode _focusNode = FocusNode();
//   bool _isFocused = false;

//   @override
//   void initState() {
//     super.initState();
//     _focusNode.addListener(_onFocusChange);
//   }

//   @override
//   void dispose() {
//     _focusNode.removeListener(_onFocusChange);
//     _focusNode.dispose();
//     super.dispose();
//   }

//   void _onFocusChange() {
//     setState(() {
//       _isFocused = _focusNode.hasFocus;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return DropdownButtonFormField2(
//       decoration: InputDecoration(
//         filled: true,
//         fillColor: _isFocused ? Colors.white : Colors.grey[200],
//         // labelText: S.of(context).gender,
//         //Add isDense true and zero Padding.
//         //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
//         isDense: true,
//         contentPadding: const EdgeInsets.only(
//           top: 18,
//           bottom: 18,
//           right: 10,
//         ),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(15),
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderSide: const BorderSide(width: 1, color: Colors.grey),
//           borderRadius: BorderRadius.circular(15),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderSide: const BorderSide(width: 1, color: Colors.grey),
//           borderRadius: BorderRadius.circular(15),
//         ),
//         //Add more decoration as you want here
//         //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
//       ),
//       isExpanded: true,
//       hint: Text(
//         (widget.selectedValue == "") ? widget.hintText : widget.selectedValue,
//         style: const TextStyle(
//           fontSize: 14,
//           color: Colors.black54,
//           fontWeight: FontWeight.w400,
//         ),
//       ),
//       iconStyleData: const IconStyleData(
//         icon: Icon(
//           Icons.arrow_drop_down,
//           color: Colors.black45,
//         ),
//         iconSize: 30,
//       ),
//       items: widget.items,
//       onChanged: (value) {
//         widget.onSelected!(value!);
//       },
//     );
//   }
// }
