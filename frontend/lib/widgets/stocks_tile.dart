import 'package:bobhack/constants.dart';
import 'package:bobhack/models/stocks_model.dart';
import 'package:bobhack/widgets/app_text.dart';
import 'package:flutter/material.dart';

class StocksTile extends StatelessWidget {
  const StocksTile({super.key, required this.stocks});

  final StocksModel stocks;

  @override
  Widget build(BuildContext context) {
    final double purchasedPrice = double.parse(stocks.purchasedPrice);
    final double quantity = stocks.quantity.toDouble();
    final double invested = purchasedPrice * quantity;
    final double? currentPrice = stocks.currentPrice;

    // Check if currentPrice is null to avoid calculations with null values
    final double ltp =
        currentPrice != null ? (currentPrice - purchasedPrice) * quantity : 0.0;
    final double percentageChange = currentPrice != null
        ? ((currentPrice - purchasedPrice) / purchasedPrice) * 100
        : 0.0;

    return Container(
      height: MediaQuery.of(context).size.height * 0.14,
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(bottom: 5),
      color: overlayColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const AppText(text: "Qty.", color: subTextColor, fontSize: 15),
              const SizedBox(width: 5),
              AppText(
                  text: stocks.quantity.toString(),
                  color: Colors.white38,
                  fontSize: 15),
              const SizedBox(width: 10),
              const Icon(
                Icons.circle,
                color: subTextColor,
                size: 7,
              ),
              const SizedBox(width: 10),
              const AppText(text: "Avg.", color: subTextColor, fontSize: 15),
              const SizedBox(width: 5),
              AppText(
                  text: stocks.purchasedPrice,
                  color: Colors.white38,
                  fontSize: 15),
              const Spacer(),
              AppText(
                  text: "${percentageChange.toStringAsFixed(2)}%",
                  color: percentageChange < 0 ? Colors.redAccent : Colors.green,
                  fontSize: 13),
            ],
          ),
          Row(
            children: [
              AppText(
                  text: stocks.stockName, color: Colors.white, fontSize: 17),
              const Spacer(),
              AppText(
                  text: ltp.toStringAsFixed(2),
                  color: ltp < 0 ? Colors.redAccent : Colors.green,
                  fontSize: 17),
            ],
          ),
          Row(
            children: [
              const AppText(
                  text: "Invested", color: subTextColor, fontSize: 15),
              const SizedBox(width: 5),
              AppText(
                  text: invested.toStringAsFixed(2),
                  color: Colors.white38,
                  fontSize: 15),
              const Spacer(),
              const AppText(text: "Current", color: subTextColor, fontSize: 15),
              const SizedBox(width: 5),
              AppText(
                  text: currentPrice != null
                      ? currentPrice.toStringAsFixed(2)
                      : "0.0",
                  color: Colors.white38,
                  fontSize: 15),
              const SizedBox(width: 5),
              AppText(
                  text: "${percentageChange.toStringAsFixed(2)}%",
                  color: percentageChange < 0 ? Colors.redAccent : Colors.green,
                  fontSize: 15),
            ],
          ),
        ],
      ),
    );
  }
}
