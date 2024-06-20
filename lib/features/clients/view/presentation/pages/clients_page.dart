import 'package:binary_city/core/constants/constants.dart';
import 'package:binary_city/core/widgets/text_widget.dart';
import 'package:binary_city/features/clients/view/presentation/widgets/add_client_button.dart';
import 'package:flutter/material.dart';

import '../../../../../core/constants/colors.dart';
import '../../../../../core/utils/utils.dart';
import 'client_table.dart';

class ClientsPage extends StatefulWidget {
  const ClientsPage({super.key});

  @override
  State<ClientsPage> createState() => _ClientsPageState();
}

class _ClientsPageState extends State<ClientsPage> {
  @override
  Widget build(BuildContext context) {
    final utils = Utils(context);
    Color color = utils.color;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //status row
          Row(
            children: [
              TextWidget(
                text: 'Home',
                color: color,
                textSize: AppConstants.mainFont9,
                hoverColor: AppColors.greyColor,
              ),
              TextWidget(
                text: ' / ',
                color: color,
                textSize: AppConstants.mainFont9,
                hoverColor: color,
              ),
              TextWidget(
                text: 'Clients',
                color: AppColors.primaryColor,
                textSize: AppConstants.mainFont9,
                hoverColor: AppColors.primaryColor,
              ),
            ],
          ),
          const SizedBox(
            height: 3,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextWidget(
                text: 'Clients',
                color: AppColors.blackColor,
                textSize: AppConstants.mainFont2,
                hoverColor: AppColors.blackColor,
              ),
              AddClientButton(
                button_title: ' + New Client',
                radius: 10,
                onPressed: () {},
                child: null,
              ),
            ],
          ),
          //table
          Expanded(
            child: ClientDataTable(
              isChecked: false,
              onChanged: (bool) {},
              color: color,
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
