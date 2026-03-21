import 'package:flutter/material.dart';
import '../widgets/app_widgets.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _pushNotifications = true;
  bool _priceAlerts = true;
  bool _darkMode = true;
  bool _biometrics = false;
  String _currency = 'USD';
  String _refreshInterval = '15 min';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0E14),
      appBar: AppBar(title: const Text('Settings')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Card
            GlowingCard(
              child: Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: const LinearGradient(
                        colors: [Color(0xFF00BCD4), Color(0xFF00838F)],
                      ),
                    ),
                    child: const Icon(Icons.person, color: Colors.white, size: 30),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('PriceRadar User', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700)),
                        const SizedBox(height: 4),
                        Text('Pro Plan Active', style: TextStyle(color: const Color(0xFF00BCD4), fontSize: 14)),
                      ],
                    ),
                  ),
                  const Icon(Icons.chevron_right_rounded, color: Color(0xFF00BCD4)),
                ],
              ),
            ),
            const SizedBox(height: 24),

            const SectionHeader(title: 'Notifications', icon: Icons.notifications_rounded),
            _buildToggle('Push Notifications', Icons.notifications_active_rounded, _pushNotifications, (v) => setState(() => _pushNotifications = v)),
            _buildToggle('Price Alerts', Icons.campaign_rounded, _priceAlerts, (v) => setState(() => _priceAlerts = v)),

            const SizedBox(height: 20),
            const SectionHeader(title: 'Preferences', icon: Icons.tune_rounded),
            _buildDropdown('Currency', Icons.monetization_on_rounded, _currency, ['USD', 'EUR', 'GBP', 'INR', 'JPY'], (v) => setState(() => _currency = v!)),
            _buildDropdown('Refresh Interval', Icons.refresh_rounded, _refreshInterval, ['5 min', '15 min', '30 min', '1 hour'], (v) => setState(() => _refreshInterval = v!)),

            const SizedBox(height: 20),
            const SectionHeader(title: 'App Settings', icon: Icons.settings_rounded),
            _buildToggle('Dark Mode', Icons.dark_mode_rounded, _darkMode, (v) => setState(() => _darkMode = v)),
            _buildToggle('Biometric Lock', Icons.fingerprint_rounded, _biometrics, (v) => setState(() => _biometrics = v)),

            const SizedBox(height: 20),
            const SectionHeader(title: 'About', icon: Icons.info_rounded),
            _buildInfoTile('App Version', '1.0.0', Icons.verified_rounded),
            _buildInfoTile('AI Engine', 'GPT-OSS 120B', Icons.auto_awesome_rounded),
            _buildInfoTile('API Endpoint', 'sai.sharedllm.com', Icons.cloud_rounded),

            const SizedBox(height: 30),
            Center(
              child: Text('PriceRadar v1.0.0 - AI Price Intelligence', style: TextStyle(color: Colors.grey[700], fontSize: 12)),
            ),
            const SizedBox(height: 8),
            Center(
              child: Text('Powered by SharedLLM', style: TextStyle(color: Colors.grey[700], fontSize: 12)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToggle(String title, IconData icon, bool value, Function(bool) onChanged) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: GlowingCard(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Icon(icon, color: const Color(0xFF00BCD4), size: 22),
            const SizedBox(width: 14),
            Expanded(child: Text(title, style: const TextStyle(color: Colors.white, fontSize: 15))),
            Switch(
              value: value,
              onChanged: onChanged,
              activeColor: const Color(0xFF00BCD4),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdown(String title, IconData icon, String value, List<String> options, Function(String?) onChanged) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: GlowingCard(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            Icon(icon, color: const Color(0xFF00BCD4), size: 22),
            const SizedBox(width: 14),
            Expanded(child: Text(title, style: const TextStyle(color: Colors.white, fontSize: 15))),
            DropdownButton<String>(
              value: value,
              dropdownColor: const Color(0xFF131920),
              style: const TextStyle(color: Color(0xFF00BCD4)),
              underline: const SizedBox(),
              items: options.map((o) => DropdownMenuItem(value: o, child: Text(o))).toList(),
              onChanged: onChanged,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoTile(String title, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: GlowingCard(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Icon(icon, color: const Color(0xFF00BCD4), size: 22),
            const SizedBox(width: 14),
            Text(title, style: const TextStyle(color: Colors.white, fontSize: 15)),
            const Spacer(),
            Text(value, style: TextStyle(color: Colors.grey[500], fontSize: 14)),
          ],
        ),
      ),
    );
  }
}
