import 'package:flutter/material.dart';

import '../models/payment.dart';
import '../widgets/payment_card.dart';

class PaymentsScreen extends StatefulWidget {
  const PaymentsScreen({super.key});

  @override
  State<PaymentsScreen> createState() => _PaymentsScreenState();
}

class _PaymentsScreenState extends State<PaymentsScreen> {
  final List<Payment> payments = [
    Payment(
      id: 'PAY-001',
      patientName: 'Rahul Kumar',
      amount: 4500,
      method: 'UPI',
      status: 'Paid',
      date: '30 Sep 2026',
    ),
    Payment(
      id: 'PAY-002',
      patientName: 'Priya Sharma',
      amount: 2800,
      method: 'Cash',
      status: 'Paid',
      date: '30 Sep 2026',
    ),
    Payment(
      id: 'PAY-003',
      patientName: 'Arjun Reddy',
      amount: 6500,
      method: 'UPI',
      status: 'Pending',
      date: '29 Sep 2026',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final paidAmount = payments
        .where((payment) => payment.status == 'Paid')
        .fold<double>(
          0,
          (sum, payment) => sum + payment.amount,
        );

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Payments',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _showPaymentDialog(context);
        },
        icon: const Icon(Icons.add),
        label: const Text('Add Payment'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          int columns = 1;

          if (constraints.maxWidth >= 1200) {
            columns = 3;
          } else if (constraints.maxWidth >= 700) {
            columns = 2;
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GridView.count(
                  crossAxisCount: columns,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  childAspectRatio: 2.1,
                  children: [
                    _PaymentSummaryCard(
                      title: 'Total Collected',
                      value:
                          '₹${paidAmount.toStringAsFixed(0)}',
                      icon: Icons.account_balance_wallet_outlined,
                    ),
                    _PaymentSummaryCard(
                      title: 'Transactions',
                      value: '${payments.length}',
                      icon: Icons.receipt_long_outlined,
                    ),
                    _PaymentSummaryCard(
                      title: 'Pending',
                      value:
                          '₹${payments.where((p) => p.status == 'Pending').fold<double>(0, (s, p) => s + p.amount).toStringAsFixed(0)}',
                      icon: Icons.pending_actions,
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                const Text(
                  'Payment History',
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                ...payments.map(
                  (payment) => Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: PaymentCard(payment: payment),
                  ),
                ),
                const SizedBox(height: 70),
              ],
            ),
          );
        },
      ),
    );
  }

  void _showPaymentDialog(BuildContext context) {
    final patientController = TextEditingController();
    final amountController = TextEditingController();

    String method = 'Cash';

    showDialog(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text('Record Payment'),
              content: SizedBox(
                width: 500,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      TextField(
                        controller: patientController,
                        decoration: const InputDecoration(
                          labelText: 'Patient Name',
                          prefixIcon: Icon(Icons.person_outline),
                        ),
                      ),
                      const SizedBox(height: 15),
                      TextField(
                        controller: amountController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Amount',
                          prefixIcon:
                              Icon(Icons.currency_rupee),
                        ),
                      ),
                      const SizedBox(height: 15),
                      DropdownButtonFormField<String>(
                        value: method,
                        decoration: const InputDecoration(
                          labelText: 'Payment Method',
                          prefixIcon: Icon(Icons.payment),
                        ),
                        items: const [
                          DropdownMenuItem(
                            value: 'Cash',
                            child: Text('Cash'),
                          ),
                          DropdownMenuItem(
                            value: 'UPI',
                            child: Text('UPI'),
                          ),
                        ],
                        onChanged: (value) {
                          setDialogState(() {
                            method = value ?? 'Cash';
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(dialogContext);
                  },
                  child: const Text('Cancel'),
                ),
                FilledButton(
                  onPressed: () {
                    final amount =
                        double.tryParse(amountController.text);

                    if (patientController.text.trim().isNotEmpty &&
                        amount != null) {
                      setState(() {
                        payments.add(
                          Payment(
                            id: 'PAY-${payments.length + 1}',
                            patientName:
                                patientController.text.trim(),
                            amount: amount,
                            method: method,
                            status: 'Paid',
                            date: '30 Sep 2026',
                          ),
                        );
                      });

                      Navigator.pop(dialogContext);
                    }
                  },
                  child: const Text('Save Payment'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

class _PaymentSummaryCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const _PaymentSummaryCard({
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(13),
              decoration: BoxDecoration(
                color: Theme.of(context)
                    .colorScheme
                    .primaryContainer,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(
                icon,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    value,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}