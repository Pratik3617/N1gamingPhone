import 'package:flutter/material.dart';
import 'package:n1gaming/Provider/accountsProvider.dart';
import 'package:provider/provider.dart';
import 'accountBox.dart';

class Account extends StatelessWidget {
  const Account({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 30, 58, 58),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
              const Center(
                child: Text(
                  'Account History',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'YoungSerif',
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Expanded(
            child: Consumer<AccountHistoryProvider>(
              builder: (context, provider, child) {
                if (provider.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (provider.accountHistory.isEmpty) {
                  return const Center(
                    child: Text(
                      'No data available',
                      style: TextStyle(
                        decoration: TextDecoration.none,
                        color: Colors.red,
                        fontFamily: 'SansSerif',
                        fontSize: 25,
                      ),
                    ),
                  );
                } else {
                  return ListView.builder(
                    itemCount: provider.accountHistory.length,
                    itemBuilder: (context, index) {
                      return AccountBox(
                          accountDetails: provider.accountHistory[index]);
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
