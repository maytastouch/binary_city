import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/utils/utils.dart';
import '../../../../../core/constants/colors.dart';

// ignore: must_be_immutable
class ContactFormDataTable extends StatefulWidget {
  final bool isChecked;
  final Function(bool?) onChanged;
  final Color color;
  final VoidCallback onPressed;

  const ContactFormDataTable({
    super.key,
    required this.isChecked,
    required this.onChanged,
    required this.color,
    required this.onPressed,
  });

  @override
  State<ContactFormDataTable> createState() => _ContactFormDataTableState();
}

class _ContactFormDataTableState extends State<ContactFormDataTable> {
  @override
  Widget build(BuildContext context) {
    final utils = Utils(context);
    Color color = utils.color;

    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: PaginatedDataTable2(
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
        rowsPerPage: 4,
        columns: const [
          DataColumn2(
            label: Text(
              'Client Name',
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
              '',
              style: TextStyle(color: AppColors.whiteColor),
            ),
          ),
        ],
        source: ClientDataSource(
          isChecked: widget.isChecked,
          onChanged: widget.onChanged,
          color: color,
          context: context,
          onPressed: widget.onPressed,
        ),
      ),
    );
  }
}

class ClientDataSource extends DataTableSource {
  final bool isChecked;
  final Function(bool?) onChanged;
  final Color color;
  final BuildContext context;
  final VoidCallback onPressed;

  ClientDataSource({
    required this.onPressed,
    required this.isChecked,
    required this.onChanged,
    required this.color,
    required this.context,
  });

  @override
  DataRow2? getRow(int index) {
    return DataRow2(
      onSelectChanged: (bool? selected) {},
      onTap: () {},
      color: WidgetStateProperty.resolveWith<Color?>(
        (Set<WidgetState> states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primaryColor.withOpacity(0.08);
          }
          return null;
        },
      ),
      cells: const [],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => 0;

  @override
  int get selectedRowCount => 0;
}
