import 'package:binary_city/core/common/widgets/text_widget.dart';
import 'package:binary_city/core/constants/constants.dart';
import 'package:binary_city/core/utils/show_snackbar.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/utils/utils.dart';
import '../../../../../core/common/entities/contact_entity.dart';
import '../../../../../core/constants/colors.dart';
import '../bloc/contact_view_bloc.dart';

// ignore: must_be_immutable
class ContactDataTable extends StatefulWidget {
  final bool isChecked;
  final Function(bool?) onChanged;
  final Color color;
  final VoidCallback onPressed;

  const ContactDataTable({
    super.key,
    required this.isChecked,
    required this.onChanged,
    required this.color,
    required this.onPressed,
  });

  @override
  State<ContactDataTable> createState() => _ContactDataTableState();
}

class _ContactDataTableState extends State<ContactDataTable> {
  List<ContactEntity> contacts = [];

  @override
  void initState() {
    contacts = ContactViewBloc.allContactList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final utils = Utils(context);
    Color color = utils.color;

    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: BlocConsumer<ContactViewBloc, ContactViewState>(
        listener: (context, state) {
          if (state is GetAllContactsError) {
            // Implement listener if needed
            showBotToast(state.message);
          }
        },
        builder: (context, state) {
          if (state is GetAllContactsLoaded) {
            contacts = state.contactList;
            if (contacts.isEmpty) {
              return TextWidget(
                  text: 'No contact(s) found.',
                  color: color,
                  textSize: AppConstants.mainFont5,
                  hoverColor: color);
            }
            return PaginatedDataTable2(
              sortAscending: true,
              showCheckboxColumn: true,
              renderEmptyRowsInTheEnd: false,
              wrapInCard: false,
              headingRowHeight: 50,
              headingRowDecoration: const BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              columnSpacing: 12,
              horizontalMargin: 12,
              rowsPerPage: 9,
              columns: const [
                DataColumn2(
                  label: Text(
                    'Name',
                    style: TextStyle(color: AppColors.whiteColor),
                  ),
                  size: ColumnSize.L,
                  fixedWidth: 190,
                ),
                DataColumn2(
                  label: Text(
                    'Surname',
                    style: TextStyle(color: AppColors.whiteColor),
                  ),
                  size: ColumnSize.S,
                ),
                DataColumn2(
                  label: Text(
                    'Email Address',
                    style: TextStyle(color: AppColors.whiteColor),
                  ),
                  size: ColumnSize.L,
                ),
                DataColumn2(
                  label: Text(
                    'No. of Linked Clients',
                    style: TextStyle(color: AppColors.whiteColor),
                  ),
                  size: ColumnSize.S,
                ),
              ],
              source: ContactsDataSource(
                contacts: state.contactList,
                isChecked: widget.isChecked,
                onChanged: widget.onChanged,
                color: color,
                context: context,
                onPressed: widget.onPressed,
              ),
            );
          } else {
            return PaginatedDataTable2(
              sortAscending: true,
              showCheckboxColumn: true,
              renderEmptyRowsInTheEnd: false,
              wrapInCard: false,
              headingRowHeight: 50,
              headingRowDecoration: const BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              columnSpacing: 12,
              horizontalMargin: 12,
              rowsPerPage: 9,
              columns: const [
                DataColumn2(
                  label: Text(
                    'Name',
                    style: TextStyle(color: AppColors.whiteColor),
                  ),
                  size: ColumnSize.L,
                  fixedWidth: 190,
                ),
                DataColumn2(
                  label: Text(
                    'Surname',
                    style: TextStyle(color: AppColors.whiteColor),
                  ),
                  size: ColumnSize.S,
                ),
                DataColumn2(
                  label: Text(
                    'Email Address',
                    style: TextStyle(color: AppColors.whiteColor),
                  ),
                  size: ColumnSize.L,
                ),
                DataColumn2(
                  label: Text(
                    'No. of Linked Clients',
                    style: TextStyle(color: AppColors.whiteColor),
                  ),
                  size: ColumnSize.S,
                ),
              ],
              source: ContactsDataSource(
                contacts: contacts,
                isChecked: widget.isChecked,
                onChanged: widget.onChanged,
                color: color,
                context: context,
                onPressed: widget.onPressed,
              ),
            );
          }
        },
      ),
    );
  }
}

class ContactsDataSource extends DataTableSource {
  final List<ContactEntity> contacts;
  final bool isChecked;
  final Function(bool?) onChanged;
  final Color color;
  final BuildContext context;
  final VoidCallback onPressed;

  ContactsDataSource({
    required this.contacts,
    required this.onPressed,
    required this.isChecked,
    required this.onChanged,
    required this.color,
    required this.context,
  });

  @override
  DataRow2? getRow(int index) {
    if (index >= contacts.length) return null;
    final contact = contacts[index];
    return DataRow2(
      onSelectChanged: (bool? selected) {
        onChanged(selected);
      },
      onTap: onPressed,
      color: WidgetStateProperty.resolveWith<Color?>(
        (Set<WidgetState> states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primaryColor.withOpacity(0.08);
          }
          return null;
        },
      ),
      cells: [
        DataCell(Text(contact.firstName)),
        DataCell(Text(contact.lastName)),
        DataCell(TextWidget(
          text: contact.email,
          color: color,
          textSize: 14,
          hoverColor: color,
          maxLines: 1,
        )),
        const DataCell(Text('4')),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => contacts.length;

  @override
  int get selectedRowCount => contacts.where((client) => isChecked).length;
}
