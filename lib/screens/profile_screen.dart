import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  static const Color _primary = Color(0xFF1E3A8A);
  static const Color _secondary = Color(0xFFF97316);
  static const Color _text = Color(0xFF0F172A);
  static const Color _muted = Color(0xFF94A3B8);
  static const Color _cardBg = Colors.white;
  static const Color _border = Color(0xFFF1F5F9);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: EdgeInsets.fromLTRB(16, MediaQuery.of(context).padding.top + 20, 16, 24),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              _buildUserInfo(),
              const SizedBox(height: 24),
              _buildStats(),
              const SizedBox(height: 24),
              _buildAccountSettings(),
              const SizedBox(height: 16),
              _buildMore(context),
              const SizedBox(height: 20),
              _buildCreateShipmentButton(),
            ]),
          ),
        ),
      ],
    );
  }


  // ─────────────────────────────────────────────
  // USER INFO
  // ─────────────────────────────────────────────
  Widget _buildUserInfo() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Avatar with camera button
        Stack(
          children: [
            CircleAvatar(
              radius: 52,
              backgroundColor: const Color(0xFFE2E8F0),
              backgroundImage: const NetworkImage(
                'https://storage.googleapis.com/uxpilot-auth.appspot.com/990ef98902-0957feadf6235b953dda.png',
              ),
            ),
            Positioned(
              bottom: 2,
              right: 2,
              child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: _secondary,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: const Icon(Icons.camera_alt_rounded, color: Colors.white, size: 14),
              ),
            ),
          ],
        ),
        const SizedBox(width: 20),
        // Name + contact + badges
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Alex Mercer',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: _text),
              ),
              const SizedBox(height: 4),
              Text(
                '+1 (555) 123-4567 • alex.m@example.com',
                style: const TextStyle(fontSize: 12, color: _muted),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  _badge(Icons.check_circle_rounded, 'Verified', const Color(0xFF16A34A), const Color(0xFFF0FDF4)),
                  const SizedBox(width: 8),
                  _badge(Icons.workspace_premium_rounded, 'Premium', _primary, const Color(0xFFEFF6FF)),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _badge(IconData icon, String label, Color color, Color bg) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(20)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: color),
          const SizedBox(width: 4),
          Text(label, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: color)),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────
  // STATS
  // ─────────────────────────────────────────────
  Widget _buildStats() {
    return Row(
      children: [
        _statCard('42', 'Total Shipments', _primary),
        const SizedBox(width: 12),
        _statCard('3', 'In Transit', _secondary),
        const SizedBox(width: 12),
        _statCard('39', 'Delivered', const Color(0xFF16A34A)),
      ],
    );
  }

  Widget _statCard(String value, String label, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 8),
        decoration: BoxDecoration(
          color: _cardBg,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: _border),
          boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 8, offset: const Offset(0, 2))],
        ),
        child: Column(
          children: [
            Text(value, style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800, color: color)),
            const SizedBox(height: 4),
            Text(
              label.toUpperCase(),
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w700, color: _muted, letterSpacing: 0.5),
            ),
          ],
        ),
      ),
    );
  }

  // ─────────────────────────────────────────────
  // ACCOUNT SETTINGS
  // ─────────────────────────────────────────────
  Widget _buildAccountSettings() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 4, bottom: 12),
          child: Text(
            'ACCOUNT SETTINGS',
            style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: _muted, letterSpacing: 0.8),
          ),
        ),
        _menuItem(icon: Icons.edit_rounded, label: 'Edit Profile', subtitle: 'Update personal details'),
        _menuItem(icon: Icons.shield_rounded, label: 'Security', subtitle: 'Manage password & 2FA'),
        _menuItem(icon: Icons.location_on_rounded, label: 'Saved Addresses', subtitle: 'Manage delivery locations'),
        _menuItem(icon: Icons.credit_card_rounded, label: 'Payment Methods', subtitle: 'Cards, wallets, and billing'),
        _menuItem(
          icon: Icons.notifications_rounded,
          label: 'Notifications',
          subtitle: 'Alerts and tracking updates',
          trailing: _toggle(true),
        ),
      ],
    );
  }

  Widget _buildMore(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 4, bottom: 12),
          child: Text(
            'MORE',
            style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: _muted, letterSpacing: 0.8),
          ),
        ),
        _menuItem(
          icon: Icons.help_rounded,
          label: 'Help & Support',
          iconBg: const Color(0xFFF1F5F9),
          iconColor: _muted,
        ),
        _menuItem(
          icon: Icons.logout_rounded,
          label: 'Logout',
          iconBg: const Color(0xFFFEF2F2),
          iconColor: const Color(0xFFEF4444),
          labelColor: const Color(0xFFEF4444),
          showChevron: false,
          onTap: () => Navigator.of(context).pushReplacementNamed('/login'),
        ),
      ],
    );
  }

  Widget _menuItem({
    required IconData icon,
    required String label,
    String? subtitle,
    Color iconBg = const Color(0xFFEFF6FF),
    Color iconColor = _primary,
    Color labelColor = _text,
    Widget? trailing,
    bool showChevron = true,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap ?? () {},
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: _cardBg,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: _border),
          boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 6, offset: const Offset(0, 2))],
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(color: iconBg, shape: BoxShape.circle),
              child: Icon(icon, size: 18, color: iconColor),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: labelColor)),
                  if (subtitle != null) ...[
                    const SizedBox(height: 2),
                    Text(subtitle, style: const TextStyle(fontSize: 11, color: _muted)),
                  ],
                ],
              ),
            ),
            trailing ??
                (showChevron
                    ? const Icon(Icons.chevron_right_rounded, color: Color(0xFFCBD5E1), size: 20)
                    : const SizedBox.shrink()),
          ],
        ),
      ),
    );
  }

  Widget _toggle(bool value) {
    return Container(
      width: 42,
      height: 24,
      decoration: BoxDecoration(
        color: value ? _primary : const Color(0xFFE2E8F0),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Align(
        alignment: value ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          width: 18,
          height: 18,
          margin: const EdgeInsets.symmetric(horizontal: 3),
          decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
        ),
      ),
    );
  }

  // ─────────────────────────────────────────────
  // CREATE SHIPMENT BUTTON
  // ─────────────────────────────────────────────
  Widget _buildCreateShipmentButton() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: _secondary,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: _secondary.withValues(alpha: 0.35), blurRadius: 20, offset: const Offset(0, 8))],
      ),
      child: TextButton.icon(
        onPressed: () {},
        icon: const Icon(Icons.inventory_2_rounded, color: Colors.white, size: 20),
        label: const Text(
          'Create New Shipment',
          style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w700),
        ),
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ),
      ),
    );
  }
}
