import 'package:aloka_mobile_app/src/modules/auth_screen/bloc/user_bloc/user_login_bloc.dart';
import 'package:aloka_mobile_app/src/res/color/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../res/strings/string.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Profile'),
        backgroundColor: ColorUtil.skyBlueColor[10],
      ),
      body: BlocBuilder<UserLoginBloc, UserLoginState>(
        builder: (context, state) {
          if (state is SystemUserLoginSuccess) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Profile Picture Section
                     Center(
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(
                          StringData.appMainLogo, // Placeholder image
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // User Name
                    Center(
                      child: Text(
                        '${state.myUserModelClass[0].firstName} ${state.myUserModelClass[0].lastName}',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Center(
                      child: Text(
                        '${state.myUserModelClass[0].userType}',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // User Information
                    _buildSection(
                      title: 'Personal Information',
                      children: [
                        _buildInfoRow(
                            'Email:', state.myUserModelClass[0].email),
                        _buildInfoRow('Mobile No:',
                            state.myUserModelClass[0].mobileNumber),
                        _buildInfoRow('NIC:', state.myUserModelClass[0].nic),
                        _buildInfoRow(
                            'Birthday:', state.myUserModelClass[0].birthday),
                        _buildInfoRow(
                            'Gender:', state.myUserModelClass[0].gender),
                      ],
                    ),
                    const SizedBox(height: 20),
                    _buildSection(
                      title: 'Address',
                      children: [
                        _buildInfoRow('Address Line 1:',
                            state.myUserModelClass[0].addressLine1),
                        _buildInfoRow('Address Line 2:',
                            state.myUserModelClass[0].addressLine2),
                        _buildInfoRow('Address Line 3:',
                            state.myUserModelClass[0].addressLine3),
                      ],
                    ),
                    const SizedBox(height: 20),
                    _buildSection(
                      title: 'Account Information',
                      children: [
                        _buildInfoRow('User ID:',
                            state.myUserModelClass[0].systemUserCusId),
                        _buildInfoRow(
                            'Created At:',
                            _formatDate(state.myUserModelClass[0].createdAt
                                .toString())),
                        _buildInfoRow(
                            'Updated At:',
                            _formatDate(state.myUserModelClass[0].updatedAt
                                .toString())),
                      ],
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  // Helper method to build section headers
  Widget _buildSection(
      {required String title, required List<Widget> children}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        ...children,
      ],
    );
  }

  // Helper method to build info rows
  Widget _buildInfoRow(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(children: [
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            value ?? 'N/A',
            style: TextStyle(
              color: Colors.grey[800],
            ),
          ),
        ),
      ]),
    );
  }

  String _formatDate(String date) {
    try {
      final DateTime parsedDate = DateTime.parse(date);
      return DateFormat('yyyy-MM-dd – kk:mm').format(parsedDate);
    } catch (e) {
      return 'Invalid Date';
    }
  }
}
