import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:share_your_route_front/core/widgets/create_route_widgets.dart';
import 'package:share_your_route_front/models/place.dart';

class RouteStep4 extends StatelessWidget {
  final String routeName;
  final String routeDescription;
  final DateTime routeDate;
  final int numberOfPeople;
  final int numberOfGuides;
  final double rangeAlert;
  final bool showPlaceInfo;
  final String alertSound;
  final bool publicRoute;
  final LatLng? meetingPoint;
  final VoidCallback onConfirm;
  final VoidCallback onCancel;
  final List<Place> stops;

  const RouteStep4({
    super.key,
    required this.routeName,
    required this.numberOfPeople,
    required this.numberOfGuides,
    required this.rangeAlert,
    required this.showPlaceInfo,
    required this.alertSound,
    required this.publicRoute,
    required this.meetingPoint,
    required this.onConfirm,
    required this.onCancel,
    required this.stops,
    required this.routeDescription,
    required this.routeDate,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Resumen de la Ruta', style: titlelabelTextStyle),
        const Divider(),
        RichText(
          text: TextSpan(
            children: [
              const TextSpan(
                text: 'Nombre de la Ruta: ',
                style: boldlabelTextStyle,
              ),
              TextSpan(
                text: routeName,
                style: labelTextStyle,
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        RichText(
          text: TextSpan(
            children: [
              const TextSpan(
                text: 'Descripción de la Ruta: ',
                style: boldlabelTextStyle,
              ),
              TextSpan(
                text: routeDescription,
                style: labelTextStyle,
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        RichText(
          text: TextSpan(
            children: [
              const TextSpan(
                text: 'Fecha de la Ruta: ',
                style: boldlabelTextStyle,
              ),
              TextSpan(
                text: DateFormat.yMd().format(routeDate),
                style: labelTextStyle,
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        RichText(
          text: TextSpan(
            children: [
              const TextSpan(
                text: 'Número de Personas: ',
                style: boldlabelTextStyle,
              ),
              TextSpan(
                text: '$numberOfPeople',
                style: labelTextStyle,
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        RichText(
          text: TextSpan(
            children: [
              const TextSpan(
                text: 'Número de Guías: ',
                style: boldlabelTextStyle,
              ),
              TextSpan(
                text: '$numberOfGuides',
                style: labelTextStyle,
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        RichText(
          text: TextSpan(
            children: [
              const TextSpan(
                text: 'Rango de Alerta: ',
                style: boldlabelTextStyle,
              ),
              TextSpan(
                text: '${rangeAlert.round()}',
                style: labelTextStyle,
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        RichText(
          text: TextSpan(
            children: [
              const TextSpan(
                text: 'Mostrar Información del Lugar: ',
                style: boldlabelTextStyle,
              ),
              TextSpan(
                text: showPlaceInfo ? 'Sí' : 'No',
                style: labelTextStyle,
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        RichText(
          text: TextSpan(
            children: [
              const TextSpan(
                text: 'Sonido de Alerta: ',
                style: boldlabelTextStyle,
              ),
              TextSpan(
                text: alertSound,
                style: labelTextStyle,
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        RichText(
          text: TextSpan(
            children: [
              const TextSpan(
                text: 'Ruta Pública: ',
                style: boldlabelTextStyle,
              ),
              TextSpan(
                text: publicRoute ? 'Sí' : 'No',
                style: labelTextStyle,
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        RichText(
          text: TextSpan(
            children: [
              const TextSpan(
                text: 'Punto de Encuentro: ',
                style: boldlabelTextStyle,
              ),
              TextSpan(
                text: meetingPoint != null
                    ? '${meetingPoint!.latitude}, ${meetingPoint!.longitude}'
                    : 'No seleccionado',
                style: labelTextStyle,
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        RichText(
          text: TextSpan(
            children: [
              const TextSpan(
                text: 'Paradas: ',
                style: boldlabelTextStyle,
              ),
              TextSpan(
                text: stops.isEmpty ? 'No se han seleccionado paradas' : '',
                style: labelTextStyle,
              ),
            ],
          ),
        ),
        const Divider(),
        if (stops.isNotEmpty)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(stops.length, (index) {
              final stop = stops[index];
              final stopName = stop.name;
              final stopStartTime = stop.startTime as TimeOfDay;
              final stopEndTime = stop.endTime as TimeOfDay;
              return RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Parada ${index + 1}: ',
                      style: boldlabelTextStyle,
                    ),
                    TextSpan(
                      text:
                          '$stopName  Inicio:${stopStartTime.format(context)}  Fin:${stopEndTime.format(context)}',
                      style: labelTextStyle,
                    ),
                  ],
                ),
              );
            }),
          ),
        const SizedBox(height: 20),
      ],
    );
  }
}
