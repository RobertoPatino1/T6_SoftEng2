import 'package:flutter/material.dart';
import 'package:share_your_route_front/core/constants/colors.dart';
import 'package:share_your_route_front/core/constants/route_type.dart';
import 'package:share_your_route_front/core/widgets/create_route_widgets.dart';
import 'package:share_your_route_front/modules/shared/ui/ui_utils.dart';

class RouteStep1 extends StatefulWidget {
  final String routeName;
  final String routeDescription;
  final DateTime routeDate;
  final int numberOfPeople;
  final int numberOfGuides;
  final double rangeAlert;
  final bool showPlaceInfo;
  final String alertSound;
  final bool publicRoute;
  final List<RouteType> selectedRouteTypes;
  final Function(String) onRouteNameChanged;
  final Function(String) onRouteDescriptionChanged;
  final Function(DateTime) onRouteDateChanged;
  final Function(int) onNumberOfPeopleChanged;
  final Function(int) onNumberOfGuidesChanged;
  final Function(double) onRangeAlertChanged;
  final Function(bool) onShowPlaceInfoChanged;
  final Function(String) onAlertSoundChanged;
  final Function(bool) onPublicRouteChanged;
  final Function(List<RouteType>) onRouteTypesChanged;

  const RouteStep1({
    super.key,
    required this.routeName,
    required this.routeDescription,
    required this.routeDate,
    required this.numberOfPeople,
    required this.numberOfGuides,
    required this.rangeAlert,
    required this.showPlaceInfo,
    required this.alertSound,
    required this.publicRoute,
    required this.selectedRouteTypes,
    required this.onRouteNameChanged,
    required this.onRouteDescriptionChanged,
    required this.onRouteDateChanged,
    required this.onNumberOfPeopleChanged,
    required this.onNumberOfGuidesChanged,
    required this.onRangeAlertChanged,
    required this.onShowPlaceInfoChanged,
    required this.onAlertSoundChanged,
    required this.onPublicRouteChanged,
    required this.onRouteTypesChanged,
  });

  @override
  _RouteStep1State createState() => _RouteStep1State();
}

class _RouteStep1State extends State<RouteStep1> {
  late double currentRangeAlert;
  late DateTime selectedDate;

  final List<RouteType> routeTypes = RouteType.values;

  @override
  void initState() {
    super.initState();
    currentRangeAlert = widget.rangeAlert;
    selectedDate = widget.routeDate;
  }

  void _handleNumberOfPeopleChange(int value) {
    if (value < 1) {
      showSnackbar(
        context,
        'Se alcanzó el número mínimo de personas',
        "warning",
      );
      widget.onNumberOfPeopleChanged(1);
    } else if (value > 30) {
      showSnackbar(
        context,
        'Se alcanzó el número máximo de personas',
        "warning",
      );
      widget.onNumberOfPeopleChanged(30);
    } else {
      widget.onNumberOfPeopleChanged(value);
    }
  }

  void _handleNumberOfGuidesChange(int value) {
    if (value < 1) {
      showSnackbar(
        context,
        'Esta ruta no tendrá guías asignados',
        "information",
      );
      widget.onNumberOfGuidesChanged(0);
    } else if (value > 5) {
      showSnackbar(context, 'Se alcanzó el número máximo de guías', "warning");
      widget.onNumberOfGuidesChanged(5);
    } else {
      widget.onNumberOfGuidesChanged(value);
    }
  }

  void _handleRouteTypeChanged(RouteType type, bool isSelected) {
    setState(() {
      if (isSelected) {
        widget.selectedRouteTypes.add(type);
      } else {
        widget.selectedRouteTypes.remove(type);
      }
      widget.onRouteTypesChanged(widget.selectedRouteTypes);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          buildRouteNameField(
            context,
            widget.routeName,
            widget.onRouteNameChanged,
          ),
          const SizedBox(height: 15),
          buildRouteDescriptionField(
            context,
            widget.routeDescription,
            widget.onRouteDescriptionChanged,
          ),
          const SizedBox(height: 15),
          buildLabeledControl(
            context,
            'Cantidad de personas',
            buildNumberChanger(
              context,
              widget.numberOfPeople,
              _handleNumberOfPeopleChange,
            ),
          ),
          buildLabeledControl(
            context,
            'Número de guías',
            buildNumberChanger(
              context,
              widget.numberOfGuides,
              _handleNumberOfGuidesChange,
            ),
          ),
          const SizedBox(height: 15),
          Text('Rango de alerta', style: theme.textTheme.headlineSmall),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: buildRangeSlider(context, currentRangeAlert, (value) {
                  setState(() {
                    currentRangeAlert = value;
                  });
                  widget.onRangeAlertChanged(value);
                }),
              ),
              const SizedBox(width: 8),
              Text(
                '${currentRangeAlert.round()} m',
                style: theme.textTheme.bodyLarge,
              ),
            ],
          ),
          const SizedBox(height: 15),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(
              'Mostrar información del lugar',
              style: theme.textTheme.headlineSmall,
            ),
            value: widget.showPlaceInfo,
            onChanged: widget.onShowPlaceInfoChanged,
            activeColor: yellowAccentColor,
          ),
          const SizedBox(height: 15),
          buildLabeledControl(
            context,
            'Sonido de alerta',
            buildDropdown(
              context,
              widget.alertSound,
              widget.onAlertSoundChanged,
            ),
          ),
          const SizedBox(height: 15),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(
              'Ruta pública',
              style: theme.textTheme.headlineSmall,
            ),
            value: widget.publicRoute,
            onChanged: widget.onPublicRouteChanged,
            activeColor: yellowAccentColor,
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Fecha de la ruta', style: theme.textTheme.headlineSmall),
              buildDatePicker(context, selectedDate, (date) {
                setState(() {
                  selectedDate = date;
                });
                widget.onRouteDateChanged(date);
              }),
            ],
          ),
          const SizedBox(height: 15),
          Text('Tipo de ruta', style: theme.textTheme.headlineSmall),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8.0,
            runSpacing: 4.0,
            children: routeTypes.map((type) {
              return ChoiceChip(
                label: Text(
                  type.toString().split('.').last,
                  style: theme.textTheme.bodyMedium,
                ),
                selected: widget.selectedRouteTypes.contains(type),
                onSelected: (selected) {
                  _handleRouteTypeChanged(type, selected);
                },
                selectedColor: theme.colorScheme.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget buildDatePicker(
    BuildContext context,
    DateTime initialDate,
    Function(DateTime) onDateChanged,
  ) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: yellowAccentColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(15.0),
        border: Border.all(
          color: yellowAccentColor,
          width: 1.5,
        ),
      ),
      child: TextButton(
        onPressed: () async {
          final DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: initialDate,
            firstDate: DateTime(2000),
            lastDate: DateTime(2100),
          );
          if (pickedDate != null) {
            onDateChanged(pickedDate);
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(
              vertical: 8.0, horizontal: 12.0), // Reduce el padding
          child: Text(
            '${initialDate.day}/${initialDate.month}/${initialDate.year}',
            style: theme.textTheme.bodyMedium?.copyWith(
              fontSize: 14.0, // Reduce el tamaño de la fuente
            ),
          ),
        ),
      ),
    );
  }
}
