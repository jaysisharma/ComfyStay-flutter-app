import 'package:flutter/material.dart';

class HelpAndSupport extends StatelessWidget {
  const HelpAndSupport({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: const Text("Help & Support"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Section
            const Text(
              "How can we help you?",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            // FAQ Section
            const Text(
              "FAQs",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            _buildFAQItem(
              "How do I reset my password?",
              "Go to the settings page, click on 'Reset Password', and follow the instructions sent to your email.",
            ),
            _buildFAQItem(
              "How can I contact customer support?",
              "You can contact us through the 'Contact Us' section or email us at support@example.com.",
            ),
            _buildFAQItem(
              "Where can I find my purchase history?",
              "Go to the 'My Account' section and click on 'Order History'.",
            ),
            const Divider(height: 32),

            // Contact Us Section
            const Text(
              "Contact Us",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            ListTile(
              leading: const Icon(Icons.email, color: Colors.blue),
              title: const Text("Email"),
              subtitle: const Text("support@example.com"),
              onTap: () {
                // Add email launching logic here
              },
            ),
            ListTile(
              leading: const Icon(Icons.phone, color: Colors.green),
              title: const Text("Phone"),
              subtitle: const Text("+91 729 484 5978"),
              onTap: () {
                // Add phone launching logic here
              },
            ),
            ListTile(
              leading: const Icon(Icons.chat, color: Colors.orange),
              title: const Text("Live Chat"),
              subtitle: const Text("Available 24/7"),
              onTap: () {
                // Navigate to live chat
              },
            ),
            const Divider(height: 32),

            // Feedback Section
            const Text(
              "Submit Feedback",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              maxLines: 5,
              decoration: InputDecoration(
                hintText: "Let us know how we can improve...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Handle feedback submission
              },
              child: const Text("Submit"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFAQItem(String question, String answer) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            answer,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
