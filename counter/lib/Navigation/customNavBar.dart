import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final VoidCallback onAddPressed;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.onAddPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(

      color: Colors.transparent,
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.bottomCenter,
        children: [
          // White Rounded Navigation Bar Background
          Container(
            height: 70,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(35),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Index 0: Home[cite: 1]
                _buildNavItem(Icons.home_rounded, 'Home', 0),
                
                // Index 1: Transactions[cite: 1]
                _buildNavItem(Icons.account_balance_wallet_outlined, 'Transactions', 1),
                
                const SizedBox(width: 48), // Spacer gap for center button
                
                // Index 2: Budget[cite: 1]
                _buildNavItem(Icons.assignment_outlined, 'Budget', 2),
                
                // Index 3: Profile[cite: 1]
                _buildNavItem(Icons.person_outline_rounded, 'Profile', 3),
              ],
            ),
          ),
          
          // Center Floating Plus Button[cite: 1]
          Positioned(
            top: -18,
            child: Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: Colors.indigo,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.indigo.withOpacity(0.4),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: IconButton(
                icon: const Icon(Icons.add, color: Colors.white, size: 28),
                onPressed: onAddPressed,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    final isSelected = currentIndex == index;
    final color = isSelected ? Colors.indigo : Colors.grey[400];

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => onTap(index),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 22),
            const SizedBox(height: 3),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 11,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}