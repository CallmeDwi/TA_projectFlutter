import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perhutaniwisata_app/pages/detail_pages/cubit/store_page_info_sates.dart';

class StorePageInfoCubits extends Cubit<List<StorePageInfoState>> {
  StorePageInfoCubits() : super([]);

  addPageInfo(String? name, int? index) {
    var list = state;
    print('my list length is 1 ${list.length}');
    emit([StorePageInfoState(name: name, Index: index), ...state]);
    print('my list length is 2 ${state.length}');
  }
}
