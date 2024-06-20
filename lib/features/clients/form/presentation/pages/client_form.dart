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
  bool _isPressed1 = false;
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
                padding: const EdgeInsets.symmetric(horizontal: 2),
                height: 60,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          _isPressed1 = !_isPressed1;
                        });
                      },
                      child: Expanded(
                        child: Container(
                          height: 57,
                          width: MediaQuery.of(context).size.width / 2.5,
                          decoration: BoxDecoration(
                            color: !_isPressed1
                                ? AppColors.primaryColor
                                : AppColors.whiteModeColor,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(8),
                            ),
                          ),
                          child: Center(
                            child: TextWidget(
                              text: 'General',
                              color: color,
                              textSize: AppConstants.mainFont4,
                              hoverColor: color,
                            ),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          _isPressed1 = !_isPressed1;
                        });
                      },
                      child: Expanded(
                        child: Container(
                          height: 57,
                          width: MediaQuery.of(context).size.width / 2.5,
                          decoration: BoxDecoration(
                            color: _isPressed1
                                ? AppColors.primaryColor
                                : AppColors.whiteModeColor,
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(8),
                            ),
                          ),
                          child: Center(
                            child: TextWidget(
                              text: 'Contacts',
                              color: color,
                              textSize: AppConstants.mainFont4,
                              hoverColor: color,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const Column(
                children: [],
              )
            ],
          )
        ],
      ),
    );
  }
}
