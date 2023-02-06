import '../http_wrapper/http_wrapper.dart';

Future<int> heightInRest() async {
  //figure out if we're syncing
  final chainInfo = await HttpWrapper().get(
    path: 'chaininfo.json',
    requestJson: true,
  );
  return chainInfo["blocks"];
}
