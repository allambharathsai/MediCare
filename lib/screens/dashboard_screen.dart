import 'package:flutter/material.dart';

import '../models/patient.dart';
import '../models/payment.dart';
import '../widgets/app_shell.dart';
import '../widgets/patient_card.dart';
import '../widgets/payment_card.dart';
import '../widgets/stat_card.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppShell();
  }
}

class DashboardContent extends StatelessWidget {
  const DashboardContent({super.key});

  final List<Patient> patients = const [
    Patient(
      id: 'PT-1001',
      name: 'Rahul Kumar',
      age: 34,
      gender: 'Male',
      phone: '+91 98765 43210',
      bloodGroup: 'O+',
      department: 'Cardiology',
      doctor: 'Dr. Anil Kumar',
      admissionDate: '30 Sep 2026',
      status: 'Active',
    ),
    Patient(
      id: 'PT-1002',
      name: 'Priya Sharma',
      age: 28,
      gender: 'Female',
      phone: '+91 98765 12345',
      bloodGroup: 'A+',
      department: 'Neurology',
      doctor: 'Dr. Sneha Rao',
      admissionDate: '29 Sep 2026',
      status: 'Active',
    ),
    Patient(
      id: 'PT-1003',
      name: 'Arjun Reddy',
      age: 45,
      gender: 'Male',
      phone: '+91 91234 56789',
      bloodGroup: 'B+',
      department: 'Orthopedics',
      doctor: 'Dr. Ravi Teja',
      admissionDate: '28 Sep 2026',
      status: 'Discharged',
    ),
  ];

  final List<Payment> payments = const [
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
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Dashboard',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              'Welcome back, Admin',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          int columns = 1;

          if (constraints.maxWidth >= 1200) {
            columns = 4;
          } else if (constraints.maxWidth >= 700) {
            columns = 2;
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Hospital Overview',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'Here is what is happening today.',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 20),
                GridView.count(
                  crossAxisCount: columns,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  childAspectRatio: constraints.maxWidth < 400
                      ? 1.9
                      : 2.2,
                  children: const [
                    StatCard(
                      title: 'Total Patients',
                      value: '1,248',
                      icon: Icons.people_alt_outlined,
                      subtitle: '+12% this month',
                    ),
                    StatCard(
                      title: 'Appointments',
                      value: '86',
                      icon: Icons.calendar_today_outlined,
                      subtitle: '18 scheduled today',
                    ),
                    StatCard(
                      title: 'Available Beds',
                      value: '42',
                      icon: Icons.bed_outlined,
                      subtitle: '68% occupancy',
                    ),
                    StatCard(
                      title: 'Revenue',
                      value: '₹2.4L',
                      icon: Icons.currency_rupee,
                      subtitle: '+8.5% this month',
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Row(
                  children: [
                    const Expanded(
                      child: Text(
                        'Recent Patients',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text('View all'),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                GridView.builder(
                  itemCount: patients.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate:
                      SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: columns == 1 ? 1 : 2,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                    childAspectRatio: columns == 1 ? 2.0 : 1.35,
                  ),
                  itemBuilder: (context, index) {
                    return PatientCard(
                      patient: patients[index],
                    );
                  },
                ),
                const SizedBox(height: 30),
                const Text(
                  'Recent Payments',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                ...payments.map(
                  (payment) => Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: PaymentCard(payment: payment),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}