import 'package:binary_city/core/constants/constants.dart';
import 'package:binary_city/features/contacts/view/presentation/bloc/contact_view_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/common/dashboard/presentation/bloc/selected_index.dart';
import '../../../../../core/common/widgets/text_widget.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/utils/utils.dart';
import '../../../form/presentation/pages/contact_form.dart';
import '../widgets/add_contact_button.dart';
import 'contacts_data_table.dart';

class ContactsPage extends StatefulWidget {
  const ContactsPage({super.key});

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  bool _isPressed1 = false;
  @override
  Widget build(BuildContext context) {
    final utils = Utils(context);
    Color color = utils.color;
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //status row
            Row(
              children: [
                InkWell(
                  onTap: () {
                    final bloc = BlocProvider.of<SelectedIndexBloc>(context);
                    bloc.add(SelectIndex(0));
                  },
                  child: TextWidget(
                    text: 'Home',
                    color: color,
                    textSize: AppConstants.mainFont9,
                    hoverColor: AppColors.greyColor,
                  ),
                ),
                TextWidget(
                  text: ' / ',
                  color: color,
                  textSize: AppConstants.mainFont9,
                  hoverColor: color,
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      _isPressed1 = false;
                    });
                    context.read<ContactViewBloc>().add(GetAllContactsEvent());
                  },
                  child: TextWidget(
                    text: 'Contacts',
                    color: AppColors.primaryColor,
                    textSize: AppConstants.mainFont9,
                    hoverColor: AppColors.primaryColor,
                  ),
                ),
                if (_isPressed1)
                  TextWidget(
                    text: ' / Form',
                    color: AppColors.primaryColor,
                    textSize: AppConstants.mainFont9,
                    hoverColor: AppColors.primaryColor,
                  ),
              ],
            ),
            const SizedBox(
              height: 3,
            ),

            //list
            if (!_isPressed1)
              Expanded(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextWidget(
                          text: 'Contacts',
                          color: color,
                          textSize: AppConstants.mainFont3,
                          hoverColor: color,
                        ),
                        AddContactButton(
                          button_title: ' + New Contact',
                          radius: 10,
                          onPressed: () {
                            setState(() {
                              _isPressed1 = !_isPressed1;
                            });
                          },
                          child: null,
                        ),
                      ],
                    ),
                    //table
                    Expanded(
                      child: ContactDataTable(
                        isChecked: false,
                        // ignore: avoid_types_as_parameter_names
                        onChanged: (bool) {},
                        color: color,
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ),
            if (_isPressed1) const ContactForm(),
          ],
        ),
      ),
    );
  }
}
