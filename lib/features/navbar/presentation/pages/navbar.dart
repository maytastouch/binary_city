import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

import '../../../../core/common/widgets/text_widget.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/constants.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  final TextEditingController _controller = TextEditingController();
  bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= AppConstants.responsiveWidth;

  //half-desktop
  bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < AppConstants.responsiveWidth;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //color theme
    final colorScheme = Theme.of(context).colorScheme;
    bool isDark =
        Theme.of(context).brightness == Brightness.dark ? true : false;

    return Container(
      //adding color to the background
      color: isDark ? AppColors.navBarDarkMode : AppColors.whiteColor,
      child: Row(
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //first Row - Logo and company name
          Row(
            children: [
              //image of the logo
              Padding(
                padding: const EdgeInsets.only(
                  left: 20.0,
                  top: 3,
                  bottom: 3,
                  right: 3,
                ),
                child: isDark
                    ? Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: Image.asset(
                          'assets/images/final.png',
                          width: 100,
                          height: 60,
                        ),
                      )
                    : Image.asset(
                        'assets/images/Screenshot 2024-06-20 at 11.36.21 AM.png',
                        width: 100,
                        height: 60,
                      ),
              ),
              //name of the company
            ],
          ),

          //first responsive search bar

          //second Row - Text Field
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: isDesktop(context)
                    ? 300
                    : MediaQuery.of(context).size.width * 0.1,
              ),
              child: TextField(
                controller: _controller,
                style: const TextStyle(color: AppColors.darkModeColor),
                onSubmitted: (value) {},
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white60,
                  hintStyle: TextStyle(
                    fontSize: 14,
                    color: isDark ? AppColors.blackColor : AppColors.greyColor,
                  ),
                  hintText: 'search...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: const BorderSide(
                      width: 1,
                      style: BorderStyle.none,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: const BorderSide(
                      width: 1,
                      color: Colors.grey,
                    ),
                  ),
                  contentPadding: const EdgeInsets.all(10),
                  suffixIcon: _controller.text.isNotEmpty
                      ? IconButton(
                          color: Colors.black,
                          icon: const Icon(Icons.clear),
                          onPressed: () {},
                        )
                      : null,
                ),
              ),
            ),
          ),

          //third Row - Trailing icons
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    IconlyLight.logout,
                    color: isDark
                        ? AppColors.whiteModeColor
                        : AppColors.primaryColor,
                  ),
                ),
                TextWidget(
                  text: 'Logout',
                  color: colorScheme.onSurface,
                  textSize: 10,
                  hoverColor: colorScheme.onSurface,
                  isTitle: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
