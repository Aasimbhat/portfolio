import 'package:flutter/material.dart';

class GlowingTextField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final int maxLines;

  const GlowingTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.icon,
    this.maxLines = 1,
  });

  @override
  State<GlowingTextField> createState() => _GlowingTextFieldState();
}

class _GlowingTextFieldState extends State<GlowingTextField> {
  bool _isFocused = false;

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: (focused) {
        setState(() => _isFocused = focused);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow:
              _isFocused
                  ? [
                    BoxShadow(
                      color: Theme.of(
                        context,
                      ).colorScheme.primary.withOpacity(0.3),
                      blurRadius: 15,
                      spreadRadius: -8,
                    ),
                  ]
                  : [],
        ),
        child: TextField(
          controller: widget.controller,
          maxLines: widget.maxLines,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            labelText: widget.label,
            labelStyle: TextStyle(
              color:
                  _isFocused
                      ? Theme.of(context).colorScheme.primary
                      : Colors.white70,
            ),
            prefixIcon: Icon(
              widget.icon,
              color:
                  _isFocused
                      ? Theme.of(context).colorScheme.primary
                      : Colors.white70,
            ),
            filled: true,
            fillColor: Colors.black.withOpacity(0.4),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: Colors.white.withOpacity(0.2)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: Colors.white.withOpacity(0.2)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.primary,
                width: 2,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
