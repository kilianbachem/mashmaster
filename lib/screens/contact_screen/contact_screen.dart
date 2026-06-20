import 'package:flutter/material.dart';
import 'package:flutter_app_info/flutter_app_info.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mashmaster/helpers/social_media_icon.dart';
import 'package:mashmaster/helpers/url_handler.dart';
import 'package:mashmaster/i18n/generated/translations.g.dart';
import 'package:wiredash/wiredash.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final package = AppInfo.of(context).package;
    final t = Translations.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  t.contact_screen.label_one,
                  style: TextStyle(fontSize: 16, height: 3),
                  textAlign: TextAlign.center,
                ),
                _DeveloperCard(
                  name: t.contact_screen.dev_card.name,
                  title: t.contact_screen.dev_card.title,
                  image: const AssetImage("assets/images/profile.jpg"),
                  initials: "NO",
                  githubUrl: 'https://github.com/NightmindOfficial',
                  emailSubject: 'Mashmaster User Feedback',
                ),
                const SizedBox(height: 8),
                _DeveloperCard(
                  name: t.contact_screen.contributor_card.name,
                  title: t.contact_screen.contributor_card.title,
                  image: const AssetImage("assets/images/profile_kilian.jpg"),
                  initials: "KB",
                  githubUrl: 'https://github.com/kilianbachem',
                ),
                Divider(),
                Text(
                  t.contact_screen.bug_report.label,
                  style: TextStyle(fontSize: 16, height: 3),
                ),
                ElevatedButton.icon(
                  icon: Icon(Icons.bug_report_rounded),
                  onPressed:
                      () =>
                          Wiredash.of(context).show(inheritMaterialTheme: true),
                  label: Text(
                    t.contact_screen.bug_report.button_label,
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Text(
                  "Mashmaster v${package.versionWithoutBuild} Build ${package.buildNumber}. ${t.contact_screen.version_label}",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DeveloperCard extends StatelessWidget {
  final String name;
  final String title;
  final ImageProvider image;
  final String initials;
  final String githubUrl;
  final String? emailSubject;

  const _DeveloperCard({
    required this.name,
    required this.title,
    required this.image,
    required this.initials,
    required this.githubUrl,
    this.emailSubject,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Card(
      color: scheme.tertiaryFixed,
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundColor: scheme.secondary,
              foregroundImage: image,
              child: Text(initials),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Column(
                  children: [
                    ListTile(
                      minTileHeight: 0,
                      contentPadding: EdgeInsets.zero,
                      title: Text(name),
                      subtitle: Text(title),
                      isThreeLine: false,
                      titleTextStyle: TextStyle(
                        fontSize: 22,
                        color: scheme.onTertiaryFixedVariant,
                        fontWeight: FontWeight.bold,
                      ),
                      subtitleTextStyle: TextStyle(
                        fontSize: 18,
                        color: scheme.onTertiaryFixedVariant,
                        height: 1.5,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton.outlined(
                          onPressed: () async {
                            await Wiredash.trackEvent('GitHub Profile Visit');
                            launchURL(githubUrl);
                          },
                          icon: Icon(
                            SocialMediaIcon.github_circled,
                            color: scheme.onTertiary,
                          ),
                          style: IconButton.styleFrom(
                            elevation: 3,
                            backgroundColor: scheme.tertiary,
                          ),
                        ),
                        if (emailSubject != null) ...[
                          SizedBox(width: 8),
                          IconButton.outlined(
                            onPressed: () async {
                              await Wiredash.trackEvent('Sent E-Mail');
                              launchURL(
                                'mailto:${dotenv.env['EMAIL']}?subject=$emailSubject',
                              );
                            },
                            icon: Icon(
                              Icons.email_rounded,
                              color: scheme.onTertiary,
                            ),
                            style: IconButton.styleFrom(
                              elevation: 3,
                              backgroundColor: scheme.tertiary,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
