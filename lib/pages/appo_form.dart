import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bike Service Booking',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: BookingFormPage(),
    );
  }
}

class BookingFormPage extends StatefulWidget {
  @override
  _BookingFormPageState createState() => _BookingFormPageState();
}

class _BookingFormPageState extends State<BookingFormPage>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _bikeNumberController = TextEditingController();
  final TextEditingController _bikeModelController = TextEditingController();
  TimeOfDay? _selectedTime;
  DateTime? _serviceDate;
  DateTime? _receiveDate;

  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _nameController.dispose();
    _bikeNumberController.dispose();
    _bikeModelController.dispose();
    super.dispose();
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  Future<void> _selectDate(BuildContext context, bool isReceiveDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isReceiveDate
          ? DateTime.now().add(Duration(days: 1))
          : DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        if (isReceiveDate) {
          _receiveDate = picked;
        } else {
          _serviceDate = picked;
        }
      });
    }
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('name', _nameController.text);
      await prefs.setString('bikeNumber', _bikeNumberController.text);
      await prefs.setString('bikeModel', _bikeModelController.text);
      await prefs.setString('serviceDate', _serviceDate.toString());
      await prefs.setString('receiveDate', _receiveDate.toString());
      await prefs.setString('time', _selectedTime?.format(context) ?? '');

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AppointmentDetailsPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.green[300]!, Colors.green[800]!],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: FadeTransition(
          opacity: _animation,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: ListView(
                    children: [
                      SizedBox(height: 20,),
                      Center(
                        child:Text("Appointment Form",style: TextStyle(color: Colors.green,fontSize: 25,),) ,
                      ),
                      SizedBox(height: 20,),
                      
                      TextFormField(
                        controller: _nameController,
                        decoration:
                            InputDecoration(labelText: 'Name', filled: true),
                        validator: (value) =>
                            value == null || value.isEmpty
                                ? 'Please enter your name'
                                : null,
                      ),
                      SizedBox(height: 16), // Added space
                      TextFormField(
                        controller: _bikeNumberController,
                        decoration: InputDecoration(
                            labelText: 'Bike Number', filled: true),
                        validator: (value) =>
                            value == null || value.isEmpty
                                ? 'Please enter your bike number'
                                : null,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                        ],
                      ),
                      SizedBox(height: 16), // Added space
                      TextFormField(
                        controller: _bikeModelController,
                        decoration: InputDecoration(
                            labelText: 'Bike Model', filled: true),
                        validator: (value) =>
                            value == null || value.isEmpty
                                ? 'Please enter your bike model'
                                : null,
                      ),
                      SizedBox(height: 20), // Added space before time selection
                      ListTile(
                        title: Text(
                            'Select Time: ${_selectedTime?.format(context) ?? 'Select Time'}'),
                        trailing: Icon(Icons.access_time),
                        onTap: () => _selectTime(context),
                      ),
                      ListTile(
                        title: Text(
                            'Service Date: ${_serviceDate == null ? 'Select Date' : _serviceDate!.toLocal().toShortDateString()}'),
                        trailing: Icon(Icons.calendar_today),
                        onTap: () => _selectDate(context, false),
                      ),
                      ListTile(
                        title: Text(
                            'Receive Date: ${_receiveDate == null ? 'Select Date' : _receiveDate!.toLocal().toShortDateString()}'),
                        trailing: Icon(Icons.calendar_today),
                        onTap: () => _selectDate(context, true),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _submitForm,
                        child: Text('Book Now'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AppointmentDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Appointment Details')),
      body: FutureBuilder<SharedPreferences>(
        future: SharedPreferences.getInstance(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          final prefs = snapshot.data!;
          final name = prefs.getString('name') ?? '';
          final bikeNumber = prefs.getString('bikeNumber') ?? '';
          final bikeModel = prefs.getString('bikeModel') ?? '';
          final serviceDate = prefs.getString('serviceDate') ?? '';
          final receiveDate = prefs.getString('receiveDate') ?? '';
          final time = prefs.getString('time') ?? '';

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Name: $name', style: TextStyle(fontSize: 18)),
                SizedBox(height: 8), 
                Text('Bike Number: $bikeNumber', style: TextStyle(fontSize: 18)),
                SizedBox(height: 8), 
                Text('Bike Model: $bikeModel', style: TextStyle(fontSize: 18)),
                SizedBox(height: 8), 
                Text('Service Date: $serviceDate', style: TextStyle(fontSize: 18)),
                SizedBox(height: 8), 
                Text('Receive Date: $receiveDate', style: TextStyle(fontSize: 18)),
                SizedBox(height: 8), 
                Text('Time: $time', style: TextStyle(fontSize: 18)),
              ],
            ),
          );
        },
      ),
    );
  }
}

extension DateTimeFormat on DateTime {
  String toShortDateString() {
    return "${this.day}/${this.month}/${this.year}";
  }
}
