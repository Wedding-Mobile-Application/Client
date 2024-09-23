import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:html';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<dynamic> posts = [];
  bool isLoading = true;
  bool hasError = false;
  bool isHovered = false; // Track hover state

  List<String> items = [
    'Location 1',
    'Location 2',
    'Location 3',
    'Location 4',
    'Location 1',
    'Location 2',
    'Location 3',
    'Location 4',
    'Location 1',
    'Location 2',
    'Location 3',
    'Location 4'
  ];
  List<bool> checkedItems = [false, false, false, false];

  void _onCheckboxChanged(int index, bool? value) {
    print(index);
    print(value);
    setState(() {
      checkedItems[index] =
          value ?? false; // Correctly update the checkedItems list
    });
  }

  @override
  void initState() {
    super.initState();
    getAllCreatedPost();
  }

  void getAllCreatedPost() async {
    try {
      final response = await http
          .get(Uri.parse('http://192.168.1.156:3000/api/v1/create/get-all'));
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        // Access the `data` array in the response and extract the postTitle
        final List<dynamic> postsList = responseData['data'];

        print(postsList[0]
            ['postTitle']); // Add this line to log the response data

        setState(() {
          posts = postsList;
          isLoading = false;
        });
      }
    } catch (error) {
      setState(() {
        isLoading = false;
        hasError = true;
      });
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: const Icon(Icons.search), // Search icon
                  ),
                ),
              ),
              const SizedBox(
                  width: 10), // Space between the search bar and buttons
              IconButton(
                icon: const Icon(Icons.filter_list),
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return Container(
                        height: screenHeight * 0.7,
                        width: screenWidth,
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('This is a Bottom Sheet'),
                            const SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(
                                    context); // Close the bottom sheet
                              },
                              child: const Text('Close'),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
              IconButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return Container(
                        height: screenHeight * 0.7,
                        width: screenWidth,
                        padding: EdgeInsets.all(
                            8.0), // Padding around the entire container
                        child: ListView.builder(
                          itemCount: items.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(items[index]), // Display item text
                              trailing: IconButton(
                                onPressed: () {
                                  showModalBottomSheet(
                                    context: context,
                                    builder: (context) {
                                      return Container(
                                        height: screenHeight * 0.7,
                                        width: screenWidth,
                                        padding: EdgeInsets.all(16.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text('Details for ${items[index]}',
                                                style: const TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                                        
                                            SizedBox(height: 10),

                                            Text('More information about ${items[index]} goes here.'),
                                            
                                            SizedBox(height: 20),
                                            
                                            ElevatedButton(
                                              onPressed: () {
                                                Navigator.pop(
                                                    context); // Close this bottom sheet
                                              },
                                              child: const Text('Close'),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                },
                                icon: Icon(Icons.arrow_forward_ios_rounded),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  );
                },
                icon: const Icon(Icons.location_on),
              ),
            ],
          ),
        ),
      ),
      body: Expanded(
        child: isLoading
            ? const Center(
                child:
                    CircularProgressIndicator()) // Show loading spinner while data is being fetched
            : hasError
                ? const Center(child: Text('Failed to load posts'))
                : Container(
                    child: ListView.builder(
                      itemCount: posts.length,
                      itemBuilder: (context, index) {
                        final post = posts[index];
                        return Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8), // Add margin to space the container
                          decoration: BoxDecoration(
                            color: Colors.white, // Background color
                            borderRadius:
                                BorderRadius.circular(12), // Rounded corners
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black12, // Shadow color
                                blurRadius: 8, // Shadow blur
                                offset: Offset(0, 4), // Shadow position
                              ),
                            ],
                            border: Border.all(
                              color: const Color.fromARGB(
                                  255, 161, 161, 161), // Border color
                              width: 2, // Border width
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(
                                16.0), // Add padding inside the container
                            child: ListTile(
                              title: Text(
                                post['postTitle'] ?? 'No title',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    post['description'] ?? 'No description',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                  Text(
                                    'price : ' + post['price'] ??
                                        'No description',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
      ),
    );
  }
}
