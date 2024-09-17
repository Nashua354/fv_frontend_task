import 'package:flutter/material.dart';

class FilterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Filters',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FilterSection(
              title: 'Date range',
              options: const [
                'All time',
                'Current month',
                'Last month',
                'This year',
                'Previous year',
              ],
              selectedOption: 'Current month',
            ),
            FilterSection(
              title: 'Status',
              options: const [
                'All',
                'Completed',
                'Pending',
              ],
              selectedOption: 'Completed',
            ),
            FilterSection(
              title: 'Categories',
              options: const [
                'All',
                'Foods & dining',
                'Housing',
                'Auto & Transport',
                'Health',
                'Entertainments',
                'Gifts & Donations',
                'Bills & Utility',
                'Travel & Lifestyle',
                'Shopping',
                'Income',
                'Investment',
                'Transfer',
                'Other',
                'Excluded',
              ],
              selectedOption: 'Foods & dining',
            ),
            FilterSection(
              title: 'Transaction type',
              options: const [
                'All',
                'Buy',
                'Sell',
                'Deposit',
                'Withdrawl',
              ],
              selectedOption: 'Withdrawl',
            ),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.black),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text(
                      'Clear all',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text(
                      'Apply',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class FilterSection extends StatelessWidget {
  final String title;
  final List<String> options;
  final String selectedOption;

  FilterSection({
    required this.title,
    required this.options,
    required this.selectedOption,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: options.map((option) {
              final isSelected = option == selectedOption;
              return FilterChip(
                label: Text(option),
                selected: isSelected,
                onSelected: (selected) {},
                selectedColor: Colors.black,
                backgroundColor: Colors.grey[200],
                labelStyle: TextStyle(
                  color: isSelected ? Colors.white : Colors.black,
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
