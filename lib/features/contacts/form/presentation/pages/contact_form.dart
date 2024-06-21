import 'package:binary_city/core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:tab_container/tab_container.dart';

import '../../../../../core/common/widgets/text_widget.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/constants/constants.dart';
import '../widgets/add_contact_textfield.dart';
import '../widgets/save_contact_button.dart';
import 'contact_form_table.dart';

class ContactForm extends StatefulWidget {
  const ContactForm({super.key});

  @override
  State<ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  //email controller
  TextEditingController emailController = TextEditingController();
  @override
  void dispose() {
    nameController.dispose();
    surnameController.dispose();
    emailController.dispose();
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
              text: 'Contact Form',
              color: color,
              textSize: AppConstants.mainFont3,
              hoverColor: color,
            ),
            Row(
              children: [
                SaveContactButton(
                  button_title: ' + Link Client',
                  radius: 10,
                  onPressed: () {
                    setState(() {});
                  },
                  child: null,
                  isRed: true,
                ),
                const SizedBox(width: 10),
                SaveContactButton(
                  button_title: ' + Save Contact',
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
                  text: 'Client(s)',
                  color: color,
                  textSize: AppConstants.mainFont5,
                  hoverColor: color),
            ],
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 400,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: isDark
                      ? AppColors.sideBarDarkModeColor
                      : AppColors.whiteColor,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AddContactTextField(
                          hint: 'Name',
                          controller: nameController,
                          label: 'Name',
                          enableValidation: true,
                        ),
                        AddContactTextField(
                          hint: 'Surname',
                          controller: surnameController,
                          label: 'Surname',
                          enableValidation: true,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AddContactTextField(
                          hint: 'Email',
                          controller: emailController,
                          label: 'Email',
                          enableValidation: true,
                        ),
                      ],
                    )
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
                  height: 400,
                  child: ContactFormDataTable(
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
