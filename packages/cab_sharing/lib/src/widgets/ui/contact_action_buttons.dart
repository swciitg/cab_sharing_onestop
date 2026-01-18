import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:onestop_ui/index.dart';

/// Contact action buttons row (Call, Text, Mail)
class ContactActionButtons extends StatelessWidget {
  final String? phoneNumber;
  final String email;
  final VoidCallback onCall;
  final VoidCallback onText;
  final VoidCallback onMail;

  const ContactActionButtons({
    super.key,
    this.phoneNumber,
    required this.email,
    required this.onCall,
    required this.onText,
    required this.onMail,
  });

  @override
  Widget build(BuildContext context) {
    final hasPhone = phoneNumber != null && phoneNumber!.isNotEmpty;

    return Row(
      children: [
        // Call button
        Expanded(
          child: _ActionButton(
            icon: TablerIcons.phone,
            label: 'Call',
            onPressed: hasPhone ? onCall : null,
          ),
        ),
        const SizedBox(width: OSpacing.xs),
        // Text button
        Expanded(
          child: _ActionButton(
            icon: TablerIcons.message,
            label: 'Text',
            onPressed: hasPhone ? onText : null,
          ),
        ),
        const SizedBox(width: OSpacing.xs),
        // Mail button
        Expanded(
          child: _ActionButton(
            icon: TablerIcons.mail,
            label: 'Mail',
            onPressed: onMail,
          ),
        ),
      ],
    );
  }
}

/// Custom action button matching SecondaryButton style
class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onPressed;

  const _ActionButton({
    required this.icon,
    required this.label,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final isEnabled = onPressed != null;

    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        foregroundColor: isEnabled ? OColor.green600 : OColor.gray400,
        side: BorderSide(
          color: isEnabled ? OColor.green600 : OColor.gray300,
          width: 1,
        ),
        padding: const EdgeInsets.symmetric(
          vertical: OSpacing.xs,
          horizontal: OSpacing.xxs,
        ),
        minimumSize: const Size(0, 44),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(OCornerRadius.m),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 16),
          const SizedBox(width: 4),
          Flexible(
            child: Text(
              label,
              style: OTextStyle.labelSmall.copyWith(
                color: isEnabled ? OColor.green600 : OColor.gray400,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
