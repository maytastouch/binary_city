import 'package:binary_city/core/common/entities/client_entity.dart';
import 'package:binary_city/core/common/widgets/text_widget.dart';
import 'package:binary_city/core/constants/constants.dart';
import 'package:binary_city/core/utils/show_snackbar.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/utils/utils.dart';
import '../../../../../core/constants/colors.dart';
import '../bloc/client_view_bloc.dart';

// ignore: must_be_immutable
class ClientDataTable extends StatefulWidget {
  final bool isChecked;
  final Function(bool?) onChanged;
  final Color color;
  final VoidCallback onPressed;

  const ClientDataTable({
    super.key,
    required this.isChecked,
    required this.onChanged,
    required this.color,
    required this.onPressed,
  });

  @override
  State<ClientDataTable> createState() => _ClientDataTableState();
}

class _ClientDataTableState extends State<ClientDataTable> {
  List<ClientEntity> clients = [];
  @override
  void initState() {
    clients = ClientViewBloc.allClients;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final utils = Utils(context);
    Color color = utils.color;

    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: BlocConsumer<ClientViewBloc, ClientViewState>(
        listener: (context, state) {
          // Implement listener if needed
          if (state is GetClientsFailure) {
            showBotToast(state.message);
          }
        },
        builder: (context, state) {
          if (state is GetClientsSuccess) {
            clients = state.clients;
            if (clients.isEmpty) {
              return TextWidget(
                  text: 'No clients found.',
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
              rowsPerPage: 6,
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
                    'Client Code',
                    style: TextStyle(color: AppColors.whiteColor),
                  ),
                  size: ColumnSize.S,
                ),
                DataColumn(
                  label: Text(
                    'No. of Linked Contacts',
                    style: TextStyle(color: AppColors.whiteColor),
                  ),
                ),
              ],
              source: ClientDataSource(
                clients: state.clients,
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
              rowsPerPage: 6,
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
                    'Client Code',
                    style: TextStyle(color: AppColors.whiteColor),
                  ),
                  size: ColumnSize.S,
                ),
                DataColumn(
                  label: Text(
                    'No. of Linked Contacts',
                    style: TextStyle(color: AppColors.whiteColor),
                  ),
                ),
              ],
              source: ClientDataSource(
                clients: clients,
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

class ClientDataSource extends DataTableSource {
  final List<ClientEntity> clients;
  final bool isChecked;
  final Function(bool?) onChanged;
  final Color color;
  final BuildContext context;
  final VoidCallback onPressed;

  ClientDataSource({
    required this.clients,
    required this.onPressed,
    required this.isChecked,
    required this.onChanged,
    required this.color,
    required this.context,
  });

  @override
  DataRow2? getRow(int index) {
    if (index >= clients.length) return null;
    final client = clients[index];
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
        DataCell(Text(client.name)),
        DataCell(Text(client.clientCode)),
        DataCell(Text(client.numberOfLinkedContacts.length.toString())),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => clients.length;

  @override
  int get selectedRowCount => clients.where((client) => isChecked).length;
}
