import 'package:path/path.dart' as path;



class Strings {
  static const String appName = 'Payment Card Demo';
  static const String fieldReq = 'This field is required';
  static const String numberIsInvalid = 'Card is invalid';
  static const String pay = 'Validate';

}



extension FileNameExtension on String {
  /// Extracts the filename and extension from a string path.
  ///
  /// Returns a tuple containing the filename (without extension) and extension.
  /// If the path doesn't contain an extension, the extension part will be an empty string.
  String getFileNameAndExtension(String userFilePath) {
    try {
      final filename = path.basename(userFilePath);
      final parts = filename.split('.');
      List<String> fileNameAndExtention = parts.length <= 1
          ? [parts[0], '']
          : [parts.sublist(0, parts.length - 1).join('.'), parts.last];

      final tempFileName = fileNameAndExtention[0];
      final tempFileExt = fileNameAndExtention[1];
      return '$tempFileName.$tempFileExt';
    } on Exception {
      return 'no file found';
    }
  }
}
