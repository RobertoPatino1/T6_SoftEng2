import 'dart:math';
import 'dart:nativewrappers/_internal/vm/lib/internal_patch.dart';

import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:share_your_route_front/core/utils/stepper/route_step1.dart';
import 'package:share_your_route_front/core/utils/stepper/route_step2.dart';
import 'package:share_your_route_front/core/utils/stepper/route_step3.dart';
import 'package:share_your_route_front/core/utils/stepper/route_step4.dart';
import 'package:share_your_route_front/modules/home/home_page/presenters/home_page.dart';

class CreateRoute extends StatefulWidget {
  const CreateRoute({super.key});

  @override
  State<CreateRoute> createState() => _CreateRouteState();
}

class _CreateRouteState extends State<CreateRoute> {
  int _currentStep = 0;
  String routeName = '';
  int numberOfPeople = 2;
  int numberOfGuides = 1;
  double rangeAlert = 2;
  bool showPlaceInfo = false;
  String alertSound = 'Sonido 1';
  bool publicRoute = false;
  LatLng? meetingPoint;
  List<Map<String, dynamic>> stops = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          textAlign: TextAlign.left,
          style: TextStyle(
            fontSize: 25.0,
            color: Color.fromRGBO(45, 75, 115, 1),
            fontWeight: FontWeight.bold,
            height: 1,
          ),
          "Crear una nueva ruta",
        ),
      ),
      body: Theme(
        data: ThemeData(
          colorScheme: const ColorScheme.light(
            primary: Color.fromRGBO(191, 141, 48, 1),
          ),
        ),
        child: Stepper(
          currentStep: _currentStep,
          onStepContinue: () {
            setState(() {
              if (_currentStep < 3) {
                _currentStep++;
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Ruta creada')),
                );
                Future.delayed(const Duration(seconds: 1), () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const HomePage()),
                  );
                });
              }
            });
          },
          onStepCancel: () {
            setState(() {
              if (_currentStep > 0) {
                _currentStep--;
              }
            });
          },
          controlsBuilder: (BuildContext context, ControlsDetails details) {
            final isLastStep = _currentStep == 3;
            final isFirstStep = _currentStep == 0;
            return Padding(
              padding: const EdgeInsets.only(
                top: 16.0,
              ), // Añade espacio arriba de los botones
              child: Row(
                children: <Widget>[
                  ElevatedButton(
                    onPressed: details.onStepContinue,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(45, 75, 115, 1),
                    ),
                    child: Text(
                      isLastStep ? 'Crear ruta' : 'Siguiente',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10), // Añade espacio entre los botones
                  if (!isFirstStep)
                    ElevatedButton(
                      onPressed: details.onStepCancel,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(45, 75, 115, 1),
                      ),
                      child: const Text(
                        'Atrás',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                ],
              ),
            );
          },
          steps: [
            Step(
              title: const Text(
                'Información Inicial',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),
              content: RouteStep1(
                routeName: routeName,
                numberOfPeople: numberOfPeople,
                numberOfGuides: numberOfGuides,
                rangeAlert: rangeAlert,
                showPlaceInfo: showPlaceInfo,
                alertSound: alertSound,
                publicRoute: publicRoute,
                onRouteNameChanged: (value) => setState(() {
                  routeName = value;
                }),
                onNumberOfPeopleChanged: (value) => setState(() {
                  numberOfPeople = value;
                  printToConsole("CACACACA");
                  if (numberOfPeople < 1) {
                    printToConsole("CACACACA");
                    numberOfPeople = 1;
                  } else if (numberOfPeople > 30) {
                    numberOfPeople = 30;
                  }
                }),
                onNumberOfGuidesChanged: (value) => setState(() {
                  numberOfGuides = value;
                  if (numberOfGuides < 0) {
                    numberOfGuides = 0;
                  } else if (numberOfGuides > 5) {
                    numberOfGuides = 5;
                  }
                }),
                onRangeAlertChanged: (value) => setState(() {
                  rangeAlert = value;
                }),
                onShowPlaceInfoChanged: (value) => setState(() {
                  showPlaceInfo = value;
                }),
                onAlertSoundChanged: (value) => setState(() {
                  alertSound = value;
                }),
                onPublicRouteChanged: (value) => setState(() {
                  publicRoute = value;
                }),
              ),
              isActive: _currentStep >= 0,
            ),
            Step(
              title: const Text(
                'Agregar Paradas',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),
              content: RouteStep2(
                stops: stops,
                onStopsChanged: (value) => setState(() {
                  stops = value;
                }),
              ),
              isActive: _currentStep >= 1,
            ),
            Step(
              title: const Text(
                'Seleccionar Punto de Encuentro',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),
              content: RouteStep3(
                meetingPoint: meetingPoint,
                onMeetingPointChanged: (value) => setState(() {
                  meetingPoint = value;
                }),
              ),
              isActive: _currentStep >= 2,
            ),
            Step(
              title: const Text(
                'Confirmación',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),
              content: RouteStep4(
                routeName: routeName,
                numberOfPeople: numberOfPeople,
                numberOfGuides: numberOfGuides,
                rangeAlert: rangeAlert,
                showPlaceInfo: showPlaceInfo,
                alertSound: alertSound,
                publicRoute: publicRoute,
                meetingPoint: meetingPoint,
                onConfirm: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Ruta creada')),
                  );
                  Future.delayed(const Duration(seconds: 1), () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const HomePage()),
                    );
                  });
                },
                onCancel: () {
                  setState(() {
                    _currentStep = 0;
                  });
                },
                stops: const [],
              ),
              isActive: _currentStep >= 3,
            ),
          ],
        ),
      ),
    );
  }
}
