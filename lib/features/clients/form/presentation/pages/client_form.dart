import 'package:binary_city/core/utils/utils.dart';
import 'package:flutter/material.dart';

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
                textSize: AppConstants.mainFont2,
                hoverColor: color,
              ),
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
          //table
        ],
      ),
    );
  }
}
