import 'dart:async';

import 'package:cyr_flutter_core/cyr_flutter_core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../core/locale/locale_keys.dart';
import '../../router/app_router.dart';
import '../../shared/widgets/app_snack_bar.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import 'bloc/chat_bloc.dart';
import 'bloc/chat_event.dart';
import 'bloc/chat_state.dart';
import 'widgets/chat_dialogs.dart';

class ChatPage extends BlocHostPage {
  const ChatPage({super.key, required this.roomId});

  final String roomId;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends BlocHostPageState<ChatPage> {
  @override
  Stream<String> get errorStream => context.read<ChatBloc>().errorStream;

  @override
  Widget buildPage(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<ChatBloc, ChatState>(
          listenWhen: (prev, curr) =>
              curr.status == ChatStatus.closed &&
              prev.status != ChatStatus.closed,
          listener: (context, state) {
            if (state.closedReason == 'access_denied') {
              AppSnackBar.show(
                context,
                message: state.errorMessage ?? 'Không có quyền truy cập',
                type: SnackBarType.error,
              );
              context.go(AppRoutes.home);
              return;
            }
            showRoomClosedDialog(
              context,
              reason: state.closedReason ?? 'closed',
              canDismiss: !state.closureInitiatedByMe,
            );
          },
        ),
        BlocListener<ChatBloc, ChatState>(
          listenWhen: (prev, curr) =>
              curr.lastAction != ChatAction.none &&
              curr.lastAction != prev.lastAction,
          listener: (context, state) {
            switch (state.lastAction) {
              case ChatAction.reportSuccess:
                AppSnackBar.show(
                  context,
                  message: tr(LocaleKeys.chatReportSuccess),
                );
              case ChatAction.reportFailed:
                AppSnackBar.show(
                  context,
                  message: tr(LocaleKeys.chatReportFailed),
                  type: SnackBarType.error,
                );
              case ChatAction.moderationBlocked:
                AppSnackBar.show(
                  context,
                  message: tr(LocaleKeys.chatModerationBlocked),
                  type: SnackBarType.error,
                );
              case ChatAction.spamDetected:
                AppSnackBar.show(
                  context,
                  message: tr(LocaleKeys.chatSpamDetected),
                  type: SnackBarType.error,
                );
              case ChatAction.none:
                break;
            }
          },
        ),
      ],
      child: const _ChatScaffold(),
    );
  }
}

class _ChatScaffold extends StatelessWidget {
  const _ChatScaffold();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: _buildAppBar(context, theme, isDark),
      body: Container(
        decoration: BoxDecoration(
          gradient: isDark
              ? AppColors.darkGradientBackground
              : AppColors.lightGradientBackground,
        ),
        child: const Column(
          children: [
            _ConnectingBanner(),
            Expanded(child: _MessageList()),
            _TypingIndicator(),
            _ChatInputBar(),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(
    BuildContext context,
    ThemeData theme,
    bool isDark,
  ) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: isDark ? AppColors.darkSurface : AppColors.lightSurface,
      surfaceTintColor: Colors.transparent,
      title: BlocBuilder<ChatBloc, ChatState>(
        buildWhen: (p, c) =>
            p.partnerAlias != c.partnerAlias ||
            p.partnerAvatar != c.partnerAvatar ||
            p.partnerOnline != c.partnerOnline,
        builder: (context, state) {
          return Row(
            children: [
              _PartnerAvatar(
                alias: state.partnerAlias,
                avatarUrl: state.partnerAvatar,
              ),
              const Gap(AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      state.partnerAlias,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Row(
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: state.partnerOnline
                                ? AppColors.success
                                : AppColors.darkTextMuted,
                          ),
                        ),
                        const Gap(AppSpacing.xs),
                        Text(
                          state.partnerOnline
                              ? tr(LocaleKeys.chatOnline)
                              : tr(LocaleKeys.chatOffline),
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: state.partnerOnline
                                ? AppColors.success
                                : theme.colorScheme.onSurface.withAlpha(100),
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
      actions: [
        IconButton(
          onPressed: () => context.push(AppRoutes.profile),
          icon: Icon(
            Icons.settings_outlined,
            color: theme.colorScheme.onSurface.withAlpha(180),
          ),
        ),
        BlocBuilder<ChatBloc, ChatState>(
          buildWhen: (p, c) => p.status != c.status,
          builder: (context, state) {
            final isActive = state.status == ChatStatus.active;
            return PopupMenuButton<String>(
              enabled: isActive,
              icon: Icon(
                Icons.more_vert_rounded,
                color: theme.colorScheme.onSurface
                    .withAlpha(isActive ? 180 : 60),
              ),
              onSelected: (value) => _onMenuAction(context, value),
              itemBuilder: (_) => [
                PopupMenuItem(
                  value: 'report',
                  child: Row(
                    children: [
                      const Icon(Icons.flag_outlined,
                          size: 20, color: AppColors.tertiary),
                      const Gap(AppSpacing.md),
                      Text(tr(LocaleKeys.chatReport)),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 'block',
                  child: Row(
                    children: [
                      const Icon(Icons.block_rounded,
                          size: 20, color: AppColors.error),
                      const Gap(AppSpacing.md),
                      Text(tr(LocaleKeys.chatBlock)),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 'leave',
                  child: Row(
                    children: [
                      Icon(Icons.exit_to_app_rounded,
                          size: 20,
                          color: theme.colorScheme.onSurface.withAlpha(150)),
                      const Gap(AppSpacing.md),
                      Text(tr(LocaleKeys.chatLeave)),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  void _onMenuAction(BuildContext context, String action) {
    final bloc = context.read<ChatBloc>();
    switch (action) {
      case 'report':
        _handleReport(context, bloc);
      case 'block':
        _handleBlock(context, bloc);
      case 'leave':
        bloc.add(const ChatLeaveRoom());
    }
  }

  Future<void> _handleReport(BuildContext context, ChatBloc bloc) async {
    final result = await showReportSheet(context);
    if (result != null && context.mounted) {
      bloc.add(ChatReportPartner(result.reason, result.description));
    }
  }

  Future<void> _handleBlock(BuildContext context, ChatBloc bloc) async {
    final confirmed = await showBlockConfirmDialog(context);
    if (confirmed) {
      bloc.add(const ChatBlockPartner());
    }
  }
}

// ── Connecting banner ──

class _ConnectingBanner extends StatelessWidget {
  const _ConnectingBanner();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<ChatBloc, ChatState>(
      buildWhen: (p, c) => p.status != c.status,
      builder: (context, state) {
        if (state.status == ChatStatus.connecting) {
          return Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
            color: AppColors.primary.withAlpha(30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 14,
                  height: 14,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
                const Gap(AppSpacing.sm),
                Text(
                  tr(LocaleKeys.chatConnecting),
                  style: theme.textTheme.bodySmall,
                ),
              ],
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}

// ── Partner avatar ──

class _PartnerAvatar extends StatelessWidget {
  const _PartnerAvatar({required this.alias, required this.avatarUrl});

  final String alias;
  final String avatarUrl;

  @override
  Widget build(BuildContext context) {
    if (avatarUrl.isNotEmpty && !avatarUrl.contains('.svg')) {
      return CircleAvatar(
        radius: 20,
        backgroundImage: NetworkImage(avatarUrl),
        onBackgroundImageError: (_, __) {},
      );
    }
    return _buildFallback();
  }

  Widget _buildFallback() {
    final hash = alias.hashCode;
    final hue1 = (hash % 360).abs().toDouble();
    final hue2 = ((hash * 17) % 360).abs().toDouble();

    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [
            HSLColor.fromAHSL(1, hue1, 0.6, 0.5).toColor(),
            HSLColor.fromAHSL(1, hue2, 0.5, 0.6).toColor(),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: Text(
          alias.isNotEmpty ? alias[0].toUpperCase() : '?',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}

// ── Message list ──

class _MessageList extends StatefulWidget {
  const _MessageList();

  @override
  State<_MessageList> createState() => _MessageListState();
}

class _MessageListState extends State<_MessageList> {
  final _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatBloc, ChatState>(
      listenWhen: (p, c) => c.messages.length > p.messages.length,
      listener: (_, __) {
        _scrollToBottom();
        HapticFeedback.lightImpact();
      },
      buildWhen: (p, c) => p.messages != c.messages,
      builder: (context, state) {
        if (state.messages.isEmpty) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.chat_bubble_outline_rounded,
                  size: 48,
                  color: Theme.of(context)
                      .colorScheme
                      .onSurface
                      .withAlpha(60),
                ),
                const Gap(AppSpacing.md),
                Text(
                  tr(LocaleKeys.chatInputHint),
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withAlpha(100),
                      ),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          controller: _scrollController,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.md,
          ),
          itemCount: state.messages.length,
          itemBuilder: (context, i) {
            final msg = state.messages[i];
            final showTimestamp = i == 0 ||
                msg.createdAt
                        .difference(state.messages[i - 1].createdAt)
                        .inMinutes >
                    5;

            return Column(
              children: [
                if (showTimestamp)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: AppSpacing.sm,
                    ),
                    child: Text(
                      _formatTime(msg.createdAt),
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onSurface
                                .withAlpha(80),
                            fontSize: 11,
                          ),
                    ),
                  ),
                _MessageBubble(message: msg),
              ],
            );
          },
        );
      },
    );
  }

  String _formatTime(DateTime dt) {
    final now = DateTime.now();
    final isToday = dt.year == now.year &&
        dt.month == now.month &&
        dt.day == now.day;
    if (isToday) {
      return '${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
    }
    return '${dt.day}/${dt.month} ${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
  }
}

// ── Message bubble ──

class _MessageBubble extends StatelessWidget {
  const _MessageBubble({required this.message});

  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    if (message.type == MessageType.system) {
      return _SystemMessage(text: message.content);
    }

    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final isMine = message.isMine;

    final bubbleColor = isMine
        ? AppColors.primary
        : isDark
            ? AppColors.darkSurfaceBright
            : AppColors.lightSurfaceVariant;

    final textColor = isMine ? Colors.white : theme.colorScheme.onSurface;

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.xs),
      child: Row(
        mainAxisAlignment:
            isMine ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (isMine) const Spacer(flex: 2),
          Flexible(
            flex: 5,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.lg,
                vertical: AppSpacing.md,
              ),
              decoration: BoxDecoration(
                color: bubbleColor,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(AppSpacing.radiusLg),
                  topRight: const Radius.circular(AppSpacing.radiusLg),
                  bottomLeft: Radius.circular(
                    isMine ? AppSpacing.radiusLg : AppSpacing.xs,
                  ),
                  bottomRight: Radius.circular(
                    isMine ? AppSpacing.xs : AppSpacing.radiusLg,
                  ),
                ),
              ),
              child: message.type == MessageType.image
                  ? _ImageContent(message: message, textColor: textColor)
                  : Text(
                      message.content,
                      style: TextStyle(color: textColor, fontSize: 15),
                    ),
            ),
          ),
          if (!isMine) const Spacer(flex: 2),
        ],
      ),
    );
  }
}

// ── Image message content ──

class _ImageContent extends StatelessWidget {
  const _ImageContent({required this.message, required this.textColor});

  final ChatMessage message;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    if (message.isUploading) {
      return const SizedBox(
        width: 120,
        height: 120,
        child: Center(
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
      );
    }

    final url = message.imageUrl ?? message.content;

    return GestureDetector(
      onTap: () => _showFullscreen(context, url),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        child: Image.network(
          url,
          width: 200,
          height: 200,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => SizedBox(
            width: 200,
            height: 80,
            child: Center(
              child: Icon(Icons.broken_image_rounded,
                  color: textColor.withAlpha(120)),
            ),
          ),
        ),
      ),
    );
  }

  void _showFullscreen(BuildContext context, String url) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            iconTheme: const IconThemeData(color: Colors.white),
          ),
          extendBodyBehindAppBar: true,
          body: Center(
            child: InteractiveViewer(
              child: Image.network(url),
            ),
          ),
        ),
      ),
    );
  }
}

// ── System message ──

class _SystemMessage extends StatelessWidget {
  const _SystemMessage({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
      child: Center(
        child: Text(
          text,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontStyle: FontStyle.italic,
                color:
                    Theme.of(context).colorScheme.onSurface.withAlpha(100),
                fontSize: 12,
              ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

// ── Typing indicator ──

class _TypingIndicator extends StatelessWidget {
  const _TypingIndicator();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatBloc, ChatState>(
      buildWhen: (p, c) =>
          p.partnerTyping != c.partnerTyping ||
          p.partnerAlias != c.partnerAlias,
      builder: (context, state) {
        if (!state.partnerTyping) return const SizedBox.shrink();

        return Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.xl,
            vertical: AppSpacing.sm,
          ),
          child: Row(
            children: [
              Text(
                tr(LocaleKeys.chatTyping,
                    namedArgs: {'name': state.partnerAlias}),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withAlpha(120),
                      fontStyle: FontStyle.italic,
                    ),
              ),
              const Gap(AppSpacing.xs),
              const _AnimatedDots(),
            ],
          ),
        ).animate().fadeIn(duration: 200.ms);
      },
    );
  }
}

// ── Animated typing dots ──

class _AnimatedDots extends StatefulWidget {
  const _AnimatedDots();

  @override
  State<_AnimatedDots> createState() => _AnimatedDotsState();
}

class _AnimatedDotsState extends State<_AnimatedDots>
    with TickerProviderStateMixin {
  late final List<AnimationController> _controllers;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(3, (i) {
      final ctrl = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 600),
      );
      Future.delayed(Duration(milliseconds: i * 200), () {
        if (mounted) ctrl.repeat(reverse: true);
      });
      return ctrl;
    });
  }

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.onSurface.withAlpha(100);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: _controllers.map((c) {
        return AnimatedBuilder(
          animation: c,
          builder: (_, __) => Container(
            margin: const EdgeInsets.symmetric(horizontal: 1.5),
            width: 5,
            height: 5,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color.withAlpha((80 + 100 * c.value).toInt()),
            ),
          ),
        );
      }).toList(),
    );
  }
}

// ── Input bar ──

class _ChatInputBar extends StatefulWidget {
  const _ChatInputBar();

  @override
  State<_ChatInputBar> createState() => _ChatInputBarState();
}

class _ChatInputBarState extends State<_ChatInputBar> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onChanged(String text) {
    if (text.isNotEmpty) {
      context.read<ChatBloc>().add(const ChatTyping());
    }
  }

  void _send() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    context.read<ChatBloc>().add(ChatSendMessage(text));
    _controller.clear();
    HapticFeedback.lightImpact();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return BlocBuilder<ChatBloc, ChatState>(
      buildWhen: (p, c) =>
          p.status != c.status ||
          p.isUploading != c.isUploading ||
          p.isSending != c.isSending ||
          p.closureInitiatedByMe != c.closureInitiatedByMe,
      builder: (context, state) {
        if (state.status == ChatStatus.closed && !state.closureInitiatedByMe) {
          return _FindSomeoneNewBar(isDark: isDark);
        }

        final disabled =
            state.status != ChatStatus.active || state.isSending;

        return Container(
          padding: EdgeInsets.only(
            left: AppSpacing.md,
            right: AppSpacing.md,
            top: AppSpacing.sm,
            bottom: MediaQuery.of(context).padding.bottom + AppSpacing.sm,
          ),
          decoration: BoxDecoration(
            color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
            border: Border(
              top: BorderSide(
                color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                width: 0.5,
              ),
            ),
          ),
          child: Row(
            children: [
              IconButton(
                onPressed: disabled || state.isUploading
                    ? null
                    : () {
                        // TODO: image_picker integration (phase sau)
                      },
                icon: state.isUploading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Icon(
                        Icons.camera_alt_outlined,
                        color: disabled
                            ? theme.colorScheme.onSurface.withAlpha(40)
                            : AppColors.primary,
                      ),
              ),
              Expanded(
                child: TextField(
                  controller: _controller,
                  enabled: !disabled,
                  onChanged: _onChanged,
                  onSubmitted: (_) => _send(),
                  textInputAction: TextInputAction.send,
                  maxLines: 4,
                  minLines: 1,
                  style: const TextStyle(fontSize: 15),
                  decoration: InputDecoration(
                    hintText: tr(LocaleKeys.chatInputHint),
                    border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(AppSpacing.radiusXl),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(AppSpacing.radiusXl),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(AppSpacing.radiusXl),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: isDark
                        ? AppColors.darkSurfaceVariant
                        : AppColors.lightSurfaceVariant,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.lg,
                      vertical: AppSpacing.md,
                    ),
                    isDense: true,
                  ),
                ),
              ),
              const Gap(AppSpacing.xs),
              ValueListenableBuilder<TextEditingValue>(
                valueListenable: _controller,
                builder: (_, value, __) {
                  final hasText = value.text.trim().isNotEmpty;
                  final canSend = hasText && !disabled;

                  if (state.isSending) {
                    return const Padding(
                      padding: EdgeInsets.all(12),
                      child: SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    );
                  }

                  return IconButton(
                    onPressed: canSend ? _send : null,
                    icon: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: canSend
                            ? AppColors.primary
                            : theme.colorScheme.onSurface.withAlpha(20),
                      ),
                      child: Icon(
                        Icons.send_rounded,
                        size: 18,
                        color: canSend
                            ? Colors.white
                            : theme.colorScheme.onSurface.withAlpha(60),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class _FindSomeoneNewBar extends StatelessWidget {
  const _FindSomeoneNewBar({required this.isDark});

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        left: AppSpacing.lg,
        right: AppSpacing.lg,
        top: AppSpacing.md,
        bottom: MediaQuery.of(context).padding.bottom + AppSpacing.md,
      ),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
        border: Border(
          top: BorderSide(
            color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
            width: 0.5,
          ),
        ),
      ),
      child: FilledButton.icon(
        onPressed: () => context.go(AppRoutes.matchmaking),
        icon: const Icon(Icons.person_search_rounded),
        label: Text(tr(LocaleKeys.chatFindNew)),
      ),
    );
  }
}
