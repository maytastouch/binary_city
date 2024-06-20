import 'package:binary_city/core/utils/utils.dart';
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
          TabContainer(
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
                  text: 'Contacts',
                  color: color,
                  textSize: AppConstants.mainFont5,
                  hoverColor: color),
            ],
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 200,
                child: const Text('Child 1'),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 200,
                child: const Text('Child 2'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
