import 'package:flutter/material.dart';
import 'profile_screen.dart';
import 'shipments_screen.dart';
import 'alerts_screen.dart';
import 'shipping_calculator_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // ── Brand Colors ──────────────────────────────────────────────────────────
  static const Color _primary = Color(0xFF1E3A8A);
  static const Color _secondary = Color(0xFFF97316);
  static const Color _surface = Colors.white;
  static const Color _background = Color(0xFFF8FAFC);
  static const Color _text = Color(0xFF0F172A);
  static const Color _muted = Color(0xFF94A3B8);
  static const Color _border = Color(0xFFE2E8F0);

  int _selectedNavIndex = 0;
  late PageController _pageController;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _selectedNavIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _onNavTap(int index) {
    setState(() {
      _selectedNavIndex = index;
    });
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _background,
      body: Stack(
        children: [
          // ── Horizontal Pager ─────────────────────────────────────────────
          PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _selectedNavIndex = index;
              });
            },
            children: [
              _buildHomeTab(),
              const ShipmentsScreen(),
              const SizedBox.shrink(), // Center FAB placeholder
              const AlertsScreen(),
              const ProfileScreen(),
            ],
          ),

          // ── Bottom Navigation Bar (always on top) ─────────────────────────
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: _buildBottomNav(),
          ),
        ],
      ),
    );
  }

  Widget _buildHomeTab() {
    return CustomScrollView(
      slivers: [
        // Header (pinned)
        SliverToBoxAdapter(child: _buildHeader()),
        // Main content
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 120),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              _buildQuickActions(),
              const SizedBox(height: 28),
              _buildRecentShipments(),
              const SizedBox(height: 28),
              _buildPromo(),
            ]),
          ),
        ),
      ],
    );
  }

  // ──────────────────────────────────────────────────────────────────────────
  // HEADER
  // ──────────────────────────────────────────────────────────────────────────
  Widget _buildHeader() {
    return Container(
      decoration: BoxDecoration(
        color: _surface,
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(32)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 16,
        left: 20,
        right: 20,
        bottom: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top row: logo + avatar
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Logo
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: _primary,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.local_shipping_rounded,
                      color: Colors.white,
                      size: 22,
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'Humble',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: _primary,
                      letterSpacing: -0.5,
                    ),
                  ),
                ],
              ),
              // Avatar with online dot
              Stack(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: _border,
                    backgroundImage: const NetworkImage(
                      'https://storage.googleapis.com/uxpilot-auth.appspot.com/70e3e454b0-f07b245e49d1dbbf08ae.png',
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 11,
                      height: 11,
                      decoration: BoxDecoration(
                        color: const Color(0xFF22C55E),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Greeting
          const Text(
            'Welcome, Alex! 👋',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: _text,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            'Manage your shipments efficiently.',
            style: TextStyle(fontSize: 13, color: _muted, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 20),

          // Search bar
          _buildSearchBar(),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: _background,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _border),
      ),
      child: Row(
        children: [
          const SizedBox(width: 14),
          Icon(Icons.search_rounded, color: _muted, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: _searchController,
              style: const TextStyle(fontSize: 13, color: _text),
              decoration: InputDecoration(
                hintText: 'Track shipment by ID...',
                hintStyle: TextStyle(color: _muted, fontSize: 13),
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
                isDense: true,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(6),
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: _primary,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.arrow_forward_rounded, color: Colors.white, size: 18),
          ),
        ],
      ),
    );
  }

  // ──────────────────────────────────────────────────────────────────────────
  // QUICK ACTIONS
  // ──────────────────────────────────────────────────────────────────────────
  Widget _buildQuickActions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Quick Actions',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: _text),
        ),
        const SizedBox(height: 14),
        Row(
          children: [
            Expanded(child: _actionCard(
              icon: Icons.calculate_outlined,
              iconBg: const Color(0xFFEFF6FF),
              iconColor: _primary,
              accentColor: _primary,
              label: 'Calculator',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ShippingCalculatorScreen()),
                );
              },
            )),
            const SizedBox(width: 12),
            Expanded(child: _actionCard(
              icon: Icons.inventory_2_rounded,
              label: 'New Booking',
              iconBg: const Color(0xFFFFF7ED),
              iconColor: _secondary,
              accentColor: _secondary,
            )),
          ],
        ),
        const SizedBox(height: 12),
        _trackingCard(),
      ],
    );
  }

  Widget _actionCard({
    required IconData icon,
    required String label,
    required Color iconBg,
    required Color iconColor,
    required Color accentColor,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: _surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: _border.withValues(alpha: 0.7)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: iconBg,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: iconColor, size: 24),
            ),
            const SizedBox(height: 14),
            Text(
              label,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: _text,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _trackingCard() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: _surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: _border.withValues(alpha: 0.7)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: const Color(0xFFEFF6FF),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.location_on_rounded, color: _primary, size: 26),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Live Tracking',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: _text),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Track your active shipments',
                    style: TextStyle(fontSize: 12, color: _muted),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right_rounded, color: _muted),
          ],
        ),
      ),
    );
  }

  // ──────────────────────────────────────────────────────────────────────────
  // RECENT SHIPMENTS
  // ──────────────────────────────────────────────────────────────────────────
  Widget _buildRecentShipments() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Recent Shipments',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: _text),
            ),
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                foregroundColor: _primary,
                padding: EdgeInsets.zero,
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: const Text('View All', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
            ),
          ],
        ),
        const SizedBox(height: 14),
        _shipmentCard1(),
        const SizedBox(height: 12),
        _shipmentCard2(),
      ],
    );
  }

  // In Transit card
  Widget _shipmentCard1() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _border.withValues(alpha: 0.7)),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 10, offset: const Offset(0, 2))
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF7ED),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.local_shipping_rounded, color: _secondary, size: 18),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('#HB-823723513', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13, color: _text)),
                    const SizedBox(height: 2),
                    Text('Electronics • 12kg', style: TextStyle(fontSize: 12, color: _muted)),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: const Color(0xFFEFF6FF),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text('In Transit', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: _primary)),
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Progress indicator
          _buildShipmentProgress(
            stops: ['NY', 'CHI', 'LA'],
            currentIndex: 1,
          ),
        ],
      ),
    );
  }

  Widget _buildShipmentProgress({required List<String> stops, required int currentIndex}) {
    return Row(
      children: List.generate(stops.length, (i) {
        final isActive = i == currentIndex;
        final isPast = i < currentIndex;
        final isLast = i == stops.length - 1;

        return Expanded(
          child: Row(
            children: [
              // Line before dot (except first)
              if (i > 0)
                Expanded(
                  child: Container(
                    height: 2,
                    color: isPast ? _primary : _border,
                  ),
                ),
              Column(
                children: [
                  Container(
                    width: isActive ? 16 : 12,
                    height: isActive ? 16 : 12,
                    decoration: BoxDecoration(
                      color: isPast || isActive ? _primary : _border,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                      boxShadow: [if (isActive) BoxShadow(color: _primary.withValues(alpha: 0.4), blurRadius: 6)],
                    ),
                    child: isActive
                        ? const Center(child: SizedBox(width: 5, height: 5, child: DecoratedBox(decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle))))
                        : null,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    stops[i],
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                      color: isActive ? _primary : _muted,
                    ),
                  ),
                ],
              ),
              // Line after dot (if not last)
              if (!isLast)
                Expanded(
                  child: Container(
                    height: 2,
                    color: isActive || isPast ? _primary : _border,
                  ),
                ),
            ],
          ),
        );
      }),
    );
  }

  // Delivered card
  Widget _shipmentCard2() {
    return Opacity(
      opacity: 0.80,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: _surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: _border.withValues(alpha: 0.7)),
          boxShadow: [
            BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 10, offset: const Offset(0, 2))
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: const Color(0xFFF0FDF4),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.check_box_rounded, color: Color(0xFF16A34A), size: 18),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('#HB-912873645', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13, color: _text)),
                  const SizedBox(height: 2),
                  Text('Documents • 0.5kg', style: TextStyle(fontSize: 12, color: _muted)),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: const Color(0xFFF0FDF4),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text('Delivered', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Color(0xFF16A34A))),
            ),
          ],
        ),
      ),
    );
  }

  // ──────────────────────────────────────────────────────────────────────────
  // PROMO BANNER
  // ──────────────────────────────────────────────────────────────────────────
  Widget _buildPromo() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _primary,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: _primary.withValues(alpha: 0.4),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        children: [
          // decorative circle
          Positioned(
            right: -20,
            top: -20,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.08),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Save 20% on International',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  height: 1.3,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Book your international cargo today\nand enjoy premium rates.',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.8),
                  fontSize: 13,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: _primary,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  elevation: 0,
                ),
                child: const Text('Book Now', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ──────────────────────────────────────────────────────────────────────────
  // BOTTOM NAV
  // ──────────────────────────────────────────────────────────────────────────
  Widget _buildBottomNav() {
    return Container(
      decoration: BoxDecoration(
        color: _surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 24,
            offset: const Offset(0, -8),
          ),
        ],
      ),
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 14,
        bottom: MediaQuery.of(context).padding.bottom + 12,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _navItem(icon: Icons.grid_view_rounded, activeIcon: Icons.grid_view_rounded, label: 'Home', index: 0),
          _navItem(icon: Icons.local_shipping_outlined, activeIcon: Icons.local_shipping_rounded, label: 'Track', index: 1),
          // FAB center button
          GestureDetector(
            onTap: () {},
            child: Container(
              width: 54,
              height: 54,
              decoration: BoxDecoration(
                color: _secondary,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: _secondary.withValues(alpha: 0.4),
                    blurRadius: 16,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: const Icon(Icons.add_rounded, color: Colors.white, size: 32),
            ),
          ),
          _navItemWithBadge(icon: Icons.notifications_none_rounded, activeIcon: Icons.notifications_rounded, label: 'Alerts', index: 3),
          _navItem(icon: Icons.person_outline_rounded, activeIcon: Icons.person_rounded, label: 'Profile', index: 4),
        ],
      ),
    );
  }

  Widget _navItem({required IconData icon, required IconData activeIcon, required String label, required int index}) {
    final bool isActive = _selectedNavIndex == index;
    return GestureDetector(
      onTap: () => _onNavTap(index),
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 60,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isActive ? activeIcon : icon, 
              size: 26, 
              color: isActive ? _primary : _muted.withValues(alpha: 0.7),
            ),
            const SizedBox(height: 6),
            if (isActive)
              Container(
                width: 4,
                height: 4,
                decoration: const BoxDecoration(
                  color: _primary,
                  shape: BoxShape.circle,
                ),
              )
            else
              const SizedBox(height: 4),
          ],
        ),
      ),
    );
  }

  Widget _navItemWithBadge({required IconData icon, required IconData activeIcon, required String label, required int index}) {
    final bool isActive = _selectedNavIndex == index;
    return GestureDetector(
      onTap: () => _onNavTap(index),
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 60,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Icon(
                  isActive ? activeIcon : icon, 
                  size: 26, 
                  color: isActive ? _primary : _muted.withValues(alpha: 0.7),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    width: 7,
                    height: 7,
                    decoration: BoxDecoration(
                      color: _secondary,
                      shape: BoxShape.circle,
                      border: Border.all(color: _surface, width: 1.5),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            if (isActive)
              Container(
                width: 4,
                height: 4,
                decoration: const BoxDecoration(
                  color: _primary,
                  shape: BoxShape.circle,
                ),
              )
            else
              const SizedBox(height: 4),
          ],
        ),
      ),
    );
  }
}
