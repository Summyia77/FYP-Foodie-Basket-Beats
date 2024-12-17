import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class fetchStoreData extends StatefulWidget {
  final String category;

  const fetchStoreData({Key? key, required this.category}) : super(key: key);

  @override
  State<fetchStoreData> createState() => _StoreListState();
}

class _StoreListState extends State<fetchStoreData> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Object?>>(
      stream: FirebaseFirestore.instance
          .collection("Store")
          .where('category', isEqualTo: widget.category)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}'); // Handle error state
        } else if (snapshot.hasData) {
          final documents = snapshot.data!.docs;
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                for (final doc in documents)
                  StoreItem(
                    imageUrl: doc['image'],
                    name: doc['name'],
                    price: doc['price'],
                    rating: doc['rating'],
                    category: doc['category'],
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => show_detail(storeData: doc)),
                    ),
                  ),
              ],
            ),
          );
        } else {
          return CircularProgressIndicator(); // Handle loading state
        }
      },
    );
  }
}

class StoreItem extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String price;
  final String rating;
  final String category;
  final VoidCallback onTap;

  const StoreItem({
    Key? key,
    required this.imageUrl,
    required this.name,
    required this.price,
    required this.rating,
    required this.category,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 104,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () async {
                    onTap
                        ?.call(); // Call the original onTap callback if provided

                    try {
                      final User? user = FirebaseAuth.instance.currentUser;
                      if (user != null) {
                        final String currentUserId = user.uid;

                        // Query for existing record
                        QuerySnapshot querySnapshot = await FirebaseFirestore
                            .instance
                            .collection('userInteractions')
                            .where('UserId', isEqualTo: currentUserId)
                            .where('category', isEqualTo: category)
                            .get();

                        if (querySnapshot.docs.isNotEmpty) {
                          // Update existing record
                          DocumentSnapshot documentSnapshot =
                              querySnapshot.docs.first;
                          await documentSnapshot.reference.update(
                              {'Interactions': FieldValue.increment(1)});
                        } else {
                          // Add new record
                          await FirebaseFirestore.instance
                              .collection('userInteractions')
                              .add({
                            'Interactions': 1,
                            'category': category,
                            'UserId': currentUserId,
                          });
                        }
                      } else {
                        // Handle the case where the user is not authenticated
                        print('User is not authenticated');
                        // You might want to show an error message or redirect the user to the login screen.
                      }
                    } catch (e) {
                      // Handle potential errors, such as network errors or Firestore exceptions
                      print('Error adding/updating data to Firestore: $e');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Colors.transparent, // Remove background color

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),

                    padding: EdgeInsets
                        .zero, // Remove padding as image fills the button
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.network(
                      imageUrl,
                      width: 95.0,
                      height: 95.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Text(name, style: TextStyle(fontSize: 14.0))),
                Text("\$$price",
                    style: TextStyle(fontSize: 14.0, color: Colors.redAccent)),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("$rating/5", style: TextStyle(fontSize: 14.0)),
                    Icon(Icons.star,
                        color: CupertinoColors.systemYellow, size: 16.0),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Assuming you have a separate `show_detail` function
Widget show_detail({required DocumentSnapshot storeData}) {
  var rat = storeData["rating"];
  return Scaffold(
      // appBar: AppBar(
      //   title: Text('Store Details'),
      // ),
      body: Center(
    child: Container(
      height: 700,
      color: Colors.white,
      child: Column(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.network(
                  storeData['image'],
                  width: 610.0,
                  height: 360.0,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                bottom: 10.0, // Adjust for desired padding from bottom
                right: 10.0, // Adjust for desired padding from right
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0,
                      vertical: 5.0), // Adjust padding as needed
                  decoration: BoxDecoration(
                    color: Colors.black, // Apply black background
                    borderRadius: BorderRadius.circular(
                        10.0), // Match image's corner radius
                  ),
                  child: Row(
                    // Wrap content in Row for horizontal arrangement
                    mainAxisAlignment: MainAxisAlignment.start, // Align to left
                    crossAxisAlignment:
                        CrossAxisAlignment.center, // Center vertically
                    children: [
                      Icon(
                        Icons.currency_rupee,
                        size: 20,
                        color:
                            Colors.white, // Adjust color for better visibility
                      ),
                      const SizedBox(
                          width: 4.0), // Add spacing between icon and text
                      Text(
                        storeData['price'],
                        style: const TextStyle(
                            fontSize: 15.0, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 11.0, top: 5, right: 11.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween, // Align evenly
              children: [
                Text(
                  storeData['name'],
                  style: TextStyle(fontSize: 24, color: Colors.orange),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: Colors.yellow,
                      size: 32,
                    ),
                    Text(
                      "$rat/5",
                      style: TextStyle(fontSize: 24, color: Colors.orange),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            height: 120,
            child: Padding(
              padding: const EdgeInsets.all(13.0),
              child:
                  SingleChildScrollView(child: Text(storeData['description'])),
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            child: Text(
              "Order Now",
              style: TextStyle(color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  Colors.black, // Set the background color to black
            ),
          ),
        ],
      ),
    ),
  ));
}
