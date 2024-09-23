import 'dart:io'; // Make sure to import this
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? imagePath;

  Future<void> _uploadImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        imagePath = image.path; // Update the image path
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile Screen"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: GestureDetector(
              onTap: _uploadImage,
              child: CircleAvatar(
                radius: 50,
                backgroundImage: imagePath != null
                    ? FileImage(File(imagePath!)) // Use FileImage for local images
                    : const NetworkImage('',) as ImageProvider, // Cast to ImageProvider
                  
                    child: imagePath == null
                    ? const Text('A') // Display initials if no image is selected
                    : const Text('Uploaded'),
                    
              ),
            ),
          ),
          const SizedBox(height: 20), // Add some spacing
          const Text("Hello"), // Additional text
        ],
      ),
    );
  }
}
