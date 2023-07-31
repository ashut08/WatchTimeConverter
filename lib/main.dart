import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timezone/data/latest.dart' as tzs;
import 'package:timezone/timezone.dart' as tz;
import 'package:wear/wear.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // tzs.initializeTimeZones(); // Initialize timezone data
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        visualDensity: VisualDensity.compact,
        useMaterial3: true, // use material 3
        colorScheme: const ColorScheme.light(
          // dark colorscheme
          primary: Colors.white24,
          // onBackground: Colors.white10,
          // onSurface: Colors.white10,
        ), // use material 3
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: WatchShape(
          builder: (BuildContext context, WearShape shape, Widget? child) {
            return AmbientMode(
              builder: (BuildContext context, WearMode mode, Widget? child) {
                return mode == WearMode.active
                    ? const ActiveMode()
                    : const Text("Time Converter");
              },
            );
          },
          // child: AmbientMode(
          //   builder: (BuildContext context, WearMode mode, Widget? child) {
          //     return mode == WearMode.active
          //         ? const ActiveMode()
          //         : Text(
          //             'Mode: ${mode == WearMode.active ? 'Active' : 'Ambient'}',
          //           );
          //   },
          // ),
        ),
      ),
    );
  }
}

class ActiveMode extends StatefulWidget {
  const ActiveMode({super.key});

  @override
  State<ActiveMode> createState() => _ActiveModeState();
}

class _ActiveModeState extends State<ActiveMode> {
  final TextEditingController _dateTimeController = TextEditingController();

  String _selectedTimezone = 'UTC'; // Default timezone

  _onTimezoneChanged(String? newTimezone) {
    setState(() {
      _selectedTimezone = newTimezone!;
    });
    if (kDebugMode) {
      print(
        'Converted Time: ${tz.TZDateTime.now(tz.getLocation(_selectedTimezone)).toString()}',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    tzs.initializeTimeZones();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        centerTitle: true,
        title: const Text(
          'Time Zone Converter',
          style: TextStyle(fontSize: 10),
        ),
      ),
      body: Theme(
        data: ThemeData(
            textTheme: const TextTheme(bodyLarge: TextStyle(fontSize: 10))),
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextField(
                  controller: _dateTimeController,
                  // decoration:
                  //     const InputDecoration(labelText: 'Enter Date and Time'),
                  keyboardType: TextInputType.datetime,
                  onTap: () async {
                    // Show date and time picker when the text field is tapped
                    // DateTime? pickedDateTime = await showDatePicker(
                    //   context: context,
                    //   initialDate: DateTime.now(),
                    //   initialEntryMode: DatePickerEntryMode.inputOnly,
                    //   firstDate: DateTime.now(),
                    //   lastDate: DateTime.now().add(const Duration(days: 356)),
                    //   builder: (context, child) {
                    //     return Column(
                    //       children: <Widget>[
                    //         SizedBox(
                    //           height: 300,
                    //           // width: 300,
                    //           child: child,
                    //         ),
                    //       ],
                    //     );
                    //   },
                    // );
                    DateTime? pickedDateTime = DateTime.now();
                    // ignore: use_build_context_synchronously
                    TimeOfDay? pickedTime = await showTimePicker(
                      initialEntryMode: TimePickerEntryMode.inputOnly,
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    if (pickedTime != null) {
                      DateTime combinedDateTime = DateTime(
                        pickedDateTime.year,
                        pickedDateTime.month,
                        pickedDateTime.day,
                        pickedTime.hour,
                        pickedTime.minute,
                      );
                      setState(() {
                        _dateTimeController.text =
                            DateFormat('yyyy-MM-dd HH:mm')
                                .format(combinedDateTime);
                      });
                    }
                  },
                ),
                DropdownButton<String>(
                  style: const TextStyle(fontSize: 10, color: Colors.black),
                  value: _selectedTimezone,
                  onChanged: _onTimezoneChanged,
                  items:
                      tz.timeZoneDatabase.locations.keys.map((String timezone) {
                    return DropdownMenuItem<String>(
                      value: timezone,
                      child: Text(timezone),
                    );
                  }).toList(),
                ),
                if (_dateTimeController.text != "" ||
                    _dateTimeController.text.isNotEmpty)
                  Text(
                    'Converted Time: ${tz.TZDateTime.from(DateTime.parse(_dateTimeController.text), tz.getLocation(_selectedTimezone)).toString()}',
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
