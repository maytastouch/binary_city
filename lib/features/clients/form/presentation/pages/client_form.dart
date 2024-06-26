import 'package:binary_city/core/common/entities/contact_entity.dart';
import 'package:binary_city/core/utils/show_snackbar.dart';
import 'package:binary_city/core/utils/utils.dart';
import 'package:binary_city/features/clients/form/presentation/pages/client_form_table.dart';
import 'package:binary_city/features/clients/form/presentation/widgets/add_client_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tab_container/tab_container.dart';

import '../../../../../core/common/widgets/loader.dart';
import '../../../../../core/common/widgets/text_widget.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/constants/constants.dart';
import '../bloc/add_client_bloc.dart';
import '../widgets/contact_choice_chip.dart';
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
  List<ContactEntity> allContacts = [];
  List<String> contactID = [];

  bool _isLoading = false;
  bool isLinkClientPressed = false;

  @override
  void dispose() {
    nameController.dispose();
    clientCodeController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    context.read<AddClientBloc>().add(GetAllContactEvent());
    allContacts = AddClientBloc.allContacts;
    super.initState();
  }

  void _unlinkContact(String id) {
    setState(() {
      contactID.remove(id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final utils = Utils(context);
    Color color = utils.color;
    bool isDark =
        Theme.of(context).brightness == Brightness.dark ? true : false;

    return BlocConsumer<AddClientBloc, AddClientState>(
      listener: (context, state) {
        if (state is AddClientFailure) {
          showBotToast(state.message);
          setState(() {
            _isLoading = false;
          });
        }

        if (state is AddClientSuccess) {
          showBotToast(state.message);
          setState(() {
            _isLoading = false;
          });
          clientCodeController = TextEditingController(text: state.code);
        }
        if (state is AddClientLoading) {
          setState(() {
            _isLoading = true;
          });
        }
      },
      builder: (context, state) {
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
                        setState(() {
                          isLinkClientPressed = !isLinkClientPressed;
                        });
                      },
                      child: null,
                      isRed: true,
                    ),
                    const SizedBox(width: 10),
                    SaveClientButton(
                      button_title: ' + Save Client',
                      radius: 10,
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          context.read<AddClientBloc>().add(AddClientsEvent(
                                name: nameController.text,
                                contactIds: contactID,
                                contacts: allContacts
                                    .where((contact) =>
                                        contactID.contains(contact.id))
                                    .map((contact) => contact.id.toString())
                                    .toList(),
                              ));
                        }
                      },
                      child: _isLoading ? const Loader() : null,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            Form(
              key: formKey,
              child: TabContainer(
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
                          hint: '',
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
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                      ),
                      width: MediaQuery.of(context).size.width,
                      height: 300,
                      child: Column(
                        children: [
                          if (isLinkClientPressed)
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: BlocBuilder<AddClientBloc, AddClientState>(
                                builder: (context, state) {
                                  if (state is GetAllContactsLoaded) {
                                    allContacts = state.contacts;
                                  }
                                  return Row(
                                    children: allContacts
                                        .map((contact) => ContactChoiceChip(
                                              contact: contact,
                                              selectedContactIDs: contactID,
                                              onSelectionChanged:
                                                  (String id, bool selected) {
                                                setState(() {
                                                  if (selected) {
                                                    if (!contactID
                                                        .contains(id)) {
                                                      contactID.add(id);
                                                    }
                                                  } else {
                                                    contactID.remove(id);
                                                  }
                                                });
                                              },
                                            ))
                                        .toList(),
                                  );
                                },
                              ),
                            ),
                          Expanded(
                            child: ClientFormDataTable(
                              isChecked: false,
                              onChanged: (bool? value) {},
                              color: color,
                              onPressed: () {},
                              onUnlink: _unlinkContact,
                              contactID: contactID, // Pass the callback
                            ),
                          ),
                        ],
                      )),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
