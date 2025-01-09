import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HelpCenterScreen extends StatefulWidget {
  const HelpCenterScreen({super.key});

  @override
  State<HelpCenterScreen> createState() => _HelpCenterScreenState();
}

class _HelpCenterScreenState extends State<HelpCenterScreen> {
  final String phoneNo1 = '0768971213';
  final String phoneNo2 = '0772618203';
  final String phoneNo3 = '0772374700';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help Center'),
        backgroundColor: Colors.teal,
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgPicture.asset(
                  'assets/svg/help.svg',
                  width: 100,
                  height: 100,
                ),
                const SizedBox(height: 20),
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Welcome to the Aloka IT Solution Help Center for Private Classes. Explore our comprehensive articles, tutorials, and FAQs to efficiently navigate the platform, solve common problems, and improve your teaching journey. At Aloka IT Solution, we are dedicated to making your private classes a success, and this help center is here to assist you every step of the way.',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.black87,
                        height: 1.5,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Contact Us',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal,
                  ),
                ),
                const SizedBox(height: 10),
                const Divider(thickness: 1, color: Colors.teal),
                const SizedBox(height: 20),
                ContactButton(
                  onPressed: () async {
                    // FlutterPhoneDirectCaller.callNumber(phoneNo1);
                  },
                  name: 'Isuru Fernando',
                  phoneNo: phoneNo1,
                ),
                const SizedBox(height: 10),
                ContactButton(
                  onPressed: () {
                    // FlutterPhoneDirectCaller.callNumber(phoneNo2);
                  },
                  name: 'Pasindu Premodh',
                  phoneNo: phoneNo2,
                ),
                const SizedBox(height: 10),
                ContactButton(
                  onPressed: () {
                    //FlutterPhoneDirectCaller.callNumber(phoneNo3);
                  },
                  name: 'Shiran Priyanjan',
                  phoneNo: phoneNo3,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ContactButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String name;
  final String phoneNo;

  const ContactButton({
    super.key,
    required this.onPressed,
    required this.name,
    required this.phoneNo,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: const Icon(Icons.call, color: Colors.teal),
        title: Text(
          '$name: $phoneNo',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        onTap: onPressed,
      ),
    );
  }
}
