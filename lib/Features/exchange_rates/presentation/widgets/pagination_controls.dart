import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swypex_currency/Features/exchange_rates/presentation/cubits/exchange_rate/exchange_rate_cubit.dart';
import 'package:swypex_currency/core/utils/app_colors.dart';

class PaginationControls extends StatelessWidget {
  final int currentPage;
  final int totalRatesCount;
  final int rowsPerPage;

  const PaginationControls({
    super.key,
    required this.currentPage,
    required this.totalRatesCount,
    required this.rowsPerPage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 2),
      ),
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: currentPage > 1
                  ? () => context.read<ExchangeRateCubit>().previousPage()
                  : null,
              child: Container(
                decoration: BoxDecoration(
                  color: currentPage > 1
                      ? Colors.blue.shade200
                      : AppColors.lightSecondaryColor,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black,
                      offset: Offset(3, 3),
                      blurRadius: 2,
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: const Icon(Icons.chevron_left, color: Colors.black),
              ),
            ),
          ),
          Container(width: 1.5, color: Colors.black),
          Expanded(
            child: InkWell(
              onTap: (currentPage * rowsPerPage) < totalRatesCount
                  ? () => context.read<ExchangeRateCubit>().nextPage()
                  : null,
              child: Container(
                decoration: BoxDecoration(
                  color: (currentPage * rowsPerPage) < totalRatesCount
                      ? Colors.white
                      : AppColors.lightSecondaryColor,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black,
                      offset: Offset(3, 3),
                      blurRadius: 2,
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: const Icon(Icons.chevron_right, color: Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
