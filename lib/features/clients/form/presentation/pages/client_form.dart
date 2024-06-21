import 'package:binary_city/core/utils/utils.dart';
import 'package:binary_city/features/clients/form/presentation/pages/client_form_table.dart';
import 'package:binary_city/features/clients/form/presentation/widgets/add_client_textfield.dart';
import 'package:flutter/material.dart';
import 'package:tab_container/tab_container.dart';

import '../../../../../core/common/widgets/text_widget.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/constants/constants.dart';
import '../widgets/save_client_button.dart';

class ClientForm extends StatefulWidget {
  const ClientForm({super.key});

  @override
  State<ClientForm> createState() => _ClientFormState();
}

class _ClientFormState extends State<ClientForm> {
  final formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController clientCodeController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    clientCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final utils = Utils(context);
    Color color = utils.color;
    bool isDark =
        Theme.of(context).brightness == Brightness.dark ? true : false;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextWidget(
              text: 'Client Form',
              color: color,
              textSize: AppConstants.mainFont3,
              hoverColor: color,
            ),
            Row(
              children: [
                SaveClientButton(
                  button_title: ' + Link Contact',
                  radius: 10,
                  onPressed: () {
                    setState(() {});
                  },
                  child: null,
                  isRed: true,
                ),
                const SizedBox(width: 10),
                SaveClientButton(
                  button_title: ' + Save Client',
                  radius: 10,
                  onPressed: () {
                    if (formKey.currentState!.validate()) {}
                  },
                  child: null,
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 20),
        //table
        Form(
          key: formKey,
          child: TabContainer(
            //controller: _tabController,
            //tabEdge: TabEdge.right,
            tabsStart: 0,
            tabsEnd: 0.9,
            tabMaxLength: 100,
            borderRadius: BorderRadius.circular(10),
            tabBorderRadius: BorderRadius.circular(10),
            childPadding: const EdgeInsets.all(20.0),
            selectedTextStyle: const TextStyle(
              color: Colors.white,
              fontSize: 15.0,
            ),
            unselectedTextStyle: const TextStyle(
              color: Colors.black,
              fontSize: 13.0,
            ),
            colors: const [
              AppColors.primaryColor,
              AppColors.primaryColor,
            ],
            tabs: [
              //Text('General'),
              //Text('Contacts'),
              TextWidget(
                  text: 'General',
                  color: color,
                  textSize: AppConstants.mainFont5,
                  hoverColor: color),
              TextWidget(
                  text: 'Contact(s)',
                  color: color,
                  textSize: AppConstants.mainFont5,
                  hoverColor: color),
            ],
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 300,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: isDark
                      ? AppColors.sideBarDarkModeColor
                      : AppColors.whiteColor,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AddClientTextField(
                      hint: 'Name',
                      controller: nameController,
                      label: 'Name',
                      enableValidation: true,
                    ),
                    AddClientTextField(
                      hint: 'Client Code',
                      controller: clientCodeController,
                      label: 'Client Code',
                      readOnly: true,
                      enableValidation: false,
                    ),
                  ],
                ),
              ),
              Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: isDark
                        ? AppColors.sideBarDarkModeColor
                        : AppColors.whiteColor,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                  width: MediaQuery.of(context).size.width,
                  height: 300,
                  child: ClientFormDataTable(
                    isChecked: false,
                    onChanged: (bool? value) {},
                    color: color,
                    onPressed: () {},
                  )),
            ],
          ),
        ),
      ],
    );
  }
}
