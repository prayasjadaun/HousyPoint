import 'package:flutter/material.dart';

class MenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final String? trailing;
  final VoidCallback onTap;

  const MenuItem({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    this.trailing,
    required this.onTap,
    required Color textColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); // Accessing the current theme

    final backgroundColor = theme.brightness == Brightness.dark
        ? Colors.grey.shade900
        : Colors.grey.shade100;

    final iconColor =
        theme.brightness == Brightness.dark ? Colors.white : Color(0xFF004253);

    final trailingTextColor =
        theme.brightness == Brightness.dark ? Colors.white : Colors.black;

    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey),
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: iconColor, // Icon color adjusts based on theme
        ),
        title: Text(
          title,
          style: TextStyle(
              color: theme.textTheme.bodyLarge?.color), // Dynamic title color
        ),
        subtitle: subtitle != null
            ? Text(
                subtitle!,
                style: TextStyle(
                    color: theme
                        .textTheme.bodyMedium?.color), // Dynamic subtitle color
              )
            : null,
        trailing: trailing != null
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    trailing!,
                    style: TextStyle(
                        color: trailingTextColor), // Trailing text color
                  ),
                  const Icon(
                    Icons.chevron_right,
                    color: Color(0xFF004253),
                  ),
                ],
              )
            : const Icon(
                Icons.chevron_right,
                color: Color(0xFF004253),
              ),
        onTap: onTap,
      ),
    );
  }
}
