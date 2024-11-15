import 'package:flutter/material.dart';

class ReOrderTextField extends StatelessWidget {
  final String prefix;
  final String? suffix;
  final bool showInfoIcon;
  final bool enabled;
  final bool isDropdown;
  final String? defaultValue;

  const ReOrderTextField({
    required this.prefix,
    this.suffix,
    this.showInfoIcon = false,
    this.enabled = true,
    this.isDropdown = false,
    this.defaultValue,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget buildTextField() {
      final baseDecoration = InputDecoration(
        filled: true,
        fillColor: Theme.of(context).cardColor,
        hintText: isDropdown?"Good till cancelled": "0.00",
        hintStyle: const TextStyle(
          color: Colors.grey,
          fontSize: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      );

      if (isDropdown) {
        return DropdownButtonFormField(
          decoration: baseDecoration,
          value: defaultValue,
          style: const TextStyle(
            color: Colors.black87,
            fontSize: 14,
          ),
          items: const [
            DropdownMenuItem(
              value: "Good till cancelled",
              child: Text("Good till cancelled"),
            ),
            DropdownMenuItem(
              value: "Fill or Kill",
              child: Text("Fill or Kill"),
            ),
            DropdownMenuItem(
              value: "Immediate or Cancel",
              child: Text("Immediate or Cancel"),
            ),
          ],
          onChanged: (value) {},
        );
      }

      return TextField(
        enabled: enabled,
        textAlign: TextAlign.end,
        style: const TextStyle(
          fontSize: 14,
        ),
        decoration: baseDecoration,
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Prefix row above the TextField
        Padding(
          padding: const EdgeInsets.only(bottom: 4),
          child: Row(
            children: [
              Text(
                prefix,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                  fontWeight: FontWeight.w400,
                ),
              ),
              if (showInfoIcon) ...[
                const SizedBox(width: 4),
                const Icon(Icons.info_outline, size: 14, color: Colors.grey),
              ],
              const Spacer(),
              if (suffix != null)
                Text(
                  suffix!,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                  ),
                ),
            ],
          ),
        ),
        // TextField or DropdownButtonFormField
        buildTextField(),
      ],
    );
  }
}