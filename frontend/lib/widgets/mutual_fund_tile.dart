import 'dart:math';
import 'package:bobhack/constants.dart';
import 'package:bobhack/models/mutual_funds_modal.dart';
import 'package:bobhack/widgets/app_text.dart';
import 'package:flutter/material.dart';

int getRandomNumber(int min, int max) {
  final random = Random();
  return min + random.nextInt(max - min + 1);
}

String getRandomImagePath() {
  int randomNumber = getRandomNumber(1, 10);
  return "assets/image$randomNumber.jpg";
}

class MutualFundsTile extends StatelessWidget {
  const MutualFundsTile({super.key, required this.fund});

  final MutualFunds fund;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(
                    getRandomImagePath(),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    text: fund.name,
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      AppText(
                        text: "Age: ${fund.age}yr",
                        color: const Color.fromARGB(255, 172, 172, 172),
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                      const SizedBox(width: 20),
                      AppText(
                        text: "Category: ${fund.category}",
                        color: const Color.fromARGB(255, 172, 172, 172),
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  AppText(
                    text: "Size: ${fund.size}cr",
                    color: const Color.fromARGB(255, 172, 172, 172),
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                // Handle investment logic
              },
              child: const AppText(
                text: "Invest",
                color: primaryColor,
                fontSize: 15,
                fontWeight: FontWeight.bold,
                overflow: TextOverflow.ellipsis,
              ),
            )
          ],
        ),
        const SizedBox(height: 15),
        const Divider(color: Color.fromARGB(255, 87, 87, 87)),
        const SizedBox(height: 15),
      ],
    );
  }
}

class InvestedMutualFundTile extends StatelessWidget {
  const InvestedMutualFundTile({super.key, required this.fund});

  final InvestedMutualFundModel fund;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(
                    getRandomImagePath(),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    text: fund.fundName,
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppText(
                        text: "Qty: ${fund.unitsPurchased}",
                        color: const Color.fromARGB(255, 172, 172, 172),
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                      // const SizedBox(width: 15),
                      AppText(
                        text:
                            "Invest: ${formatter.format(fund.investmentAmount)}",
                        color: const Color.fromARGB(255, 172, 172, 172),
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                      // const SizedBox(width: 15),
                      AppText(
                        text:
                            "Current: ${formatter.format(fund.currentValue).toString()}",
                        color: const Color.fromARGB(255, 172, 172, 172),
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
        const Divider(color: Color.fromARGB(255, 87, 87, 87)),
        const SizedBox(height: 15),
      ],
    );
  }
}
