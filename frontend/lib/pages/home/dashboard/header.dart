import 'package:bobhack/constants.dart';
import 'package:bobhack/controllers/investment_controller.dart';
import 'package:bobhack/pages/home/dashboard/recent_notifications.dart';
import 'package:bobhack/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class BobHeader extends StatelessWidget {
  BobHeader({super.key});

  final InvestmentController investmentController =
      Get.put(InvestmentController());
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(
            () => Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                  color: overlayColor, borderRadius: BorderRadius.circular(13)),
              child: Center(
                child: AppText(
                  text: investmentController.personalDetails["first_name"][0] +
                      investmentController.personalDetails["last_name"][0],
                  color: const Color.fromARGB(255, 174, 174, 174),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                text: 'Welcome',
                color: Colors.grey[400]!,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              Obx(
                () => AppText(
                  text: investmentController.name.value,
                  color: Colors.grey[500]!,
                  fontSize: 18,
                ),
              )
            ],
          ),
          const Spacer(),
          IconButton(
              onPressed: () => Get.to(() => RecentNotifications()),
              icon: FaIcon(
                size: 20,
                FontAwesomeIcons.bell,
                color: Colors.grey[500],
              ))
        ],
      ),
    );
  }
}
