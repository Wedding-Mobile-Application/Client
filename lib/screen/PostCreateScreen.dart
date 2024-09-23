import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_quill/flutter_quill.dart' as quill;

class PostCreateScreen extends StatefulWidget {
  const PostCreateScreen({super.key});

  @override
  State<PostCreateScreen> createState() => _PostCreateScreenState();
}

class _PostCreateScreenState extends State<PostCreateScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _locationController = TextEditingController();
  final _priceController = TextEditingController();
  final _contactNumberController = TextEditingController();
  final _imageNameController = TextEditingController();
  final _perDay = TextEditingController();
  final _perHour = TextEditingController();
  final quill.QuillController _controller = quill.QuillController.basic();

  // List of items in the dropdown
  final List<String> items = [
    'Photography',
    'Decoration',
    'Catering',
    'Event Planning',
    'Cake',
    'Wedding Attire',
    'Transportation',
    'Beauty',
    'Entertainment'
  ];

  // Variable to hold the selected item
  String? selectedItem;

  File? _image;
  final picker = ImagePicker();

  Future pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    print(pickedFile);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void handleDayClick(String day) {
    // print(day);
    setState(() {
      _perDay.text = day;
    });

    print(_perDay.text);
  }

  void handleHourClick(String hour) {
    // print(day);
    setState(() {
      _perHour.text = hour;
    });

    print(_perHour.text);
  }

  Future<void> handleFormSubmit() async {
    try {
      print('Title: ${_titleController.text}');
      print('Contact Number: ${_contactNumberController.text}');
      print('Location: ${_locationController.text}');
      print('Price: ${_priceController.text}');
      print('Description: ${_descriptionController.text}');
      print('Category: $selectedItem');
      print('Image: ${_image?.path ?? 'No image selected'}');
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Create Post',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color.fromARGB(255, 37, 36, 25),
              fontFamily: 'Playfair Display',
              fontSize: 30,
              shadows: [
                Shadow(
                  offset: Offset(3.0, 3.0), // Shadow position
                  blurRadius: 2.0, // Shadow blur
                  color: Colors.grey, // Shadow color
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 15.0, left: 20.0, right: 20.0),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Title section
                Padding(
                  padding: const EdgeInsets.only(top: 25.0),
                  child: TextField(
                    controller: _titleController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter Post Title',
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),

                // Description section
                TextField(
                  controller: _descriptionController,
                  keyboardType: TextInputType.multiline,
                  maxLines: 4, // Set the maximum number of lines
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter your description here',
                  ),
                ),

                const SizedBox(height: 20.0),

                // Location section
                Padding(
                  padding: const EdgeInsets.only(top: 25.0),
                  child: TextField(
                    controller: _locationController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Select Your Service Location',
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),

                // Price section
                Padding(
                  padding: const EdgeInsets.only(top: 25.0),
                  child: TextField(
                    controller: _priceController,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      hintText: 'Enter Your Price',
                      suffixIcon: Row(
                        mainAxisSize: MainAxisSize
                            .min, // Ensure the row doesn't take up too much space
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              child: ElevatedButton(
                                onPressed: () {
                                  handleDayClick('Day');
                                },
                                child: Text('Day'),
                              ),
                            ),
                          ),
                          Container(
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Container(
                                child: ElevatedButton(
                                  onPressed: () {
                                    handleHourClick('hour');
                                  },
                                  child: Text('Hour'),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20.0),

                // Contact Number section
                Padding(
                  padding: const EdgeInsets.only(top: 25.0),
                  child: TextField(
                    controller: _contactNumberController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter Your Contact Number',
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),

                // Category section
                Padding(
                  padding: const EdgeInsets.only(top: 25.0),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 5.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.black26,
                          width: 2.0), // Border color and thickness
                      borderRadius:
                          BorderRadius.circular(10.0), // Rounded corners
                      color: Colors.white, // Background color of the button
                    ),
                    child: DropdownButton<String>(
                      value: selectedItem,
                      hint: const Text('Select a Category'),
                      icon: const Icon(Icons.arrow_drop_down,
                          color: Colors.black), // Custom dropdown icon
                      iconSize: 30.0, // Size of the dropdown icon
                      isExpanded:
                          true, // Expands the dropdown to fit the container
                      underline: Container(), // Removes the default underline
                      style: const TextStyle(
                        color: Colors.black, // Text color
                        fontSize: 16, // Text size
                      ),
                      dropdownColor:
                          Colors.white, // Background color of the dropdown
                      items:
                          items.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedItem = newValue!;
                        });
                      },
                    ),
                  ),
                ),

                const SizedBox(height: 30.0),

                Align(
                  alignment: Alignment.centerLeft, // Align to the left side
                  child: Container(
                    child: _image == null
                        ? const Text('No image selected.')
                        : const Text('Image selected.'),
                  ),
                ),

                // Align(
                //   alignment: Alignment.centerRight, // Align to the left side
                //   child: SizedBox(
                //     width: 150, // Width of the button
                //     height: 40, // Height of the button
                //     child: Container(
                //       decoration: BoxDecoration(
                //         border: Border.all(
                //             color: Color.fromARGB(255, 148, 148, 148),
                //             width: 1.0), // Black border with width of 2.0
                //         borderRadius: BorderRadius.circular(
                //             10), // Match the button's border radius
                //       ),
                //       child: ElevatedButton(
                //         onPressed: pickImage,
                //         style: ElevatedButton.styleFrom(
                //           primary:
                //               Colors.white, // Background color of the button
                //           shape: RoundedRectangleBorder(
                //             borderRadius: BorderRadius.circular(
                //                 10), // Match the container's border radius
                //           ),
                //           side: BorderSide.none, // Remove default border
                //         ),
                //         child: const Text(
                //           'Pick Image',
                //           style: TextStyle(color: Colors.black, fontSize: 16),
                //         ),
                //       ),
                //     ),
                //   ),
                // ),

                // Image select section
                Padding(
                  padding: const EdgeInsets.only(top: 25.0),
                  child: TextField(
                    controller: _imageNameController,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      hintText: 'Give Image Name',
                      suffixIcon: Row(
                        mainAxisSize: MainAxisSize
                            .min, // Ensure the row doesn't take up too much space
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              child: ElevatedButton(
                                onPressed: pickImage,
                                child: Text('Pick Image'),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20.0),

                Align(
                  alignment: Alignment.center, // Align to the left side
                  child: SizedBox(
                    width: 400, // Set the desired width
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 0.0, top: 50.0), // External padding
                      child: ElevatedButton(
                        onPressed: handleFormSubmit,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              vertical: 18.0,
                              horizontal: 20.0), // Internal padding
                        ),
                        child: const Text(
                          'Create Post',
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 100.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
