import 'package:bobhack/constants.dart';
import 'package:bobhack/models/transactions_modal.dart';
import 'package:bobhack/widgets/app_text.dart';
import 'package:flutter/material.dart';

class TransactionTile extends StatelessWidget {
  const TransactionTile({super.key, required this.transaction});

  final Transactions transaction;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: overlayColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                text: "To: ${transaction.reciverName}",
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  AppText(
                    text: transaction.date,
                    color: Colors.white,
                    fontSize: 13,
                  ),
                  const SizedBox(width: 20),
                  AppText(
                    text: transaction.description,
                    color: Colors.white,
                    fontSize: 13,
                  ),
                ],
              ),
            ],
          ),
          AppText(
            text: transaction.amount,
            color: const Color.fromARGB(255, 212, 69, 59),
            fontWeight: FontWeight.bold,
            fontSize: 15,
          )
        ],
      ),
    );
  }
}
