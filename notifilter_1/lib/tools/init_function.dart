import 'package:notifilter_1/tools/central_store.dart' as Store;

class Init {

  static Future initialize() async {
    await Store.createAppList();
    await Store.initStore();
  }
}