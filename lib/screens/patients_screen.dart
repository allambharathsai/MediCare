import 'package:flutter/material.dart';

import '../models/patient.dart';
import '../widgets/patient_card.dart';

class PatientsScreen extends StatefulWidget {
  const PatientsScreen({super.key});

  @override
  State<PatientsScreen> createState() => _PatientsScreenState();
}

class _PatientsScreenState extends State<PatientsScreen> {
  final searchController = TextEditingController();

  final List<Patient> patients = [
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
    Patient(
      id: 'PT-1004',
      name: 'Sneha Patel',
      age: 31,
      gender: 'Female',
      phone: '+91 99887 77665',
      bloodGroup: 'AB+',
      department: 'General Medicine',
      doctor: 'Dr. Meera',
      admissionDate: '27 Sep 2026',
      status: 'Active',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Patients',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () {
              _showAddPatientDialog(context);
            },
            icon: const Icon(Icons.person_add_alt_1),
          ),
          const SizedBox(width: 8),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _showAddPatientDialog(context);
        },
        icon: const Icon(Icons.add),
        label: const Text('Add Patient'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: searchController,
              onChanged: (_) {
                setState(() {});
              },
              decoration: const InputDecoration(
                hintText: 'Search patients...',
                prefixIcon: Icon(Icons.search),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final filtered = patients.where((patient) {
                    return patient.name
                        .toLowerCase()
                        .contains(searchController.text.toLowerCase());
                  }).toList();

                  int columns = 1;

                  if (constraints.maxWidth >= 1200) {
                    columns = 3;
                  } else if (constraints.maxWidth >= 700) {
                    columns = 2;
                  }

                  return GridView.builder(
                    padding: const EdgeInsets.only(bottom: 80),
                    itemCount: filtered.length,
                    gridDelegate:
                        SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: columns,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 15,
                      childAspectRatio: columns == 1 ? 1.7 : 1.15,
                    ),
                    itemBuilder: (context, index) {
                      return PatientCard(
                        patient: filtered[index],
                        onTap: () {
                          _showPatientDetails(
                            context,
                            filtered[index],
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddPatientDialog(BuildContext context) {
    final nameController = TextEditingController();
    final ageController = TextEditingController();
    final phoneController = TextEditingController();

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Add New Patient'),
          content: SizedBox(
            width: 500,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      labelText: 'Patient Name',
                      prefixIcon: Icon(Icons.person_outline),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: ageController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Age',
                      prefixIcon: Icon(Icons.cake_outlined),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      labelText: 'Phone Number',
                      prefixIcon: Icon(Icons.phone_outlined),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const TextField(
                    decoration: InputDecoration(
                      labelText: 'Blood Group',
                      prefixIcon: Icon(Icons.bloodtype_outlined),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const TextField(
                    decoration: InputDecoration(
                      labelText: 'Department',
                      prefixIcon: Icon(Icons.medical_services_outlined),
                    ),
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
                if (nameController.text.trim().isNotEmpty) {
                  setState(() {
                    patients.add(
                      Patient(
                        id: 'PT-${1000 + patients.length + 1}',
                        name: nameController.text.trim(),
                        age: int.tryParse(ageController.text) ?? 0,
                        gender: 'Not specified',
                        phone: phoneController.text.trim(),
                        bloodGroup: 'Not specified',
                        department: 'General Medicine',
                        doctor: 'Not assigned',
                        admissionDate: '30 Sep 2026',
                        status: 'Active',
                      ),
                    );
                  });

                  Navigator.pop(dialogContext);
                }
              },
              child: const Text('Add Patient'),
            ),
          ],
        );
      },
    );
  }

  void _showPatientDetails(
    BuildContext context,
    Patient patient,
  ) {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (_) {
        return SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(
              24,
              10,
              24,
              30,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  patient.name,
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(patient.id),
                const Divider(height: 30),
                _detail('Age', '${patient.age} years'),
                _detail('Gender', patient.gender),
                _detail('Phone', patient.phone),
                _detail('Blood Group', patient.bloodGroup),
                _detail('Department', patient.department),
                _detail('Doctor', patient.doctor),
                _detail('Admission', patient.admissionDate),
                _detail('Status', patient.status),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _detail(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}