// import 'package:flutter/material.dart';
// import 'dart:io';
// import 'package:file_picker/file_picker.dart';
// import 'home_page.dart'; // Import Home Page for navigation

// class ProfilePage extends StatefulWidget {
//   @override
//   _ProfilePageState createState() => _ProfilePageState();
// }

// class _ProfilePageState extends State<ProfilePage> {
//   File? selectedFile;

//   Future<void> uploadPDF() async {
//     FilePickerResult? result = await FilePicker.platform.pickFiles(
//       type: FileType.custom,
//       allowedExtensions: ['pdf'],
//     );

//     if (result != null) {
//       setState(() {
//         selectedFile = File(result.files.single.path!);
//       });
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('PDF Uploaded Successfully')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back, color: Colors.black),
//           onPressed: () {
//             Navigator.pushReplacement(
//                 context, MaterialPageRoute(builder: (context) => HomePage()));
//           },
//         ),
//         title: Text('Profile', style: TextStyle(color: Colors.black)),
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Profile Info Section
//             Row(
//               children: [
//                 CircleAvatar(
//                   radius: 40,
//                   backgroundImage: AssetImage('assets/profile_pic.png'),
//                 ),
//                 SizedBox(width: 16),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text("Hera Rhea Cronus",
//                         style: TextStyle(
//                             fontSize: 22, fontWeight: FontWeight.bold)),
//                     Text("84% Leaning Endometriosis",
//                         style:
//                             TextStyle(fontSize: 16, color: Colors.redAccent)),
//                   ],
//                 ),
//               ],
//             ),
//             SizedBox(height: 20),

//             // Health Profile Section
//             Text("Health Profile",
//                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//             SizedBox(height: 10),

//             Card(
//               elevation: 2,
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10)),
//               // color: Color.fromARGB(255, 253, 240, 244),
//               child: Padding(
//                 padding: EdgeInsets.all(16.0),
//                 child: Column(
//                   children: [
//                     ProfileDetailRow(title: "Age", value: "21"),
//                     ProfileDetailRow(title: "Weight", value: "56 kg"),
//                     ProfileDetailRow(title: "Height", value: "5'6\""),
//                     ProfileDetailRow(title: "Blood Group", value: "O+"),
//                   ],
//                 ),
//               ),
//             ),
//             SizedBox(height: 20),

//             // Medications Section
//             Text("Medications",
//                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//             SizedBox(height: 10),

//             MedicationItem(
//                 name: "Ibuprofen",
//                 amount: "250 mg",
//                 dose: "Twice a day during Cycles"),
//             MedicationItem(
//                 name: "Vitamin D", amount: "1000 IU", dose: "Once a week"),

//             SizedBox(height: 20),

//             // My Documents Section
//             Text("My Documents",
//                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//             SizedBox(height: 10),

//             Card(
//               elevation: 2,
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10)),
//               // color: Colors.pink[50],
//               child: ListTile(
//                 title: Text("View Reports & Prescriptions"),
//                 trailing: Icon(Icons.arrow_forward_ios),
//                 onTap: () {
//                   // Navigate to reports page
//                 },
//               ),
//             ),
//             SizedBox(height: 10),

//             // Upload PDFs Section
//             ElevatedButton.icon(
//               onPressed: uploadPDF,
//               icon: Icon(Icons.upload_file),
//               label: Text("Upload PDF"),
//               style: ElevatedButton.styleFrom(
//                 // backgroundColor: Colors.pink[50], // Lighter Pink
//                 shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10)),
//                 padding: EdgeInsets.symmetric(vertical: 12),
//               ),
//             ),
//             if (selectedFile != null)
//               Padding(
//                 padding: EdgeInsets.only(top: 10),
//                 child: Text("Uploaded: ${selectedFile!.path.split('/').last}",
//                     style: TextStyle(color: Colors.green)),
//               ),
//           ],
//         ),
//       ),
//       // 🔽 Bottom Navigation Bar
//       bottomNavigationBar: BottomAppBar(
//         shape: CircularNotchedRectangle(),
//         notchMargin: 6.0,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             IconButton(icon: Icon(Icons.article), onPressed: () {}),
//             IconButton(icon: Icon(Icons.local_hospital), onPressed: () {}),
//             SizedBox(width: 40), // Space for the floating action button
//             IconButton(icon: Icon(Icons.chat), onPressed: () {}),
//             IconButton(icon: Icon(Icons.shopping_cart), onPressed: () {}),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {},
//         child: Icon(Icons.add_circle, size: 32, color: Colors.white),
//         backgroundColor: Colors.pink.shade300, // Lighter pink shade
//         shape: CircleBorder(),
//         elevation: 5,
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//     );
//   }
// }

// // Widget for Health Profile Details
// class ProfileDetailRow extends StatelessWidget {
//   final String title;
//   final String value;
//   ProfileDetailRow({required this.title, required this.value});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: 5),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(title,
//               style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
//           Text(value, style: TextStyle(fontSize: 16)),
//         ],
//       ),
//     );
//   }
// }

// // Widget for Medication Item

// class MedicationItem extends StatelessWidget {
//   final String name;
//   final String amount;
//   final String dose;

//   MedicationItem({
//     required this.name,
//     required this.amount,
//     required this.dose,
//   });

//   void showMedicationDetails(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text("💊 **Dosage:** $amount"),
//               SizedBox(height: 8),
//               Text(
//                   "🩺 **Prescription Reason:** Used to relieve pain and inflammation."),
//               SizedBox(height: 8),
//               Text("📋 **Usage Instructions:** $dose"),
//               SizedBox(height: 8),
//               Text(
//                 "📖 **General Info:** $name is commonly used to treat mild to moderate pain, reduce inflammation, and manage various conditions such as headaches, muscle pain, and menstrual cramps.",
//               ),
//             ],
//           ),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(context),
//               child: Text("Close", style: TextStyle(color: Colors.pink)),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 2,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//       child: ListTile(
//         title: Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
//         subtitle: Text("$amount | $dose"),
//         trailing: ElevatedButton(
//           onPressed: () => showMedicationDetails(context),
//           child: Text("Details", style: TextStyle(color: Colors.black)),
//           style: ElevatedButton.styleFrom(
//             backgroundColor: Colors.pink.shade300,
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'home_page.dart'; // Import Home Page for navigation

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? selectedFile;

  Future<void> uploadPDF() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      setState(() {
        selectedFile = File(result.files.single.path!);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('PDF Uploaded Successfully')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => HomePage()));
          },
        ),
        title: Text('Profile', style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Info Section
            Row(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage('assets/profile_pic.png'),
                ),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Hera Rhea Cronus",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold)),
                    Text("84% Leaning Endometriosis",
                        style:
                            TextStyle(fontSize: 16, color: Colors.redAccent)),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),

            // Health Profile Section
            SectionTitle(title: "Health Profile"),
            HealthCard(details: [
              ProfileDetailRow(title: "Age", value: "21"),
              ProfileDetailRow(title: "Weight", value: "56 kg"),
              ProfileDetailRow(title: "Height", value: "5'6\""),
              ProfileDetailRow(title: "Blood Group", value: "O+"),
            ]),

            SizedBox(height: 20),

            // Menstrual Cycle Information
            SectionTitle(title: "Menstrual Cycle Information"),
            HealthCard(details: [
              ProfileDetailRow(title: "Cycle Length", value: "28 days"),
              ProfileDetailRow(title: "Regularity", value: "Regular"),
              ProfileDetailRow(title: "Pain Level", value: "Moderate"),
            ]),

            SizedBox(height: 20),

            // Medications Section
            SectionTitle(title: "Medications"),
            MedicationItem(
                name: "Ibuprofen",
                amount: "250 mg",
                dose: "Twice a day during Cycles"),
            MedicationItem(
                name: "Vitamin D", amount: "1000 IU", dose: "Once a week"),

            SizedBox(height: 20),
            // Family Medical History Section
            SectionTitle(title: "Family Medical History"),
            HealthCard(details: [
              ProfileDetailRow(title: "Mother", value: "Thyroid"),
              ProfileDetailRow(title: "Father", value: "Diabetes"),
              ProfileDetailRow(title: "Grandmother", value: "Osteoporosis"),
            ]),

            SizedBox(height: 20),

            // My Documents Section
            SectionTitle(title: "My Documents"),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: ListTile(
                title: Text("View Reports & Prescriptions"),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () {
                  // Navigate to reports page
                },
              ),
            ),
            SizedBox(height: 10),

            // Upload PDFs Section
            ElevatedButton.icon(
              onPressed: uploadPDF,
              icon: Icon(Icons.upload_file),
              label: Text("Upload PDF"),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                padding: EdgeInsets.symmetric(vertical: 12),
              ),
            ),
            if (selectedFile != null)
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: Text("Uploaded: ${selectedFile!.path.split('/').last}",
                    style: TextStyle(color: Colors.green)),
              ),
          ],
        ),
      ),
      // Bottom Navigation Bar
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 6.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(icon: Icon(Icons.article), onPressed: () {}),
            IconButton(icon: Icon(Icons.local_hospital), onPressed: () {}),
            SizedBox(width: 40), // Space for floating action button
            IconButton(icon: Icon(Icons.chat), onPressed: () {}),
            IconButton(icon: Icon(Icons.shopping_cart), onPressed: () {}),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add_circle, size: 32, color: Colors.white),
        backgroundColor: Colors.pink.shade300,
        shape: CircleBorder(),
        elevation: 5,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

// Reusable Widget for Section Titles
class SectionTitle extends StatelessWidget {
  final String title;
  SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    );
  }
}

// Reusable Widget for Health Profile & Family Medical History
class HealthCard extends StatelessWidget {
  final List<Widget> details;
  HealthCard({required this.details});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(children: details),
      ),
    );
  }
}

// Widget for Profile Detail Rows
class ProfileDetailRow extends StatelessWidget {
  final String title;
  final String value;
  ProfileDetailRow({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          Text(value, style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}

class MedicationItem extends StatelessWidget {
  final String name;
  final String amount;
  final String dose;

  MedicationItem({
    required this.name,
    required this.amount,
    required this.dose,
  });

  void showMedicationDetails(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("💊 **Dosage:** $amount"),
              SizedBox(height: 8),
              Text(
                  "🩺 **Prescription Reason:** Used to relieve pain and inflammation."),
              SizedBox(height: 8),
              Text("📋 **Usage Instructions:** $dose"),
              SizedBox(height: 8),
              Text(
                "📖 **General Info:** $name is commonly used to treat mild to moderate pain, reduce inflammation, and manage various conditions such as headaches, muscle pain, and menstrual cramps.",
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Close", style: TextStyle(color: Colors.pink)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        title: Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text("$amount | $dose"),
        trailing: ElevatedButton(
          onPressed: () => showMedicationDetails(context),
          child: Text("Details", style: TextStyle(color: Colors.black)),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.pink.shade300,
          ),
        ),
      ),
    );
  }
}
