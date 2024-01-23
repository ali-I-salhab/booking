import 'package:booking/Apiapplink.dart';
import 'package:booking/core/class/crud.dart';

class PeriodsData {
  Crud crud;
  PeriodsData(this.crud);

  addperiod(String hotelid, String start, String end) async {
    var response = await crud.postdata(ApiApplinks.addperiod, {
      "period_hotelid": hotelid,
      "period_start": start,
      "period_end": end,
    });

    // print(response);
    return response.fold((l) => l, (r) => r);
  }

  editperiod(String id, String start, String end) async {
    var response = await crud.postdata(ApiApplinks.editperiod, {
      "id": id,
      "period_start": start,
      "period_end": end,
    });

    // print(response);
    return response.fold((l) => l, (r) => r);
  }

  deleteperiod(String periodid) async {
    var response = await crud.postdata(ApiApplinks.deleteperiod, {
      "id": periodid,
    });

    // print(response);
    return response.fold((l) => l, (r) => r);
  }

  viewperiod(String hotelid) async {
    var response = await crud.postdata(ApiApplinks.viewperiod, {
      "hotelid": hotelid,
    });

    // print(response);
    return response.fold((l) => l, (r) => r);
  }
}
