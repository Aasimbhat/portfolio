import 'package:flutter/material.dart';

import '../widgets/buttons.dart';
import '../widgets/form_widgets.dart';
import '../widgets/neon_text.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  final Map<String, TextEditingController> _controllers = {
    'name': TextEditingController(),
    'email': TextEditingController(),
    'subject': TextEditingController(),
    'message': TextEditingController(),
  };

  @override
  void dispose() {
    _controllers.forEach((_, controller) => controller.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 100, bottom: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: NeonText(
              'Get In Touch',
              color: Theme.of(context).colorScheme.primary,
              fontSize: 42,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              'Let\'s create something amazing together',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white.withOpacity(0.7),
              ),
            ),
          ),
          const SizedBox(height: 60),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: ContactForm(controllers: _controllers),
                  ),
                  const SizedBox(width: 60),
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        ContactInfoCard(
                          title: 'Email Address',
                          info: 'asimbhat799@gmail.com',
                          icon: Icons.email,
                        ),
                        SizedBox(height: 24),
                        ContactInfoCard(
                          title: 'Location',
                          info: 'Srinagar, Jammu & Kashmir, India',
                          icon: Icons.location_on,
                        ),
                        SizedBox(height: 40),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ContactForm extends StatelessWidget {
  final Map<String, TextEditingController> controllers;

  const ContactForm({super.key, required this.controllers});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.black.withOpacity(0.3),
        border: Border.all(color: Colors.white.withOpacity(0.1), width: 1),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
            blurRadius: 20,
            spreadRadius: -10,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: GlowingTextField(
                  controller: controllers['name']!,
                  label: 'Name',
                  icon: Icons.person,
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: GlowingTextField(
                  controller: controllers['email']!,
                  label: 'Email',
                  icon: Icons.email,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          GlowingTextField(
            controller: controllers['subject']!,
            label: 'Subject',
            icon: Icons.text_fields,
          ),
          const SizedBox(height: 24),
          GlowingTextField(
            controller: controllers['message']!,
            label: 'Message',
            icon: Icons.message,
            maxLines: 5,
          ),
          const SizedBox(height: 32),
          Center(
            child: GlowingButton(
              text: 'Send Message',
              color: Theme.of(context).colorScheme.primary,
              onPressed: () {},
              width: 200,
            ),
          ),
        ],
      ),
    );
  }
}

class ContactInfoCard extends StatefulWidget {
  final String title;
  final String info;
  final IconData icon;

  const ContactInfoCard({
    super.key,
    required this.title,
    required this.info,
    required this.icon,
  });

  @override
  State<ContactInfoCard> createState() => _ContactInfoCardState();
}

class _ContactInfoCardState extends State<ContactInfoCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color:
              _isHovered
                  ? Theme.of(context).colorScheme.primary.withOpacity(0.15)
                  : Colors.black.withOpacity(0.3),
          border: Border.all(
            color:
                _isHovered
                    ? Theme.of(context).colorScheme.primary.withOpacity(0.5)
                    : Colors.white.withOpacity(0.1),
            width: 1,
          ),
          boxShadow:
              _isHovered
                  ? [
                    BoxShadow(
                      color: Theme.of(
                        context,
                      ).colorScheme.primary.withOpacity(0.2),
                      blurRadius: 15,
                      spreadRadius: -5,
                    ),
                  ]
                  : [],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color:
                    _isHovered
                        ? Theme.of(context).colorScheme.primary.withOpacity(0.2)
                        : Colors.black.withOpacity(0.4),
              ),
              child: Icon(
                widget.icon,
                color:
                    _isHovered
                        ? Theme.of(context).colorScheme.primary
                        : Colors.white,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withOpacity(0.6),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  widget.info,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
