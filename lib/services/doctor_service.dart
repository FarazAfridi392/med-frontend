import 'package:http/http.dart' as http;
import 'package:med_consultation/Constants.dart' as Constants;

class DoctorService {
  Future<http.Response> getAllPatients() {
    return http.get(Uri.parse(Constants.BASE_URL + '/getAllPatients'));
  }
}
