import 'package:flutter/material.dart';
import 'package:fv_frontend_task/constants/app_colors.dart';
import 'package:fv_frontend_task/constants/mock_responses.dart';
import 'package:go_router/go_router.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  List<String> dateOptions = [
    "All time",
    "Current month",
    "Last month",
    "This year",
    "Previous year"
  ];

  List<String> statusOptions = ["All", "Completed", "Pending"];

  List<String> categoryOptions = [
    "All",
    "Foods & Dining",
    "Housing",
    "Auto & Transport",
    "Health",
    "Entertainments",
    "Gifts & Donations",
    "Bills & Utlity",
    "Travel & Lifestyle",
    "Shopping",
    "Income",
    "Investment",
    "Transfer",
    "Other",
    "Excluded"
  ];

  List<String> transactionTypeOptions = [
    "All",
    "Buy",
    "Sell",
    "Deposit",
    "Withdrawal"
  ];

  String selectedDateOption = "All time";

  String selectedStatusOption = "All";

  String selectedCategoryOption = "All";

  String selectedTransactionTypeOption = "All";
  @override
  void initState() {
    if (selectedFilters["date"].isNotEmpty) {
      selectedDateOption = selectedFilters["date"];
    }
    if (selectedFilters["status"].isNotEmpty) {
      selectedStatusOption = selectedFilters["status"];
    }
    if (selectedFilters["type"].isNotEmpty) {
      selectedTransactionTypeOption = selectedFilters["type"];
    }
    if (selectedFilters["category"].isNotEmpty) {
      selectedCategoryOption = selectedFilters["category"];
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _filterSection(
              title: 'Date range',
              options: dateOptions,
            ),
            _filterSection(
              title: 'Status',
              options: statusOptions,
            ),
            _filterSection(
              title: 'Categories',
              options: categoryOptions,
            ),
            _filterSection(
              title: 'Transaction type',
              options: transactionTypeOptions,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      selectedFilters["status"] = "All";
                      selectedFilters["date"] = "All time";
                      selectedFilters["type"] = "All";
                      selectedFilters["category"] = "All";
                      setState(() {});
                      context.pop();
                    },
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
                    onPressed: () {
                      selectedFilters = {
                        "date": selectedDateOption,
                        "type": selectedTransactionTypeOption,
                        "category": selectedCategoryOption,
                        "status": selectedStatusOption,
                      };
                      context.pop();
                    },
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
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  _filterSection({
    required String title,
    required List<String> options,
  }) {
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
            children: options.map(
              (option) {
                String selectedOption = "";
                if (options == categoryOptions) {
                  selectedOption = selectedCategoryOption;
                }
                if (options == dateOptions) {
                  selectedOption = selectedDateOption;
                }
                if (options == transactionTypeOptions) {
                  selectedOption = selectedTransactionTypeOption;
                }
                if (options == statusOptions) {
                  selectedOption = selectedStatusOption;
                }
                return FilterChip(
                  showCheckmark: false,
                  label: Text(option),
                  selected: selectedOption == option,
                  onSelected: (selected) {
                    if (options == categoryOptions) {
                      selectedCategoryOption = option;
                    }
                    if (options == dateOptions) {
                      selectedDateOption = option;
                    }
                    if (options == transactionTypeOptions) {
                      selectedTransactionTypeOption = option;
                    }
                    if (options == statusOptions) {
                      selectedStatusOption = option;
                    }
                    setState(() {});
                  },
                  selectedColor: Colors.black,
                  backgroundColor: Colors.grey[200],
                  labelStyle: TextStyle(
                    color:
                        selectedOption == option ? Colors.white : Colors.black,
                  ),
                );
              },
            ).toList(),
          ),
          const SizedBox(height: 8),
          Divider(color: AppColors.dividerColor, height: 2),
        ],
      ),
    );
  }
}
