import 'package:bobhack/constants.dart';
import 'package:bobhack/controllers/goal_controller.dart';
import 'package:bobhack/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class NoGoals extends StatelessWidget {
  NoGoals({super.key});

  final GoalController goalController = Get.find();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height * 0.8,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const AppText(
                text: "No goals set yet.",
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: subTextColor),
            const SizedBox(height: 10),
            const AppText(
                text: "Set your financial goals to track your progress.",
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: subTextColor),
            const SizedBox(height: 10),
            TextButton.icon(
              onPressed: () {
                goalController.toggleAddGoal.value = true;
              },
              icon: const FaIcon(
                FontAwesomeIcons.plus,
                size: 15,
                color: primaryColor,
              ),
              label: const AppText(
                  text: "Create Goal",
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: primaryColor),
            )
          ],
        ),
      ),
    );
  }
}
