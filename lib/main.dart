import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Stepper Sample',
      home: const MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyStatefulWidget> {
  final _emailFieldKey = GlobalKey<FormBuilderFieldState>();
  int currentStep = 0;

  List<Step> getSteps() => [
        Step(
          isActive: currentStep >= 0,
          title: Text('Personal'),
          content: Column(
            children: <Widget>[
              FormBuilderTextField(
                name: 'Name',
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              const SizedBox(height: 10),
              FormBuilderTextField(
                name: 'Surname',
                decoration: const InputDecoration(labelText: 'Surname'),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
        Step(
          isActive: currentStep >= 1,
          title: Text('Contact'),
          content: Column(
            children: <Widget>[
              FormBuilderTextField(
                key: _emailFieldKey,
                name: 'email',
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              const SizedBox(height: 10),
              FormBuilderTextField(
                name: 'Address',
                decoration: const InputDecoration(labelText: 'Address'),
              ),
              const SizedBox(height: 10),
              FormBuilderTextField(
                name: 'Mobile No',
                decoration: const InputDecoration(labelText: 'Mobile No'),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
        Step(
          isActive: currentStep >= 2,
          title: Text('Upload'),
          content: Column(
            children: [
              FormBuilderTextField(
                name: 'Extra comments',
                decoration: const InputDecoration(labelText: 'Extra Comments'),
              ),
            ],
          ),
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Stepper Sample'),
        backgroundColor: Color.fromARGB(255, 26, 152, 255),
      ),
      body: Stepper(
        type: StepperType.horizontal,
        steps: getSteps(),
        currentStep: currentStep,
        onStepContinue: () {
          final isLastStep = currentStep == getSteps().length - 1;

          if (isLastStep) {
            print('completed');
          } else {
            setState(() => currentStep += 1);
          }
        },
        onStepCancel:
            currentStep == 0 ? null : () => setState(() => currentStep -= 1),
      ),
    );
  }
}
