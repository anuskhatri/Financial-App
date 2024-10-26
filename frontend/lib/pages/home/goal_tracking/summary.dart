import 'package:bobhack/constants.dart';
import 'package:bobhack/controllers/goal_controller.dart';
import 'package:bobhack/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class Summary extends StatelessWidget {
  Summary({super.key});

  final GoalController goalController = Get.put(GoalController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(top: 50, left: 20, right: 20),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: overlayColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const AppText(
                        text: "Summary",
                        color: subTextColor,
                        fontSize: 17,
                        fontWeight: FontWeight.bold),
                    const SizedBox(height: 20),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const AppText(
                                text: "Target Amount",
                                color: subTextColor,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                            AppText(
                                text:
                                    "₹ ${goalController.goalData["goal_amount"]}",
                                color: subTextColor,
                                fontSize: 15),
                          ],
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.18),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const AppText(
                                text: "Timeframe",
                                color: subTextColor,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                            AppText(
                              text: goalController
                                          .goalData["monthly_savings_needed"] ==
                                      null
                                  ? "${goalController.goalData["time_frame"]} Days"
                                  : "${goalController.goalData["time_frame"] ~/ 365} Years",
                              color: subTextColor,
                              fontSize: 15,
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const AppText(
                                text: "Bank Balance",
                                color: subTextColor,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                            AppText(
                                text:
                                    "₹ ${goalController.goalData["bank_balance"]}",
                                color: subTextColor,
                                fontSize: 15),
                          ],
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.2),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const AppText(
                                text: "Pending Loan",
                                color: subTextColor,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                            AppText(
                                text:
                                    "₹ ${goalController.goalData["pending_loan"]}",
                                color: subTextColor,
                                fontSize: 15),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const AppText(
                                text: "Monthly Income",
                                color: subTextColor,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                            AppText(
                                text:
                                    "₹ ${goalController.goalData["month_income"]}",
                                color: subTextColor,
                                fontSize: 15),
                          ],
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.15),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const AppText(
                                text: "Net Savings",
                                color: subTextColor,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                            AppText(
                                text:
                                    "₹ ${goalController.goalData["net_savings"]}",
                                color: subTextColor,
                                fontSize: 15),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const AppText(
                                text: "Goal Amount",
                                color: subTextColor,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                            AppText(
                                text: goalController.goalData['interval'] ==
                                        "monthly"
                                    ? "₹ ${goalController.goalData["saving_needed_excluding_all"]}/pm"
                                    : "₹ ${goalController.goalData["saving_needed_excluding_all"]}/day",
                                color: subTextColor,
                                fontSize: 15),
                          ],
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.2),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const AppText(
                                text: "Savings Analysis",
                                color: subTextColor,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                            AppText(
                                text:
                                    "₹ ${goalController.goalData["saving_needed_considering_all"]}",
                                color: subTextColor,
                                fontSize: 15),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              AppText(
                  text: goalController.goalData["message"],
                  color: subTextColor,
                  fontSize: 15),
              const SizedBox(height: 20),
              Row(
                children: [
                  TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: const AppText(
                        text: "Change Goal", color: primaryColor, fontSize: 15),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Dialog(
                              child: Container(
                                padding: const EdgeInsets.all(20),
                                height:
                                    MediaQuery.of(context).size.height * 0.3,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: bgColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const AppText(
                                        text: "Give your goal a name",
                                        color: subTextColor,
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold),
                                    const SizedBox(height: 20),
                                    Container(
                                      alignment: Alignment.center,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 1),
                                      width: double.infinity,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: overlayColor,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: TextFormField(
                                        controller:
                                            goalController.goalNameController,
                                        style: const TextStyle(
                                            color: Colors.white),
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 5),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    Container(
                                      alignment: Alignment.centerRight,
                                      child: TextButton.icon(
                                        onPressed: () {
                                          goalController.goalName.value =
                                              goalController
                                                  .goalNameController.text;

                                          if (goalController
                                              .goalName.isNotEmpty) {
                                            goalController.addGoal();
                                          }
                                        },
                                        icon: const FaIcon(
                                            FontAwesomeIcons.plus,
                                            size: 17,
                                            color: primaryColor),
                                        label: const AppText(
                                            text: "Generate Map",
                                            color: primaryColor,
                                            fontSize: 15),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          });
                    },
                    child: const AppText(
                        text: "Create Goal", color: primaryColor, fontSize: 15),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              )
            ],
          ),
        ),
      ),
    );
  }
}
