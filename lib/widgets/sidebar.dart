import 'package:flutter/material.dart';
import 'logout_dialog.dart';

class Sidebar extends StatelessWidget {
  final Function(int) onMenuTap;

  const Sidebar({super.key, required this.onMenuTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260,
      color: const Color(0xFF0F2744),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),

            /// Sidebar Header
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "ACTION",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 30),

            /// Menu Items
            _menuItem(Icons.home, "Home", () => onMenuTap(0)),

            /// Activities with dropdown
            _expansionMenu(
              icon: Icons.history,
              title: "Activities",
              children: [
                _menuItem(Icons.assignment, "Recent", () => onMenuTap(1)),
                _menuItem(Icons.add, "Create", () => onMenuTap(2)), // Create page
              ],
            ),

            /// Other standalone menu items
            _menuItem(Icons.calendar_today, "Calendar", () => onMenuTap(3)),
            _menuItem(Icons.support_agent, "Tech Support", () => onMenuTap(4)),
            _menuItem(Icons.bug_report, "Bug Reports", () => onMenuTap(5)),

            const Spacer(),
            const Divider(color: Colors.white24),

            /// Logout
            _menuItem(Icons.logout, "Logout", () => showLogoutDialog(context)),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  /// Normal Menu Item
  Widget _menuItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
      leading: Icon(icon, color: Colors.white),
      title: Text(title, style: const TextStyle(color: Colors.white)),
      onTap: onTap,
    );
  }

  /// Expansion Menu for Sub-options
  Widget _expansionMenu({
    required IconData icon,
    required String title,
    required List<Widget> children,
  }) {
    return Theme(
      data: ThemeData().copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        leading: Icon(icon, color: Colors.white),
        title: Text(title, style: const TextStyle(color: Colors.white)),
        childrenPadding: const EdgeInsets.only(left: 20),
        children: children,
        iconColor: Colors.white,
        collapsedIconColor: Colors.white,
      ),
    );
  }
}