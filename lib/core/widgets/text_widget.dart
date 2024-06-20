import 'package:flutter/material.dart';

//this is the text widget
// ignore: must_be_immutable
class TextWidget extends StatefulWidget {
  TextWidget({
    super.key,
    required this.text,
    required this.color,
    required this.textSize,
    this.isTitle = false,
    this.maxLines = 10,
    required this.hoverColor,
  });

  final String text;
  final Color color;
  final Color hoverColor;
  final double textSize;
  bool isTitle;
  int maxLines = 10;

  @override
  State<TextWidget> createState() => _TextWidgetState();
}

class _TextWidgetState extends State<TextWidget> {
  bool isHovered = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (enter) {
        setState(() {
          isHovered = true;
        });
      },
      onExit: (event) {
        setState(() {
          isHovered = false;
        });
      },
      child: Text(
        widget.text,
        maxLines: widget.maxLines,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
            color: isHovered ? widget.hoverColor : widget.color,
            fontSize: widget.textSize,
            fontWeight: widget.isTitle ? FontWeight.bold : FontWeight.normal),
      ),
    );
  }
}
