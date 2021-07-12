import 'package:http/http.dart' as http;
import 'package:med_consultation/Constants.dart' as Constants;
class AdminService{
  Future<http.Response> getAllAccountRequests() async {
    return await http.get(Uri.parse(Constants.BASE_URL+'/getAllAccountRequests'));
  }

  Future<bool>acceptAccountRequest(String uid) async{
    await http.post(Uri.parse(Constants.BASE_URL+'/acceptAccountRequest'),body: {
      'uid':uid
    });
    return true;
  }
}