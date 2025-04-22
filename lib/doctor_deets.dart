import 'package:flutter/material.dart';
import 'package:herahealthie/doctor_book.dart';

class DoctorProfilePage extends StatelessWidget {
  final Map<String, String> doctor;

  DoctorProfilePage({required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(doctor['name']!),
        backgroundColor: Colors.pink[300],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Doctor Profile Picture
            Container(
              height:
                  MediaQuery.of(context).size.height * 0.40, // 40% of the page
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(doctor['image']!),
                  fit: BoxFit.cover,
                ),
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(30)),
              ),
            ),

            // Doctor Name, Speciality, Rating & Reviews
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    doctor['name']!,
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.pink[600]),
                  ),
                  SizedBox(height: 5),
                  Text(
                    doctor['speciality']!,
                    style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 18),
                      SizedBox(width: 5),
                      Text(
                        '${doctor['rating']} | 196 reviews',
                        style: TextStyle(fontSize: 14, color: Colors.pink[400]),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Icons Section: Patients Treated, Experience, Rating, Reviews
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildIconSection(Icons.person, 'Patients Treated', '1500+'),
                  _buildIconSection(
                      Icons.check_circle, 'Experience', '10 years'),
                  _buildIconSection(Icons.star, 'Rating', '4.8'),
                  _buildIconSection(Icons.message, 'Reviews', '196'),
                ],
              ),
            ),

            // About Me Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'About Me',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.pink[600]),
                  ),
                  SizedBox(height: 10),
                  Text(
                    '${doctor['name']} is a highly experienced specialist in ${doctor['speciality']} with over ${doctor['experience']} of experience. Passionate about improving health and well-being, she offers comprehensive care to her patients, focusing on personalized treatment plans and the latest medical advancements.',
                    style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                  ),
                ],
              ),
            ),

            // Book Appointment Button
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  // Navigate to appointment booking
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          AppointmentBookingPage(doctor: doctor),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink[300], // Button color
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 30),
                ),
                child: Text(
                  'Book Appointment',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIconSection(IconData icon, String title, String value) {
    return Column(
      children: [
        Icon(
          icon,
          color: Colors.pink[400],
          size: 30,
        ),
        SizedBox(height: 5),
        Text(
          value,
          style: TextStyle(fontSize: 14, color: Colors.grey[600]),
        ),
        SizedBox(height: 5),
        Text(
          title,
          style: TextStyle(fontSize: 12, color: Colors.grey[500]),
        ),
      ],
    );
  }
}
