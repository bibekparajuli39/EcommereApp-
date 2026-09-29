import 'package:flutter/material.dart';

import 'package:nana/core/constants/theme_color.dart';

Widget profileMenu({
  required IconData icon,
  required String title,
  required String subtitle,
  required VoidCallback onTap,
  Color iconColor = ThemeColor.primaryColor,
  Color titleColor = Colors.black,
}) {
  return Card(
    margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
    elevation: 1,
    shadowColor: Colors.black12,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    child: ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),

      leading: Container(
        height: 42,
        width: 42,
        decoration: BoxDecoration(
          color: iconColor == Colors.redAccent
              ? Colors.red.withValues(alpha: 0.08)
              : const Color(0xFFF0EBFF),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: iconColor),
      ),

      title: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.w600, color: titleColor),
      ),

      subtitle: Text(
        subtitle,
        style: const TextStyle(fontSize: 12, color: Colors.grey),
      ),

      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 15,
        color: Colors.grey,
      ),

      onTap: onTap,
    ),
  );
}
