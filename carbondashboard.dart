import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:pedometer/pedometer.dart';
import 'vehicle_emission_form.dart'; // Your form for logging vehicle emissions

class CarbonDashboard extends StatefulWidget {
  const CarbonDashboard({super.key});

  @override
  State<CarbonDashboard> createState() => _CarbonDashboardState();
}

class _CarbonDashboardState extends State<CarbonDashboard> {
  String selectedRange = 'Day';
  int? touchedIndex;
  String stepCountValue = "0";

  final List<String> monthNames = [
    "Jan", "Feb", "Mar", "Apr", "May", "Jun",
    "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
  ];

  // All emissions start at 0
  Map<String, List<Map<String, dynamic>>> carbonDataSets = {
    "Day": [
      {"label": "Transportation", "value": 0.0, "color": Colors.blue},
      {"label": "Home Energy", "value": 0.0, "color": Colors.orange},
      {"label": "Food and Diet", "value": 0.0, "color": Colors.red},
      {"label": "Shopping", "value": 0.0, "color": Colors.purple},
      {"label": "Other", "value": 0.0, "color": Colors.green},
    ],
    "Week": [
      {"label": "Transportation", "value": 0.0, "color": Colors.blue},
      {"label": "Home Energy", "value": 0.0, "color": Colors.orange},
      {"label": "Food and Diet", "value": 0.0, "color": Colors.red},
      {"label": "Shopping", "value": 0.0, "color": Colors.purple},
      {"label": "Other", "value": 0.0, "color": Colors.green},
    ],
    "Month": [
      {"label": "Transportation", "value": 0.0, "color": Colors.blue},
      {"label": "Home Energy", "value": 0.0, "color": Colors.orange},
      {"label": "Food and Diet", "value": 0.0, "color": Colors.red},
      {"label": "Shopping", "value": 0.0, "color": Colors.purple},
      {"label": "Other", "value": 0.0, "color": Colors.green},
    ],
    "Year": [
      {"label": "Transportation", "value": 0.0, "color": Colors.blue},
      {"label": "Home Energy", "value": 0.0, "color": Colors.orange},
      {"label": "Food and Diet", "value": 0.0, "color": Colors.red},
      {"label": "Shopping", "value": 0.0, "color": Colors.purple},
      {"label": "Other", "value": 0.0, "color": Colors.green},
    ],
  };

  final List<double> monthlyData = List.generate(12, (_) => 0.0); // All months start at 0

  @override
  void initState() {
    super.initState();
    _initPedometer();
  }

  void _initPedometer() {
    Pedometer.stepCountStream.listen(
      (StepCount event) {
        setState(() {
          stepCountValue = event.steps.toString();
        });
      },
      onError: (error) {
        setState(() {
          stepCountValue = "Error";
        });
      },
    );
  }

  void _navigateToVehicleForm() {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => VehicleEmissionForm(
        onValueChanged: (value) {
          // live update transportation emission
          setState(() {
            for (var range in carbonDataSets.keys) {
              carbonDataSets[range]![0]['value'] = value;
            }
            monthlyData[DateTime.now().month - 1] = value;
          });
        },
      ),
    ),
  );
}

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> currentData = carbonDataSets[selectedRange]!;
    final double total = currentData.fold(0, (sum, e) => sum + e['value']);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Carbon Footprint Overview"),
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _navigateToVehicleForm,
            tooltip: "Log Vehicle Activity",
          ),
          const SizedBox(width: 8),
          _buildBadge(Icons.directions_walk, stepCountValue),
          const SizedBox(width: 8),
          _buildBadge(Icons.eco, "0"),
          const SizedBox(width: 8),
          _buildBadge(Icons.public, "0"),
          const SizedBox(width: 8),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Time range buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: ['Day', 'Week', 'Month', 'Year'].map((range) {
                  return OutlinedButton(
                    onPressed: () {
                      setState(() {
                        selectedRange = range;
                        touchedIndex = null;
                      });
                    },
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(
                        color: selectedRange == range ? Colors.green : Colors.grey,
                      ),
                    ),
                    child: Text(range),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
              Text(
                "Total Carbon Emission: ${total.toStringAsFixed(1)} kg",
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              // Pie Chart
              AspectRatio(
                aspectRatio: 1.2,
                child: PieChart(
                  PieChartData(
                    sectionsSpace: 2,
                    centerSpaceRadius: 40,
                    pieTouchData: PieTouchData(
                      touchCallback: (event, response) {
                        setState(() {
                          if (!event.isInterestedForInteractions ||
                              response == null ||
                              response.touchedSection == null) {
                            touchedIndex = null;
                            return;
                          }
                          touchedIndex = response.touchedSection!.touchedSectionIndex;
                        });
                      },
                    ),
                    sections: List.generate(currentData.length, (index) {
                      final item = currentData[index];
                      final double percent = total == 0 ? 0 : (item['value'] / total) * 100;
                      final isTouched = index == touchedIndex;
                      final opacity = touchedIndex == null || isTouched ? 1.0 : 0.3;

                      return PieChartSectionData(
                        value: item['value'],
                        color: item['color'].withOpacity(opacity),
                        radius: isTouched ? 80 : 65,
                        title: "${item['label']} \n${percent.toStringAsFixed(1)}%",
                        titleStyle: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      );
                    }),
                  ),
                ),
              ),

              const SizedBox(height: 30),
              Text(
                "Monthly Carbon Trend",
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),

              // Line Chart
              AspectRatio(
                aspectRatio: 1.7,
                child: LineChart(
                  LineChartData(
                    lineTouchData: LineTouchData(
                      touchTooltipData: LineTouchTooltipData(
                        tooltipBgColor: Colors.green.shade100,
                        getTooltipItems: (touchedSpots) {
                          return touchedSpots.map((spot) {
                            final month = monthNames[spot.x.toInt()];
                            return LineTooltipItem(
                              '$month\n${spot.y} kg',
                              const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          }).toList();
                        },
                      ),
                    ),
                    gridData: FlGridData(show: true),
                    titlesData: FlTitlesData(
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          interval: 1,
                          getTitlesWidget: (value, _) {
                            return Text(
                              monthNames[value.toInt()].substring(0, 3),
                              style: const TextStyle(fontSize: 10),
                            );
                          },
                        ),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 40,
                          interval: 100,
                          getTitlesWidget: (value, _) {
                            return Text(
                              "${value.toInt()} kg",
                              style: const TextStyle(fontSize: 10),
                            );
                          },
                        ),
                      ),
                      topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    ),
                    borderData: FlBorderData(show: true),
                    minX: 0,
                    maxX: 11,
                    minY: 0,
                    maxY: 600,
                    lineBarsData: [
                      LineChartBarData(
                        isCurved: true,
                        color: const Color.fromARGB(255, 24, 107, 27),
                        barWidth: 3,
                        dotData: FlDotData(show: true),
                        belowBarData: BarAreaData(show: false),
                        spots: List.generate(monthlyData.length, (index) {
                          return FlSpot(index.toDouble(), monthlyData[index]);
                        }),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBadge(IconData icon, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color.fromARGB(255, 51, 134, 94), width: 2),
      ),
      child: Row(
        children: [
          Icon(icon, color: const Color.fromARGB(255, 30, 110, 71), size: 18),
          const SizedBox(width: 4),
          Text(value, style: const TextStyle(color: Colors.white, fontSize: 16)),
        ],
      ),
    );
  }
}
