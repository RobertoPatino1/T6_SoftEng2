import 'package:flutter/material.dart';
import 'package:share_your_route_front/core/widgets/create_route_widgets.dart';

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
  final Function(String) onRouteNameChanged;
  final Function(String) onRouteDescriptionChanged;
  final Function(DateTime) onRouteDateChanged;
  final Function(int) onNumberOfPeopleChanged;
  final Function(int) onNumberOfGuidesChanged;
  final Function(double) onRangeAlertChanged;
  final Function(bool) onShowPlaceInfoChanged;
  final Function(String) onAlertSoundChanged;
  final Function(bool) onPublicRouteChanged;

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
    required this.onRouteNameChanged,
    required this.onRouteDescriptionChanged,
    required this.onRouteDateChanged,
    required this.onNumberOfPeopleChanged,
    required this.onNumberOfGuidesChanged,
    required this.onRangeAlertChanged,
    required this.onShowPlaceInfoChanged,
    required this.onAlertSoundChanged,
    required this.onPublicRouteChanged,
  });

  @override
  _RouteStep1State createState() => _RouteStep1State();
}

class _RouteStep1State extends State<RouteStep1> {
  late double currentRangeAlert;
  late DateTime selectedDate;

  @override
  void initState() {
    super.initState();
    currentRangeAlert = widget.rangeAlert;
    selectedDate = widget.routeDate;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          buildRouteNameField(widget.routeName, widget.onRouteNameChanged),
          const SizedBox(height: 15),
          buildRouteDescriptionField(
              widget.routeDescription, widget.onRouteDescriptionChanged),
          const SizedBox(height: 15),
          buildLabeledControl(
              'Número de personas',
              buildNumberChanger(
                  widget.numberOfPeople, widget.onNumberOfPeopleChanged)),
          const SizedBox(height: 15),
          buildLabeledControl(
              'Número de guías',
              buildNumberChanger(
                  widget.numberOfGuides, widget.onNumberOfGuidesChanged)),
          const SizedBox(height: 15),
          const Text('Rango de alerta', style: titlelabelTextStyle),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: buildRangeSlider(currentRangeAlert, (value) {
                  setState(() {
                    currentRangeAlert = value;
                  });
                  widget.onRangeAlertChanged(value);
                }),
              ),
              const SizedBox(width: 8),
              Text('${currentRangeAlert.round()} m', style: labelTextStyle),
            ],
          ),
          const SizedBox(height: 15),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text(
              'Mostrar información del lugar',
              style: titlelabelTextStyle,
            ),
            value: widget.showPlaceInfo,
            onChanged: widget.onShowPlaceInfoChanged,
            activeColor: const Color.fromRGBO(191, 141, 48, 1),
          ),
          const SizedBox(height: 15),
          buildLabeledControl('Sonido de alerta',
              buildDropdown(widget.alertSound, widget.onAlertSoundChanged)),
          const SizedBox(height: 15),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text(
              'Ruta pública',
              style: titlelabelTextStyle,
            ),
            value: widget.publicRoute,
            onChanged: widget.onPublicRouteChanged,
            activeColor: const Color.fromRGBO(191, 141, 48, 1),
          ),
          const SizedBox(height: 15),
          const Text('Fecha de la ruta', style: titlelabelTextStyle),
          const SizedBox(height: 8),
          buildDatePicker(selectedDate, (date) {
            setState(() {
              selectedDate = date;
            });
            widget.onRouteDateChanged(date);
          }),
        ],
      ),
    );
  }

  Widget buildDatePicker(
      DateTime initialDate, Function(DateTime) onDateChanged) {
    return TextButton(
      onPressed: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: initialDate,
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
        );
        if (pickedDate != null) {
          onDateChanged(pickedDate);
        }
      },
      child: Text(
        '${initialDate.day}/${initialDate.month}/${initialDate.year}',
        style: const TextStyle(fontSize: 16),
      ),
    );
  }
}
