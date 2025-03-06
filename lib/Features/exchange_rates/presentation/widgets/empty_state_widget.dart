import 'package:flutter/material.dart';
import 'package:swypex_currency/core/utils/app_colors.dart';

class EmptyStateWidget extends StatelessWidget {
  final VoidCallback onPickDate;

  const EmptyStateWidget({super.key, required this.onPickDate});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          Icons.date_range,
          size: 64,
          color: Colors.grey.shade400,
        ),
        const SizedBox(height: 16),
        Text(
          "Start by selecting a time period",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade700,
          ),
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Text(
            "Select a start and end date to retrieve historical exchange rates, then press the Submit button.",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
          ),
        ),
        const SizedBox(height: 24),
        ElevatedButton.icon(
          onPressed: onPickDate,
          icon: const Icon(Icons.edit_calendar),
          label: const Text(
            "Pick Dates Now",
          ),
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: AppColors.lightPrimaryColor,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ],
    );
  }
}
