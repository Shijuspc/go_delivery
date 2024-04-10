import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  XFile? pickfile;
  File? pickimage;
  String? profileImageUrl;

  @override
  void initState() {
    super.initState();
    // Fetch the current user's data and populate the text controllers
    _fetchUserProfile();
  }

  Future<File?> _selectImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      return File(pickedFile.path);
    }
    return null;
  }

  Future<void> _fetchUserProfile() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final userData = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        if (userData.exists) {
          final data = userData.data() as Map<String, dynamic>;
          _nameController.text = data['name'];
          _emailController.text = data['email'];
          _phoneNumberController.text = data['phoneNumber'];
          _addressController.text = data['address'];
          profileImageUrl = data['profileImageUrl'];

          if (profileImageUrl != null && pickimage != null) {
            try {
              final imageFile = await firebase_storage.FirebaseStorage.instance
                  .refFromURL(profileImageUrl!)
                  .writeToFile(pickimage!);
              setState(() {
                pickimage = imageFile as File?;
              });
            } catch (e) {
              print('Error retrieving profile image: $e');
            }
          }
        }
      }
    } catch (e) {
      print('Error fetching user profile: $e');
    }
  }

  Future<void> _updateProfile() async {
    if (_formKey.currentState!.validate()) {
      // Validate form fields
      _formKey.currentState!.save();

      try {
        // Get the current user
        final user = FirebaseAuth.instance.currentUser;

        if (user != null) {
          // Update user profile information in Firestore
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .set({
            'name': _nameController.text,
            'email': _emailController.text,
            'phoneNumber': _phoneNumberController.text,
            'address': _addressController.text,
          });
          // Upload image to Firebase Storage if an image is selected
          if (pickimage != null) {
            try {
              final user = FirebaseAuth.instance.currentUser;
              final storageRef = firebase_storage.FirebaseStorage.instance
                  .ref()
                  .child('profile_images')
                  .child(user!.uid);

              await storageRef.putFile(pickimage!);
              final imageUrl = await storageRef.getDownloadURL();

              // Save the image URL to Firestore or use it as needed
              await FirebaseFirestore.instance
                  .collection('users')
                  .doc(user.uid)
                  .update({'profileImageUrl': imageUrl});
            } catch (e) {
              print('Error uploading image: $e');
            }
          }
          // Show success message or navigate to a different screen
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Profile updated successfully')),
          );
        }
      } catch (e) {
        // Show error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update profile')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 245, 245, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(255, 94, 94, 1),
        title: Center(
          child: Text(
            'Profile',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 80,
                  width: 80,
                  child: InkWell(
                    onTap: () async {
                      ImagePicker picker = ImagePicker();
                      pickfile =
                          await picker.pickImage(source: ImageSource.gallery);
                      setState(() {
                        pickimage = File(pickfile!.path);
                      });
                    },
                    child: SizedBox(
                      height: 80,
                      width: 80,
                      child: ClipOval(
                        child: CircleAvatar(
                          backgroundImage:
                              pickimage != null ? FileImage(pickimage!) : null,
                          radius: 40,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    labelStyle: TextStyle(
                      color: Color.fromRGBO(255, 94, 94, 1),
                      fontWeight: FontWeight.w500,
                    ),
                    contentPadding: EdgeInsets.only(left: 30),
                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        width: 2,
                        color: Color.fromRGBO(255, 94, 94, 1),
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        width: 2,
                        color: Color.fromRGBO(255, 94, 94, 1),
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'E-mail',
                    labelStyle: TextStyle(
                      color: Color.fromRGBO(255, 94, 94, 1),
                      fontWeight: FontWeight.w500,
                    ),
                    contentPadding: EdgeInsets.only(left: 30),
                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        width: 2,
                        color: Color.fromRGBO(255, 94, 94, 1),
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        width: 2,
                        color: Color.fromRGBO(255, 94, 94, 1),
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your e-mail';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _phoneNumberController,
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
                    labelStyle: TextStyle(
                      color: Color.fromRGBO(255, 94, 94, 1),
                      fontWeight: FontWeight.w500,
                    ),
                    contentPadding: EdgeInsets.only(left: 30),
                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        width: 2,
                        color: Color.fromRGBO(255, 94, 94, 1),
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        width: 2,
                        color: Color.fromRGBO(255, 94, 94, 1),
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your phone number';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 100,
                  child: TextFormField(
                    controller: _addressController,
                    maxLines: null,
                    expands: true,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      labelText: 'Address',
                      labelStyle: TextStyle(
                        color: Color.fromRGBO(255, 94, 94, 1),
                        fontWeight: FontWeight.w500,
                      ),
                      contentPadding: EdgeInsets.only(left: 30),
                      filled: true,
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          width: 2,
                          color: Color.fromRGBO(255, 94, 94, 1),
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          width: 2,
                          color: Color.fromRGBO(255, 94, 94, 1),
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your address';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 16.0),
                SizedBox(
                  height: 50,
                  width: 160,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: Color.fromRGBO(255, 94, 94, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    onPressed: _updateProfile,
                    child: Text(
                      'Update Profile',
                      style: TextStyle(color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
