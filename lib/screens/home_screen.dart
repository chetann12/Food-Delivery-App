import 'package:flutter/material.dart';
import 'menu_screen.dart';
import 'cart_screen.dart';
import 'orders_screen.dart';
import 'profile_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Colors.deepOrange;

    return Scaffold(
      appBar: AppBar(
        title: const Text("FoodDash"),
        backgroundColor: primaryColor,
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.deepOrange),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.fastfood, color: Colors.white, size: 48),
                  SizedBox(height: 10),
                  Text("Welcome!",
                      style: TextStyle(fontSize: 24, color: Colors.white)),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.restaurant_menu),
              title: const Text("Menu"),
              onTap: () => Navigator.push(
                  context, MaterialPageRoute(builder: (_) => MenuScreen())),
            ),
            ListTile(
              leading: const Icon(Icons.shopping_cart),
              title: const Text("Cart"),
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const CartScreen())),
            ),
            ListTile(
              leading: const Icon(Icons.receipt),
              title: const Text("Orders"),
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const OrdersScreen())),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text("Profile"),
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const ProfileScreen())),
            ),
          ],
        ),
      ),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Color(0xFFFFE0B2)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(Icons.fastfood, size: 80, color: Colors.deepOrange),
              const SizedBox(height: 10),
              const Text(
                "Welcome to FoodDash!",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                "Enjoy fast food delivery 🍔🍕",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.black87),
              ),
              const SizedBox(height: 30),
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _buildHomeCard(
                    icon: Icons.restaurant_menu,
                    title: "Menu",
                    color: Colors.orange,
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => MenuScreen()));
                    },
                  ),
                  _buildHomeCard(
                    icon: Icons.shopping_cart,
                    title: "Cart",
                    color: Colors.deepOrange,
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const CartScreen()));
                    },
                  ),
                  _buildHomeCard(
                    icon: Icons.receipt,
                    title: "Orders",
                    color: Colors.orangeAccent,
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const OrdersScreen()));
                    },
                  ),
                  _buildHomeCard(
                    icon: Icons.person,
                    title: "Profile",
                    color: Colors.deepOrangeAccent,
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const ProfileScreen()));
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHomeCard({
    required IconData icon,
    required String title,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Material(
      color: color,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 40, color: Colors.white),
              const SizedBox(height: 10),
              Text(
                title,
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ),
    );
  }
}
