import 'package:flutter/material.dart';
import 'package:skincare_app/src/core/utils/app_assets/app_assets.dart';
import 'package:skincare_app/src/core/utils/constants/app_sizes.dart';

class FadeScaffold extends StatefulWidget {
  const FadeScaffold({super.key});

  @override
  State<FadeScaffold> createState() => _FadeScaffoldState();
}

class _FadeScaffoldState extends State<FadeScaffold> {
  String fullName = '';
  String phoneNumber = '';
  String amount = '';
  bool schedulePayments = false;
  bool saveBeneficiary = false;
  String selectedFrequency = 'Weekly';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Stack(
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: ShaderMask(
                  blendMode: BlendMode.srcIn,
                  shaderCallback: (bounds) {
                    return LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.white,
                        Colors.blue.withOpacity(0.5),
                        Colors.blue
                      ],
                    ).createShader(bounds);
                  },
                  child: Container(
                    height: 150,
                    width: screenSize(context).width,
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.5),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 0,
                bottom: 0,
                right: -70,
                child: Opacity(
                  opacity: 0.3,
                  child: Image.asset(
                    AppAssets.church,
                    height: 200,
                    width: 200,
                  ),
                ),
              ),
              //Form Widget starts here
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 15,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Balance ₦240,000.85',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Saved Beneficiaries',
                      style: TextStyle(fontSize: 16, color: Colors.blue),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      decoration: const InputDecoration(labelText: 'Full Name'),
                      onChanged: (value) {
                        setState(() {
                          fullName = value;
                        });
                      },
                    ),
                    TextField(
                      decoration: const InputDecoration(labelText: 'Phone Number'),
                      keyboardType: TextInputType.phone,
                      onChanged: (value) {
                        setState(() {
                          phoneNumber = value;
                        });
                      },
                    ),
                    TextField(
                      decoration:
                          const InputDecoration(labelText: 'Amount (Minimum ₦100)'),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        setState(() {
                          amount = value;
                        });
                      },
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      'Additional fees ₦100',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Checkbox(
                          value: schedulePayments,
                          onChanged: (value) {
                            setState(() {
                              schedulePayments = value!;
                            });
                          },
                        ),
                        const Text('Schedule Payments'),
                      ],
                    ),
                    if (schedulePayments)
                      DropdownButton<String>(
                        value: selectedFrequency,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedFrequency = newValue!;
                          });
                        },
                        items: <String>['Weekly', 'Monthly', 'Yearly']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    Row(
                      children: [
                        Checkbox(
                          value: saveBeneficiary,
                          onChanged: (value) {
                            setState(() {
                              saveBeneficiary = value!;
                            });
                          },
                        ),
                        const Text('Save Beneficiary'),
                      ],
                    ),
                    const Spacer(),
                    Center(
                      child: ElevatedButton(
                        style: const ButtonStyle(),
                        onPressed: () {
                          // Implement the verification logic here
                        },
                        child: const Text('Verify'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
