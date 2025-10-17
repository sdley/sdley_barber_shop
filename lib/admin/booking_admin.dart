import 'package:flutter/material.dart';
import 'package:sdley_barber_shop/services/database.dart';
import 'package:sdley_barber_shop/pages/home.dart';

class BookingAdmin extends StatefulWidget {
  const BookingAdmin({super.key});

  @override
  State<BookingAdmin> createState() => _BookingAdminState();
}

class _BookingAdminState extends State<BookingAdmin> {
  Stream? bookingsStream;

  getOnLoad() async {
    bookingsStream = await DatabaseServices().getAppointments();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getOnLoad();
  }

  Widget bookingList() {
    return StreamBuilder(
      stream: bookingsStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(child: Text("No bookings available"));
        }
        return ListView.separated(
          padding: EdgeInsets.only(bottom: 20.0, top: 0.0),
          itemCount: snapshot.data!.docs.length,
          separatorBuilder: (context, index) => SizedBox(height: 16.0),
          itemBuilder: (context, index) {
            var booking = snapshot.data!.docs[index];
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 0.0),
              child: Material(
                elevation: 8.0,
                borderRadius: BorderRadius.circular(20.0),
                child: Container(
                  padding: EdgeInsets.all(10.0),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFFb91635),
                        Color(0xFF621d3c),
                        Color(0xFF311937),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(60.0),
                            child: Image.network(
                              booking['image'],
                              height: 80.0,
                              width: 80.0,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        "Service: " + booking['service'],
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        "Name: " + booking['name'],
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        "Date: " + booking['date'],
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        "Time: " + booking['time'],
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 20.0, bottom: 10.0),
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                          onPressed: () async {
                            await DatabaseServices()
                                .deleteAppointment(booking.id)
                                .then((value) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        "Booking deleted successfully",
                                      ),
                                    ),
                                  );
                                });
                          },
                          child: Text(
                            "Mark as Completed",
                            style: TextStyle(
                              color: Color(0xFFb91635),
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 50.0, left: 20.0, right: 20.0),
        child: Column(
          children: [
            Column(
              children: [
                Center(
                  child: Text(
                    "All Bookings",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(height: 12.0),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => Home()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 12.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                    child: Text(
                      'Back to Home',
                      style: TextStyle(
                        color: Color(0xFFb91635),
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
              ],
            ),
            Expanded(child: bookingList()),
          ],
        ),
      ),
    );
  }
}
