import 'dart:convert';
import 'package:http/http.dart' as http;

class AIService {
  static const String _baseUrl = 'https://sai.sharedllm.com/v1/chat/completions';
  static const String _model = 'gpt-oss:120b';

  static Future<String> getCompletion(String systemPrompt, String userMessage) async {
    try {
      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'model': _model,
          'messages': [
            {'role': 'system', 'content': systemPrompt},
            {'role': 'user', 'content': userMessage},
          ],
          'max_tokens': 2048,
          'temperature': 0.7,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['choices'][0]['message']['content'] ?? 'No response generated.';
      } else {
        return 'Error: Server returned status ${response.statusCode}. Please try again.';
      }
    } catch (e) {
      return 'Connection error. Please check your internet and try again.';
    }
  }

  static Future<String> analyzePrice(String product, String details) async {
    return getCompletion(
      'You are PriceRadar AI, an expert price analyst. Provide detailed price analysis with market trends, fair value estimates, and buy/sell recommendations. Use data-driven insights with specific numbers and percentages. Format with clear sections using bullet points.',
      'Analyze the price for: $product\n\nDetails: $details',
    );
  }

  static Future<String> compareProducts(String product1, String product2) async {
    return getCompletion(
      'You are PriceRadar AI, a product comparison expert. Compare products across price, value, features, and market positioning. Create a structured comparison with pros/cons for each. Include a final recommendation.',
      'Compare these products:\n1. $product1\n2. $product2',
    );
  }

  static Future<String> getDynamicPricing(String product, String context) async {
    return getCompletion(
      'You are PriceRadar AI, a dynamic pricing strategist. Analyze market conditions and suggest optimal pricing strategies. Include demand elasticity insights, competitive pricing ranges, and time-based pricing recommendations.',
      'Generate dynamic pricing strategy for: $product\n\nContext: $context',
    );
  }

  static Future<String> generateAlert(String product, String threshold) async {
    return getCompletion(
      'You are PriceRadar AI, a price alert analyst. Analyze price trends and predict when prices might cross specified thresholds. Provide probability estimates and recommended alert configurations.',
      'Set up price alert analysis for: $product\nPrice threshold: $threshold',
    );
  }
}
