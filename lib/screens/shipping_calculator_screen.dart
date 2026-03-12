import 'package:flutter/material.dart';

class ShippingCalculatorScreen extends StatefulWidget {
  const ShippingCalculatorScreen({super.key});

  @override
  State<ShippingCalculatorScreen> createState() => _ShippingCalculatorScreenState();
}

class _ShippingCalculatorScreenState extends State<ShippingCalculatorScreen> {
  static const Color _primary = Color(0xFF1E3A8A);
  static const Color _secondary = Color(0xFFF97316);
  static const Color _text = Color(0xFF0F172A);
  static const Color _muted = Color(0xFF94A3B8);
  static const Color _background = Color(0xFFF8FAFC);
  static const Color _surface = Colors.white;

  bool _showResult = false;
  String _selectedSize = 'Small';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _background,
      body: Column(
        children: [
          // ── Header ──────────────────────────────────────────────────────────
          Container(
            color: _surface,
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 8,
              bottom: 16,
              left: 8,
              right: 20,
            ),
            child: Row(
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back_rounded, color: _text),
                ),
                const Text(
                  'Shipping Calculator',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: _text,
                    letterSpacing: -0.5,
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (!_showResult) _buildForm() else _buildResult(),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Location Inputs
        _buildInputField(
          icon: Icons.location_on_rounded,
          iconColor: _primary,
          hint: 'Sending From',
        ),
        const SizedBox(height: 16),
        _buildInputField(
          icon: Icons.map_rounded, // Using map-pin equivalent
          iconColor: _secondary,
          hint: 'Sending To',
        ),
        const SizedBox(height: 24),

        // Package Details (Weight)
        const Text(
          'Package Details',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Color(0xFF64748B)),
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: _surface,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 10, offset: const Offset(0, 4)),
            ],
          ),
          child: Row(
            children: [
              const Expanded(
                child: TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Weight',
                    hintStyle: TextStyle(color: _muted),
                    contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    border: InputBorder.none,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                height: 60,
                decoration: const BoxDecoration(
                  color: Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.horizontal(right: Radius.circular(20)),
                ),
                alignment: Alignment.center,
                child: const Text('KG', style: TextStyle(fontWeight: FontWeight.w700, color: Color(0xFF64748B))),
              ),
            ],
          ),
        ),

        const SizedBox(height: 24),

        // Dimensions
        const Text(
          'Dimensions (cm)',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Color(0xFF64748B)),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(child: _buildDimensionInput('Length')),
            const SizedBox(width: 12),
            Expanded(child: _buildDimensionInput('Width')),
            const SizedBox(width: 12),
            Expanded(child: _buildDimensionInput('Height')),
          ],
        ),

        const SizedBox(height: 24),

        // Parcel Size
        const Text(
          'Parcel Size',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Color(0xFF64748B)),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(child: _buildSizeOption('Small')),
            const SizedBox(width: 12),
            Expanded(child: _buildSizeOption('Medium')),
            const SizedBox(width: 12),
            Expanded(child: _buildSizeOption('Large')),
          ],
        ),

        const SizedBox(height: 40),

        // Calculate Button
        SizedBox(
          width: double.infinity,
          height: 62,
          child: ElevatedButton(
            onPressed: () => setState(() => _showResult = true),
            style: ElevatedButton.styleFrom(
              backgroundColor: _primary,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              elevation: 0,
            ),
            child: const Text('Calculate', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
          ),
        ),
      ],
    );
  }

  Widget _buildResult() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: _surface,
            borderRadius: BorderRadius.circular(28),
            boxShadow: [
              BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 20, offset: const Offset(0, 8)),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Shipping Details',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: _text),
              ),
              const SizedBox(height: 24),
              _buildResultRow(icon: Icons.route_rounded, iconBg: Color(0xFFEFF6FF), iconColor: _primary, label: 'Distance', value: '5,842 km'),
              _divider(),
              _buildResultRow(icon: Icons.timer_outlined, iconBg: Color(0xFFFFF7ED), iconColor: _secondary, label: 'Estimated Time', value: '3-5 Days'),
              _divider(),
              _buildResultRow(icon: Icons.inventory_2_outlined, iconBg: Color(0xFFEFF6FF), iconColor: _primary, label: 'Dimensions', value: '30×20×15 cm'),
              _divider(),
              _buildResultRow(icon: Icons.monitor_weight_outlined, iconBg: Color(0xFFEFF6FF), iconColor: _primary, label: 'Weight', value: '5 KG'),
            ],
          ),
        ),
        const SizedBox(height: 32),
        // Book Button
        SizedBox(
          width: double.infinity,
          height: 62,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: _secondary,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              elevation: 0,
            ),
            child: const Text('Book Shipment', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
          ),
        ),
        const SizedBox(height: 16),
        Center(
          child: TextButton(
            onPressed: () => setState(() => _showResult = false),
            child: const Text('Recalculate', style: TextStyle(color: _primary, fontWeight: FontWeight.w700)),
          ),
        ),
      ],
    );
  }

  Widget _buildInputField({required IconData icon, required Color iconColor, required String hint}) {
    return Container(
      decoration: BoxDecoration(
        color: _surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: _muted),
          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Icon(icon, color: iconColor),
          ),
          prefixIconConstraints: const BoxConstraints(minWidth: 40),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 20),
        ),
      ),
    );
  }

  Widget _buildDimensionInput(String hint) {
    return Container(
      decoration: BoxDecoration(
        color: _surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.02), blurRadius: 8, offset: const Offset(0, 4)),
        ],
      ),
      child: TextField(
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: _muted, fontSize: 13),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 20),
        ),
      ),
    );
  }

  Widget _buildSizeOption(String label) {
    final bool isSelected = _selectedSize == label;
    return GestureDetector(
      onTap: () => setState(() => _selectedSize = label),
      child: Container(
        height: 52,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? _primary.withValues(alpha: 0.05) : _surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? _primary : const Color(0xFFE2E8F0),
            width: isSelected ? 2 : 1.5,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
            color: isSelected ? _primary : const Color(0xFF64748B),
          ),
        ),
      ),
    );
  }

  Widget _buildResultRow({required IconData icon, required Color iconBg, required Color iconColor, required String label, required String value}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(color: iconBg, borderRadius: BorderRadius.circular(14)),
                child: Icon(icon, color: iconColor, size: 20),
              ),
              const SizedBox(width: 16),
              Text(label, style: const TextStyle(fontSize: 14, color: Color(0xFF64748B), fontWeight: FontWeight.w500)),
            ],
          ),
          Text(value, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: _text)),
        ],
      ),
    );
  }

  Widget _divider() => const Divider(color: Color(0xFFF1F5F9), height: 1);
}
