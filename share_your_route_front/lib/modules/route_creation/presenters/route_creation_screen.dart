import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:share_your_route_front/core/constants/colors.dart';
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
  List<RouteType> routeTypesInput = [];

  late final RouteService routeService;

  void createRoute() {
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
      routeType: routeTypesInput,
    );

    newRoute.save();
    showSnackbar(context, "Ruta creada exitosamente!", "confirmation");
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.push(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(builder: (_) => const HomePage()),
      );
    });
  }

  Future<void> createRouteData(TouristRoute newRoute) async {
    routeService = await RouteService.create();
    await routeService.createData(newRoute);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: const CustomAppBar(title: "Crear Ruta"),
      body: AnimatedSwitcher(
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
                    context, "Debe ingresar el nombre de la ruta", "error");
              } else if (_currentStep == 1 && stopsInput.isEmpty) {
                showSnackbar(
                    context, "Debe agregar al menos una parada", "error");
              } else if (_currentStep == 2 && meetingPointInput == null) {
                showSnackbar(
                    context, "Debe seleccionar un punto de encuentro", "error");
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
              padding: const EdgeInsets.only(top: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  if (!isFirstStep)
                    Expanded(
                      child: ElevatedButton(
                        onPressed: details.onStepCancel,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: theme.colorScheme.primary,
                        ),
                        child: Text(
                          'Atrás',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onPrimary,
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
                            showSnackbar(context,
                                "Debe ingresar el nombre de la ruta", "error");
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: theme.colorScheme.primary,
                        ),
                        child: Text(
                          'Siguiente',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onPrimary,
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
                            showSnackbar(context,
                                "Debe agregar al menos una parada", "error");
                          } else if (_currentStep == 2 &&
                              meetingPointInput == null) {
                            showSnackbar(
                                context,
                                "Debe seleccionar un punto de encuentro",
                                "error");
                          } else {
                            details.onStepContinue!();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: theme.colorScheme.primary,
                        ),
                        child: Text(
                          isLastStep ? 'Crear ruta' : 'Siguiente',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onPrimary,
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
              title: Text(
                'Información Inicial',
                style: theme.textTheme.headlineSmall?.copyWith(
                  color: yellowAccentColor,
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
                selectedRouteTypes: routeTypesInput,
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
              state: _currentStep == 0
                  ? StepState.editing
                  : StepState
                      .indexed, // Cambia el estado para reflejar el paso activo
            ),
            Step(
              title: Text(
                'Agregar Paradas',
                style: theme.textTheme.headlineSmall?.copyWith(
                  color: yellowAccentColor,
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
              state: _currentStep == 1
                  ? StepState.editing
                  : StepState
                      .indexed, // Cambia el estado para reflejar el paso activo
            ),
            Step(
              title: Text(
                'Seleccionar Punto de Encuentro',
                style: theme.textTheme.headlineSmall?.copyWith(
                  color: yellowAccentColor,
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
              state: _currentStep == 2
                  ? StepState.editing
                  : StepState
                      .indexed, // Cambia el estado para reflejar el paso activo
            ),
            Step(
              title: Text(
                'Confirmación',
                style: theme.textTheme.headlineSmall?.copyWith(
                  color: yellowAccentColor,
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
              state: _currentStep == 3
                  ? StepState.editing
                  : StepState
                      .indexed, // Cambia el estado para reflejar el paso activo
            ),
          ],
        ),
      ),
    );
  }
}
