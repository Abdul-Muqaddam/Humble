import 'package:flutter/material.dart';

class AlertsScreen extends StatelessWidget {
  const AlertsScreen({super.key});

  static const Color _primary = Color(0xFF1E3A8A);
  static const Color _secondary = Color(0xFFF97316);
  static const Color _text = Color(0xFF0F172A);
  static const Color _muted = Color(0xFF94A3B8);
  static const Color _border = Color(0xFFE2E8F0);
  static const Color _surface = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ── Header ──────────────────────────────────────────────────────────
        Container(
          color: _surface,
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top + 16,
            left: 20,
            right: 20,
            bottom: 20,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Notifications',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: _primary,
                  letterSpacing: -0.5,
                ),
              ),
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  foregroundColor: _secondary,
                  overlayColor: _secondary.withValues(alpha: 0.1),
                ),
                child: const Text(
                  'Mark all as read',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
                ),
              ),
            ],
          ),
        ),

        // ── Alerts List ─────────────────────────────────────────────────────
        Expanded(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 120),
            children: [
              _buildSectionHeader('TODAY'),
              _buildAlertCard(
                icon: Icons.local_shipping_rounded,
                iconBg: const Color(0xFFEFF6FF),
                iconColor: _primary,
                title: 'Shipment #HB-8237 is out for delivery',
                time: '2h ago',
                isNew: true,
              ),
              _buildAlertCard(
                icon: Icons.check_circle_rounded,
                iconBg: const Color(0xFFF0FDF4),
                iconColor: const Color(0xFF16A34A),
                title: 'Your profile has been successfully verified',
                time: '5h ago',
                isNew: true,
              ),
              const SizedBox(height: 24),
              _buildSectionHeader('YESTERDAY'),
              _buildAlertCard(
                icon: Icons.notifications_active_rounded,
                iconBg: const Color(0xFFFFF7ED),
                iconColor: _secondary,
                title: 'New discount alert: 20% off international',
                time: '1d ago',
                isNew: false,
              ),
              _buildAlertCard(
                icon: Icons.location_on_rounded,
                iconBg: const Color(0xFFEFF6FF),
                iconColor: _primary,
                title: 'Address updated: Los Angeles branch',
                time: '1d ago',
                isNew: false,
              ),
              _buildAlertCard(
                icon: Icons.credit_card_rounded,
                iconBg: const Color(0xFFF1F5F9),
                iconColor: _muted,
                title: 'Payment method "Visa **** 4492" added',
                time: '1d ago',
                isNew: false,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 16),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w800,
          color: _muted,
          letterSpacing: 1.0,
        ),
      ),
    );
  }

  Widget _buildAlertCard({
    required IconData icon,
    required Color iconBg,
    required Color iconColor,
    required String title,
    required String time,
    required bool isNew,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _border.withValues(alpha: 0.7)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          const SizedBox(width: 16),
          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      time,
                      style: const TextStyle(fontSize: 11, color: _muted, fontWeight: FontWeight.w500),
                    ),
                    if (isNew)
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: _secondary,
                          shape: BoxShape.circle,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: isNew ? FontWeight.w700 : FontWeight.w600,
                    color: _text,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
