import 'package:flutter/material.dart';
import '../services/ai_service.dart';
import '../widgets/app_widgets.dart';

class ComparisonScreen extends StatefulWidget {
  const ComparisonScreen({super.key});

  @override
  State<ComparisonScreen> createState() => _ComparisonScreenState();
}

class _ComparisonScreenState extends State<ComparisonScreen> {
  final _product1Controller = TextEditingController();
  final _product2Controller = TextEditingController();
  String _result = '';
  bool _isLoading = false;

  Future<void> _compare() async {
    if (_product1Controller.text.trim().isEmpty || _product2Controller.text.trim().isEmpty) return;
    setState(() { _isLoading = true; _result = ''; });
    final result = await AIService.compareProducts(
      _product1Controller.text.trim(),
      _product2Controller.text.trim(),
    );
    if (mounted) setState(() { _result = result; _isLoading = false; });
  }

  @override
  void dispose() {
    _product1Controller.dispose();
    _product2Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0E14),
      appBar: AppBar(title: const Text('Product Comparison')),
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
                      Icon(Icons.compare_arrows_rounded, color: Color(0xFF00E5FF)),
                      SizedBox(width: 10),
                      Text(
                        'Compare Products',
                        style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'AI-powered side-by-side product analysis',
                    style: TextStyle(color: Colors.grey[500], fontSize: 13),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            GlowingCard(
              glowColor: const Color(0xFF26C6DA),
              child: Column(
                children: [
                  TextField(
                    controller: _product1Controller,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      hintText: 'Product 1 (e.g., iPhone 15 Pro)',
                      prefixIcon: Icon(Icons.looks_one_rounded),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(child: Divider(color: const Color(0xFF1E2A35))),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: const Color(0xFF00BCD4).withOpacity(0.15),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.swap_vert_rounded, color: Color(0xFF00E5FF), size: 20),
                        ),
                      ),
                      Expanded(child: Divider(color: const Color(0xFF1E2A35))),
                    ],
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _product2Controller,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      hintText: 'Product 2 (e.g., Samsung S24 Ultra)',
                      prefixIcon: Icon(Icons.looks_two_rounded),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _isLoading ? null : _compare,
                icon: const Icon(Icons.compare_rounded),
                label: Text(_isLoading ? 'Comparing...' : 'Compare Products'),
              ),
            ),
            const SizedBox(height: 24),
            if (_isLoading || _result.isNotEmpty)
              AIResponseCard(response: _result, isLoading: _isLoading),

            const SizedBox(height: 24),
            const SectionHeader(title: 'Popular Comparisons', icon: Icons.star_rounded),
            ...[
              ['iPhone 15 Pro', 'Samsung S24 Ultra'],
              ['MacBook Air M3', 'Dell XPS 15'],
              ['PS5', 'Xbox Series X'],
            ].map((pair) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: InkWell(
                onTap: () {
                  _product1Controller.text = pair[0];
                  _product2Controller.text = pair[1];
                  _compare();
                },
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  decoration: BoxDecoration(
                    color: const Color(0xFF131920),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFF1E2A35)),
                  ),
                  child: Row(
                    children: [
                      Text(pair[0], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                      const Spacer(),
                      const Icon(Icons.compare_arrows, color: Color(0xFF00BCD4), size: 18),
                      const Spacer(),
                      Text(pair[1], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }
}
