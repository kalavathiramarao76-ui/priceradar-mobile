import 'package:flutter/material.dart';
import '../services/ai_service.dart';
import '../widgets/app_widgets.dart';

class AlertsScreen extends StatefulWidget {
  const AlertsScreen({super.key});

  @override
  State<AlertsScreen> createState() => _AlertsScreenState();
}

class _AlertsScreenState extends State<AlertsScreen> {
  final _productController = TextEditingController();
  final _thresholdController = TextEditingController();
  String _result = '';
  bool _isLoading = false;

  final List<Map<String, dynamic>> _activeAlerts = [
    {'product': 'MacBook Pro M3', 'target': '\$1,799', 'current': '\$1,999', 'status': 'Watching', 'progress': 0.65},
    {'product': 'Sony WH-1000XM5', 'target': '\$279', 'current': '\$299', 'status': 'Near Target', 'progress': 0.88},
    {'product': 'iPad Air M2', 'target': '\$549', 'current': '\$599', 'status': 'Watching', 'progress': 0.72},
    {'product': 'RTX 4070 Ti', 'target': '\$699', 'current': '\$749', 'status': 'Tracking', 'progress': 0.55},
  ];

  Future<void> _createAlert() async {
    if (_productController.text.trim().isEmpty) return;
    setState(() { _isLoading = true; _result = ''; });
    final result = await AIService.generateAlert(
      _productController.text.trim(),
      _thresholdController.text.trim(),
    );
    if (mounted) setState(() { _result = result; _isLoading = false; });
  }

  @override
  void dispose() {
    _productController.dispose();
    _thresholdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0E14),
      appBar: AppBar(title: const Text('Smart Alerts')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GlowingCard(
              glowColor: Colors.tealAccent,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.notifications_active_rounded, color: Color(0xFF00E5FF)),
                      SizedBox(width: 10),
                      Text('AI Price Alerts', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700)),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text('Set intelligent alerts that predict price movements', style: TextStyle(color: Colors.grey[500], fontSize: 13)),
                ],
              ),
            ),
            const SizedBox(height: 20),

            const SectionHeader(title: 'Active Alerts', icon: Icons.notifications_rounded),
            ..._activeAlerts.map((alert) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: GlowingCard(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(alert['product'] as String, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 15)),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: (alert['progress'] as double) > 0.8
                                ? Colors.green.withOpacity(0.15)
                                : const Color(0xFF00BCD4).withOpacity(0.15),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            alert['status'] as String,
                            style: TextStyle(
                              color: (alert['progress'] as double) > 0.8 ? Colors.greenAccent : const Color(0xFF00E5FF),
                              fontSize: 12, fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Text('Current: ', style: TextStyle(color: Colors.grey[500], fontSize: 13)),
                        Text(alert['current'] as String, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                        const SizedBox(width: 20),
                        Text('Target: ', style: TextStyle(color: Colors.grey[500], fontSize: 13)),
                        Text(alert['target'] as String, style: const TextStyle(color: Color(0xFF00BCD4), fontWeight: FontWeight.w600)),
                      ],
                    ),
                    const SizedBox(height: 10),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: alert['progress'] as double,
                        backgroundColor: const Color(0xFF1E2A35),
                        valueColor: AlwaysStoppedAnimation<Color>(
                          (alert['progress'] as double) > 0.8 ? Colors.greenAccent : const Color(0xFF00BCD4),
                        ),
                        minHeight: 6,
                      ),
                    ),
                  ],
                ),
              ),
            )),

            const SizedBox(height: 20),
            const SectionHeader(title: 'Create New Alert', icon: Icons.add_alert_rounded),
            TextField(
              controller: _productController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                hintText: 'Product name',
                prefixIcon: Icon(Icons.search_rounded),
              ),
            ),
            const SizedBox(height: 14),
            TextField(
              controller: _thresholdController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                hintText: 'Target price (e.g., \$299)',
                prefixIcon: Icon(Icons.attach_money_rounded),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _isLoading ? null : _createAlert,
                icon: const Icon(Icons.add_alert_rounded),
                label: Text(_isLoading ? 'Analyzing...' : 'Create Smart Alert'),
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
