import 'package:flutter/material.dart';
import 'doctor_deets.dart'; // Ensure this imports the file where DoctorProfilePage is defined.

class DoctorListPage extends StatelessWidget {
  final List<Map<String, String>> doctors = [
    {
      'id': '1',
      'name': 'Dr. Priyanshi Sharma',
      'speciality': 'Gynecologist',
      'experience': '10 years',
      'rating': '4.8',
      'fees': '₹900',
      'image': 'assets/doctors/doctor1.png', // Add image assets in your project
    },
    {
      'id': '2',
      'name': 'Dr. Neha Gupta',
      'speciality': 'PCOS Specialist',
      'experience': '5 years',
      'rating': '4.7',
      'fees': '₹600',
      'image': 'assets/doctors/doctor2.png', // Add image assets in your project
    },
    {
      'id': '3',
      'name': 'Dr. Rituraj Khurrana',
      'speciality': 'Nutritionist',
      'experience': '12 years',
      'rating': '4.9',
      'fees': '₹600',
      'image': 'assets/doctors/doctor3.png', // Add image assets in your project
    },
    {
      'id': '4',
      'name': 'Dr. Fatima Mehvish Patel',
      'speciality': 'Obstetrician',
      'experience': '8 years',
      'rating': '4.6',
      'fees': '₹700',
      'image': 'assets/doctors/doctor4.png', // Add image assets in your project
    },
    {
      'id': '5',
      'name': 'Dr. Agnez Iyer',
      'speciality': 'Endometriosis Specialist',
      'experience': '6 years',
      'rating': '5.0',
      'fees': '₹850',
      'image': 'assets/doctors/doctor5.png', // Add image assets in your project
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Doctor Appointment Booking'),
        backgroundColor: Colors.pink[300], // Pink theme for AppBar
      ),
      body: ListView.builder(
        itemCount: doctors.length,
        itemBuilder: (context, index) {
          return DoctorCard(doctor: doctors[index]);
        },
      ),
    );
  }
}

class DoctorCard extends StatelessWidget {
  final Map<String, String> doctor;

  DoctorCard({required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      color: Colors.white,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () {
          // Navigate to the doctor profile page when the card is clicked
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DoctorProfilePage(
                  doctor:
                      doctor), // Passing the doctor data to the profile page
            ),
          );
        },
        child: Padding(
          padding: EdgeInsets.all(12.0),
          child: Row(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: AssetImage(doctor['image']!),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      doctor['name']!,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.pink[600],
                      ),
                    ),
                    Text(
                      doctor['speciality']!,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Experience: ${doctor['experience']}',
                          style: TextStyle(fontSize: 12),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 16,
                            ),
                            SizedBox(width: 3),
                            Text(
                              doctor['rating']!,
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Fees: ${doctor['fees']}',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
