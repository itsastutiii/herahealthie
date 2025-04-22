import 'package:flutter/material.dart';

class ResultsPage extends StatelessWidget {
  final double pcosProbability;
  final double endoProbability;

  const ResultsPage({
    Key? key,
    required this.pcosProbability,
    required this.endoProbability,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool pcosRisk = pcosProbability > 0.5;
    bool endoRisk = endoProbability > 0.5;

    return Scaffold(
      backgroundColor: Colors.pink[50],
      appBar: AppBar(
        backgroundColor: Colors.pink[300],
        title: const Text('Your Results 💖'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            resultCard(
              title: "PCOS Probability",
              percent: pcosProbability,
              risk: pcosRisk,
              advice: pcosRisk
                  ? "Consider speaking with a gynecologist. You may be at risk for PCOS."
                  : "Low risk! Keep up with healthy lifestyle habits.",
            ),
            const SizedBox(height: 20),
            resultCard(
              title: "Endometriosis Probability",
              percent: endoProbability,
              risk: endoRisk,
              advice: endoRisk
                  ? "High risk for Endometriosis. Please consult a specialist."
                  : "You're at low risk for Endometriosis 💪",
            ),
          ],
        ),
      ),
    );
  }

  Widget resultCard({
    required String title,
    required double percent,
    required bool risk,
    required String advice,
  }) {
    return Card(
      color: Colors.white,
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text("${(percent * 100).toStringAsFixed(1)}%",
                style: TextStyle(
                    fontSize: 24,
                    color: risk ? Colors.redAccent : Colors.green,
                    fontWeight: FontWeight.w600)),
            const SizedBox(height: 12),
            Text(advice,
                style: const TextStyle(fontSize: 16, color: Colors.black87)),
          ],
        ),
      ),
    );
  }
}
