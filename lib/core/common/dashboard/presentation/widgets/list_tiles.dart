import 'package:flutter/material.dart';

import '../../../../constants/colors.dart';
import '../../../../constants/constants.dart';

class ListTiles extends StatefulWidget {
  final String title;
  final IconData? icon;
  final Function? onPressed;
  final Color? hoverColor;
  final Color? color;
  final int? index; // Add this line
  final int? selectedTileIndex;

  const ListTiles({
    super.key,
    required this.title,
    this.icon,
    this.onPressed,
    this.hoverColor,
    this.color,
    this.index,
    this.selectedTileIndex,
  });

  @override
  State<ListTiles> createState() => _ListTilesState();
}

class _ListTilesState extends State<ListTiles> {
  //to track whether a tile is being hovered or not
  bool _isHovered = false;

  //desktop
  bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= AppConstants.responsiveWidth;

  //mobile
  bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < AppConstants.responsiveWidth;

  //these will change accordingly
  late Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    bool isDark =
        Theme.of(context).brightness == Brightness.dark ? true : false;
    if (widget.selectedTileIndex == widget.index) {
      backgroundColor = isDark ? AppColors.primaryColor : Colors.white;
    } else {
      backgroundColor =
          isDark ? AppColors.sideBarDarkModeColor : AppColors.sideBarColor;
    }
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          _isHovered = true;
        });
      },
      onExit: (_) {
        setState(() {
          _isHovered = false;
        });
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Stack(
          children: [
            //responsive
            if (isDesktop(context))
              AnimatedPositioned(
                duration: const Duration(microseconds: 300),
                height: 50,
                width: 200,
                left: 0,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: isDark
                          ? (_isHovered ? widget.hoverColor : backgroundColor)
                          : (_isHovered ? widget.hoverColor : backgroundColor),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                  ),
                ),
              ),
            if (isMobile(context))
              AnimatedPositioned(
                duration: const Duration(microseconds: 300),
                height: 50,
                width: 70,
                left: 0,
                child: Padding(
                  padding: const EdgeInsets.only(left: 6.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: isDark
                          ? (_isHovered ? widget.hoverColor : backgroundColor)
                          : (_isHovered ? widget.hoverColor : backgroundColor),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.only(left: 9.0),
              child: ListTile(
                title: Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 0, bottom: 8),
                  child: Text(
                    widget.title,
                    style: TextStyle(
                      fontSize: AppConstants.mainFont9,
                      //fontWeight: FontWeight.w800,
                      color: isDark
                          ? AppColors.whiteModeColor
                          : AppColors.blackColor,
                    ),
                  ),
                ),
                leading: Icon(
                  widget.icon,
                  color:
                      isDark ? AppColors.whiteModeColor : AppColors.blackColor,
                ),
                onTap: () {
                  widget.onPressed!();
                },
                hoverColor: widget.hoverColor,
                selected: widget.selectedTileIndex == widget.index,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
