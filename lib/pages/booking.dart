import 'package:flutter/material.dart';
import 'package:sdley_barber_shop/services/database.dart';
import 'package:sdley_barber_shop/services/shared_pref.dart';

class Booking extends StatefulWidget {
  final String service;
  Booking({required this.service});

  @override
  State<Booking> createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  String? name, image, email;

  getDataFromSharedPreferences() async {
    name = await SharedPreferencesHelper.getUserName();
    image = await SharedPreferencesHelper.getUserAvatar();
    email = await SharedPreferencesHelper.getUserEmail();
    setState(() {});
  }

  getOnLoad() async {
    await getDataFromSharedPreferences();
    setState(() {
      name = name;
      image = image;
      email = email;
    });
  }

  @override
  void initState() {
    getOnLoad();
    super.initState();
  }

  DateTime _selectedDate = DateTime.now();
  int _currentYear = DateTime.now().year;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(_currentYear),
      lastDate: DateTime(_currentYear + 1),
    );
    if (picked != null && picked != _selectedDate)
      setState(() {
        _selectedDate = picked;
      });
  }

  TimeOfDay _selectedTime = TimeOfDay.now();

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2b1615),
      body: Container(
        margin: EdgeInsets.only(left: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: Colors.white,
                  size: 30.0,
                ),
              ),
            ),
            SizedBox(height: 30.0),
            Text(
              "Let's the\njourney begin!",
              style: TextStyle(
                color: Colors.white70,
                fontSize: 28.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 20.0),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Image.asset(
                "assets/images/discount.png",
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              widget.service,
              style: TextStyle(
                color: Colors.white,
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20.0),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10.0),
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
              decoration: BoxDecoration(
                color: Color(0xFFb4817e),
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: Column(
                children: [
                  Text(
                    "Choose a date",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 22.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          _selectDate(context);
                        },
                        child: Icon(
                          Icons.calendar_today,
                          color: Colors.white,
                          size: 30.0,
                        ),
                      ),
                      SizedBox(width: 20.0),
                      Text(
                        "${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.0),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10.0),
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
              decoration: BoxDecoration(
                color: Color(0xFFb4817e),
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: Column(
                children: [
                  Text(
                    "Choose a time",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 22.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          _selectTime(context);
                        },
                        child: Icon(
                          Icons.alarm,
                          color: Colors.white,
                          size: 30.0,
                        ),
                      ),
                      SizedBox(width: 20.0),
                      Text(
                        "${_selectedTime.format(context)}",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 30.0),
            GestureDetector(
              onTap: () async {
                Map<String, dynamic> appointment = {
                  "service": widget.service,
                  "date":
                      "${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}",
                  "time": _selectedTime.format(
                    context,
                  ), // Format time as a string
                  "name": name,
                  "email": email,
                  "image": image,
                };
                // Save appointment to database
                await DatabaseServices().addAppointment(appointment).then((
                  value,
                ) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Color(0xFFe29452),
                      content: Text(
                        "Your appointment has been booked successfully",
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ),
                  );
                });
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
                decoration: BoxDecoration(
                  color: Color(0xFFdf711a),
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: Center(
                  child: Text(
                    "BOOK NOW",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
