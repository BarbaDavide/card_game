import 'package:flutter/material.dart';

/// Widget button accessibile con supporto screen reader e area di tocco minima 48x48dp
class AccessibleButton extends StatelessWidget {
  final VoidCallback onTap;
  final String label;
  final String? semanticLabel;
  final Widget child;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final bool enabled;
  final double minWidth;
  final double minHeight;

  const AccessibleButton({
    Key? key,
    required this.onTap,
    required this.label,
    this.semanticLabel,
    required this.child,
    this.backgroundColor,
    this.foregroundColor,
    this.enabled = true,
    this.minWidth = 48.0,
    this.minHeight = 48.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Semantics(
      button: true,
      label: semanticLabel ?? label,
      enabled: enabled,
      excludeSemantics: false,
      child: Material(
        color: enabled 
            ? (backgroundColor ?? theme.colorScheme.primary)
            : theme.colorScheme.onSurface.withOpacity(0.12),
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: enabled ? onTap : null,
          borderRadius: BorderRadius.circular(12),
          splashColor: theme.colorScheme.primary.withOpacity(0.1),
          highlightColor: theme.colorScheme.primary.withOpacity(0.2),
          child: Container(
            constraints: BoxConstraints(
              minWidth: minWidth,
              minHeight: minHeight,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Center(
              child: DefaultTextStyle(
                style: theme.textTheme.labelLarge!.copyWith(
                  color: enabled
                      ? (foregroundColor ?? theme.colorScheme.onPrimary)
                      : theme.colorScheme.onSurface.withOpacity(0.38),
                ),
                child: child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
