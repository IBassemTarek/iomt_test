// @dart=2.9
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class IoMTScreen extends StatefulWidget {
  const IoMTScreen({Key key}) : super(key: key);

  @override
  _IoMTScreenState createState() => _IoMTScreenState();
}

class _IoMTScreenState extends State<IoMTScreen> {
  bool value = false;
  final dbRef = FirebaseDatabase.instance;
  onUpdate() {
    setState(() {
      value = !value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder(
            stream: dbRef.reference().onValue,
            builder: (context, snapshot) {
              if (snapshot.hasData &&
                  !snapshot.hasError &&
                  snapshot.connectionState == ConnectionState.active &&
                  snapshot.data != null) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Icon(Icons.clear_all),
                          Text(
                            'Patient Data',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Icon(Icons.settings)
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Column(
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Temperature',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Celecus',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        // ignore: prefer_const_constructors
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          // ignore: prefer_const_constructors
                          child: Text(
                            snapshot.data.snapshot.value["Temp"].toString() +
                                " °C",
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Fehrenhite',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        // ignore: prefer_const_constructors
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          // ignore: prefer_const_constructors
                          child: Text(
                            snapshot.data.snapshot.value["farh"].toString() +
                                " °F",
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Column(
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Text(
                            'Bool Control',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        // ignore: prefer_const_constructors
                        FloatingActionButton.extended(
                          onPressed: () {
                            onUpdate();
                            onWrite();
                          },
                          label: Text(value ? "ON" : "OFF"),
                          elevation: 20,
                          icon: value
                              ? const Icon(Icons.visibility)
                              : const Icon(Icons.visibility_off),
                          backgroundColor: value ? Colors.green : Colors.white,
                        )
                      ],
                    ),
                  ],
                );
              } else {
                return Container();
              }
            }),
      ),
    );
  }

  onWrite() {
    dbRef.reference().child('SwitchState').set(value);
  }
}
