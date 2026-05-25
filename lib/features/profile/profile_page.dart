import 'package:cyr_flutter_core/cyr_flutter_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stranger_confide/data/models/response/profile_response.dart';

import 'bloc/profile_bloc.dart';
import 'bloc/profile_state.dart';

class ProfilePage extends BlocHostPage {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends BlocHostPageState<ProfilePage> {
  @override
  Stream<String> get errorStream => context.read<ProfileBloc>().errorStream;

  @override
  Widget buildPage(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          return switch (state.status) {
            ProfileStatus.initial || ProfileStatus.loading => const Center(
                child: CircularProgressIndicator(),
              ),
            ProfileStatus.failure => const Center(
                child: Text('Không tải được profile'),
              ),
            ProfileStatus.loaded => _ProfileContent(data: state.data!),
          };
        },
      ),
    );
  }
}

class _ProfileContent extends StatelessWidget {
  const _ProfileContent({required this.data});

  final ProfileResponse data;

  @override
  Widget build(BuildContext context) {
    final user = data.user;
    final profile = data.profile;
    final theme = Theme.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          CircleAvatar(
            radius: 48,
            backgroundColor: theme.colorScheme.primaryContainer,
            child: user.avatar.isNotEmpty
                ? ClipOval(
                    child: Image.network(
                      user.avatar,
                      width: 96,
                      height: 96,
                      fit: BoxFit.cover,
                    ),
                  )
                : Text(
                    user.displayName.isNotEmpty
                        ? user.displayName[0].toUpperCase()
                        : '?',
                    style: theme.textTheme.headlineLarge?.copyWith(
                      color: theme.colorScheme.onPrimaryContainer,
                    ),
                  ),
          ),
          const SizedBox(height: 16),
          Text(
            user.displayName,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            user.email,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 24),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _InfoRow(
                    icon: Icons.person_outline,
                    label: 'Giới tính',
                    value: _genderLabel(profile.gender),
                  ),
                  const Divider(),
                  _InfoRow(
                    icon: Icons.cake_outlined,
                    label: 'Tuổi',
                    value: '${profile.age}',
                  ),
                  const Divider(),
                  _InfoRow(
                    icon: Icons.chat_bubble_outline,
                    label: 'Muốn chat với',
                    value: _genderLabel(profile.preferredGender),
                  ),
                  const Divider(),
                  _InfoRow(
                    icon: Icons.verified_outlined,
                    label: 'Role',
                    value: user.role,
                  ),
                  if (profile.bio.isNotEmpty) ...[
                    const Divider(),
                    _InfoRow(
                      icon: Icons.info_outline,
                      label: 'Bio',
                      value: profile.bio,
                    ),
                  ],
                  const Divider(),
                  _InfoRow(
                    icon: Icons.star_outline,
                    label: 'VIP',
                    value: profile.isVip ? 'Có' : 'Không',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  static String _genderLabel(String gender) => switch (gender) {
        'male' => 'Nam',
        'female' => 'Nữ',
        _ => gender,
      };
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.grey[600]),
          const SizedBox(width: 12),
          Text(label, style: const TextStyle(color: Colors.grey)),
          const Spacer(),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}
