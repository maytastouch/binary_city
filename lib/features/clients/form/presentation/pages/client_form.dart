import 'package:binary_city/core/utils/utils.dart';
import 'package:flutter/material.dart';

import '../../../../../core/constants/colors.dart';
import '../../../../../core/constants/constants.dart';
import '../../../../../core/widgets/text_widget.dart';
import '../widgets/save_client_button.dart';

class ClientForm extends StatefulWidget {
  const ClientForm({super.key});

  @override
  State<ClientForm> createState() => _ClientFormState();
}

class _ClientFormState extends State<ClientForm> {
  @override
  Widget build(BuildContext context) {
    final utils = Utils(context);
    Color color = utils.color;

    return Expanded(
      child: Column(
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
                      setState(() {});
                    },
                    child: null,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          //table
          Column(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                height: 60,
                decoration: const BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextWidget(
                      text: 'General',
                      color: color,
                      textSize: AppConstants.mainFont3,
                      hoverColor: color,
                    ),
                    TextWidget(
                      text: 'Contacts',
                      color: color,
                      textSize: AppConstants.mainFont3,
                      hoverColor: color,
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}