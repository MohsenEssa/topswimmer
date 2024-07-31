import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

enum ReminderInterval {
  Daily,
  EveryTwoDays,
  EveryThreeDays,
}

class SchedulingScreen extends StatefulWidget {
  const SchedulingScreen({super.key});

  @override
  _SchedulingScreenState createState() => _SchedulingScreenState();
}

class _SchedulingScreenState extends State<SchedulingScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  ReminderInterval _selectedInterval = ReminderInterval.Daily;
  List<Map<String, dynamic>> reminders = [];

  @override
  void initState() {
    super.initState();
    _loadReminders();
  }

  @override
  void dispose() {
    _timeController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _loadReminders() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('reminders')
          .get()
          .then((QuerySnapshot querySnapshot) {
        List<Map<String, dynamic>> fetchedReminders = [];
        for (var document in querySnapshot.docs) {
          Map<String, dynamic> data =
              document.data() as Map<String, dynamic>? ?? {};
          Map<String, dynamic> reminderData = {
            'id': document.id,
            ...data,
          };
          fetchedReminders.add(reminderData);
        }
        setState(() {
          reminders = fetchedReminders;
        });
      }).catchError((error) {
        print('Failed to fetch reminders: $error');
      });
    }
  }

  Future<void> _addReminder() async {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      TimeOfDay selectedTime = TimeOfDay.fromDateTime(
        DateFormat.jm().parse(_timeController.text),
      );
      String message = _messageController.text;

      Map<String, dynamic> newReminder = {
        'time': selectedTime.format(context),
        'reminderText': message,
        'interval': _selectedInterval.toString(),
      };

      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .collection('reminders')
            .add(newReminder)
            .then((value) {
          print('Reminder added successfully!');
          _clearForm();
        }).catchError((error) {
          print('Failed to add reminder: $error');
        });
      }
    }
  }

  Future<void> _deleteReminder(int index) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('reminders')
          .doc(reminders[index]['id'])
          .delete()
          .then((value) {
        print('Reminder deleted successfully!');
        setState(() {
          reminders.removeAt(index);
        });
      }).catchError((error) {
        print('Failed to delete reminder: $error');
      });
    }
  }

  void _clearForm() {
    _timeController.clear();
    _messageController.clear();
    _selectedInterval = ReminderInterval.Daily;
  }

  String getIntervalLabel(ReminderInterval interval) {
    switch (interval) {
      case ReminderInterval.Daily:
        return 'Daily';
      case ReminderInterval.EveryTwoDays:
        return 'Every 2 Days';
      case ReminderInterval.EveryThreeDays:
        return 'Every 3 Days';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Watering Reminders',
          style: TextStyle(color: Colors.green, fontSize: 25),
        ),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.green),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _messageController,
                decoration: const InputDecoration(
                  labelText: 'Which Plants  🌱',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.green,
                    ),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter Plants';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _timeController,
                decoration: const InputDecoration(
                  labelText: 'Select Time  ⏰',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.green,
                    ),
                  ),
                ),
                readOnly: true,
                onTap: () async {
                  final TimeOfDay? pickedTime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (pickedTime != null) {
                    setState(() {
                      _timeController.text = pickedTime.format(context);
                    });
                  }
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please select a time';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              DropdownButtonFormField<ReminderInterval>(
                value: _selectedInterval,
                onChanged: (value) {
                  setState(() {
                    _selectedInterval = value!;
                  });
                },
                items: const [
                  DropdownMenuItem(
                    value: ReminderInterval.Daily,
                    child: Text('Daily'),
                  ),
                  DropdownMenuItem(
                    value: ReminderInterval.EveryTwoDays,
                    child: Text('Every 2 Days'),
                  ),
                  DropdownMenuItem(
                    value: ReminderInterval.EveryThreeDays,
                    child: Text('Every 3 Days'),
                  ),
                ],
                decoration: const InputDecoration(
                  labelText: 'Interval',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                ),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _addReminder,
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: Colors.green,
                ),
                child: const Text('Add Reminder'),
              ),
              const SizedBox(height: 16.0),
              Expanded(
                child: ListView.builder(
                  itemCount: reminders.length,
                  itemBuilder: (context, index) {
                    final reminder = reminders[index];
                    final selectedTime = reminder['time'] as String;
                    final reminderText = reminder['reminderText'] as String;
                    final interval = reminder['interval'] as String;

                    final ReminderInterval parsedInterval =
                        ReminderInterval.values.firstWhere(
                      (e) => e.toString() == 'ReminderInterval.$interval',
                      orElse: () => ReminderInterval.Daily,
                    );

                    return ListTile(
                      title: Text('$selectedTime - $reminderText'),
                      subtitle:
                          Text('Interval: ${getIntervalLabel(parsedInterval)}'),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => _deleteReminder(index),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
