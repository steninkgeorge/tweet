class AppwriteConstants {
  static const String databaseId = '64ac1c859b4b75360aea';
  static const String projectId = '64ac19a20b4999dc324d';
  static const String endPoint = 'http://192.168.163.241:80/v1';
  static const String usersCollection = '64bfe73b43482dcb8db6';
  static const String tweetsCollection = '64f6306c0a8054614d2f';
  static const String imagesBucket = '64fad924b860c2b61134';
  static String imageUrl(String imageId) =>
      '$endPoint/storage/buckets/$imagesBucket/files/$imageId/view?project=$projectId&mode=admin';
}
