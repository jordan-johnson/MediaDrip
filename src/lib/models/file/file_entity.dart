import 'dart:io';

class FileEntity {
  String name;
  String path;
  FileSystemEntityType type;

  FileEntity({FileSystemEntity entity}) {
    this.path = entity.path.replaceAll('\\', '/');
    this.name = this.path.split('/').last;
    this.type = FileSystemEntity.typeSync(entity.path);
  }
}

class StructuredFileEntities {
  final List<FileEntity> folders = List<FileEntity>();
  final List<FileEntity> files = List<FileEntity>();

  void add(FileEntity entity) {
    switch(entity.type) {
      case FileSystemEntityType.directory:
        folders.add(entity);
      break;
      case FileSystemEntityType.file:
      case FileSystemEntityType.link:
      default:
        files.add(entity);
      break;
    }
  }
}