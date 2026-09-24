import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../widgets/ui_helper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedBottomIndex = 0;

  final List<Map<String, dynamic>> exclusiveProducts = [
    {
      'name': 'Organic Bananas',
      'quantity': '7pcs, Price',
      'price': 4.99,
      'image': 'assets/images/banana.png',
    },
    {
      'name': 'Red Apple',
      'quantity': '1kg, Price',
      'price': 4.99,
      'image': 'assets/images/apple.png',
    },
    {
      'name': 'Organic Bananas',
      'quantity': '7pcs, Price',
      'price': 4.99,
      'image': 'assets/images/banana.png',
    },
  ];

  final List<Map<String, dynamic>> bestSellingProducts = [
    {
      'name': 'Bell Pepper Red',
      'quantity': '1kg, Price',
      'price': 4.99,
      'image': 'assets/images/pepper.png',
    },
    {
      'name': 'Ginger',
      'quantity': '250g, Price',
      'price': 4.99,
      'image': 'assets/images/ginger.png',
    },
    {
      'name': 'Bell Pepper Red',
      'quantity': '1kg, Price',
      'price': 4.99,
      'image': 'assets/images/pepper.png',
    },
  ];

  final List<Map<String, dynamic>> groceryProducts = [
    {
      'name': 'Beef Bone',
      'quantity': '1kg, Price',
      'price': 4.99,
      'image': 'assets/images/beef.png',
    },
    {
      'name': 'Broiler Chicken',
      'quantity': '1kg, Price',
      'price': 4.99,
      'image': 'assets/images/chicken.png',
    },
    {
      'name': 'Beef Bone',
      'quantity': '1kg, Price',
      'price': 4.99,
      'image': 'assets/images/beef.png',
    },
  ];

  Widget buildProductList(List<Map<String, dynamic>> products) {
    return SizedBox(
      height: 240,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final item = products[index];
          return UiHelper.productCard(
            product: item,
            onAddTap: () {
              UiHelper.showSnackBar(
                context,
                '${item['name']} added to cart',
              );
            },
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 12),
              const Icon(
                Icons.eco,
                color: AppColors.primary,
                size: 32,
              ),
              const SizedBox(height: 6),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.location_on,
                    size: 16,
                    color: Colors.black54,
                  ),
                  SizedBox(width: 4),
                  Text(
                    'Gondal, Gujarat',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  height: 48,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF2F3F2),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.search, size: 22),
                      hintText: 'Search Store',
                      hintStyle: TextStyle(fontSize: 13, color: Colors.grey),
                      contentPadding: EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: SizedBox(
                    width: double.infinity,
                    height: 145,
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: Image.asset(
                            'assets/images/vegetables_banner.png',
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: const Color(0xFFEAF6D8),
                              );
                            },
                          ),
                        ),
                        const Positioned(
                          left: 140,
                          right: 12,
                          top: 35,
                          child: Column(
                            children: [
                              Text(
                                'Fresh Vegetables',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF064E3B),
                                ),
                              ),
                              SizedBox(height: 6),
                              Text(
                                'Get Up To 40% OFF',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF20B86A),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              UiHelper.sectionTitle('Exclusive Offer', 'See all'),
              buildProductList(exclusiveProducts),
              const SizedBox(height: 10),
              UiHelper.sectionTitle('Best Selling', 'See all'),
              buildProductList(bestSellingProducts),
              const SizedBox(height: 10),
              UiHelper.sectionTitle('Groceries', 'See all'),
              SizedBox(
                height: 80,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  children: [
                    UiHelper.categoryCard(
                      title: 'Pulses',
                      image: 'assets/images/pulses.png',
                    ),
                    UiHelper.categoryCard(
                      title: 'Rice',
                      image: 'assets/images/rice.png',
                    ),
                    UiHelper.categoryCard(
                      title: 'Vegetables',
                      image: 'assets/images/vegetables.png',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              buildProductList(groceryProducts),
              const SizedBox(height: 25),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedBottomIndex,
        onTap: (index) {
          setState(() {
            selectedBottomIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: Colors.black87,
        selectedFontSize: 11,
        unselectedFontSize: 11,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.store_outlined),
            activeIcon: Icon(Icons.store),
            label: 'Shop',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.manage_search_outlined),
            activeIcon: Icon(Icons.manage_search),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            activeIcon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            activeIcon: Icon(Icons.favorite),
            label: 'Favourite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Account',
          ),
        ],
      ),
    );
  }
}