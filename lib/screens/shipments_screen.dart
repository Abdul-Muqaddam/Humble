import 'package:flutter/material.dart';

class ShipmentsScreen extends StatefulWidget {
  const ShipmentsScreen({super.key});

  @override
  State<ShipmentsScreen> createState() => _ShipmentsScreenState();
}

class _ShipmentsScreenState extends State<ShipmentsScreen> with SingleTickerProviderStateMixin {
  static const Color _primary = Color(0xFF1E3A8A);
  static const Color _secondary = Color(0xFFF97316);
  static const Color _text = Color(0xFF0F172A);
  static const Color _muted = Color(0xFF94A3B8);
  static const Color _border = Color(0xFFE2E8F0);
  static const Color _background = Color(0xFFF8FAFC);
  static const Color _surface = Colors.white;

  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

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
            bottom: 8,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'My Shipments',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: _primary,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 16),
              // Search Bar
              Container(
                height: 48,
                decoration: BoxDecoration(
                  color: _background,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: _border),
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 14),
                    const Icon(Icons.search_rounded, color: _muted, size: 20),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        style: const TextStyle(fontSize: 13, color: _text),
                        decoration: const InputDecoration(
                          hintText: 'Search shipment ID or destination...',
                          hintStyle: TextStyle(color: _muted, fontSize: 13),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.zero,
                          isDense: true,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              // Custom TabBar
              TabBar(
                controller: _tabController,
                indicatorColor: _secondary,
                indicatorWeight: 3,
                labelColor: _primary,
                unselectedLabelColor: _muted,
                labelStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
                unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                tabs: const [
                  Tab(text: 'All'),
                  Tab(text: 'Active'),
                  Tab(text: 'Completed'),
                ],
              ),
            ],
          ),
        ),

        // ── Shipments List ──────────────────────────────────────────────────
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              _buildShipmentList('all'),
              _buildShipmentList('active'),
              _buildShipmentList('completed'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildShipmentList(String filter) {
    // Mock data based on the design aesthetic
    final List<Map<String, dynamic>> mockShipments = [
      {
        'id': '#HB-823723513',
        'type': 'Electronics',
        'weight': '12.5kg',
        'status': 'In Transit',
        'statusColor': _primary,
        'statusBg': const Color(0xFFEFF6FF),
        'from': 'New York, US',
        'to': 'Los Angeles, US',
        'progress': 0.65,
      },
      {
        'id': '#HB-912873645',
        'type': 'Documents',
        'weight': '0.5kg',
        'status': 'Delivered',
        'statusColor': const Color(0xFF16A34A),
        'statusBg': const Color(0xFFF0FDF4),
        'from': 'London, UK',
        'to': 'Paris, FR',
        'progress': 1.0,
      },
      {
        'id': '#HB-734291082',
        'type': 'Furniture',
        'weight': '45.0kg',
        'status': 'Processing',
        'statusColor': _secondary,
        'statusBg': const Color(0xFFFFF7ED),
        'from': 'Berlin, DE',
        'to': 'Madrid, ES',
        'progress': 0.15,
      },
    ];

    final filteredShipments = mockShipments.where((s) {
      if (filter == 'active') return s['status'] != 'Delivered';
      if (filter == 'completed') return s['status'] == 'Delivered';
      return true;
    }).toList();

    if (filteredShipments.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.inventory_2_outlined, size: 64, color: _border),
            const SizedBox(height: 16),
            Text(
              'No shipments found',
              style: TextStyle(color: _muted, fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      itemCount: filteredShipments.length,
      separatorBuilder: (_, index) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        final shipment = filteredShipments[index];
        return _buildShipmentCard(shipment);
      },
    );
  }

  Widget _buildShipmentCard(Map<String, dynamic> shipment) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: _border.withValues(alpha: 0.7)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Row: ID + Status
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    shipment['id'],
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 16,
                      color: _text,
                      letterSpacing: -0.2,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${shipment['type']} • ${shipment['weight']}',
                    style: const TextStyle(fontSize: 12, color: _muted, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: shipment['statusBg'],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  shipment['status'],
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: shipment['statusColor'],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Route info
          Row(
            children: [
              Column(
                children: [
                  const Icon(Icons.circle, size: 8, color: _primary),
                  Container(width: 2, height: 24, color: _border),
                  const Icon(Icons.location_on_rounded, size: 14, color: _secondary),
                ],
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      shipment['from'],
                      style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: _text),
                    ),
                    const SizedBox(height: 14),
                    Text(
                      shipment['to'],
                      style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: _text),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Progress bar
          Stack(
            children: [
              Container(
                height: 6,
                decoration: BoxDecoration(
                  color: _border,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
              FractionallySizedBox(
                widthFactor: shipment['progress'],
                child: Container(
                  height: 6,
                  decoration: BoxDecoration(
                    color: shipment['statusColor'],
                    borderRadius: BorderRadius.circular(3),
                    boxShadow: [
                      BoxShadow(
                        color: (shipment['statusColor'] as Color).withValues(alpha: 0.3),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
