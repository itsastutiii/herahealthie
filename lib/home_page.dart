import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:herahealthie/bogs.dart';
import 'package:herahealthie/chatbot_ui.dart';
import 'package:herahealthie/profile.dart';
import 'package:herahealthie/shop.dart';
import 'package:herahealthie/survey.dart';
import 'package:table_calendar/table_calendar.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  // 🔴 Define past period dates (Replace with actual data)
  List<DateTime> pastPeriods = [
    DateTime(2025, 3, 1),
    DateTime(2025, 3, 2),
    DateTime(2025, 3, 3),
    DateTime(2025, 2, 3),
    DateTime(2025, 2, 4),
    DateTime(2025, 2, 28),
    DateTime(2025, 2, 1),
    DateTime(2025, 2, 2),
  ];

  // 🔮 Predict next periods (Assuming a 28-day cycle)
  List<DateTime> getPredictedPeriodRange() {
    List<DateTime> predictedPeriodDates = [];
    if (pastPeriods.isNotEmpty) {
      DateTime lastPeriod = pastPeriods.first; // Latest past period
      int cycleLength = 28; // Default cycle length (customizable)
      int periodLength = 5; // Assume 5-day period

      for (int i = 1; i <= 4; i++) {
        // Predict for 4 cycles
        DateTime start = lastPeriod.add(Duration(days: i * cycleLength));

        for (int j = 0; j < periodLength; j++) {
          predictedPeriodDates.add(start.add(Duration(days: j)));
        }
      }
    }
    return predictedPeriodDates;
  }

  @override
  Widget build(BuildContext context) {
    List<DateTime> predictedPeriods = getPredictedPeriodRange();
    DateTime today = DateTime.now();

    // Find the next predicted period date
    DateTime? nextPeriod = predictedPeriods.firstWhere(
      (date) => date.isAfter(today),
      orElse: () => DateTime(0), // Default value if no future periods found
    );

    // Calculate days left until the next period
    int daysLeft =
        nextPeriod.year != 0 ? nextPeriod.difference(today).inDays : -1;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start, // Moves text to right
          children: [
            Text(
              '    Good Afternoon, Hera', // Change dynamically later
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.person, color: Colors.black),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ProfilePage()));
            },
          ),
        ],
      ),

      body: Column(
        children: [
          // 🔴 Display Days Left Message
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              daysLeft >= 0
                  ? "$daysLeft days left until your next period"
                  : "No upcoming periods predicted",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.pink),
            ),
          ),
          // 📅 Calendar Widget
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TableCalendar(
              firstDay: DateTime(2023, 1, 1),
              lastDay: DateTime(2030, 12, 31),
              focusedDay: _focusedDay,
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              calendarFormat: _calendarFormat,
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              },
              onPageChanged: (focusedDay) {
                _focusedDay = focusedDay;
              },
              headerStyle: HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
              ),
              calendarStyle: CalendarStyle(
                todayDecoration: BoxDecoration(
                  color: Colors.pink.shade300,
                  shape: BoxShape.circle,
                ),
                selectedDecoration: BoxDecoration(
                  color: Colors.pink,
                  shape: BoxShape.circle,
                ),
                markersMaxCount: 1,
              ),
              calendarBuilders: CalendarBuilders(
                // 🔴 Highlight past period dates (DARK PINK)
                defaultBuilder: (context, date, _) {
                  if (pastPeriods.any((d) => isSameDay(d, date))) {
                    return Center(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.pink,
                          shape: BoxShape.circle,
                        ),
                        width: 35,
                        height: 35,
                        alignment: Alignment.center,
                        child: Text(
                          '${date.day}',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    );
                  }

                  // 🔮 Highlight predicted periods (LIGHT PINK)
                  if (predictedPeriods.any((d) => isSameDay(d, date))) {
                    return Center(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.pink.shade100,
                          shape: BoxShape.circle,
                        ),
                        width: 35,
                        height: 35,
                        alignment: Alignment.center,
                        child: Text(
                          '${date.day}',
                          style: TextStyle(color: Colors.black87),
                        ),
                      ),
                    );
                  }
                  return null;
                },
              ),
            ),
          ),

          // 📊 Health Risk Indicator
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Health Risk Analysis',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: LinearProgressIndicator(
                        value: 0.83,
                        backgroundColor: Colors.grey.shade300,
                        color: Colors.pink,
                        minHeight: 10,
                      ),
                    ),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('84%',
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold)),
                        Text('Leaning Endometriosis',
                            style: TextStyle(fontSize: 14)),
                      ],
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => InputFormPage()),
                        );
                      },
                      child: Text('Re-Take Quiz'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pink,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),

      // 🔽 Bottom Navigation Bar
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 6.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              //blogs
              icon: Icon(Icons.article),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BlogsPage()),
                );
              },
            ),

            //medical appointment
            IconButton(icon: Icon(Icons.local_hospital), onPressed: () {}),
            SizedBox(width: 40), // Space for the floating action button

            //chatbot
            IconButton(
              icon: Icon(Icons.chat),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChatbotPage()),
                );
              },
            ),

            //shop
            IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ShopPage()),
                );
              },
            ),
          ],
        ),
      ),

      //log
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return LogPopupDialog();
            },
          );
        },
        child: Icon(Icons.add_circle,
            size: 32, color: Colors.white), // Icon color white for contrast
        backgroundColor:
            const Color.fromARGB(255, 232, 62, 118), // Lighter pink shade
        shape: CircleBorder(), // Ensures it's perfectly circular
        elevation: 5, // Slight shadow effect
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class LogPopupDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Theme(
        data: Theme.of(context).copyWith(
          colorScheme: Theme.of(context).colorScheme.copyWith(
                surface: Colors.white, // Ensures dialog base is white
                surfaceTint: Colors.transparent, // Removes M3 tinting
              ),
        ),
        child: AlertDialog(
          backgroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Text(
            "Create Log",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.pink.shade600,
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildLogOption(
                  context,
                  icon: Icons.bloodtype_rounded,
                  label: 'Period Started',
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                _buildLogOption(
                  context,
                  icon: Icons.bloodtype_outlined,
                  label: 'Period Ended',
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                _buildLogOption(
                  context,
                  icon: Icons.height,
                  label: 'Add Height/Weight',
                  onTap: () {
                    Navigator.pop(context);
                    showDialog(
                      context: context,
                      builder: (_) => HeightWeightDialog(),
                    );
                  },
                ),
                _buildLogOption(
                  context,
                  icon: Icons.medication,
                  label: 'Add Medication',
                  onTap: () {
                    Navigator.pop(context);
                    showDialog(
                      context: context,
                      builder: (_) => MedicationLogDialog(),
                    );
                  },
                ),
                _buildLogOption(
                  context,
                  icon: Icons.mood,
                  label: 'Mood',
                  onTap: () {
                    Navigator.pop(context);
                    showDialog(
                      context: context,
                      builder: (_) => MoodLogDialog(),
                    );
                  },
                ),
                _buildLogOption(
                  context,
                  icon: Icons.sick,
                  label: 'Symptom',
                  onTap: () {
                    Navigator.pop(context);
                    showDialog(
                      context: context,
                      builder: (_) => SymptomLogDialog(),
                    );
                  },
                ),
              ],
            ),
          ),
        ));
  }

  Widget _buildLogOption(BuildContext context,
      {required IconData icon,
      required String label,
      required VoidCallback onTap}) {
    return ListTile(
      leading: Icon(icon, color: Colors.pink.shade400),
      title: Text(
        label,
        style: TextStyle(
          color: Colors.black87,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      // shape: RoundedRectangleBorder(
      //   borderRadius: BorderRadius.circular(12),
      // ),
      tileColor: Colors.white, //Color.fromARGB(255, 247, 218, 228),
      onTap: onTap,
      contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
    );
  }
}

class HeightWeightDialog extends StatefulWidget {
  @override
  _HeightWeightDialogState createState() => _HeightWeightDialogState();
}

class _HeightWeightDialogState extends State<HeightWeightDialog> {
  final TextEditingController feetController = TextEditingController();
  final TextEditingController inchController = TextEditingController();
  final TextEditingController weightController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: Theme.of(context).copyWith(
          colorScheme: Theme.of(context).colorScheme.copyWith(
                surface: Colors.white, // Ensures dialog base is white
                surfaceTint: Colors.transparent, // Removes M3 tinting
              ),
        ),
        child: AlertDialog(
          backgroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Text(
            "Enter Height & Weight",
            style: TextStyle(
              color: Colors.pink.shade600,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Height",
                style: TextStyle(
                  color: Colors.pink.shade800,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: feetController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: InputDecoration(
                        labelText: "Feet",
                        labelStyle: TextStyle(color: Colors.pink),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.pink),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.pink.shade100),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      controller: inchController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: InputDecoration(
                        labelText: "Inches",
                        labelStyle: TextStyle(color: Colors.pink),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.pink),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.pink.shade100),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Text(
                "Weight (kg)",
                style: TextStyle(
                  color: Colors.pink.shade800,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 8),
              TextField(
                controller: weightController,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: InputDecoration(
                  labelText: "Kilograms",
                  labelStyle: TextStyle(color: Colors.pink),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.pink),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.pink.shade100),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text("Cancel", style: TextStyle(color: Colors.grey)),
              onPressed: () => Navigator.pop(context),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pink.shade400,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                final heightFeet = feetController.text;
                final heightInch = inchController.text;
                final weight = weightController.text;
                print(
                    "Height: ${heightFeet}ft ${heightInch}in | Weight: ${weight}kg");
                Navigator.pop(context);
              },
              child: Text("Save", style: TextStyle(color: Colors.white)),
            ),
          ],
        ));
  }
}

class MedicationLogDialog extends StatefulWidget {
  @override
  _MedicationLogDialogState createState() => _MedicationLogDialogState();
}

class _MedicationLogDialogState extends State<MedicationLogDialog> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dosageController = TextEditingController();
  TimeOfDay? _selectedTime;

  void _pickTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.pink.shade400, // clock face, buttons
              onPrimary: Colors.white, // text on primary color
              onSurface: Colors.pink.shade800, // hour/minute numbers
            ),
            timePickerTheme: TimePickerThemeData(
              dialHandColor: Colors.pink.shade400,
              dialBackgroundColor: Colors.pink.shade50,
              entryModeIconColor: Colors.pink.shade300,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  void _saveMedication() {
    Navigator.of(context).pop({
      'name': _nameController.text,
      'dosage': _dosageController.text,
      'time': _selectedTime?.format(context),
    });
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: Theme.of(context).copyWith(
          colorScheme: Theme.of(context).colorScheme.copyWith(
                surface: Colors.white, // Ensures dialog base is white
                surfaceTint: Colors.transparent, // Removes M3 tinting
              ),
        ),
        child: AlertDialog(
          backgroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Text(
            "Log Medication",
            style: TextStyle(
              color: Colors.pink.shade600,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildTextField(_nameController, 'Medicine Name'),
              SizedBox(height: 12),
              _buildTextField(_dosageController, 'Dosage (e.g., 500mg)'),
              SizedBox(height: 18),
              TextButton.icon(
                onPressed: _pickTime,
                icon: Icon(Icons.access_time, color: Colors.pink.shade400),
                label: Text(
                  _selectedTime == null
                      ? 'Select Time'
                      : _selectedTime!.format(context),
                  style: TextStyle(
                    color: Colors.pink.shade600,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child:
                  Text('Cancel', style: TextStyle(color: Colors.pink.shade400)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pink.shade300,
              ),
              onPressed: _saveMedication,
              child: Text('Save', style: TextStyle(color: Colors.white)),
            ),
          ],
        ));
  }

  Widget _buildTextField(TextEditingController controller, String label) {
    return TextField(
      controller: controller,
      cursorColor: Colors.pink.shade400,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.pink.shade700),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.pink.shade200),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.pink.shade400),
          borderRadius: BorderRadius.circular(12),
        ),
        fillColor: Colors.white,
        filled: true,
      ),
    );
  }
}

class MoodLogDialog extends StatefulWidget {
  @override
  _MoodLogDialogState createState() => _MoodLogDialogState();
}

class _MoodLogDialogState extends State<MoodLogDialog> {
  final List<Map<String, dynamic>> moods = [
    {'emoji': '😊', 'label': 'Happy'},
    {'emoji': '😔', 'label': 'Sad'},
    {'emoji': '😤', 'label': 'Frustrated'},
    {'emoji': '😭', 'label': 'Depressed'},
    {'emoji': '😡', 'label': 'Angry'},
    {'emoji': '🤩', 'label': 'Excited'},
    {'emoji': '😴', 'label': 'Tired'},
    {'emoji': '😰', 'label': 'Anxious'},
    {'emoji': '😌', 'label': 'Calm'},
  ];

  final Set<String> selectedMoods = {};

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: Theme.of(context).copyWith(
          colorScheme: Theme.of(context).colorScheme.copyWith(
                surface: Colors.white, // Ensures dialog base is white
                surfaceTint: Colors.transparent, // Removes M3 tinting
              ),
        ),
        child: AlertDialog(
          backgroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Text(
            "Log Mood",
            style: TextStyle(
              color: Colors.pink.shade600,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: SingleChildScrollView(
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: moods.map((mood) {
                final label = mood['label'];
                final isSelected = selectedMoods.contains(label);

                return ChoiceChip(
                  label: Text(
                    "${mood['emoji']} $label",
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.pink.shade600,
                    ),
                  ),
                  selected: isSelected,
                  backgroundColor: Colors.pink.shade50,
                  selectedColor: Color.fromARGB(255, 246, 70, 129),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(color: Colors.pink.shade200),
                  ),
                  onSelected: (selected) {
                    setState(() {
                      if (selected) {
                        selectedMoods.add(label);
                      } else {
                        selectedMoods.remove(label);
                      }
                    });
                  },
                );
              }).toList(),
            ),
          ),
          actions: [
            TextButton(
              child: Text("Cancel", style: TextStyle(color: Colors.grey)),
              onPressed: () => Navigator.pop(context),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pink.shade400,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                print("Selected moods: $selectedMoods");
                Navigator.pop(context);
              },
              child: Text("Save", style: TextStyle(color: Colors.white)),
            ),
          ],
        ));
  }
}

class SymptomLogDialog extends StatefulWidget {
  @override
  _SymptomLogDialogState createState() => _SymptomLogDialogState();
}

class _SymptomLogDialogState extends State<SymptomLogDialog> {
  final Map<String, List<String>> symptomCategories = {
    'Physical': [
      'Pelvic Cramps',
      'Breast Pain',
      'Fever',
      'Nausea',
      'Discharge',
      'Headache',
      'Fatigue',
    ],
    'Mental': [
      'Brain Fog',
      'Irritability',
      'Low Mood',
      'Anxiety',
      'Lack of Focus',
      'Insomnia',
    ],
    'Digestive': [
      'Bloating',
      'Constipation',
      'Diarrhea',
      'Acid Reflux',
      'Loss of Appetite',
    ],
    'Other': [
      'Skin Changes',
      'Hair Fall',
      'Joint Pain',
      'Dizziness',
    ],
  };

  final Map<String, Set<String>> selectedSymptoms = {};

  void _toggleSymptom(String category, String symptom) {
    setState(() {
      selectedSymptoms.putIfAbsent(category, () => <String>{});
      if (selectedSymptoms[category]!.contains(symptom)) {
        selectedSymptoms[category]!.remove(symptom);
      } else {
        selectedSymptoms[category]!.add(symptom);
      }
    });
  }

  void _saveSymptoms() {
    Navigator.of(context).pop(selectedSymptoms);
  }

  @override
  Widget build(BuildContext context) {
    // return Theme(
    //   data: Theme.of(context).copyWith(
    //     dialogBackgroundColor: Colors.white,
    //     colorScheme: Theme.of(context).colorScheme.copyWith(
    //           surface: Colors.white,
    //           primary: Colors.pink.shade600,
    //           secondary: Colors.pink.shade200,
    //         ),
    //   ),
    return Theme(
      data: Theme.of(context).copyWith(
        colorScheme: Theme.of(context).colorScheme.copyWith(
              surface: Colors.white, // Ensures dialog base is white
              surfaceTint: Colors.transparent, // Removes M3 tinting
            ),
      ),
      child: AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          "Log Symptoms",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.pink.shade600,
          ),
        ),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: symptomCategories.entries.map((entry) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    entry.key,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.pink.shade400,
                    ),
                  ),
                  Wrap(
                    spacing: 10,
                    children: entry.value.map((symptom) {
                      final selected =
                          selectedSymptoms[entry.key]?.contains(symptom) ??
                              false;
                      return FilterChip(
                        label: Text(symptom),
                        selected: selected,
                        selectedColor: Colors.pink.shade100,
                        backgroundColor: Colors.pink.shade50,
                        checkmarkColor: Colors.pink.shade800,
                        labelStyle: TextStyle(
                          color:
                              selected ? Colors.pink.shade800 : Colors.black87,
                        ),
                        onSelected: (_) => _toggleSymptom(entry.key, symptom),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 10),
                ],
              );
            }).toList(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: _saveSymptoms,
            child: Text(
              'Save',
              style: TextStyle(color: Colors.pink.shade600),
            ),
          ),
        ],
      ),
    );
  }
}
