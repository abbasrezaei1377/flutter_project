import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Interactive Product Card',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
      ),
      home: const ProductScreen(),
    );
  }
}

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  bool showDetails = false;
  bool isFavorite = false;
  bool isArchived = false;

  double dragDistance = 0;

  // Safe threshold for swipe
  final double swipeThreshold = 100;

  void toggleDetails() {
    setState(() {
      showDetails = !showDetails;
    });
  }

  void toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 1),
        content: Text(
          isFavorite
              ? 'Added to favorites ❤️'
              : 'Removed from favorites',
        ),
      ),
    );
  }

  void archiveProduct() {
    setState(() {
      isArchived = true;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Product archived'),
        action: SnackBarAction(
          label: 'UNDO',
          onPressed: () {
            setState(() {
              isArchived = false;
            });
          },
        ),
      ),
    );
  }

  void showActionMenu() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.edit),
                title: const Text('Edit'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.share),
                title: const Text('Share'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.archive),
                title: const Text('Archive'),
                onTap: () {
                  Navigator.pop(context);
                  archiveProduct();
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
                title: const Text(
                  'Delete',
                  style: TextStyle(color: Colors.red),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Interactive Product Card'),
        centerTitle: true,
      ),

      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),

          child: isArchived
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.archive,
                      size: 80,
                      color: Colors.grey,
                    ),

                    const SizedBox(height: 10),

                    const Text(
                      'Product Archived',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 20),

                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          isArchived = false;
                        });
                      },
                      child: const Text('Restore Product'),
                    ),
                  ],
                )

              // PRODUCT CARD
              : GestureDetector(
                  // Single Tap
                  onTap: toggleDetails,

                  // Double Tap
                  onDoubleTap: toggleFavorite,

                  // Long Press
                  onLongPress: showActionMenu,

                  // Start horizontal drag
                  onHorizontalDragStart: (details) {
                    dragDistance = 0;
                  },

                  // Update horizontal drag
                  onHorizontalDragUpdate: (details) {
                    dragDistance += details.delta.dx;
                  },

                  // End horizontal drag
                  onHorizontalDragEnd: (details) {
                    if (dragDistance.abs() >= swipeThreshold) {
                      archiveProduct();
                    }

                    dragDistance = 0;
                  },

                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),

                    width: 360,

                    padding: const EdgeInsets.all(16),

                    decoration: BoxDecoration(
                      color: isFavorite
                          ? Colors.red.shade50
                          : Colors.white,

                      borderRadius: BorderRadius.circular(20),

                      border: Border.all(
                        color: isFavorite
                            ? Colors.red
                            : Colors.grey.shade300,
                        width: isFavorite ? 2 : 1,
                      ),

                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),

                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [

                        // PRODUCT IMAGE WITH ZOOM
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15),

                          child: SizedBox(
                            height: 220,
                            width: double.infinity,

                            child: InteractiveViewer(
                              minScale: 1,
                              maxScale: 4,

                              child: Image.network(
                                'https://images.unsplash.com/photo-1542291026-7eec264c27ff',
                                fit: BoxFit.cover,

                                errorBuilder:
                                    (context, error, stackTrace) {
                                  return Container(
                                    color: Colors.grey.shade200,
                                    child: const Center(
                                      child: Icon(
                                        Icons.image,
                                        size: 80,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        // PRODUCT NAME
                        Row(
                          mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,

                          children: [
                            const Expanded(
                              child: Text(
                                'Nike Running Shoes',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),

                            Icon(
                              isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border,

                              color:
                                  isFavorite ? Colors.red : Colors.grey,

                              size: 32,
                            ),
                          ],
                        ),

                        const SizedBox(height: 8),

                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '\$120',
                            style: TextStyle(
                              fontSize: 21,
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        // DETAILS
                        AnimatedCrossFade(
                          duration: const Duration(milliseconds: 300),

                          firstChild: const SizedBox(),

                          secondChild: Container(
                            width: double.infinity,

                            margin: const EdgeInsets.only(top: 15),

                            padding: const EdgeInsets.all(12),

                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(12),
                            ),

                            child: const Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,

                              children: [
                                Text(
                                  'Product Details',
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                SizedBox(height: 8),

                                Text('Size: 42'),
                                Text('Color: Red / White'),
                                Text('Category: Running Shoes'),
                                Text('Status: In Stock'),
                              ],
                            ),
                          ),

                          crossFadeState: showDetails
                              ? CrossFadeState.showSecond
                              : CrossFadeState.showFirst,
                        ),

                        const SizedBox(height: 20),

                        // VISIBLE STANDARD BUTTON
                        SizedBox(
                          width: double.infinity,

                          child: ElevatedButton.icon(
                            onPressed: () {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Buy Now button pressed',
                                  ),
                                ),
                              );
                            },

                            icon: const Icon(
                              Icons.shopping_cart,
                            ),

                            label: const Text('Buy Now'),
                          ),
                        ),

                        const SizedBox(height: 12),

                        Text(
                          'Tap: Details • Double Tap: Favorite\n'
                          'Long Press: Menu • Swipe: Archive\n'
                          'Pinch image: Zoom',

                          textAlign: TextAlign.center,

                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}