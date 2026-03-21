import 'package:flutter/material.dart';
import '../services/ai_service.dart';
import '../widgets/app_widgets.dart';

class PriceAnalyzerScreen extends StatefulWidget {
  const PriceAnalyzerScreen({super.key});

  @override
  State<PriceAnalyzerScreen> createState() => _PriceAnalyzerScreenState();
}

class _PriceAnalyzerScreenState extends State<PriceAnalyzerScreen> {
  final _productController = TextEditingController();
  final _detailsController = TextEditingController();
  String _result = '';
  bool _isLoading = false;

  Future<void> _analyze() async {
    if (_productController.text.trim().isEmpty) return;
    setState(() { _isLoading = true; _result = ''; });
    final result = await AIService.analyzePrice(
      _productController.text.trim(),
      _detailsController.text.trim(),
    );
    if (mounted) setState(() { _result = result; _isLoading = false; });
  }

  @override
  void dispose() {
    _productController.dispose();
    _detailsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0E14),
      appBar: AppBar(title: const Text('Price Analyzer')),
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
                      Icon(Icons.analytics_rounded, color: Color(0xFF00E5FF)),
                      SizedBox(width: 10),
                      Text(
                        'Analyze Product Price',
                        style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Enter a product to get AI-powered price insights',
                    style: TextStyle(color: Colors.grey[500], fontSize: 13),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _productController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                hintText: 'Product name (e.g., iPhone 15 Pro)',
                prefixIcon: Icon(Icons.search_rounded),
              ),
            ),
            const SizedBox(height: 14),
            TextField(
              controller: _detailsController,
              style: const TextStyle(color: Colors.white),
              maxLines: 3,
              decoration: const InputDecoration(
                hintText: 'Additional details (region, variant, etc.)',
                prefixIcon: Icon(Icons.info_outline_rounded),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _isLoading ? null : _analyze,
                icon: const Icon(Icons.radar_rounded),
                label: Text(_isLoading ? 'Analyzing...' : 'Analyze Price'),
              ),
            ),
            const SizedBox(height: 24),
            if (_isLoading || _result.isNotEmpty)
              AIResponseCard(response: _result, isLoading: _isLoading),

            const SizedBox(height: 24),
            const SectionHeader(title: 'Popular Searches', icon: Icons.trending_up_rounded),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: ['iPhone 15', 'MacBook Pro', 'PS5', 'RTX 4090', 'Tesla Model 3', 'AirPods Pro'].map((tag) {
                return ActionChip(
                  label: Text(tag),
                  labelStyle: const TextStyle(color: Color(0xFF00BCD4), fontSize: 13),
                  backgroundColor: const Color(0xFF131920),
                  side: const BorderSide(color: Color(0xFF1E2A35)),
                  onPressed: () {
                    _productController.text = tag;
                    _analyze();
                  },
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
