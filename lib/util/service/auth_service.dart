import 'package:mirim_oauth_flutter/mirim_oauth_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

MirimOAuth auth = MirimOAuth(
  clientId: dotenv.env['CLIENT_ID']!,
  clientSecret: dotenv.env['CLIENT_SECRET']!,
  redirectUri: 'mirimpay://callback',
  scopes: ['email', 'nickname'],
);