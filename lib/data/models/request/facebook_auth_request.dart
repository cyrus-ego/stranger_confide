class FacebookAuthRequest {
  const FacebookAuthRequest({
    required this.accessToken,
    required this.tokenType,
    this.nonce,
  });

  final String accessToken;
  final String tokenType;
  final String? nonce;

  Map<String, dynamic> toJson() => {
    'accessToken': accessToken,
    'tokenType': tokenType,
    if (nonce != null) 'nonce': nonce,
  };
}
