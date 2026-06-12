import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mashmaster/i18n/generated/translations.g.dart';
import 'package:mashmaster/router/route_helpers.dart';

class StageAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String _titleKey;
  final List<Widget>? _actions;

  const StageAppBar({super.key, String? titleKey, List<Widget>? actions})
    : _titleKey = titleKey ?? "Title Not Set!",
      _actions = actions;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      // toolbarHeight: 0,
      title: Text(
        _getTitleForCurrentRoute(_titleKey, t),
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      leading:
          showLeadingBackButton(context)
              ? IconButton(
                onPressed: () => context.pop(),
                icon: Icon(Icons.arrow_back_rounded),
              )
              : null,
      actions: [
        ...?_actions,
        // IconButton( //FUTURE think about adding it to the UI
        // onPressed: () => Wiredash.of(context).show(),
        // icon: Icon(Icons.bug_report_rounded),
        // ),
      ],
      backgroundColor: const Color(0xfffbe311),
      foregroundColor: const Color(0xff261606),
    );
    // return AppBar(
    //   // forceMaterialTransparency: true,
    //   backgroundColor: Theme.of(context).colorScheme.inversePrimary,

    //   title: Text(_title, style: TextStyle(fontWeight: FontWeight.bold)),
    // );
  }

  String _getTitleForCurrentRoute(String titleKey, Translations t) {
    return t['routes.$titleKey'];
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
