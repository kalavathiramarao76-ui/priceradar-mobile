import 'package:flutter/material.dart';
import '../services/ai_service.dart';
import '../widgets/app_widgets.dart';

class DynamicPricingScreen extends StatefulWidget {
  const DynamicPricingScreen({super.key});

  @override
  State<DynamicPricingScreen> createState() => _DynamicPricingScreenState();
}

class _DynamicPricingScreenState extends State<DynamicPricingScreen> {
  final _productController = TextEditingController();
  final _contextController = TextEditingController();
  String _selectedStrategy = 'Competitive';
  String _result = '';
  bool _isLoading = false;

  final List<Map<String, dynamic>> _strategies = [
    {'name': 'Competitive', 'icon': Icons.people_rounded, 'color': const Color(0xFF00BCD4)},
    {'name': 'Value-Based', 'icon': Icons.diamond_rounded, 'color': const Color(0xFF26C6DA)},
    {'name': 'Time-Based', 'icon': Icons.schedule_rounded, 'color': const Color(0xFF00E5FF)},
    {'name': 'Demand-Driven', 'icon': Icons.trending_up_rounded, 'color': Colors.tealAccent},
  ];

  Future<void> _generatePricing() async {
    if (_productController.text.trim().isEmpty) return;
    setState(() { _isLoading = true; _result = ''; });
    final context = 'Strategy: $_selectedStrategy\n${_contextController.text.trim()}';
    final result = await AIService.getDynamicPricing(
      _productController.text.trim(),
      context,
    );
    if (mounted) setState(() { _result = result; _isLoading = false; });
  }

  @override
  void dispose() {
    _productController.dispose();
    _contextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0E14),
      appBar: AppBar(title: const Text('Dynamic Pricing')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GlowingCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.dynamic_feed_rounded, color: Color(0xFF00E5FF)),
                      SizedBox(width: 10),
                      Text(
                        'Dynamic Pricing Engine',
                        style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'AI-optimized pricing strategies for maximum ROI',
                    style: TextStyle(color: Colors.grey[500], fontSize: 13),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            const SectionHeader(title: 'Pricing Strategy', icon: Icons.strategy),
            const SizedBox(height: 8),
            SizedBox(
              height: 50,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: _strategies.length,
                separatorBuilder: (_, __) => const SizedBox(width: 10),
                itemBuilder: (_, i) {
                  final s = _strategies[i];
                  final isSelected = _selectedStrategy == s['name'];
                  return ChoiceChip(
                    label: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(s['icon'] as IconData, size: 16, color: isSelected ? Colors.black : s['color'] as Color),
                        const SizedBox(width: 6),
                        Text(s['name'] as String),
                      ],
                    ),
                    selected: isSelected,
                    selectedColor: const Color(0xFF00BCD4),
                    backgroundColor: const Color(0xFF131920),
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.black : Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                    side: BorderSide(
                      color: isSelected ? const Color(0xFF00BCD4) : const Color(0xFF1E2A35),
                    ),
                    onSelected: (_) => setState(() => _selectedStrategy = s['name'] as String),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),

            TextField(
              controller: _productController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                hintText: 'Product or service name',
                prefixIcon: Icon(Icons.inventory_2_rounded),
              ),
            ),
            const SizedBox(height: 14),
            TextField(
              controller: _contextController,
              style: const TextStyle(color: Colors.white),
              maxLines: 3,
              decoration: const InputDecoration(
                hintText: 'Market context, target audience, competitors...',
                prefixIcon: Icon(Icons.description_rounded),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _isLoading ? null : _generatePricing,
                icon: const Icon(Icons.auto_awesome_rounded),
                label: Text(_isLoading ? 'Generating...' : 'Generate Pricing Strategy'),
              ),
            ),
            const SizedBox(height: 24),
            if (_isLoading || _result.isNotEmpty)
              AIResponseCard(response: _result, isLoading: _isLoading),
          ],
        ),
      ),
    );
  }
}
