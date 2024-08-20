import 'package:flutter/material.dart';

class CustomRadioListTile<T> extends StatelessWidget {
  const CustomRadioListTile(
      {super.key,
      required this.value,
      required this.groupValue,
      required this.label,
      required this.onChanged});
  final T value;
  final T groupValue;
  final String label;
  final ValueChanged<T?> onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () => onChanged(value),
        child: Row(
          children: [_customRadioButton],
        ));
  }

  Widget get _customRadioButton {
    final isSelected = (value == groupValue);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
          color: isSelected ? Colors.black : Colors.white,
          borderRadius: BorderRadius.circular(4)),
      child: Text(
        label,
        style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 15),
      ),
    );
  }
}
