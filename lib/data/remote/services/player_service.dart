import 'package:perebas_fc_app/data/remote/services/api_service_base.dart';
import 'package:perebas_fc_app/domain/models/player/player.dart';

class PlayerService extends ApiServiceBase {
  Future<bool> nicknameValid(String nickname) async {
    List<dynamic> players = (await get('filter/$nickname')) as List;
    return !players.isNotEmpty;
  }

  Future<void> Create(PlayerModel player) async {}
}
