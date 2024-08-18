import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
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
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Resumen de la Ruta', style: theme.textTheme.headlineSmall),
        Divider(color: theme.colorScheme.secondary),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Nombre de la Ruta: ',
                style: theme.textTheme.bodyMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text: routeName,
                style: theme.textTheme.bodyMedium,
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Descripción de la Ruta: ',
                style: theme.textTheme.bodyMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text: routeDescription,
                style: theme.textTheme.bodyMedium,
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Fecha de la Ruta: ',
                style: theme.textTheme.bodyMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text: DateFormat.yMd().format(routeDate),
                style: theme.textTheme.bodyMedium,
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Número de Personas: ',
                style: theme.textTheme.bodyMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text: '$numberOfPeople',
                style: theme.textTheme.bodyMedium,
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Número de Guías: ',
                style: theme.textTheme.bodyMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text: '$numberOfGuides',
                style: theme.textTheme.bodyMedium,
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Rango de Alerta: ',
                style: theme.textTheme.bodyMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text: '${rangeAlert.round()}',
                style: theme.textTheme.bodyMedium,
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Mostrar Información del Lugar: ',
                style: theme.textTheme.bodyMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text: showPlaceInfo ? 'Sí' : 'No',
                style: theme.textTheme.bodyMedium,
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Sonido de Alerta: ',
                style: theme.textTheme.bodyMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text: alertSound,
                style: theme.textTheme.bodyMedium,
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Ruta Pública: ',
                style: theme.textTheme.bodyMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text: publicRoute ? 'Sí' : 'No',
                style: theme.textTheme.bodyMedium,
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Punto de Encuentro: ',
                style: theme.textTheme.bodyMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text: meetingPoint != null
                    ? '${meetingPoint!.latitude}, ${meetingPoint!.longitude}'
                    : 'No seleccionado',
                style: theme.textTheme.bodyMedium,
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Paradas: ',
                style: theme.textTheme.bodyMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text: stops.isEmpty ? 'No se han seleccionado paradas' : '',
                style: theme.textTheme.bodyMedium,
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
              final stopStartTime = stop.startTime;
              final stopEndTime = stop.endTime;
              return RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Parada ${index + 1}: ',
                      style: theme.textTheme.bodyMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text:
                          '$stopName  Inicio:${stopStartTime.format(context)}  Fin:${stopEndTime.format(context)}',
                      style: theme.textTheme.bodyMedium,
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
