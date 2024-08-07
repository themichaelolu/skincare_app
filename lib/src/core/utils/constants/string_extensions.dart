import 'package:flutter/services.dart';
import 'package:path/path.dart' as path;

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


class CardMonthInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var newText = newValue.text;

    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    var buffer = StringBuffer();
    for (int i = 0; i < newText.length; i++) {
      buffer.write(newText[i]);
      var nonZeroIndex = i + 1;
      if (nonZeroIndex % 2 == 0 && nonZeroIndex != newText.length) {
        buffer.write('/');
      }
    }

    var string = buffer.toString();
    return newValue.copyWith(
        text: string,
        selection: TextSelection.collapsed(offset: string.length));
  }
}
