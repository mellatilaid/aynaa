import 'dart:developer';
import 'dart:io';

import 'package:cross_file/cross_file.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tus_client_dart/tus_client_dart.dart';
import 'package:url_launcher/url_launcher.dart';

class UploadPage extends StatefulWidget {
  const UploadPage({super.key});

  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  double _progress = 0;
  Duration _estimate = const Duration();
  XFile? _file;
  TusClient? _client;
  Uri? _fileUrl;
  String uid = Supabase.instance.client.auth.currentUser!.id;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TUS Client Upload Demo'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const SizedBox(height: 12),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              child: Text(
                "This demo uses TUS client to upload a file",
                style: TextStyle(fontSize: 18),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(6),
              child: Card(
                color: Colors.teal,
                child: InkWell(
                  onTap: () async {
                    if (!await ensurePermissions()) {
                      return;
                    }

                    _file = await _getXFile();
                    setState(() {
                      _progress = 0;
                      _fileUrl = null;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    child: const Column(
                      children: <Widget>[
                        Icon(Icons.cloud_upload, color: Colors.white, size: 60),
                        Text(
                          "Upload a file",
                          style: TextStyle(fontSize: 25, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _file == null
                          ? null
                          : () async {
                              final tempDir = await getTemporaryDirectory();
                              final tempDirectory = Directory(
                                  '${tempDir.path}/${_file?.name}_uploads');
                              if (!tempDirectory.existsSync()) {
                                tempDirectory.createSync(recursive: true);
                              }

                              // Create a client
                              print("Create a client");
                              _client = TusClient(
                                _file!,
                                store: TusFileStore(tempDirectory),
                                maxChunkSize: 1024 * 1024 * 6,
                                retries: 10, // change as wanted
                                retryInterval: 2, // interval in seconds
                                retryScale: RetryScale.exponential,
                              );

                              print("Starting upload");
                              await _client!.upload(
                                onStart:
                                    (TusClient client, Duration? estimation) {
                                  print(estimation);
                                },
                                onComplete: () async {
                                  print("Completed!");
                                  tempDirectory.deleteSync(recursive: true);
                                  setState(() => _fileUrl = _client!.uploadUrl);
                                },
                                onProgress: (progress, estimate) {
                                  print("Progress: $progress");
                                  print('Estimate: $estimate');
                                  setState(() {
                                    _progress = progress;
                                    _estimate = estimate;
                                  });
                                },
                                uri: Uri.parse(projectUrl),
                                metadata: {
                                  'bucketName': '2022',
                                  'objectName':
                                      '$uid/${_file!.name}', // name to be saved in supabase
                                  'contentType':
                                      'application/octet-stream', //content type, e.g. application/octet-stream
                                  'cacheControl': '3600',
                                },
                                headers: {
                                  'Authorization':
                                      'Bearer ${Supabase.instance.client.auth.currentSession?.accessToken}',
                                  // Set to true to enable overwrite
                                  'x-upsert': 'true'
                                },

                                /*headers: {
                                  'testHeaders': 'testHeaders',
                                  'testHeaders2': 'testHeaders2',
                                },*/
                                measureUploadSpeed: true,
                              );
                            },
                      child: const Text("Upload"),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _progress == 0
                          ? null
                          : () async {
                              _client!.pauseUpload();
                            },
                      child: const Text("Pause"),
                    ),
                  ),
                ],
              ),
            ),
            Stack(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.all(8),
                  padding: const EdgeInsets.all(1),
                  color: Colors.grey,
                  width: double.infinity,
                  child: const Text(" "),
                ),
                FractionallySizedBox(
                  widthFactor: _progress / 100,
                  child: Container(
                    margin: const EdgeInsets.all(8),
                    padding: const EdgeInsets.all(1),
                    color: Colors.green,
                    child: const Text(" "),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(8),
                  padding: const EdgeInsets.all(1),
                  width: double.infinity,
                  child: Text(
                      "Progress: ${_progress.toStringAsFixed(1)}%, estimated time: ${_printDuration(_estimate)}"),
                ),
              ],
            ),
            if (_progress > 0)
              ElevatedButton(
                onPressed: () async {
                  final result = await _client!.cancelUpload();

                  if (result) {
                    setState(() {
                      _progress = 0;
                      _estimate = const Duration();
                    });
                  }
                },
                child: const Text("Cancel"),
              ),
            GestureDetector(
              onTap: _progress != 100
                  ? null
                  : () async {
                      await launchUrl(_fileUrl!);
                    },
              child: Container(
                color: _progress == 100 ? Colors.green : Colors.grey,
                padding: const EdgeInsets.all(8.0),
                margin: const EdgeInsets.all(8.0),
                child:
                    Text(_progress == 100 ? "Link to view:\n $_fileUrl" : "-"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _printDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    final twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return '$twoDigitMinutes:$twoDigitSeconds';
  }

  /// Copy file to temporary directory before uploading
  Future<XFile?> _getXFile() async {
    if (!await ensurePermissions()) {
      return null;
    }

    final result = await FilePicker.platform.pickFiles();

    if (result != null) {
      final chosenFile = result.files.first;
      if (chosenFile.path != null) {
        // Android, iOS, Desktop
        return XFile(chosenFile.path!);
      } else {
        // Web
        return XFile.fromData(
          chosenFile.bytes!,
          name: chosenFile.name,
        );
      }
    }

    return null;
  }

  Future<bool> ensurePermissions() async {
    var enableStorage = true;

    if (Platform.isAndroid) {
      final devicePlugin = DeviceInfoPlugin();
      final androidDeviceInfo = await devicePlugin.androidInfo;
      _androidSdkVersion = androidDeviceInfo.version.sdkInt;
      enableStorage = _androidSdkVersion < 33;
    }

    final storage = enableStorage
        ? await Permission.storage.status
        : PermissionStatus.granted;
    final photos = Platform.isIOS
        ? await Permission.photos.status
        : PermissionStatus.granted;

    return storage.isGranted && photos.isGranted;
  }

  int _androidSdkVersion = 0;
}

Future<XFile> pickFile(List<String> allowedExtensions) async {
  // Function to pick files
  FilePickerResult? result = await FilePicker.platform
      .pickFiles(type: FileType.custom, allowedExtensions: allowedExtensions);
  if (result != null) {
    XFile file = XFile(result.files.single.path!);
    return file;
  } else {
    // User canceled the picker
    return XFile('');
  }
}

Future<void> pickFilesAndUploadToSupabaseWithTUS() async {
  try {
    XFile? file = await pickFile(['pdf']);

    String uid = Supabase.instance.client.auth.currentUser!.id;
    final tempDir = await getTemporaryDirectory();
    final tempDirectory = Directory('${tempDir.path}/${file.name}_uploads');
    if (!tempDirectory.existsSync()) {
      tempDirectory.createSync(recursive: true);
    }
    final tusClient = TusClient(
      file,
      store: TusFileStore(tempDirectory),
      maxChunkSize: 6 * 1024 * 1024, //do not change
      retries: 10, // change as wanted
      retryInterval: 2, // interval in seconds
      retryScale: RetryScale.exponential,
    );
    // Create a new TusClient instance
    /*final tusClient = TusClient(
      file,
      store: TusMemoryStore(tempDirectory),
      retries: 5,
      maxChunkSize: 1024 * 1024,
    );*/
    log(Supabase.instance.client.auth.currentSession?.accessToken.toString() ??
        'tokes is null');
    // function to print progress
    void printOnProgress(double progress, Duration duration) {
      print('Progress: $progress% and $duration time');
    }

    // Starts the upload
    await tusClient.upload(
      uri: Uri.parse(
          // This resolves to our Supabase Storage URL
          projectUrl),
      headers: {
        'Authorization':
            'Bearer ${Supabase.instance.client.auth.currentSession?.accessToken}',
        // Set to true to enable overwrite
        'x-upsert': 'true'
      },
      metadata: {
        'bucketName': '2022',
        'objectName': '$uid/${file.name}',
        'contentType': 'application/pdf',
      },
      onStart: (TusClient client, Duration? estimate) {
        // If estimate is not null, it will provide the estimate time for completion
        // it will only be not null if measuring upload speed
        print('This is the client to be used $client and $estimate time');
      },
      onComplete: () {
        print("Complete!");
        // Prints the uploaded file URL
        print(tusClient.uploadUrl.toString());
      },
      onProgress: printOnProgress,
      // Set this to true if you want to measure upload speed at the start of the upload
      measureUploadSpeed: true,
    );
  } catch (e) {
    log(e.toString());
  }
}

/*resumableUploads({required String filePath, int? fileSize}) async {
  try {
    Uri? fileUrl;
    TusClient client;
    XFile? file = XFile(filePath, length: fileSize);
    final fileName = path.basename(filePath);

    final tempDir = await getTemporaryDirectory();
    final tempDirectory = Directory('${tempDir.path}/${file.name}_uploads');
    if (!tempDirectory.existsSync()) {
      tempDirectory.createSync(recursive: true);
    }
//Create TUS client
    client = TusClient(
      file,
      store: TusFileStore(tempDirectory),
      maxChunkSize: 6 * 1024 * 1024, //do not change
      retries: 10, // change as wanted
      retryInterval: 2, // interval in seconds
      retryScale: RetryScale.exponential,
    );
    await client.upload(
        uri: Uri.parse(projectUrl),
        headers: {
          // 'Authorization': 'Bearer $jwt',
          'x-upsert':
              'true', // set to false to disable overwriting, keep in mind this will throw an error if 2 files have the same name.
        },
        measureUploadSpeed: true,
        metadata: {
          'bucketName': '2022',
          'objectName': 'math/$fileName', // name to be saved in supabase
          //content type, e.g. application/octet-stream
          'cacheControl': '3600',
        },
        onStart: (TusClient client, Duration? estimation) {
          if (estimation != null) {
            print('Started upload. Estimation: $estimation');
          }
        },
        onProgress: (progress, estimate) {
          print('Uploading: Pogress $progress');
          print('Uploading: Estimate $estimate');
        },
        onComplete: () async {
          print('Upload completed!');
          fileUrl = client.uploadUrl;
          print(fileUrl);
        });
  } catch (e) {
    log(e.toString());
  }
}*/

const projectUrl =
    'https://oowclgphdoiksgmztyat.supabase.co/storage/v1/upload/resumable';
