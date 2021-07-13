import 'package:http/http.dart' as http;
import 'package:med_consultation/Constants.dart' as Constants;

class PatientService {
  Future<http.Response> getAllDoctors() {
    return http.get(Uri.parse(Constants.BASE_URL + '/getAllDoctors'));
  }
}
