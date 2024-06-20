import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';

import '../../../../constants/colors.dart';
import '../../../../constants/constants.dart';
import '../bloc/selected_index.dart';
import '../widgets/list_tiles.dart';

class SideBar extends StatefulWidget {
  final PageController pageController;
  const SideBar({
    super.key,
    required this.pageController,
  });

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
//default value for the selected index
  int _selectedTileIndex = 0;

  @override
  Widget build(BuildContext context) {
    //final utils = Utils(context);
    //Color color = utils.color;

    bool isDark =
        Theme.of(context).brightness == Brightness.dark ? true : false;

    //desktop
    bool isDesktop(BuildContext context) =>
        MediaQuery.of(context).size.width >= AppConstants.responsiveWidth;

    return Expanded(
        child: BlocConsumer<SelectedIndexBloc, SelectedIndexState>(
      listener: (context, state) {
        widget.pageController.animateToPage(state.index,
            duration: const Duration(milliseconds: 1), curve: Curves.ease);
        _selectedTileIndex = state.index;
      },
      builder: (context, state) {
        return Container(
          color:
              isDark ? AppColors.sideBarDarkModeColor : AppColors.sideBarColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  //dashboard
                  ListTiles(
                    title: isDesktop(context) ? 'Dashboard' : "",
                    icon: _selectedTileIndex == 0
                        ? IconlyBold.home
                        : IconlyLight.home,
                    color: AppColors.primaryColor,
                    onPressed: () {
                      setState(() {
                        context.read<SelectedIndexBloc>().add(SelectIndex(0));
                        _selectedTileIndex = 0;
                      });
                    },
                    hoverColor: isDark ? AppColors.primaryColor : Colors.white,
                    index: 0,
                    selectedTileIndex: _selectedTileIndex,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  //first responsive student

                  ListTiles(
                    title: isDesktop(context) ? 'Clients' : "",
                    icon: _selectedTileIndex == 1
                        ? IconlyBold.user_2
                        : IconlyLight.user,
                    color: AppColors.primaryColor,
                    onPressed: () {
                      setState(
                        () {
                          context.read<SelectedIndexBloc>().add(SelectIndex(1));
                          _selectedTileIndex = 1;
                        },
                      );
                    },
                    hoverColor: isDark ? AppColors.primaryColor : Colors.white,
                    index: 1,
                    selectedTileIndex: _selectedTileIndex,
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  //first responsive teacher

                  ListTiles(
                    title: isDesktop(context) ? 'Contacts' : "",
                    icon: _selectedTileIndex == 2
                        ? IconlyBold.user_3
                        : IconlyLight.user_1,
                    color: AppColors.primaryColor,
                    onPressed: () {
                      setState(() {
                        context.read<SelectedIndexBloc>().add(SelectIndex(2));
                        _selectedTileIndex = 2;
                      });
                    },
                    hoverColor: isDark ? AppColors.primaryColor : Colors.white,
                    index: 2,
                    selectedTileIndex: _selectedTileIndex,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  //settings
                  Column(
                    children: [
                      ListTiles(
                        title: isDesktop(context) ? 'Settings' : "",
                        icon: _selectedTileIndex == 3
                            ? IconlyBold.setting
                            : IconlyLight.setting,
                        color: AppColors.primaryColor,
                        onPressed: () {
                          setState(() {
                            context
                                .read<SelectedIndexBloc>()
                                .add(SelectIndex(3));
                            _selectedTileIndex = 3;
                          });
                        },
                        hoverColor:
                            isDark ? AppColors.primaryColor : Colors.white,
                        index: 3,
                        selectedTileIndex: _selectedTileIndex,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),

                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.0),
                    //child: Divider(),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    ));
  }
}
