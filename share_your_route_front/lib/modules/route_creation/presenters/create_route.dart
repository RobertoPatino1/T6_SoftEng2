import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:share_your_route_front/core/constants/route_type.dart';
import 'package:share_your_route_front/core/utils/jsonConverters/tourist_route_json_converter.dart';
import 'package:share_your_route_front/core/utils/stepper/route_step1.dart';
import 'package:share_your_route_front/core/utils/stepper/route_step2.dart';
import 'package:share_your_route_front/core/utils/stepper/route_step3.dart';
import 'package:share_your_route_front/core/utils/stepper/route_step4.dart';
import 'package:share_your_route_front/models/place.dart';
import 'package:share_your_route_front/models/tourist_route.dart';
import 'package:share_your_route_front/modules/home/home_page/presenters/home_page.dart';

class CreateRoute extends StatefulWidget {
  const CreateRoute({super.key});

  @override
  State<CreateRoute> createState() => _CreateRouteState();
}

class _CreateRouteState extends State<CreateRoute> {
  int _currentStep = 0;
  String routeNameInput = '';
  String routeDescriptionInput = '';
  DateTime routeDateInput = DateTime.now();
  int numberOfPeopleInput = 2;
  int numberOfGuidesInput = 1;
  double rangeAlertInput = 2;
  bool showPlaceInfoInput = false;
  String alertSoundInput = 'Sonido 1';
  bool publicRouteInput = false;
  LatLng? meetingPointInput;
  List<Place> stopsInput = [];

  void createRoute() {
    // Aquí puedes procesar los datos capturados y crear la nueva ruta
    TouristRoute newRoute = TouristRoute(
      name: routeNameInput,
      description: routeDescriptionInput,
      routeDate: routeDateInput,
      routeType: [RouteType.city],
      startTime: stopsInput.first.startTime,
      endTime: stopsInput.last.endTime,
      hasStarted: false,
      image: 'no_image',
      startingPoint: meetingPointInput!,
      currentPlaceIndex: 0,
      placesList: stopsInput,
    );

    if (publicRouteInput == true) {
      addPublicRoute(newRoute);
    } else {
      addPrivateRoute(newRoute);
    }

    print('Nueva ruta creada: $newRoute');
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Crear una nueva ruta",
          textAlign: TextAlign.left,
          style: TextStyle(
            fontSize: 25.0,
            color: Color.fromRGBO(45, 75, 115, 1),
            fontWeight: FontWeight.bold,
            height: 1,
          ),
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
                createRoute();
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
                routeName: routeNameInput,
                routeDescription: routeDescriptionInput,
                routeDate: routeDateInput,
                numberOfPeople: numberOfPeopleInput,
                numberOfGuides: numberOfGuidesInput,
                rangeAlert: rangeAlertInput,
                showPlaceInfo: showPlaceInfoInput,
                alertSound: alertSoundInput,
                publicRoute: publicRouteInput,
                onRouteNameChanged: (value) => setState(() {
                  routeNameInput = value;
                }),
                onRouteDescriptionChanged: (value) => setState(() {
                  routeDescriptionInput = value;
                }),
                onRouteDateChanged: (date) => setState(() {
                  routeDateInput = date;
                }),
                onNumberOfPeopleChanged: (value) => setState(() {
                  numberOfPeopleInput = value;
                  if (numberOfPeopleInput < 1) {
                    numberOfPeopleInput = 1;
                  } else if (numberOfPeopleInput > 30) {
                    numberOfPeopleInput = 30;
                  }
                }),
                onNumberOfGuidesChanged: (value) => setState(() {
                  numberOfGuidesInput = value;
                  if (numberOfGuidesInput < 0) {
                    numberOfGuidesInput = 0;
                  } else if (numberOfGuidesInput > 5) {
                    numberOfGuidesInput = 5;
                  }
                }),
                onRangeAlertChanged: (value) => setState(() {
                  rangeAlertInput = value;
                }),
                onShowPlaceInfoChanged: (value) => setState(() {
                  showPlaceInfoInput = value;
                }),
                onAlertSoundChanged: (value) => setState(() {
                  alertSoundInput = value;
                }),
                onPublicRouteChanged: (value) => setState(() {
                  publicRouteInput = value;
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
                stops: stopsInput,
                onStopsChanged: (value) => setState(() {
                  stopsInput = value;
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
                meetingPoint: meetingPointInput,
                onMeetingPointChanged: (value) => setState(() {
                  meetingPointInput = value;
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
                routeName: routeNameInput,
                routeDescription: routeDescriptionInput,
                routeDate: routeDateInput,
                numberOfPeople: numberOfPeopleInput,
                numberOfGuides: numberOfGuidesInput,
                rangeAlert: rangeAlertInput,
                showPlaceInfo: showPlaceInfoInput,
                alertSound: alertSoundInput,
                publicRoute: publicRouteInput,
                meetingPoint: meetingPointInput,
                stops: stopsInput,
                onConfirm: createRoute,
                onCancel: () {
                  setState(() {
                    _currentStep = 0;
                  });
                },
              ),
              isActive: _currentStep >= 3,
            ),
          ],
        ),
      ),
    );
  }
}
