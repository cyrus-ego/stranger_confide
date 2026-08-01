enum FacebookTokenType { classic, limited }

class FacebookLoginToken {
  const FacebookLoginToken({
    required this.accessToken,
    required this.type,
    this.nonce,
  });

  final String accessToken;
  final FacebookTokenType type;
  final String? nonce;
}
