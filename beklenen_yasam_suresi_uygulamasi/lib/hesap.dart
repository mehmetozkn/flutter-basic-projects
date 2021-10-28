import 'package:beklenen_yasam_suresi_uygulamasi/user_data.dart';

class Hesap {
  UserData _userData;
  Hesap(this._userData);

  double calculate() {
    double result;
    result = 90 + _userData.sporSayisi - _userData.icilenSigara;
    result += (_userData.boy) / (_userData.kilo);

    _userData.selectedGender == "FEMALE" ? result += 3 : result;
    return result;
  }
}
