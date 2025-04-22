import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppointmentBookingPage extends StatefulWidget {
  final Map<String, String> doctor;

  AppointmentBookingPage({required this.doctor});

  @override
  _AppointmentBookingPageState createState() => _AppointmentBookingPageState();
}

class _AppointmentBookingPageState extends State<AppointmentBookingPage> {
  DateTime? _selectedDate;
  String? _selectedTime;
  final List<String> _availableTimeSlots = [
    "10:00 AM",
    "11:00 AM",
    "12:00 PM",
    "1:00 PM",
    "2:00 PM",
    "3:00 PM",
    "4:00 PM"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Appointment with ${widget.doctor['name']}'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Doctor's Image and Details
            Row(
              children: [
                // CircleAvatar(
                //   radius: 40, // Adjust size as needed
                //   backgroundImage: NetworkImage(widget.doctor['image'] ??
                //       'https://via.placeholder.com/150'),
                //   backgroundColor: Colors.grey[300],
                // ),
                CircleAvatar(
                  radius: 40, // Adjust size as needed
                  backgroundImage: AssetImage(
                    _getDoctorImage(widget
                        .doctor), // Use a function to determine the image path
                  ),
                  backgroundColor: Colors.grey[300],
                ),

                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.doctor['name'] ?? 'Doctor Name',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Specialty: ${widget.doctor['speciality'] ?? 'N/A'}',
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      'Experience: ${widget.doctor['experience'] ?? 'N/A'}',
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      'Rating: ${widget.doctor['rating'] ?? 'N/A'}',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),

            // Date Selection
            Text(
              'Select Appointment Date:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            GestureDetector(
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2023),
                  lastDate: DateTime(2101),
                );
                if (pickedDate != null && pickedDate != _selectedDate) {
                  setState(() {
                    _selectedDate = pickedDate;
                  });
                }
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.calendar_today,
                      color: Colors.blue,
                    ),
                    SizedBox(width: 10),
                    Text(
                      _selectedDate == null
                          ? 'Select a date'
                          : DateFormat('dd MMM yyyy').format(_selectedDate!),
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),

            // Time Slot Selection
            Text(
              'Select Appointment Time:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            DropdownButton<String>(
              hint: Text('Select time slot'),
              value: _selectedTime,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedTime = newValue;
                });
              },
              items: _availableTimeSlots.map((String time) {
                return DropdownMenuItem<String>(
                  value: time,
                  child: Text(time),
                );
              }).toList(),
            ),
            SizedBox(height: 20),

            // Confirm Button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  if (_selectedDate != null && _selectedTime != null) {
                    // Appointment confirmed, show a dialog or message
                    _showConfirmationDialog();
                  } else {
                    // Show error if any field is missing
                    _showErrorDialog();
                  }
                },
                // child: Text('Confirm Appointment'),
                // style: ElevatedButton.styleFrom(
                //   padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                //   backgroundColor: Colors.pink[300],
                //   textStyle: TextStyle(fontSize: 18, color: Colors.black),
                //   shape: RoundedRectangleBorder(
                //     borderRadius: BorderRadius.circular(8),
                //   ),
                // ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink[300], // Button color
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 30),
                ),
                child: Text(
                  'Confirm Appointment',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                // ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Appointment Confirmed!'),
          content: Text(
            'Your appointment with Dr. ${widget.doctor['name']} has been successfully booked for ${DateFormat('dd MMM yyyy').format(_selectedDate!)} at $_selectedTime.',
          ),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context); // Go back to the previous screen
              },
            ),
          ],
        );
      },
    );
  }

  void _showErrorDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(
              'Please select both date and time to confirm the appointment.'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}

String _getDoctorImage(Map<String, String> doctor) {
  // Assuming the doctor object has a unique 'id' or 'imageIndex'
  // You can also use the name or any other unique identifier
  String doctorId =
      doctor['id'] ?? '1'; // Default to doctor1 if no id is provided

  // Dynamically select the image based on the doctor id or image index
  switch (doctorId) {
    case '1':
      return 'assets/doctors/doctor1.png';
    case '2':
      return 'assets/doctors/doctor2.png';
    case '3':
      return 'assets/doctors/doctor3.png';
    case '4':
      return 'assets/doctors/doctor4.png';
    case '5':
      return 'assets/doctors/doctor5.png';
    default:
      return 'assets/doctors/doctor1.png'; // Default image
  }
}
