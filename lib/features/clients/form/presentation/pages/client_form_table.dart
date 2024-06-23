import 'package:binary_city/core/common/widgets/loader.dart';
import 'package:binary_city/core/constants/constants.dart';
import 'package:binary_city/features/clients/form/presentation/bloc/add_client_bloc.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/utils/utils.dart';
import '../../../../../core/common/entities/contact_entity.dart';
import '../../../../../core/common/widgets/text_widget.dart';
import '../../../../../core/constants/colors.dart';

// ignore: must_be_immutable
class ClientFormDataTable extends StatefulWidget {
  final bool isChecked;
  final Function(bool?) onChanged;
  final Color color;
  final VoidCallback onPressed;

  const ClientFormDataTable({
    super.key,
    required this.isChecked,
    required this.onChanged,
    required this.color,
    required this.onPressed,
  });

  @override
  State<ClientFormDataTable> createState() => _ClientFormDataTableState();
}

class _ClientFormDataTableState extends State<ClientFormDataTable> {
  List<ContactEntity> contacts = [];
  List<String> selectedContacts = [];
  @override
  Widget build(BuildContext context) {
    final utils = Utils(context);
    Color color = utils.color;

    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: BlocConsumer<AddClientBloc, AddClientState>(
        listener: (context, state) {
          if (state is GetAllContactsLoaded) {
            contacts = state.contacts;
          }
          if (state is AddClientSuccess) {
            contacts = AddClientBloc.allContacts;
            selectedContacts = state.client.numberOfLinkedContacts;

            // filter contacts to only include selected contacts
            contacts = contacts
                .where((contact) => selectedContacts.contains(contact.id))
                .toList();
          }
        },
        builder: (context, state) {
          if (state is AddClientSuccess) {
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
              rowsPerPage: 3,
              columns: const [
                DataColumn2(
                  label: Text(
                    'Full Name',
                    style: TextStyle(color: AppColors.whiteColor),
                  ),
                  size: ColumnSize.L,
                  fixedWidth: 190,
                ),
                DataColumn2(
                  label: Text(
                    'Email Address',
                    style: TextStyle(color: AppColors.whiteColor),
                  ),
                  size: ColumnSize.S,
                ),
                DataColumn(
                  label: Text(
                    '',
                    style: TextStyle(color: AppColors.whiteColor),
                  ),
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
          } else if (state is AddClientLoading) {
            return const Loader();
          }
          return TextWidget(
              text: 'No contacts found.',
              color: color,
              textSize: AppConstants.mainFont5,
              hoverColor: color);
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
        DataCell(Text('${contact.firstName} ${contact.lastName}')),
        DataCell(TextWidget(
          text: contact.email,
          color: color,
          textSize: 14,
          hoverColor: color,
          maxLines: 1,
        )),
        DataCell(
          TextWidget(
            text: 'Unlink',
            color: AppColors.primaryColor,
            textSize: 14,
            hoverColor: AppColors.primaryColor,
            maxLines: 1,
          ),
        ),
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
