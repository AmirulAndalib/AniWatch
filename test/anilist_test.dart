import 'package:aniwatch/api/meta.dart';

void main() {
  var client = AnilistMeta();
  // ignore: avoid_print
  client.getPopular().then((value) => print(value));
}
