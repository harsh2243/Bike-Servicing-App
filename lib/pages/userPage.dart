
import 'package:project/shared_prefernce.dart';

import '../pages/bike_service_center.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../pages/appo_form.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BottomNavBar(),
    );
  }
}

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    UserScreen(),
    AdminScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'User',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.admin_panel_settings),
            label: 'Admin',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}

// User Screen
class UserScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: ListTile(
          title: Text("Welcome !"),
          leading: CircleAvatar(
            backgroundImage: NetworkImage(
              "https://png.pngtree.com/png-clipart/20231019/original/pngtree-user-profile-avatar-png-image_13369988.png",
            ),
          ),
        ),
        backgroundColor: CupertinoColors.activeGreen,
      ),
      endDrawer: _buildDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildAdvertisementCard(context),
            SizedBox(height: 16),
            BikeServiceScreen(),
          ],
        ),
      ),
    );
  }

  Drawer _buildDrawer() {
    return Drawer(
      backgroundColor: Colors.green,
      child: Column(
        children: [
          DrawerHeader(
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                "https://png.pngtree.com/png-clipart/20231019/original/pngtree-user-profile-avatar-png-image_13369988.png",
              ),
              radius: 100,
            ),
          ),
          ListTile(
            title: Text("Tilak pandit", style: TextStyle(color: Colors.white)),
            leading: Icon(Icons.person, color: Colors.white),
          ),
          ListTile(
            title: Text("tilak@gmail.com", style: TextStyle(color: Colors.white)),
            leading: Icon(Icons.email, color: Colors.white),
          ),
          ListTile(
            title: Text("6203572038", style: TextStyle(color: Colors.white)),
            leading: Icon(Icons.phone, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Padding _buildAdvertisementCard(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: AdvertisementCard(
        imageUrl: 'assets/image/Bike.png',
        title: 'Exclusive Bike Service Deal!',
        subtitle: 'Flat 25% off on All Services',
        description:
        'Get your bike fully serviced and enjoy a 25% discount. Offer available till the end of the month.',
        buttonText: 'Book Now',
        onPressed: () {
          print('Book Now clicked');
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => BookingFormPage()),
          );
        },
      ),
    );
  }
}

// Advertisement Card
class AdvertisementCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String subtitle;
  final String description;
  final String buttonText;
  final VoidCallback onPressed;

  const AdvertisementCard({
    required this.imageUrl,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.buttonText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
            child: Image.asset(
              imageUrl,
              height: 180,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  subtitle,
                  style: TextStyle(fontSize: 18, color: Colors.blueAccent),
                ),
                SizedBox(height: 12),
                Text(
                  description,
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 16),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: onPressed,
                    child: Text(buttonText),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Bike Service Screen
class BikeServiceScreen extends StatefulWidget {
  @override
  _BikeServiceScreenState createState() => _BikeServiceScreenState();
}

class _BikeServiceScreenState extends State<BikeServiceScreen> {
  final TextEditingController _bikeNumberController = TextEditingController();
  Map<String, String>? bikeData;

  // Dummy bike data
  final List<Map<String, String>> _bikeList = [
    {
      'Bike Number': 'MH1AB1234',
      'Owner': 'Alice Smith',
      'Model': 'Yamaha FZ',
      'Last Service': '01st Oct 2024',
      'Status': 'Due for service',
      'Image': 'https://png.pngtree.com/png-vector/20221222/ourmid/pngtree-vector-motorcycle-transport-poster-png-image_6501913.png',
    },
    {
      'Bike Number': 'JH1AB1234',
      'Owner': 'Bob Johnson',
      'Model': 'Honda CBR',
      'Last Service': '15th Aug 2024',
      'Status': 'No service due',
      'Image': 'https://png.pngtree.com/png-vector/20240227/ourmid/pngtree-vector-illustration-of-a-sport-motorbike-honda-cbr-150-cc-png-image_11877568.png',
    },
    {
      'Bike Number': 'HR1AB1234',
      'Owner': 'Charlie Brown',
      'Model': 'Kawasaki Ninja',
      'Last Service': '20th Sept 2024',
      'Status': 'Due for service',
      'Image': 'https://png.pngtree.com/png-vector/20240603/ourmid/pngtree-the-black-and-green-kawasaki-ninja-zx-r-motorcycle-is-displayed-png-image_12606671.png',
    },
    {
      'Bike Number': 'CH1AB1234',
      'Owner': 'David Wilson',
      'Model': 'Suzuki GSX',
      'Last Service': '30th July 2024',
      'Status': 'No service due',
      'Image': 'https://example.com/suzuki_gsx.jpg',
    },
    {
      'Bike Number': 'PB1AB1234',
      'Owner': 'Eva Adams',
      'Model': 'Ducati Panigale',
      'Last Service': '05th Oct 2024',
      'Status': 'Due for service',
      'Image': 'https://example.com/ducati_paningale.jpg',
    },
  ];

  void _getBikeData() {
    String enteredBikeNumber = _bikeNumberController.text;
    Map<String, String>? foundBike = _bikeList.firstWhere(
          (bike) => bike['Bike Number'] == enteredBikeNumber,
      orElse: () => {},
    );

    setState(() {
      bikeData = foundBike.isNotEmpty ? foundBike : {'Error': 'Bike not found'};
    });
  }

  


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: _bikeNumberController,
                  decoration: InputDecoration(
                    labelText: 'Enter Bike No.',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _getBikeData,
                  child: Text('Get Data'),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 16),
        bikeData != null
            ? Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Bike Details',
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Divider(),
                          // Display all details except the image URL
                          for (var entry in bikeData!.entries)
                            if (entry.key != 'Image') // Exclude the image URL
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 4.0),
                                child: Text(
                                  '${entry.key}: ${entry.value}',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                        ],
                      ),
                    ),
                    SizedBox(width: 16), // Space between details and image
                    if (bikeData!['Image'] != null)
                      Container(
                        width: 100, // Set width for the image
                        height: 100, // Set height for the image
                        child: Image.network(
                          bikeData!['Image']!,
                          fit: BoxFit.cover,
                        ),
                      ),
                  ],
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>ServiceCenterPage()));
                  },
                  child: Text('Check for Service Center'),
                ),
              ],
            ),
          ),
        )
            : Container(),
      ],
    );
  }
}


// Admin Screen
class AdminScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ListTile(
          title: Text("Admin "),
          leading: CircleAvatar(
            backgroundImage: NetworkImage(
              "https://png.pngtree.com/png-clipart/20231019/original/pngtree-user-profile-avatar-png-image_13369988.png",
            ),
          ),
        ),
        backgroundColor: CupertinoColors.activeGreen,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Welcome to the Admin Dashboard',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 40),
              _buildServiceButton(context, 'Manage Users', UserManagementPage()),
              SizedBox(height: 20),
              _buildServiceButton(context, 'View Appoinment Requests', ServiceRequestsPage()),
            ],
          ),
        ),
      ),
    );
  }
  Widget _buildServiceButton(BuildContext context, String title, Widget page) {
    return GestureDetector(
      onTap: () {
        // Navigate to the respective page
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.green, Colors.lightGreenAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}




class UserManagementPage extends StatefulWidget {
  @override
  _UserManagementPageState createState() => _UserManagementPageState();
}

class _UserManagementPageState extends State<UserManagementPage> {
  Map<String, String?> _userData = {};

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    SharedPreferencesService prefs = SharedPreferencesService();
    Map<String, String?> userData = await prefs.getUser();
    setState(() {
      _userData = userData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Panel'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Logged in User:',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            // User data displayed in a card
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Name: ${_userData['name'] ?? 'N/A'}',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Mobile: ${_userData['mobile'] ?? 'N/A'}',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Email: ${_userData['email'] ?? 'N/A'}',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            // You can add more functionalities or data below
          ],
        ),
      ),
    );
  }
}



class ServiceRequestsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Panel'),
        backgroundColor: Colors.green,
      ),
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
            child: ListView(
              children: [
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('User Details',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        SizedBox(height: 16),
                        Text('Name: $name', style: TextStyle(fontSize: 18)),
                        SizedBox(height: 8),
                        Text('Bike Number: $bikeNumber',
                            style: TextStyle(fontSize: 18)),
                        SizedBox(height: 8),
                        Text('Bike Model: $bikeModel',
                            style: TextStyle(fontSize: 18)),
                        SizedBox(height: 8),
                        Text('Service Date: $serviceDate',
                            style: TextStyle(fontSize: 18)),
                        SizedBox(height: 8),
                        Text('Receive Date: $receiveDate',
                            style: TextStyle(fontSize: 18)),
                        SizedBox(height: 8),
                        Text('Time: $time', style: TextStyle(fontSize: 18)),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                // Additional functionalities or options can be added here
              ],
            ),
          );
        },
      ),
    );
  }
}



