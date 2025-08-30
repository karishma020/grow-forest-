import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class VehicleEmissionForm extends StatefulWidget {
  final Function(double) onValueChanged; // Callback for live updates

  const VehicleEmissionForm({super.key, required this.onValueChanged});

  @override
  State<VehicleEmissionForm> createState() => _VehicleEmissionFormState();
}

class _VehicleEmissionFormState extends State<VehicleEmissionForm> {
  final _formKey = GlobalKey<FormState>();

  String? selectedVehicle;
  String? selectedFuel;

  File? odometerImage;

  // Vehicle types with allowed fuels & their efficiencies
  final Map<String, Map<String, String>> vehicleFuelOptions = {
    'Passenger Cars (4-wheelers)': {
      'Petrol': '16-18 km/l',
      'Diesel': '20-22 km/l',
      'CNG': '25-27 km/kg',
      'Hybrid': '22-25 km/l',
    },
    'Two-Wheelers (2-wheelers)': {
      'Petrol': '55-65 km/l',
    },
  };

  // Emission factors (standardized units)
  final Map<String, String> emissionFactors = {
    'Petrol': '2.31 kg CO₂ / liter',
    'Diesel': '2.68 kg CO₂ / liter',
    'CNG': '2.74 kg CO₂ / kg',
    'Hybrid': '≈2.0–2.3 kg CO₂ / liter (depends on fuel)',
    'Electricity': '0.82 kg CO₂ / kWh',
  };

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        odometerImage = File(pickedFile.path);
      });

      // TODO: Replace with actual OCR reading later
      double emissionValue = 5.0; // Simulated emission value
      widget.onValueChanged(emissionValue);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Available fuels for the selected vehicle type
    Map<String, String> fuelOptions =
        selectedVehicle != null ? vehicleFuelOptions[selectedVehicle!]! : {};

    return Scaffold(
      appBar: AppBar(title: const Text("Vehicle Emission Form")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Vehicle type dropdown
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(labelText: "Vehicle Type"),
                  value: selectedVehicle,
                  items: vehicleFuelOptions.keys
                      .map((vehicle) => DropdownMenuItem(
                            value: vehicle,
                            child: Text(vehicle),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedVehicle = value;
                      selectedFuel = null;
                    });
                  },
                  validator: (value) =>
                      value == null ? 'Please select vehicle type' : null,
                ),
                const SizedBox(height: 16),

                // Fuel type dropdown
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(labelText: "Fuel Type"),
                  value: selectedFuel,
                  items: fuelOptions.keys
                      .map((fuel) => DropdownMenuItem(
                            value: fuel,
                            child: Text(
                                '$fuel (${fuelOptions[fuel]})'), // show efficiency
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedFuel = value;
                    });
                  },
                  validator: (value) =>
                      value == null ? 'Please select fuel type' : null,
                ),
                const SizedBox(height: 16),

                // Emission factor display (readonly)
                if (selectedFuel != null)
                  ListTile(
                    title: const Text("Emission Factor"),
                    subtitle: Text(emissionFactors[selectedFuel!] ??
                        "Not available for this fuel"),
                  ),
                const SizedBox(height: 16),

                // Image picker
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: _pickImage,
                      child: const Text("Upload Odometer Image 1"),
                    ),
                    const SizedBox(width: 16),
                    odometerImage != null
                        ? Image.file(
                            odometerImage!,
                            width: 100,
                            height: 100,
                          )
                        : const Text("No image selected"),
                  ],
                ),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: _pickImage,
                      child: const Text("Upload Odometer Image 2"),
                    ),
                    const SizedBox(width: 16),
                    odometerImage != null
                        ? Image.file(
                            odometerImage!,
                            width: 100,
                            height: 100,
                          )
                        : const Text("No image selected"),
                  ],
                ),
                const SizedBox(height: 30),

                // Submit button
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Form submitted!')),
                      );
                      Navigator.pop(context);
                    }
                  },
                  child: const Text("Submit"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
