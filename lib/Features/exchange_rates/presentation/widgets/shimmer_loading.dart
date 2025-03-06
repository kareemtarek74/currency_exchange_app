import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

// A shimmer loading effect to simulate the loading state of the currency table
class ShimmerLoadingWidget extends StatelessWidget {
  const ShimmerLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Creates a shimmering effect for the table header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              height: 30,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        // Creates shimmer placeholders for table rows
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Column(
              children: [
                buildShimmerHeader(), // Header shimmer effect
                buildShimmerRows(), // Rows shimmer effect
              ],
            ),
          ),
        ),
      ],
    );
  }

// Builds a shimmer effect for the table header to match actual table structure
  Widget buildShimmerHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: List.generate(4, (index) {
          return Container(
            height: 28,
            width: getColumnWidth(index), // adjusts width based on column index
            margin: const EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(4),
            ),
          );
        }),
      ),
    );
  }

// build a shimmer effect for the table rows, ensuring proper alignment
  Widget buildShimmerRows() {
    return Column(
      children: List.generate(5, (index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          child: Row(
            children: List.generate(4, (colIndex) {
              return Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  height: 30,
                  width: getColumnWidth(colIndex), // matches table column width
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              );
            }),
          ),
        );
      }),
    );
  }

// returns dynamic column width to match the actual table structure
  double getColumnWidth(int index) {
    switch (index) {
      case 0:
        return 100;
      case 1:
        return 80;
      case 2:
        return 80;
      case 3:
        return 120;
      default:
        return 100;
    }
  }
}
