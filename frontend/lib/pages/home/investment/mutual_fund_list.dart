import 'package:bobhack/constants.dart';
import 'package:bobhack/controllers/investment_controller.dart';
import 'package:bobhack/widgets/app_text.dart';
import 'package:bobhack/widgets/mutual_fund_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class MutualFundsList extends StatelessWidget {
  MutualFundsList({super.key});

  final MutualFundsController mutualFundsController =
      Get.put(MutualFundsController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => mutualFundsController.isLoading.isTrue
          ? const Center(child: SpinKitWaveSpinner(color: primaryColor))
          : mutualFundsController.searchType.value == "amc"
              ? mutualFundsController.mutualFunds.isEmpty
                  ? const Center(child: SpinKitWaveSpinner(color: primaryColor))
                  : Expanded(
                      child: ListView.builder(
                        itemCount: mutualFundsController.mutualFunds.length,
                        itemBuilder: (context, index) {
                          var fund = mutualFundsController.mutualFunds[index];
                          return MutualFundsTile(
                            fund: fund,
                          );
                        },
                      ),
                    )
              : mutualFundsController.mutualFunds.isEmpty &&
                      mutualFundsController.mutualFundInfoMessage.isEmpty
                  ? const Expanded(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "GenerativeAI",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: subTextColor),
                            ),
                            SizedBox(height: 5),
                            AppText(
                                text: "Invest In Future With Generative AI",
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: subTextColor),
                            SizedBox(height: 15),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                AppText(
                                    text: "Risk",
                                    color: subTextColor,
                                    fontWeight: FontWeight.bold),
                                SizedBox(width: 20),
                                AppText(
                                    text: "Invest",
                                    color: subTextColor,
                                    fontWeight: FontWeight.bold),
                                SizedBox(width: 20),
                                AppText(
                                    text: "Return",
                                    color: subTextColor,
                                    fontWeight: FontWeight.bold),
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  : mutualFundsController.mutualFundInfoMessage.isNotEmpty
                      ? Expanded(
                          child: Center(
                            child: Container(
                              padding: const EdgeInsets.all(20),
                              alignment: Alignment.center,
                              height: 250,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: overlayColor,
                                  borderRadius: BorderRadius.circular(20)),
                              child: AppText(
                                text: mutualFundsController
                                    .mutualFundInfoMessage.value,
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: subTextColor,
                                alignment: TextAlign.center,
                              ),
                            ),
                          ),
                        )
                      : Expanded(
                          child: ListView.builder(
                            itemCount: mutualFundsController.mutualFunds.length,
                            itemBuilder: (context, index) {
                              var fund =
                                  mutualFundsController.mutualFunds[index];
                              return Column(
                                children: [
                                  MutualFundsTile(
                                    fund: fund,
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
    );
  }
}
