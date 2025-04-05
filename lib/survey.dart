import 'package:flutter/material.dart';

class InputFormPage extends StatefulWidget {
  const InputFormPage({Key? key}) : super(key: key);

  @override
  _InputFormPageState createState() => _InputFormPageState();
}

class _InputFormPageState extends State<InputFormPage> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for numerical inputs
  TextEditingController ageController = TextEditingController();
  TextEditingController bmiController = TextEditingController();
  TextEditingController painController = TextEditingController();
  TextEditingController lifestyleController = TextEditingController();
  TextEditingController likelihoodController = TextEditingController();

  // Dropdown / toggle selections
  bool hasRegularCycles = true;
  bool hasHirsutism = false;
  int acneSeverity = 0;
  bool familyHistoryPCOS = false;
  bool insulinResistance = false;
  bool hormoneAbnormal = false;
  bool experiencedInfertility = false;
  int stressLevel = 0;
  bool isUrban = true;
  int socioeconomicStatus = 1;
  bool awareOfPCOS = false;
  bool fertilityConcerns = false;

  // Converts bools and selects to doubles
  int boolToInt(bool b) => b ? 1 : 0;

  void handleSubmit() {
    try {
      final List<double> inputs = [
        double.parse(ageController.text), // 1. Age
        double.parse(bmiController.text), // 2. BMI
        boolToInt(hasRegularCycles).toDouble(), // 3
        boolToInt(hasHirsutism).toDouble(), // 4
        acneSeverity.toDouble(), // 5
        boolToInt(familyHistoryPCOS).toDouble(), // 6
        boolToInt(insulinResistance).toDouble(), // 7
        double.parse(painController.text), // 8
        boolToInt(hormoneAbnormal).toDouble(), // 9
        boolToInt(experiencedInfertility).toDouble(), // 10
        double.parse(lifestyleController.text), // 11
        stressLevel.toDouble(), // 12
        boolToInt(isUrban).toDouble(), // 13
        socioeconomicStatus.toDouble(), // 14
        boolToInt(awareOfPCOS).toDouble(), // 15
        boolToInt(fertilityConcerns).toDouble(), // 16
        double.parse(likelihoodController.text), // 17
      ];

      print('Sending: $inputs'); // ⬅️ Replace with API/Firebase logic
    } catch (e) {
      print('Error parsing inputs: $e');
    }
  }

  Widget buildSwitch(String label, bool value, void Function(bool) onChanged) {
    return SwitchListTile(
      title: Text(label),
      value: value,
      onChanged: onChanged,
      activeColor: Color.fromARGB(255, 250, 90, 143),
    );
  }

  Widget buildDropdown<T>(
      String label, T current, List<T> options, void Function(T?) onChanged) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label),
        DropdownButton<T>(
          value: current,
          items: options.map((e) {
            return DropdownMenuItem<T>(
              value: e,
              child: Text(e.toString()),
            );
          }).toList(),
          onChanged: onChanged,
        )
      ],
    );
  }

  Widget buildNumberField(String label, TextEditingController controller,
      {String hint = ''}) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: const OutlineInputBorder(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hera Risk Predictor'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              buildNumberField("1. Age (in years)", ageController),
              buildNumberField("2. BMI (e.g. 22.5)", bmiController),
              buildSwitch("3. Regular menstrual cycles?", hasRegularCycles,
                  (v) => setState(() => hasRegularCycles = v)),
              buildSwitch("4. Hirsutism (excess hair)?", hasHirsutism,
                  (v) => setState(() => hasHirsutism = v)),
              buildDropdown<int>(
                "5. Acne Severity",
                acneSeverity,
                [0, 1, 2, 3],
                (val) => setState(() => acneSeverity = val ?? 0),
              ),
              buildSwitch("6. Family history of PCOS?", familyHistoryPCOS,
                  (v) => setState(() => familyHistoryPCOS = v)),
              buildSwitch("7. Insulin resistance diagnosed?", insulinResistance,
                  (v) => setState(() => insulinResistance = v)),
              buildNumberField("8. Pelvic pain level (0–10)", painController),
              buildSwitch("9. Hormone abnormality?", hormoneAbnormal,
                  (v) => setState(() => hormoneAbnormal = v)),
              buildSwitch(
                  "10. Experienced infertility?",
                  experiencedInfertility,
                  (v) => setState(() => experiencedInfertility = v)),
              buildNumberField(
                  "11. Lifestyle score (0–1)", lifestyleController),
              buildDropdown<int>(
                "12. Stress level",
                stressLevel,
                [0, 1, 2],
                (val) => setState(() => stressLevel = val ?? 0),
              ),
              buildSwitch("13. Urban area?", isUrban,
                  (v) => setState(() => isUrban = v)),
              buildDropdown<int>(
                "14. Socioeconomic status",
                socioeconomicStatus,
                [0, 1, 2],
                (val) => setState(() => socioeconomicStatus = val ?? 1),
              ),
              buildSwitch("15. Aware of PCOS?", awareOfPCOS,
                  (v) => setState(() => awareOfPCOS = v)),
              buildSwitch("16. Fertility concerns?", fertilityConcerns,
                  (v) => setState(() => fertilityConcerns = v)),
              buildNumberField("17. Undiagnosed PCOS likelihood (0–1)",
                  likelihoodController),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: handleSubmit,
                child:
                    const Text("Submit", style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
