import 'package:flutter/material.dart';
import '../pages/appo_form.dart';

class ServiceCenterPage extends StatelessWidget {
  final List<Map<String, String>> serviceCenters = [
    {
      'Name': 'City Bike Service',
      'Address': '123 Main St, Springfield',
      'Phone': '123-456-7890',
      'Image': 'assets/image/shop1.png', 
    },
    {
      'Name': 'Speedy Repairs',
      'Address': '456 Elm St, Springfield',
      'Phone': '987-654-3210',
      'Image': 'assets/image/shop2.png', 
    },
    {
      'Name': 'Ultimate Bike Care',
      'Address': '789 Oak St, Springfield',
      'Phone': '555-123-4567',
      'Image': 'assets/image/shop3.png', 
    },
    {
      'Name': 'Radhe Repairs',
      'Address': '456 rlm St, Sprihvdhfield',
      'Phone': '987-6548-3210',
      'Image': 'assets/image/shop2.png', 
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Service Centers'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: serviceCenters.length,
          itemBuilder: (context, index) {
            final center = serviceCenters[index];
            return Card(
              elevation: 4,
              margin: EdgeInsets.symmetric(vertical: 8),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            center['Name']!,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 4),
                          Text(center['Address']!),
                          SizedBox(height: 4),
                          Text('Phone: ${center['Phone']}'),
                        ],
                      ),
                    ),
                    SizedBox(width: 16), 
                    Column(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                           
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text(
                                      'Appointment booked at ${center['Name']}')),
                            );
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BookingFormPage()));
                          },
                          child: Text('Book Appointment'),
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Colors.green 
                              ),
                        ),
                        SizedBox(height: 16),
                        // Uncomment and modify if you want to display the image
                        // if (center['Image'] != null)
                        //   Container(
                        //     width: 100,
                        //     height: 100,
                        //     child: Image.asset(
                        //       center['Image']!,
                        //       fit: BoxFit.cover,
                        //     ),
                        //   ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
