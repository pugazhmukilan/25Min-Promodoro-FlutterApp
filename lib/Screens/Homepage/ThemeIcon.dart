import 'package:flutter/material.dart';

class ThemeIcon extends StatefulWidget {
  const ThemeIcon({
    super.key,
    required this.onToggle, // Callback to toggle theme
  });

  final VoidCallback onToggle;

  @override
  State<ThemeIcon> createState() => _ThemeIconState();
}

class _ThemeIconState extends State<ThemeIcon> {
  @override
  Widget build(BuildContext context) {
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: widget.onToggle, // Call the toggle function when tapped`
      child: CircleAvatar(
        radius: 40,
        backgroundColor: const Color(0x1F939393),
        child: Image.asset(
          isDarkTheme ? "assets/light_logo.png" : "assets/dark_logo.png",
          scale: 3,
        ),
      ),
    );
  }
}