import 'package:binary_city/features/clients/presentation/pages/clients_page.dart';
import 'package:binary_city/features/contacts/presentation/pages/contacts_page.dart';
import 'package:binary_city/features/settings/presentation/pages/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../features/home/presentation/pages/homepage.dart';
import '../../../../../features/navbar/presentation/pages/navbar.dart';
import '../../../../constants/constants.dart';
import '../bloc/selected_index.dart';
import 'sidebar.dart';

class DashBoard extends StatefulWidget {
  final int? index;

  const DashBoard({
    super.key,
    this.index,
  });

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  late PageController _pageController;
  bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= AppConstants.responsiveWidth;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.index ?? 0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const NavBar(),
          Expanded(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: isDesktop(context) ? 210 : 75,
                height: MediaQuery.of(context).size.height * 1,
                child: Column(
                  children: [
                    BlocListener<SelectedIndexBloc, SelectedIndexState>(
                      listener: (context, state) {
                        _pageController.animateToPage(state.index,
                            duration: const Duration(milliseconds: 250),
                            curve: Curves.easeInOut);
                      },
                      child: SideBar(
                        pageController: _pageController,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.85,
                  height: MediaQuery.of(context).size.height * 1,
                  child: PageView(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: _pageController,
                    children: const [
                      HomePage(),
                      ClientsPage(),
                      ContactsPage(),
                      SettingsPage(),
                    ],
                  ),
                ),
              ),
            ],
          ))
        ],
      ),
    );
  }
}
