import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../theme/bloc/theme_bloc.dart';

class Utils {
  BuildContext context;
  Utils(this.context);

  bool get getTheme =>
      BlocProvider.of<ThemeBloc>(context).state.themeData.brightness ==
      Brightness.dark;
  Color get color => getTheme ? Colors.white : Colors.black;
  Size get getScreenSize => MediaQuery.of(context).size;
}
