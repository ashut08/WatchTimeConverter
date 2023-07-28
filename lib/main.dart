import 'package:flutter/material.dart';
import 'package:wear/wear.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        visualDensity: VisualDensity.compact,
        useMaterial3: true, // use material 3
        // colorScheme: const ColorScheme.dark(
        //   // dark colorscheme
        //   primary: Colors.white24,
        //   onBackground: Colors.white10,
        //   onSurface: Colors.white10,
        // ),
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _dateTimeController = TextEditingController();
  final String _selectedTimeZone = 'UTC'; // Default to UTC
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      body: Center(
        child: WatchShape(
          builder: (BuildContext context, WearShape shape, Widget? child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Shape: ${shape == WearShape.round ? 'round' : 'square'}',
                ),
                child!,
              ],
            );
          },
          child: AmbientMode(
            builder: (BuildContext context, WearMode mode, Widget? child) {
              return Text(
                'Mode: ${mode == WearMode.active ? 'Active' : 'Ambient'}',
              );
            },
          ),
        ),
      ),
    );

    // widget(
    //   child: Scaffold(
    //     appBar: AppBar(
    //       title: const Text('Time Zone Converter'),
    //     ),
    //     body: Padding(
    //       padding: const EdgeInsets.all(16.0),
    //       child: Column(
    //         crossAxisAlignment: CrossAxisAlignment.stretch,
    //         children: [
    //           TextField(
    //             controller: _dateTimeController,
    //             decoration:
    //                 const InputDecoration(labelText: 'Enter Date and Time'),
    //             keyboardType: TextInputType.datetime,
    //             onTap: () async {
    //               // Show date and time picker when the text field is tapped
    //               DateTime? pickedDateTime = await showDatePicker(
    //                 context: context,
    //                 initialDate: DateTime.now(),
    //                 firstDate: DateTime(2000),
    //                 lastDate: DateTime(2100),
    //               );
    //               if (pickedDateTime != null) {
    //                 // ignore: use_build_context_synchronously
    //                 TimeOfDay? pickedTime = await showTimePicker(
    //                   context: context,
    //                   initialTime: TimeOfDay.now(),
    //                 );
    //                 if (pickedTime != null) {
    //                   DateTime combinedDateTime = DateTime(
    //                     pickedDateTime.year,
    //                     pickedDateTime.month,
    //                     pickedDateTime.day,
    //                     pickedTime.hour,
    //                     pickedTime.minute,
    //                   );
    //                   setState(() {
    //                     _dateTimeController.text =
    //                         DateFormat('yyyy-MM-dd HH:mm')
    //                             .format(combinedDateTime);
    //                   });
    //                 }
    //               }
    //             },
    //           ),
    //           const SizedBox(height: 20),
    //           DropdownButton<String>(
    //             value: _selectedTimeZone,
    //             items: <String>[
    //               'UTC',
    //               'America/New_York',
    //               'Europe/London',
    //               'Asia/Tokyo',
    //               // Add more time zones here if needed
    //             ].map((String timeZone) {
    //               return DropdownMenuItem<String>(
    //                 value: timeZone,
    //                 child: Text(timeZone),
    //               );
    //             }).toList(),
    //             onChanged: (String? newValue) {
    //               setState(() {
    //                 _selectedTimeZone = newValue!;
    //               });
    //             },
    //           ),
    //           const SizedBox(height: 20),
    //           ElevatedButton(
    //             onPressed: () {
    //               // Convert time to the selected time zone
    //               if (_dateTimeController.text.isNotEmpty) {
    //                 DateTime inputDateTime = DateFormat('yyyy-MM-dd HH:mm')
    //                     .parse(_dateTimeController.text);
    //                 DateTime convertedDateTime = inputDateTime
    //                     .toLocal()
    //                     .toUtc()
    //                     .add(
    //                       Duration(
    //                         hours: DateTime.parse(_selectedTimeZone).hour,
    //                         minutes: DateTime.parse(_selectedTimeZone).minute,
    //                       ),
    //                     );
    //                 String formattedConvertedTime =
    //                     DateFormat('yyyy-MM-dd HH:mm')
    //                         .format(convertedDateTime);
    //                 if (kDebugMode) {
    //                   print(formattedConvertedTime);
    //                 }
    //               }
    //             },
    //             child: const Text('Convert Time'),
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }
}
