import 'package:path/path.dart' as p;

enum UrlTypes { image, video, unknown }

class UrlType {
  static final List<String> imageTypes = [
    'jpg',
    'jpeg',
    'jfif',
    'pjpeg',
    'pjp',
    'png',
    'svg',
    'gif',
    'apng',
    'webp',
    'avif',
    'gif',
  ];

  static final List<String> videoTypes = [
    '3g2',
    '3gp',
    'aaf',
    'asf',
    'avchd',
    'avi',
    'drc',
    'flv',
    'm2v',
    'm3u8',
    'm4p',
    'm4v',
    'mkv',
    'mng',
    'mov',
    'mp2',
    'mp4',
    'mpe',
    'mpeg',
    'mpg',
    'mpv',
    'mxf',
    'nsv',
    'ogg',
    'ogv',
    'qt',
    'rm',
    'rmvb',
    'roq',
    'svi',
    'vob',
    'webm',
    'wmv',
    'yuv',
  ];

  static final List<String> docTypes = [
    'doc',
    'docx',
    'xls',
    'xslx',
    'ppt',
    'pptx',
    'pdf',
    'txt',
  ];

  static UrlTypes getType(String url) {
    try {
      Uri uri = Uri.parse(url);
      String extension = p.extension(uri.path).toLowerCase();
      if (extension.isEmpty) {
        return UrlTypes.unknown;
      }

      extension = extension.split('.').last;
      if (imageTypes.contains(extension)) {
        return UrlTypes.image;
      } else if (videoTypes.contains(extension)) {
        return UrlTypes.video;
      }
    } catch (e) {
      return UrlTypes.unknown;
    }
    return UrlTypes.unknown;
  }
}
