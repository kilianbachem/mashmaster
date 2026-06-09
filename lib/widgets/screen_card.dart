import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ScreenCard extends StatelessWidget {
  final String _title;
  final String? _subtitle;
  final IconData _icon;
  final Color _color;
  final String? _location;
  final Function? _onTap;

  const ScreenCard({
    super.key,
    required String title,
    required IconData icon,
    required Color color,
    String? subtitle,
    String? location,
    Function? onTap,
  }) : assert(
         (location == null) != (onTap == null),
         'Exactly one of location or onTap must be defined',
       ),
       _color = color,
       _title = title,
       _subtitle = subtitle,
       _icon = icon,
       _location = location,
       _onTap = onTap;

  String get title => _title;
  String? get subtitle => _subtitle;
  IconData get icon => _icon;
  Color get color => _color;
  String? get location => _location;
  Function? get onTap => _onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    // Derive a subtle gradient: the card's accent color at low opacity over the
    // surface container so it works in both light and dark themes.
    final accentSurface = Color.alphaBlend(
      _color.withValues(alpha: 0.12),
      scheme.surfaceContainerLow,
    );
    final accentSurfaceTop = Color.alphaBlend(
      _color.withValues(alpha: 0.06),
      scheme.surfaceContainerLowest,
    );

    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: _location != null
            ? () => context.push(_location)
            : () => _onTap?.call(),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [accentSurfaceTop, accentSurface],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          // AspectRatio makes the card square in the grid
          child: AspectRatio(
            aspectRatio: 1,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Icon badge
                  Container(
                    decoration: BoxDecoration(
                      color: _color.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.all(10),
                    child: Icon(_icon, color: _color, size: 26),
                  ),
                  const Spacer(),
                  Text(
                    _title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: scheme.onSurface,
                        ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (_subtitle != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      _subtitle,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: scheme.onSurfaceVariant,
                          ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
