import 'package:vigaviga/api_manager/api_client.dart';

final appClient = ApiClient();
Future getList() async {
  return await appClient.get('xxxxx');
}
