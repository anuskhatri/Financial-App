import 'package:bobhack/constants.dart';
import 'package:bobhack/controllers/investment_controller.dart';
import 'package:bobhack/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LinkedAccounts extends StatelessWidget {
  LinkedAccounts({super.key});

  final InvestmentController investmentController =
      Get.put(InvestmentController());

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppText(
            text: "Linked Accounts",
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
          Obx(() => Row(
                children: [
                  const AppText(
                    text: "IDFC First Bank",
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: subTextColor,
                  ),
                  const Spacer(),
                  AppText(
                    text: displayAccountNumber(
                        investmentController.personalDetails["account_number"]),
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: subTextColor,
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
