import 'package:healthy_bag/data/dto/user_dto.dart';

class UserProfileUrlMapper {
  static String map(UserDTO user) {
    return user.profileUrl;
  }
}
