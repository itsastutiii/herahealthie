import 'package:flutter/material.dart';
import 'package:herahealthie/bogs.dart';
import 'package:herahealthie/profile.dart';
import 'package:herahealthie/shop.dart';
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
                      onPressed: () {},
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
              icon: Icon(Icons.article),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BlogsPage()),
                );
              },
            ),
            IconButton(icon: Icon(Icons.local_hospital), onPressed: () {}),
            SizedBox(width: 40), // Space for the floating action button
            IconButton(icon: Icon(Icons.chat), onPressed: () {}),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
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
