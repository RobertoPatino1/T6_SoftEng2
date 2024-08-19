import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:share_your_route_front/core/constants/route_type.dart';
import 'package:share_your_route_front/core/utils/stepper/route_step1.dart';
import 'package:share_your_route_front/core/utils/stepper/route_step2.dart';
import 'package:share_your_route_front/core/utils/stepper/route_step3.dart';
import 'package:share_your_route_front/core/utils/stepper/route_step4.dart';
import 'package:share_your_route_front/models/place.dart';
import 'package:share_your_route_front/models/tourist_route.dart';
import 'package:share_your_route_front/modules/home/home_page/presenters/home_page.dart';
import 'package:share_your_route_front/modules/shared/services/route_service.dart';
import 'package:share_your_route_front/modules/shared/ui/custom_app_bar.dart';
import 'package:share_your_route_front/modules/shared/ui/ui_utils.dart';

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
  List<RouteType> routeTypesInput =
      []; // Lista para tipos de ruta seleccionados

  late final RouteService routeService;

  void createRoute() {
    // Aquí puedes procesar los datos capturados y crear la nueva ruta
    final TouristRoute newRoute = TouristRoute(
      name: routeNameInput,
      placesList: stopsInput,
      currentPlaceIndex: 0,
      numberPeople: numberOfPeopleInput,
      numberGuides: numberOfGuidesInput,
      routeIsPublic: publicRouteInput,
      routeDate: routeDateInput,
      startingPoint: meetingPointInput!,
      startTime:
          stopsInput.isNotEmpty ? stopsInput.first.startTime : TimeOfDay.now(),
      endTime:
          stopsInput.isNotEmpty ? stopsInput.last.endTime : TimeOfDay.now(),
      image: 'no_image',
      description: routeDescriptionInput,
      hasStarted: false,
      routeType: routeTypesInput, // Usar directamente la lista de RouteType
    );

    newRoute.save();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Ruta creada")),
    );
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const HomePage()),
      );
    });
  }

  /*Future<void> createRouteData(TouristRoute newRoute) async {
    routeService = await RouteService.create();
    await routeService.createData(newRoute);
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(title: "Crear Ruta"),
      body: Theme(
        data: ThemeData(
          colorScheme: const ColorScheme.light(
            primary: Color.fromRGBO(191, 141, 48, 1),
          ),
        ),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
          child: Stepper(
            key: ValueKey<int>(_currentStep),
            currentStep: _currentStep,
            onStepContinue: () {
              setState(() {
                if (_currentStep == 0 && routeNameInput.isEmpty) {
                  showSnackbar(
                    context,
                    "Debe ingresar el nombre de la ruta",
                    "error",
                  );
                } else if (_currentStep == 1 && stopsInput.isEmpty) {
                  showSnackbar(
                    context,
                    "Debe agregar al menos una parada",
                    "error",
                  );
                } else if (_currentStep == 2 && meetingPointInput == null) {
                  showSnackbar(
                    context,
                    "Debe seleccionar un punto de encuentro",
                    "error",
                  );
                } else if (_currentStep < 3) {
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
            controlsBuilder: (BuildContext context, ControlsDetails details) {
              final isLastStep = _currentStep == 3;
              final isFirstStep = _currentStep == 0;
              return Padding(
                padding: const EdgeInsets.only(
                  top: 16.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    if (!isFirstStep)
                      Expanded(
                        child: ElevatedButton(
                          onPressed: details.onStepCancel,
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromRGBO(45, 75, 115, 1),
                          ),
                          child: const Text(
                            'Atrás',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    const SizedBox(width: 10),
                    if (isFirstStep)
                      SizedBox(
                        width: 200,
                        child: ElevatedButton(
                          onPressed: () {
                            if (routeNameInput.isNotEmpty) {
                              details.onStepContinue!();
                            } else {
                              showSnackbar(
                                context,
                                "Debe ingresar el nombre de la ruta",
                                "error",
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromRGBO(45, 75, 115, 1),
                          ),
                          child: const Text(
                            'Siguiente',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      )
                    else
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            if (_currentStep == 1 && stopsInput.isEmpty) {
                              showSnackbar(
                                context,
                                "Debe agregar al menos una parada",
                                "error",
                              );
                            } else if (_currentStep == 2 &&
                                meetingPointInput == null) {
                              showSnackbar(
                                context,
                                "Debe seleccionar un punto de encuentro",
                                "error",
                              );
                            } else {
                              details.onStepContinue!();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromRGBO(45, 75, 115, 1),
                          ),
                          child: Text(
                            isLastStep ? 'Crear ruta' : 'Siguiente',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
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
                  routeName: routeNameInput,
                  routeDescription: routeDescriptionInput,
                  routeDate: routeDateInput,
                  numberOfPeople: numberOfPeopleInput,
                  numberOfGuides: numberOfGuidesInput,
                  rangeAlert: rangeAlertInput,
                  showPlaceInfo: showPlaceInfoInput,
                  alertSound: alertSoundInput,
                  publicRoute: publicRouteInput,
                  selectedRouteTypes: routeTypesInput, // Convertir a String
                  onRouteNameChanged: (value) => setState(() {
                    routeNameInput = value;
                  }),
                  onRouteDescriptionChanged: (value) => setState(() {
                    routeDescriptionInput = value;
                  }),
                  onRouteDateChanged: (value) => setState(() {
                    routeDateInput = value;
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
                  onRouteTypesChanged: (value) => setState(() {
                    routeTypesInput = value;
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
      ),
    );
  }
}
