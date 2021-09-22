import 'dart:io';
import 'dart:convert';
import 'dart:async';
import 'dart:math';
import 'package:archive/archive.dart';
import 'package:path/path.dart' as p;
import 'dart:typed_data';
import 'package:pointycastle/pointycastle.dart';
import 'package:collection/collection.dart';
import "package:http/http.dart" as http;

int counter = 0;

Future<void> main(List<String> arguments) async {
  // //OS Variable
  // String os = Platform.operatingSystem;
  // print('OS: ${os} ${Platform.version}');
  //
  // if(Platform.isMacOS){
  //   print('Run MacOS code');
  // }else{
  //   print('Run normal code');
  // }
  //
  // print('Path: ${Platform.script.path}');
  // print('dart: ${Platform.executable}');
  //
  // print('Env: ');
  // Platform.environment.keys.forEach((key) {
  //   print('${key} ${Platform.environment[key]}');
  // });
  //
  // //List all files in a directory
  // Process.run('ls', ['-l']).then(( results) {
  //   print(results.stdout);
  //   print('Exit code: ${results.exitCode}');
  // });
  //
  // //Communicating with process
  // Process.start('cat', []).then((process) {
  //   process.stdout.transform(utf8.decoder).listen((data) { print(data); });
  //   process.stdin.writeln('Hello World!');
  //   Process.killPid(process.pid);
  //   process.exitCode.then((code){
  //     print('Exit code: ${code}');
  //   });
  // });
  //
  // //Timers and callbacks
  // Duration duration = new Duration(seconds: 1);
  // Timer timer = new Timer.periodic(duration, timeOut);
  // print('Started ${getTime()}');
  //
  // //Futures
  // String path = Directory.current.path + '/test.txt';
  // print('Appending to ${path}');
  //
  // File file = new File(path);
  // Future<RandomAccessFile> f = file.open(mode: FileMode.append);
  //
  // f.then((RandomAccessFile raf) {
  //   print('File has been opened');
  //
  //   raf.writeString('Hello World!').then((value){
  //     print('File has been appended');
  //
  //   }).catchError(() => print('An error occured')).whenComplete(() => raf.close());
  // });
  //
  // //Await
  // File? filee = await appendFile();
  // print('Appended to file ${file.path}');
  //
  // //GZIP Compression
  // String data = '';
  // for(int i = 0; i < 100; i++){
  //   data = data + 'Hello World\r\n';
  //
  //   final original = utf8.encode(data);
  //   final compressed = gzip.encode(original);
  //   final decompressed = gzip.decode(compressed);
  //
  //   print('Original ${original.length} bytes');
  //   print('Compressed ${compressed.length} bytes');
  //   print('Decompressed ${decompressed.length} bytes');
  //
  //   String decoded = utf8.decode(decompressed);
  //   assert(data == decoded);
  //   print(decoded);
  // }
  //
  // //ZLIP Compression
  // int ZLIB = testCompress(zlib);
  // int GZIP = testCompress(gzip);
  //
  // print('zlib = ${ZLIB}');
  // print('gzip = ${GZIP}');
  //
  // //Zip Files
  // // List files = [];
  // // Directory.current.listSync().forEach((fse) {
  // //   if(fse.statSync().type == FileSystemEntityType.file) files.add(fse.path);
  // // });
  // //
  // // String zipFile = '/home/rootshell/Videos/test/test.zip';
  // //
  // // zip(files, zipFile);
  // // unzip(zipFile, '/home/rootshell/Videos/test/decompressed' );
  //
  // //Hash
  // Digest digest = new Digest('SHA-256');
  // String value = 'Hello World';
  // Uint8List daata = new Uint8List.fromList(utf8.encode(value));
  // Uint8List hash = digest.process(daata);
  //
  // print(hash);
  // print(base64.encode(hash)); //encoding is not encryption
  //
  // //Deriving Keys
  // String password = 'password';
  // final salt = createUint8ListFromString('salt');
  // final pkcs = KeyDerivator("SHA-1/HMAC/PBKDF2");
  // final params = Pbkdf2Parameters(salt, 100, 16);
  //
  // pkcs.init(params);
  // Uint8List key = pkcs.process(createUint8ListFromString(password));
  // display('Key value', key);
  //
  // //Secure Random Number
  // print(randomBytes(8));
  //
  // //Stream Ciphers
  // final keyBytes = randomBytes(16);
  // final keey = KeyParameter(keyBytes);
  // final iv = randomBytes(8);
  // final pparams = ParametersWithIV(keey, iv);
  //
  // StreamCipher cipher = StreamCipher("Salsa20");
  // cipher.init(true, pparams);
  //
  // String plainText = "Hello World";
  // Uint8List plainData = createUint8ListFromString(plainText);
  // Uint8List encrypted = cipher.process(plainData);
  //
  // cipher.reset();
  // cipher.init(false, pparams);
  // Uint8List decrypted = cipher.process(encrypted);
  //
  // display('Plain Text', plainData);
  // display('Encrypted Data', encrypted);
  // display('Decrypted Data', decrypted);
  //
  // Function eq = const DeepCollectionEquality().equals;
  // assert(eq(decrypted, plainData));
  // print(utf8.decode(decrypted));
  //
  // //Block Ciphers - AES
  // final kkey = randomBytes(16);
  // final ppparams = KeyParameter(kkey);
  //
  // BlockCipher ccipher = BlockCipher("AES");
  // ccipher.init(true, ppparams);
  //
  // String plaintext = 'Hello World';
  // Uint8List plaindata = createUint8ListFromString(plaintext.padRight(ccipher.blockSize));
  // Uint8List encrypted_data = ccipher.process(plaindata);
  //
  // ccipher.reset();
  // ccipher.init(false, ppparams);
  // Uint8List decrypted_data = ccipher.process(encrypted_data);
  //
  // display('Plain text', plaindata);
  // display('Encrypted data', encrypted_data);
  // display('Decrypted data', decrypted_data);
  //
  // Function eqq = const DeepCollectionEquality().equals;
  // assert(eqq(plaindata, decrypted_data));
  //
  // print(utf8.decode(decrypted_data).trim());
  //
  // //TCP Server
  // var serverSocket = await ServerSocket.bind('127.0.0.1', 3000);
  // print('Listening');
  // await for (var socket in serverSocket){
  //   socket.listen((values){
  //     print('${socket.remoteAddress}:${socket.remotePort} = ${utf8.decode(values)}');
  //   });
  // }

  // //TCP Client
  // var sserverSocket = await ServerSocket.bind("127.0.0.1", 3000);
  // print("Listening");
  //
  // await for (var socket in sserverSocket){
  //   socket.listen((values){
  //     print('${socket.remoteAddress}:${socket.remotePort} = ${utf8.decode(values)}');
  //   });
  // }

  // //HTTP Get
  // var url = Uri.parse('http://httpbin.org');
  // var response = await http.get(url);
  // print('Response status: ${response.statusCode}');
  // print('Response body: ${response.body}');

  // //HTTP Post
  // var url = Uri.parse('http://httpbin.org/post');
  // var response = await http.post(url,body: 'name=Bryan&color=blue');
  // print('Response status:: ${response.statusCode}');
  // print('Response body: ${response.body}');

  //UDP Socket
  var data = 'Hello World';
  List<int> dataToSend = utf8.encode(data);
  int port = 3000;

  RawDatagramSocket.bind(InternetAddress.loopbackIPv4, port).then((udpSocket){
    udpSocket.listen((event) {
      if(event == RawSocketEvent.read){
        Datagram? dg = udpSocket.receive();
        print(utf8.decode(dg!.data));
      }
    });

    udpSocket.send(dataToSend, InternetAddress.loopbackIPv4, port);
    print('sent');
  });
}






void timeOut(Timer timer){
  print('Timeout: ${getTime()}');

  counter++;
  if(counter >= 5) timer.cancel();
}

String getTime(){
  DateTime dt = new DateTime.now();
  return dt.toString();
}

Future<File>? appendFile(){
  File file = new File(Directory.current.path+ '/test.txt');
  DateTime now = new DateTime.now();
  return file.writeAsString(now.toString() + '\r\n', mode: FileMode.append);
}

String generateData(){
  String data = '';
  for(int i = 0; i<1000; i++){
    data = data + 'Hello World\r\n';
  }
  return data;
}

int testCompress(var codec){
  String data = generateData();
  final original = utf8.encode(data);
  final compressed = codec.encode(original);
  final decompressed = codec.decode(compressed);

  print('Testing ${codec.toString()}');
  print('Original ${original.length}');
  print('Compressed ${compressed.length}');
  print('Decompressed ${decompressed.length}');

  print('');

  String decoded = utf8.decode(decompressed);
  assert(data == decoded);
  return compressed.length;
}

void zip(List<dynamic> files, String file){
  Archive archive = new Archive();
  files.forEach((path) {
    File file = new File(path);
    ArchiveFile archiveFile = new ArchiveFile(p.basename(path), file.lengthSync(), file.readAsBytesSync());
    archive.addFile(archiveFile);
  });

  ZipEncoder encoder = new ZipEncoder();
  File f = new File(file);
  //f.writeAsBytesSync(encoder.encode(archive));
  print("Compressed");
}

void unzip(String zip, String path){
  File file = new File(zip);
  Archive archive = new ZipDecoder().decodeBytes(file.readAsBytesSync()); 
  
  archive.forEach((archivefile) { 
    File file = new File(path + '/' + archivefile.name);
    file.createSync(recursive: true);
    file.writeAsBytesSync(archivefile.content);
  });

  print('Decompressed');
}

Uint8List createUint8ListFromString(String value) => Uint8List.fromList(utf8.encode(value));
void display(String title, Uint8List value){
  print(title);
  print(value);
  print(base64.encode(value));
}

Uint8List randomBytes(int length){
  final rnd = SecureRandom("AES/CTR/AUTO-SEED-PRNG");
  final key = Uint8List(16);
  final keyParam =  KeyParameter(key);
  final params = ParametersWithIV(keyParam, Uint8List(16));
  rnd.seed(params);

  var random = Random();
  for(int i=0 ; i < random.nextInt(255) ; i++){
    rnd.nextUint8();
  }

  var bytes = rnd.nextBytes(length);
  return bytes;

}