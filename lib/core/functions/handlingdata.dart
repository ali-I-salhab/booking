import 'package:booking/core/class/statusrequest.dart';

handlingdata(response) {
  if (response is Statusrequest) {
    print("from handling data function the first status");
    return response;
//failurre
  } else {
    print("from handling data function the second status");

    return Statusrequest.success;
  }
}
