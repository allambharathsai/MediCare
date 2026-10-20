import 'package:flutter/material.dart';

class AppointmentsScreen extends StatelessWidget {
  const AppointmentsScreen({super.key});

  final appointments = const [
    {
      'patient': 'Rahul Kumar',
      'doctor': 'Dr. Anil Kumar',
      'department': 'Cardiology',
      'time': '10:00 AM',
      'status': 'Confirmed',
    },
    {
      'patient': 'Priya Sharma',
      'doctor': 'Dr. Sneha Rao',
      'department': 'Neurology',
      'time': '11:30 AM',
      'status': 'Waiting',
    },
    {
      'patient': 'Arjun Reddy',
      'doctor': 'Dr. Ravi Teja',
      'department': 'Orthopedics',
      'time': '02:00 PM',
      'status': 'Confirmed',
    },
    {
      'patient': 'Sneha Patel',
      'doctor': 'Dr. Meera',
      'department': 'General Medicine',
      'time': '04:30 PM',
      'status': 'Pending',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Appointments',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.filter_list),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _addAppointment(context);
        },
        icon: const Icon(Icons.add),
        label: const Text('New Appointment'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          int columns = 1;

          if (constraints.maxWidth >= 1200) {
            columns = 3;
          } else if (constraints.maxWidth >= 700) {
            columns = 2;
          }

          return GridView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: appointments.length,
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: columns,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              childAspectRatio: columns == 1 ? 2.8 : 1.6,
            ),
            itemBuilder: (context, index) {
              final appointment = appointments[index];

              return Card(
                elevation: 0,
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Theme.of(context)
                                .colorScheme
                                .primaryContainer,
                            child: const Icon(Icons.person),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              appointment['patient']!,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          const Icon(Icons.more_vert),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Text(
                        appointment['doctor']!,
                        style: TextStyle(
                          color: Colors.grey.shade700,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        appointment['department']!,
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 13,
                        ),
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          const Icon(
                            Icons.access_time,
                            size: 18,
                          ),
                          const SizedBox(width: 6),
                          Text(appointment['time']!),
                          const Spacer(),
                          Text(
                            appointment['status']!,
                            style: TextStyle(
                              color: appointment['status'] ==
                                      'Confirmed'
                                  ? Colors.green.shade700
                                  : Colors.orange.shade700,
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _addAppointment(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text('New Appointment'),
          content: const SizedBox(
            width: 450,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Patient Name',
                      prefixIcon: Icon(Icons.person_outline),
                    ),
                  ),
                  SizedBox(height: 12),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Doctor',
                      prefixIcon: Icon(Icons.medical_services_outlined),
                    ),
                  ),
                  SizedBox(height: 12),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Date',
                      prefixIcon: Icon(Icons.calendar_today),
                    ),
                  ),
                  SizedBox(height: 12),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Time',
                      prefixIcon: Icon(Icons.access_time),
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Create'),
            ),
          ],
        );
      },
    );
  }
}