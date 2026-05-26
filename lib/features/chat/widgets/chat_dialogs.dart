import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../core/locale/locale_keys.dart';
import '../../../router/app_router.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_spacing.dart';

// ── Block confirm dialog ──

Future<bool> showBlockConfirmDialog(BuildContext context) async {
  final result = await showDialog<bool>(
    context: context,
    builder: (ctx) => AlertDialog(
      title: Text(tr(LocaleKeys.chatBlockConfirmTitle)),
      content: Text(tr(LocaleKeys.chatBlockConfirmBody)),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(ctx, false),
          child: Text(tr(LocaleKeys.profileCancel)),
        ),
        FilledButton(
          onPressed: () => Navigator.pop(ctx, true),
          style: FilledButton.styleFrom(backgroundColor: AppColors.error),
          child: Text(tr(LocaleKeys.chatBlockConfirmAction)),
        ),
      ],
    ),
  );
  return result ?? false;
}

// ── Report bottom sheet ──

Future<({String reason, String? description})?> showReportSheet(
  BuildContext context,
) {
  return showModalBottomSheet<({String reason, String? description})>(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(AppSpacing.radiusXl),
      ),
    ),
    builder: (ctx) => const _ReportSheet(),
  );
}

class _ReportSheet extends StatefulWidget {
  const _ReportSheet();

  @override
  State<_ReportSheet> createState() => _ReportSheetState();
}

class _ReportSheetState extends State<_ReportSheet> {
  String? _selectedReason;
  final _descController = TextEditingController();

  static const _reasons = [
    'spam',
    'harassment',
    'adult_content',
    'privacy',
    'other',
  ];

  String _reasonLabel(String key) => switch (key) {
    'spam' => tr(LocaleKeys.chatReportSpam),
    'harassment' => tr(LocaleKeys.chatReportHarassment),
    'adult_content' => tr(LocaleKeys.chatReportAdultContent),
    'privacy' => tr(LocaleKeys.chatReportPrivacy),
    _ => tr(LocaleKeys.chatReportOther),
  };

  @override
  void dispose() {
    _descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bottom = MediaQuery.of(context).viewInsets.bottom;

    return Padding(
      padding: EdgeInsets.only(
        left: AppSpacing.xl,
        right: AppSpacing.xl,
        top: AppSpacing.xl,
        bottom: bottom + AppSpacing.xl,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: theme.colorScheme.outline,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const Gap(AppSpacing.lg),
          Text(
            tr(LocaleKeys.chatReportTitle),
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const Gap(AppSpacing.lg),
          RadioGroup<String>(
            groupValue: _selectedReason,
            onChanged: (v) => setState(() => _selectedReason = v),
            child: Column(
              children: _reasons
                  .map(
                    (r) => ListTile(
                      contentPadding: EdgeInsets.zero,
                      dense: true,
                      leading: Radio<String>(value: r),
                      title: Text(_reasonLabel(r)),
                      onTap: () => setState(() => _selectedReason = r),
                    ),
                  )
                  .toList(),
            ),
          ),
          const Gap(AppSpacing.md),
          TextField(
            controller: _descController,
            maxLines: 3,
            decoration: InputDecoration(
              hintText: tr(LocaleKeys.chatReportDescription),
            ),
          ),
          const Gap(AppSpacing.xl),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: FilledButton(
              onPressed: _selectedReason == null
                  ? null
                  : () => Navigator.pop(context, (
                      reason: _selectedReason!,
                      description: _descController.text.trim().isEmpty
                          ? null
                          : _descController.text.trim(),
                    )),
              child: Text(tr(LocaleKeys.chatReportSubmit)),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Room closed dialog ──

Future<void> showRoomClosedDialog(
  BuildContext context, {
  required String reason,
}) {
  final message = switch (reason) {
    'partner_left' => tr(LocaleKeys.chatRoomClosedPartnerLeft),
    'blocked' => tr(LocaleKeys.chatRoomClosedBlocked),
    _ => tr(LocaleKeys.chatRoomClosedPartnerLeft),
  };

  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (ctx) {
      final theme = Theme.of(ctx);

      return AlertDialog(
        title: Row(
          children: [
            Icon(
              Icons.meeting_room_outlined,
              color: theme.colorScheme.onSurface.withAlpha(150),
            ),
            const Gap(AppSpacing.sm),
            Text(tr(LocaleKeys.chatRoomClosedTitle)),
          ],
        ),
        content: Text(message),
        actionsAlignment: MainAxisAlignment.spaceEvenly,
        actions: [
          OutlinedButton.icon(
            onPressed: () {
              Navigator.pop(ctx);
              context.go(AppRoutes.home);
            },
            icon: const Icon(Icons.home_outlined, size: 18),
            label: Text(tr(LocaleKeys.chatGoHome)),
          ),
          const SizedBox(height: AppSpacing.md),
          FilledButton.icon(
            onPressed: () {
              Navigator.pop(ctx);
              context.go(AppRoutes.matchmaking);
            },
            icon: const Icon(Icons.search_rounded, size: 18),
            label: Text(tr(LocaleKeys.chatFindNew)),
          ),
        ],
      );
    },
  );
}
