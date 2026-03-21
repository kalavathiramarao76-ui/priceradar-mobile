import 'package:flutter/material.dart';
import '../widgets/app_widgets.dart';
import 'price_analyzer_screen.dart';
import 'comparison_screen.dart';
import 'dynamic_pricing_screen.dart';
import 'alerts_screen.dart';
import 'settings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0E14),
      body: IndexedStack(
        index: _selectedIndex,
        children: const [
          _HomeContent(),
          PriceAnalyzerScreen(),
          ComparisonScreen(),
          AlertsScreen(),
          SettingsScreen(),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (i) => setState(() => _selectedIndex = i),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_rounded), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.analytics_rounded), label: 'Analyze'),
          NavigationDestination(icon: Icon(Icons.compare_arrows_rounded), label: 'Compare'),
          NavigationDestination(icon: Icon(Icons.notifications_rounded), label: 'Alerts'),
          NavigationDestination(icon: Icon(Icons.settings_rounded), label: 'Settings'),
        ],
      ),
    );
  }
}

class _HomeContent extends StatelessWidget {
  const _HomeContent();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'PriceRadar',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'AI Price Intelligence Hub',
                      style: TextStyle(color: const Color(0xFF00BCD4), fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color(0xFF131920),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFF1E2A35)),
                  ),
                  child: const Icon(Icons.radar_rounded, color: Color(0xFF00E5FF), size: 28),
                ),
              ],
            ),
            const SizedBox(height: 28),

            // Stats Row
            Row(
              children: [
                Expanded(
                  child: StatCard(
                    label: 'Products Tracked',
                    value: '2,847',
                    icon: Icons.track_changes_rounded,
                    trend: '+12.5%',
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: StatCard(
                    label: 'Avg Savings',
                    value: '23.4%',
                    icon: Icons.savings_rounded,
                    color: const Color(0xFF26C6DA),
                    trend: '+3.2%',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                Expanded(
                  child: StatCard(
                    label: 'Active Alerts',
                    value: '156',
                    icon: Icons.notifications_active_rounded,
                    color: const Color(0xFF00E5FF),
                    trend: '+8',
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: StatCard(
                    label: 'Price Drops',
                    value: '42',
                    icon: Icons.trending_down_rounded,
                    color: Colors.greenAccent,
                    trend: '+15',
                  ),
                ),
              ],
            ),

            const SizedBox(height: 28),
            const SectionHeader(title: 'Quick Actions', icon: Icons.flash_on_rounded),
            const SizedBox(height: 8),

            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 14,
              crossAxisSpacing: 14,
              childAspectRatio: 1.15,
              children: [
                FeatureButton(
                  label: 'Price\nAnalyzer',
                  icon: Icons.analytics_rounded,
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PriceAnalyzerScreen())),
                ),
                FeatureButton(
                  label: 'Product\nComparison',
                  icon: Icons.compare_arrows_rounded,
                  color: const Color(0xFF26C6DA),
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ComparisonScreen())),
                ),
                FeatureButton(
                  label: 'Dynamic\nPricing',
                  icon: Icons.dynamic_feed_rounded,
                  color: const Color(0xFF00E5FF),
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const DynamicPricingScreen())),
                ),
                FeatureButton(
                  label: 'Smart\nAlerts',
                  icon: Icons.notifications_active_rounded,
                  color: Colors.tealAccent,
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AlertsScreen())),
                ),
              ],
            ),

            const SizedBox(height: 28),
            const SectionHeader(title: 'Recent Insights', icon: Icons.lightbulb_rounded),
            const SizedBox(height: 8),

            ..._buildInsightCards(),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildInsightCards() {
    final insights = [
      {'title': 'Electronics Market Dip', 'desc': 'GPU prices dropped 15% - optimal buy window detected', 'icon': Icons.computer, 'trend': '-15%'},
      {'title': 'Grocery Inflation Alert', 'desc': 'Food category trending up 8% over last 30 days', 'icon': Icons.shopping_cart, 'trend': '+8%'},
      {'title': 'Travel Deal Detected', 'desc': 'Flight prices to Europe at 6-month low', 'icon': Icons.flight, 'trend': '-22%'},
    ];

    return insights.map((insight) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: GlowingCard(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFF00BCD4).withOpacity(0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(insight['icon'] as IconData, color: const Color(0xFF00E5FF), size: 24),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      insight['title'] as String,
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 15),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      insight['desc'] as String,
                      style: TextStyle(color: Colors.grey[500], fontSize: 13),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: (insight['trend'] as String).startsWith('-')
                      ? Colors.green.withOpacity(0.15)
                      : Colors.red.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  insight['trend'] as String,
                  style: TextStyle(
                    color: (insight['trend'] as String).startsWith('-') ? Colors.greenAccent : Colors.redAccent,
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }).toList();
  }
}
