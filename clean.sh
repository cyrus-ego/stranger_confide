echo 'cleaning flutter cache and dependencies ....'
flutter pub cache clean && flutter clean && flutter pub get 
echo 'clean complete'