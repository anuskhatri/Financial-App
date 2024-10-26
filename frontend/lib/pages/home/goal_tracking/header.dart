import 'package:bobhack/constants.dart';
import 'package:bobhack/controllers/goal_controller.dart';
import 'package:bobhack/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GoalsHeader extends StatelessWidget {
  GoalsHeader({super.key});
  final GoalController goalController = Get.put(GoalController());
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            AppText(
                text: "Goal Tracking",
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Colors.white),
            AppText(
                text: "Track your financial goals.",
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: subTextColor),
          ],
        ),
        const Spacer(),
        Obx(
          () => goalController.allGoals.isNotEmpty
              ? goalController.toggleAddGoal.isTrue
                  ? TextButton(
                      onPressed: () {
                        goalController.toggleAddGoal.value = false;
                      },
                      child: const AppText(
                        text: "Cancel",
                        color: Colors.redAccent,
                      ))
                  : TextButton.icon(
                      onPressed: () {
                        goalController.toggleAddGoal.value = true;
                      },
                      label:
                          const AppText(text: "Add Goal", color: primaryColor),
                      icon: const Icon(
                        Icons.add,
                        color: primaryColor,
                        size: 20,
                      ),
                    )
              : const SizedBox.shrink(),
        )
      ],
    );
  }
}
