abstract class ChatRepository {
  Future<void> sendMessage(String message);

  ///Should return messages with time stamps
  ///
  ///thow [ServerException] in case of failures
  Future<Map<DateTime, String>> fetchMessages();

  ///Should return the amount owed either +ve or -ve
  ///
  ///
  Future<double> fetchMyDue();
}

class ChatRepositoryImpl implements ChatRepository{
  @override
  Future<Map<DateTime, String>> fetchMessages() {
    // TODO: implement fetchMessages
    throw UnimplementedError();
  }

  @override
  Future<double> fetchMyDue() {
    // TODO: implement fetchMyDue
    throw UnimplementedError();
  }

  @override
  Future<void> sendMessage(String message) {
    // TODO: implement sendMessage
    throw UnimplementedError();
  }
}