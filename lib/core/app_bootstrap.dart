import 'package:cyr_app_kit/cyr_app_kit.dart';
import 'package:cyr_flutter_core/cyr_flutter_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';

const _defaultApiBaseUrl = 'https://api.chatvn.online/api';
const _defaultHeaders = {
  'Accept': 'application/json',
  'Content-Type': 'application/json',
  'ngrok-skip-browser-warning': 'true',
};

Future<void> bootstrapAppCore() async {
  final baseUrl = dotenv.env['API_BASE_URL'] ?? _defaultApiBaseUrl;
  await bootstrapAppKit(
    AppKitConfig(
      baseUrl: baseUrl,
      defaultHeaders: _defaultHeaders,
      onSessionExpired: () {
        final context = appNavigatorKey.currentContext;
        if (context != null && context.mounted) {
          context.go('/login');
        }
      },
      presentation: const PresentationConfig(
        errorDialogTitle: 'Lỗi',
        errorDialogCloseLabel: 'Đóng',
        connectionErrorMessage: 'Không kết nối được. Thử lại.',
      ),
    ),
  );
}
