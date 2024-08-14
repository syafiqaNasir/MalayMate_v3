import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'phrasebook.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await _onCreate(db, version);
        await initializeData(db);
      },
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE languages (
        id INTEGER PRIMARY KEY,
        name TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE situations (
        id INTEGER PRIMARY KEY,
        name TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE categories (
        id INTEGER PRIMARY KEY,
        situationId INTEGER,
        name TEXT,
        FOREIGN KEY (situationId) REFERENCES situations (id)
      )
    ''');

    await db.execute('''
      CREATE TABLE phrases (
        id INTEGER PRIMARY KEY,
        languageId INTEGER,
        categoryId INTEGER,
        phrase TEXT,
        translation TEXT,
        FOREIGN KEY (languageId) REFERENCES languages (id),
        FOREIGN KEY (categoryId) REFERENCES categories (id)
      )
    ''');
  }

  Future<void> initializeData(Database db) async {
    await db.insert('languages', {'name': 'MALAY'});
    await db.insert('languages', {'name': 'KELANTAN'});
    await db.insert('languages', {'name': 'TERENGGANU'});
    await db.insert('languages', {'name': 'PAHANG'});
    await db.insert('languages', {'name': 'JOHOR'});
    await db.insert('languages', {'name': 'MELAKA'});
    await db.insert('languages', {'name': 'NEGERI'});
    await db.insert('languages', {'name': 'PERAK'});
    await db.insert('languages', {'name': 'KEDAH'});
    await db.insert('languages', {'name': 'SABAH'});
    await db.insert('languages', {'name': 'SARAWAK'});

    await db.insert('situations', {'name': 'ESSENTIALS'});
    await db.insert('situations', {'name': 'WHILE_TRAVELING'});
    await db.insert('situations', {'name': 'HELP_MEDICAL'});
    await db.insert('situations', {'name': 'AT_HOTEL'});
    await db.insert('situations', {'name': 'AT_RESTAURANT'});
    await db.insert('situations', {'name': 'AT_STORE'});
    await db.insert('situations', {'name': 'AT_WORK'});
    await db.insert('situations', {'name': 'TIME_DATE_NUMBERS'});


    await db.insert('categories', {'situationId': 1, 'name': 'GREETING'});
    await db.insert('categories', {'situationId': 1, 'name': 'BASICS'});
    await db.insert('categories', {'situationId': 1, 'name': 'DIRECTIONS'});
    await db.insert('categories', {'situationId': 1, 'name': 'MONEY'});
    await db.insert('categories', {'situationId': 1, 'name': 'GENERAL'});
    await db.insert('categories', {'situationId': 1, 'name': 'LANGUAGE'});

    await db.insert('categories', {'situationId': 2, 'name': 'DIRECTIONS'});
    await db.insert('categories', {'situationId': 2, 'name': 'MONEY'});
    await db.insert('categories', {'situationId': 2, 'name': 'GENERAL'});
    await db.insert('categories', {'situationId': 2, 'name': 'LANGUAGE'});
    await db.insert('categories', {'situationId': 2, 'name': 'GREETING'});
    await db.insert('categories', {'situationId': 2, 'name': 'LOCATIONS'});
    await db.insert('categories', {'situationId': 2, 'name': 'BUYING TICKETS'});
    await db.insert(
        'categories', {'situationId': 2, 'name': 'PUBLIC TRANSPORTATION'});

    await db.insert(
        'categories', {'situationId': 3, 'name': 'CUSTOMS & IMMIGRATION'});
    await db.insert(
        'categories', {'situationId': 3, 'name': 'ALLERGIES & ASTHMA'});

    await db.insert('categories', {'situationId': 4, 'name': 'CHECK IN'});
    await db.insert(
        'categories', {'situationId': 4, 'name': 'MAKE A RESERVATION'});

    await db.insert('categories', {'situationId': 5, 'name': 'BASICS'});
    await db.insert('categories', {'situationId': 5, 'name': 'DRINKS'});

    await db.insert('categories', {'situationId': 6, 'name': 'DRINKS'});
    await db.insert(
        'categories', {'situationId': 6, 'name': 'PRODUCTS & SECTIONS'});

    await db.insert('categories', {'situationId': 7, 'name': 'GENERAL'});
    await db.insert('categories', {'situationId': 7, 'name': 'CONNECTIVITY'});
    await db.insert('categories', {'situationId': 8, 'name': 'EMAIL'});
    await db.insert('categories', {'situationId': 8, 'name': 'MESSAGING'});
    await db.insert('categories', {'situationId': 8, 'name': 'LOST DEVICES'});


    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 1,
      'phrase': 'Hello',
      'translation': 'Helo'
    });
    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 1,
      'phrase': 'My name is',
      'translation': 'Nama saya'
    });
    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 1,
      'phrase': 'Excuse me',
      'translation': 'Maafkan saya'
    });
    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 1,
      'phrase': 'Goodbye',
      'translation': 'Selamat tinggal'
    });
    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 1,
      'phrase': 'How are you?',
      'translation': 'Apa khabar?'
    });
    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 1,
      'phrase': 'Nice to meet you!',
      'translation': 'Gembira bertemu dengan anda!'
    });

    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 2,
      'phrase': 'Please',
      'translation': 'Tolong'
    });
    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 2,
      'phrase': 'I\'m sorry.',
      'translation': 'Saya minta maaf.'
    });
    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 2,
      'phrase': 'Thank you.',
      'translation': 'Terima kasih.'
    });

    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 3,
      'phrase': 'Left',
      'translation': 'Kiri'
    });
    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 3,
      'phrase': 'Right',
      'translation': 'Kanan'
    });
    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 3,
      'phrase': 'Straight ahead',
      'translation': 'Terus ke hadapan'
    });
    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 3,
      'phrase': 'In ___ meters.',
      'translation': 'Dalam ___ meter.'
    });
    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 3,
      'phrase': 'Traffic light',
      'translation': 'Lampu isyarat'
    });
    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 3,
      'phrase': 'Stop sign',
      'translation': 'Tanda berhenti'
    });
    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 3,
      'phrase': 'North',
      'translation': 'Utara'
    });
    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 3,
      'phrase': 'South',
      'translation': 'Selatan'
    });
    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 3,
      'phrase': 'East',
      'translation': 'Timur'
    });
    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 3,
      'phrase': 'West',
      'translation': 'Barat'
    });

    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 4,
      'phrase': 'Where is the ATM?',
      'translation': 'Di mana ATM?'
    });
    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 4,
      'phrase': 'I want to exchange money.',
      'translation': 'Saya mahu menukar wang.'
    });
    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 4,
      'phrase': 'What is the exchange fee?',
      'translation': 'Berapakah yuran pertukaran?'
    });
    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 4,
      'phrase': 'How much does it cost?',
      'translation': 'Berapakah harganya?'
    });

    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 5,
      'phrase': 'Where is the toilet?',
      'translation': 'Di mana tandas?'
    });
    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 5,
      'phrase': 'Where is the grocery store?',
      'translation': 'Di mana kedai runcit?'
    });
    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 5,
      'phrase': 'This is an emergency!',
      'translation': 'Ini adalah kecemasan!'
    });
    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 5,
      'phrase': 'I need help.',
      'translation': 'Saya perlukan bantuan.'
    });

    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 6,
      'phrase': 'Do you speak ___?',
      'translation': 'Adakah anda bercakap ___?'
    });
    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 6,
      'phrase': 'I don\'t speak ___.',
      'translation': 'Saya tidak bercakap ___.'
    });
    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 6,
      'phrase': 'I don\'t understand.',
      'translation': 'Saya tidak faham.'
    });
    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 6,
      'phrase': 'I speak ___.',
      'translation': 'Saya bercakap ___.'
    });

    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 7,
      'phrase': 'Left',
      'translation': 'Kiri'
    });
    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 7,
      'phrase': 'Right',
      'translation': 'Kanan'
    });
    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 7,
      'phrase': 'Straight ahead',
      'translation': 'Terus ke hadapan'
    });
    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 7,
      'phrase': 'In ___ meters.',
      'translation': 'Dalam ___ meter.'
    });
    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 7,
      'phrase': 'Traffic light',
      'translation': 'Lampu isyarat'
    });
    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 7,
      'phrase': 'Stop sign',
      'translation': 'Tanda berhenti'
    });
    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 7,
      'phrase': 'North',
      'translation': 'Utara'
    });
    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 7,
      'phrase': 'South',
      'translation': 'Selatan'
    });
    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 7,
      'phrase': 'East',
      'translation': 'Timur'
    });
    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 7,
      'phrase': 'West',
      'translation': 'Barat'
    });

    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 8,
      'phrase': 'Where is the ATM?',
      'translation': 'Di mana ATM?'
    });
    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 8,
      'phrase': 'I want to exchange money.',
      'translation': 'Saya mahu menukar wang.'
    });
    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 8,
      'phrase': 'What is the exchange fee?',
      'translation': 'Berapakah yuran pertukaran?'
    });
    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 8,
      'phrase': 'How much does it cost?',
      'translation': 'Berapakah harganya?'
    });

    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 9,
      'phrase': 'Where is the toilet?',
      'translation': 'Di mana tandas?'
    });
    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 9,
      'phrase': 'Where is the grocery store?',
      'translation': 'Di mana kedai runcit?'
    });
    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 9,
      'phrase': 'This is an emergency!',
      'translation': 'Ini adalah kecemasan!'
    });
    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 9,
      'phrase': 'I need help.',
      'translation': 'Saya perlukan bantuan.'
    });

    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 10,
      'phrase': 'Do you speak ___?',
      'translation': 'Adakah anda bercakap ___?'
    });
    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 10,
      'phrase': 'I don\'t speak ___.',
      'translation': 'Saya tidak bercakap ___.'
    });
    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 10,
      'phrase': 'I don\'t understand.',
      'translation': 'Saya tidak faham.'
    });
    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 10,
      'phrase': 'I speak ___.',
      'translation': 'Saya bercakap ___.'
    });

    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 11,
      'phrase': 'Hello',
      'translation': 'Helo'
    });
    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 11,
      'phrase': 'My name is __.',
      'translation': 'Nama saya __.'
    });
    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 11,
      'phrase': 'Excuse me',
      'translation': 'Maafkan saya'
    });
    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 11,
      'phrase': 'Goodbye',
      'translation': 'Selamat tinggal'
    });
    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 11,
      'phrase': 'How are you?',
      'translation': 'Apa khabar?'
    });
    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 11,
      'phrase': 'Nice to meet you!',
      'translation': 'Gembira bertemu dengan anda!'
    });

    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 12,
      'phrase': 'Where is the airport?',
      'translation': 'Di mana lapangan terbang?'
    });
    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 12,
      'phrase': 'Where is the train station?',
      'translation': 'Di mana stesen kereta api?'
    });
    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 12,
      'phrase': 'Where is the subway?',
      'translation': 'Di mana kereta api bawah tanah?'
    });
    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 12,
      'phrase': 'Where is the bus station?',
      'translation': 'Di mana stesen bas?'
    });
    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 12,
      'phrase': 'Where is the ___ museum?',
      'translation': 'Di mana muzium ___?'
    });
    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 12,
      'phrase': 'Where is a good restaurant?',
      'translation': 'Di mana restoran yang baik?'
    });
    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 12,
      'phrase': 'Where is a nice coffee place?',
      'translation': 'Di mana kedai kopi yang bagus?'
    });
    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 12,
      'phrase': 'Where is a nice bar?',
      'translation': 'Di mana bar yang bagus?'
    });

    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 13,
      'phrase': 'Where can I buy a ticket?',
      'translation': 'Di mana saya boleh membeli tiket?'
    });
    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 13,
      'phrase': 'How much is a ticket?',
      'translation': 'Berapakah harga tiket?'
    });
    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 13,
      'phrase': 'I need ___ tickets, please.',
      'translation': 'Saya perlukan ___ tiket, tolong.'
    });
    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 13,
      'phrase': 'I would like to change my ticket.',
      'translation': 'Saya ingin menukar tiket saya.'
    });

    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 14,
      'phrase': 'Which platform?',
      'translation': 'Platform yang mana?'
    });
    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 14,
      'phrase': 'Where is the platform?',
      'translation': 'Di mana platform?'
    });
    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 14,
      'phrase': 'Where should I get off?',
      'translation': 'Di mana saya perlu turun?'
    });
    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 14,
      'phrase': 'I\'d like to get off at ___.',
      'translation': 'Saya ingin turun di ___.'
    });
    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 14,
      'phrase': 'Where do I change trains?',
      'translation': 'Di mana saya menukar kereta api?'
    });
    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 14,
      'phrase': 'Where do I change buses?',
      'translation': 'Di mana saya menukar bas?'
    });

    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 15,
      'phrase': 'Here is my passport.',
      'translation': 'Ini pasport saya.'
    });
    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 15,
      'phrase': 'Do I need a visa?',
      'translation': 'Adakah saya perlukan visa?'
    });
    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 15,
      'phrase': 'I am an immigrant.',
      'translation': 'Saya seorang imigran.'
    });
    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 15,
      'phrase': 'I am a refugee.',
      'translation': 'Saya seorang pelarian.'
    });
    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 15,
      'phrase': 'I have nothing to declare.',
      'translation': 'Saya tiada apa-apa untuk diisytiharkan.'
    });
    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 15,
      'phrase': 'I have something to declare.',
      'translation': 'Saya ada sesuatu untuk diisytiharkan.'
    });

    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 16,
      'phrase': 'I have allergies.',
      'translation': 'Saya mempunyai alahan.'
    });
    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 16,
      'phrase': 'I am allergic to ___.',
      'translation': 'Saya alah kepada ___.'
    });
    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 16,
      'phrase': 'I am allergic to penicillin.',
      'translation': 'Saya alah kepada penisilin.'
    });
    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 16,
      'phrase': 'I am allergic to antibiotics.',
      'translation': 'Saya alah kepada antibiotik.'
    });
    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 16,
      'phrase': 'I have Asthma.',
      'translation': 'Saya menghidap asma.'
    });

    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 17,
      'phrase': 'I would like to check in.',
      'translation': 'Saya ingin mendaftar masuk.'
    });
    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 17,
      'phrase': 'I would like to change my reservation.',
      'translation': 'Saya ingin menukar tempahan saya.'
    });
    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 17,
      'phrase': 'Can we have a room with ___ view?',
      'translation': 'Bolehkah kami mendapatkan bilik dengan pemandangan ___?'
    });
    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 17,
      'phrase': 'When does breakfast start?',
      'translation': 'Bila sarapan bermula?'
    });
    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 17,
      'phrase': 'When does lunch start?',
      'translation': 'Bila makan tengahari bermula?'
    });
    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 17,
      'phrase': 'When does dinner start?',
      'translation': 'Bila makan malam bermula?'
    });
    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 17,
      'phrase': 'When is check out?',
      'translation': 'Bila waktu daftar keluar?'
    });
    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 17,
      'phrase': 'My room needs to be cleaned.',
      'translation': 'Bilik saya perlu dibersihkan.'
    });

    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 18,
      'phrase': 'Do you have free rooms?',
      'translation': 'Adakah anda mempunyai bilik percuma?'
    });
    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 18,
      'phrase': 'I would like ___ rooms.',
      'translation': 'Saya ingin ___ bilik.'
    });
    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 18,
      'phrase': 'We are ___ people.',
      'translation': 'Kami ___ orang.'
    });
    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 18,
      'phrase': 'How much does the room cost?',
      'translation': 'Berapakah kos bilik?'
    });
    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 18,
      'phrase': 'Is it air conditioned?',
      'translation': 'Adakah ia berpenyaman udara?'
    });
    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 18,
      'phrase': 'Is there room service?',
      'translation': 'Adakah terdapat perkhidmatan bilik?'
    });
    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 18,
      'phrase': 'Is breakfast included?',
      'translation': 'Adakah sarapan termasuk?'
    });
    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 18,
      'phrase': 'Is lunch included?',
      'translation': 'Adakah makan tengahari termasuk?'
    });
    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 18,
      'phrase': 'Is dinner included?',
      'translation': 'Adakah makan malam termasuk?'
    });
    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 18,
      'phrase': 'Is there a restaurant?',
      'translation': 'Adakah terdapat restoran?'
    });
    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 18,
      'phrase': 'When is check out?',
      'translation': 'Bila waktu daftar keluar?'
    });

    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 19,
      'phrase': 'May I see the menu?',
      'translation': 'Bolehkah saya lihat menu?'
    });
    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 19,
      'phrase': 'I would like to order __.',
      'translation': 'Saya ingin memesan __.'
    });
    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 19,
      'phrase': 'I would like breakfast.',
      'translation': 'Saya ingin sarapan.'
    });
    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 19,
      'phrase': 'I would like lunch.',
      'translation': 'Saya ingin makan tengahari.'
    });
    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 19,
      'phrase': 'I would like dinner.',
      'translation': 'Saya ingin makan malam.'
    });
    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 19,
      'phrase': 'I\'m a vegetarian.',
      'translation': 'Saya seorang vegetarian.'
    });
    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 19,
      'phrase': 'I\'m vegan.',
      'translation': 'Saya seorang vegan.'
    });
    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 19,
      'phrase': 'I don\'t eat pork.',
      'translation': 'Saya tidak makan daging babi.'
    });
    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 19,
      'phrase': 'I don\'t eat beef.',
      'translation': 'Saya tidak makan daging lembu.'
    });
    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 19,
      'phrase': 'I don\'t eat __.',
      'translation': 'Saya tidak makan __.'
    });
    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 19,
      'phrase': 'The bill please.',
      'translation': 'Bil, tolong.'
    });

    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 20,
      'phrase': 'I would like some __.',
      'translation': 'Saya ingin sedikit __.'
    });
    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 20,
      'phrase': 'I would like some bottled water.',
      'translation': 'Saya ingin sedikit air botol.'
    });
    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 20,
      'phrase': 'I would like some carbonated water.',
      'translation': 'Saya ingin sedikit air berkarbonat.'
    });
    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 20,
      'phrase': 'No ice.',
      'translation': 'Tanpa ais.'
    });
    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 20,
      'phrase': 'With ice.',
      'translation': 'Dengan ais.'
    });

    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 21,
      'phrase': 'I would like some __.',
      'translation': 'Saya ingin sedikit __.'
    });
    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 21,
      'phrase': 'I would like some bottled water.',
      'translation': 'Saya ingin sedikit air botol.'
    });
    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 21,
      'phrase': 'I would like some carbonated water.',
      'translation': 'Saya ingin sedikit air berkarbonat.'
    });
    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 21,
      'phrase': 'No ice.',
      'translation': 'Tanpa ais.'
    });
    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 21,
      'phrase': 'With ice.',
      'translation': 'Dengan ais.'
    });

    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 22,
      'phrase': 'Where is the milk?',
      'translation': 'Di mana susu?'
    });
    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 22,
      'phrase': 'Where are the eggs?',
      'translation': 'Di mana telur?'
    });
    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 22,
      'phrase': 'Where is the ice cream?',
      'translation': 'Di mana aiskrim?'
    });
    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 22,
      'phrase': 'Where is the bottled water?',
      'translation': 'Di mana air botol?'
    });
    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 22,
      'phrase': 'Where are the soft drinks?',
      'translation': 'Di mana minuman ringan?'
    });
    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 22,
      'phrase': 'Where are the fruits?',
      'translation': 'Di mana buah-buahan?'
    });
    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 22,
      'phrase': 'Where are the vegetables?',
      'translation': 'Di mana sayur-sayuran?'
    });
    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 22,
      'phrase': 'Where is the meat?',
      'translation': 'Di mana daging?'
    });
    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 22,
      'phrase': 'Where is the bread?',
      'translation': 'Di mana roti?'
    });
    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 22,
      'phrase': 'Where is the beer?',
      'translation': 'Di mana bir?'
    });
    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 22,
      'phrase': 'Where is the wine?',
      'translation': 'Di mana wain?'
    });

    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 23,
      'phrase': 'I need a phone charger.',
      'translation': 'Saya perlukan pengecas telefon.'
    });
    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 23,
      'phrase': 'I need to check my email.',
      'translation': 'Saya perlu memeriksa e-mel saya.'
    });
    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 23,
      'phrase': 'Can you change it to English?',
      'translation': 'Bolehkah anda menukarnya ke bahasa Inggeris?'
    });
    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 23,
      'phrase': 'I need a printer.',
      'translation': 'Saya perlukan pencetak.'
    });
    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 23,
      'phrase': 'I need a __.',
      'translation': 'Saya perlukan __.'
    });

    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 24,
      'phrase': 'Is there Wi-Fi?',
      'translation': 'Adakah terdapat Wi-Fi?'
    });
    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 24,
      'phrase': 'What is the password?',
      'translation': 'Apakah kata laluan?'
    });
    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 24,
      'phrase': 'The Wi-fi isn\'t working.',
      'translation': 'Wi-Fi tidak berfungsi.'
    });

    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 25,
      'phrase': 'What is your email?',
      'translation': 'Apakah e-mel anda?'
    });
    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 25,
      'phrase': 'I need to check my emails.',
      'translation': 'Saya perlu memeriksa e-mel saya.'
    });
    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 25,
      'phrase': 'Can you email it to me?',
      'translation': 'Bolehkah anda e-melkan kepada saya?'
    });

    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 26,
      'phrase': 'Can you send it to me?',
      'translation': 'Bolehkah anda menghantarnya kepada saya?'
    });
    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 26,
      'phrase': 'Can you message it to me?',
      'translation': 'Bolehkah anda mesejkannya kepada saya?'
    });
    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 26,
      'phrase': 'Can you Whatsapp it to me?',
      'translation': 'Bolehkah anda Whatsappkannya kepada saya?'
    });

    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 27,
      'phrase': 'I lost my phone.',
      'translation': 'Saya kehilangan telefon saya.'
    });
    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 27,
      'phrase': 'I lost my laptop.',
      'translation': 'Saya kehilangan komputer riba saya.'
    });
    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 27,
      'phrase': 'I lost my __.',
      'translation': 'Saya kehilangan __.'
    });

    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 28,
      'phrase': 'Monday',
      'translation': 'Isnin'
    });
    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 28,
      'phrase': 'Tuesday',
      'translation': 'Selasa'
    });
    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 28,
      'phrase': 'Wednesday',
      'translation': 'Rabu'
    });
    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 28,
      'phrase': 'Thursday',
      'translation': 'Khamis'
    });
    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 28,
      'phrase': 'Friday',
      'translation': 'Jumaat'
    });
    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 28,
      'phrase': 'Saturday',
      'translation': 'Sabtu'
    });
    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 28,
      'phrase': 'Sunday',
      'translation': 'Ahad'
    });

    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 29,
      'phrase': 'Morning',
      'translation': 'Pagi'
    });
    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 29,
      'phrase': 'Noon',
      'translation': 'Tengahari'
    });
    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 29,
      'phrase': 'Afternoon',
      'translation': 'Petang'
    });
    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 29,
      'phrase': 'Evening',
      'translation': 'Malam'
    });
    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 29,
      'phrase': 'Night',
      'translation': 'Malam'
    });
    await db.insert('phrases', {
      'languageId': 1,
      'categoryId': 29,
      'phrase': 'Midnight',
      'translation': 'Tengah malam'
    });

    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 1,
      'phrase': 'Hello',
      'translation': 'Alo'
    });
    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 1,
      'phrase': 'My name is',
      'translation': 'Nammo kawe'
    });
    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 1,
      'phrase': 'Excuse me',
      'translation': 'Sori laa'
    });
    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 1,
      'phrase': 'Goodbye',
      'translation': 'Selamok tinggal'
    });
    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 1,
      'phrase': 'How are you?',
      'translation': 'Gapo khabar?'
    });
    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 1,
      'phrase': 'Nice to meet you!',
      'translation': 'Suke tengok demo!'
    });

    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 2,
      'phrase': 'Please',
      'translation': 'Tolong laa'
    });
    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 2,
      'phrase': 'I\'m sorry.',
      'translation': 'Kawe minta maaf.'
    });
    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 2,
      'phrase': 'Thank you.',
      'translation': 'Teri Mokaseh.'
    });

    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 3,
      'phrase': 'Left',
      'translation': 'Kiro'
    });
    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 3,
      'phrase': 'Right',
      'translation': 'Kanan'
    });
    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 3,
      'phrase': 'Straight ahead',
      'translation': 'Terus ke depe'
    });
    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 3,
      'phrase': 'In ___ meters.',
      'translation': 'Dalam ___ meter.'
    });
    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 3,
      'phrase': 'Traffic light',
      'translation': 'Lampu isyarak'
    });
    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 3,
      'phrase': 'Stop sign',
      'translation': 'Tanda berenti'
    });
    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 3,
      'phrase': 'North',
      'translation': 'Utare'
    });
    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 3,
      'phrase': 'South',
      'translation': 'Selate'
    });
    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 3,
      'phrase': 'East',
      'translation': 'Timur'
    });
    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 3,
      'phrase': 'West',
      'translation': 'Barat'
    });

    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 4,
      'phrase': 'Where is the ATM?',
      'translation': 'Male ATM mano?'
    });
    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 4,
      'phrase': 'I want to exchange money.',
      'translation': 'Kawe nok tukor pitih.'
    });
    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 4,
      'phrase': 'What is the exchange fee?',
      'translation': 'Brp bayor yuran tukor?'
    });
    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 4,
      'phrase': 'How much does it cost?',
      'translation': 'Brp hargo?'
    });

    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 5,
      'phrase': 'Where is the toilet?',
      'translation': 'Male jambang mano?'
    });
    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 5,
      'phrase': 'Where is the grocery store?',
      'translation': 'Male kdai runcik mano?'
    });
    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 5,
      'phrase': 'This is an emergency!',
      'translation': 'Ni kecemase!'
    });
    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 5,
      'phrase': 'I need help.',
      'translation': 'Kawe perlu tolong.'
    });

    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 6,
      'phrase': 'Do you speak ___?',
      'translation': 'Demo kecek ___?'
    });
    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 6,
      'phrase': 'I don\'t speak ___.',
      'translation': 'Kawe tak kecek ___.'
    });
    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 6,
      'phrase': 'I don\'t understand.',
      'translation': 'Kawe tak paham.'
    });
    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 6,
      'phrase': 'I speak ___.',
      'translation': 'Kawe kecek ___.'
    });

    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 7,
      'phrase': 'Left',
      'translation': 'Kiro'
    });
    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 7,
      'phrase': 'Right',
      'translation': 'Kanan'
    });
    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 7,
      'phrase': 'Straight ahead',
      'translation': 'Terus ke depe'
    });
    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 7,
      'phrase': 'In ___ meters.',
      'translation': 'Dalam ___ meter.'
    });
    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 7,
      'phrase': 'Traffic light',
      'translation': 'Lampu isyarak'
    });
    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 7,
      'phrase': 'Stop sign',
      'translation': 'Tanda berenti'
    });
    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 7,
      'phrase': 'North',
      'translation': 'Utare'
    });
    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 7,
      'phrase': 'South',
      'translation': 'Selate'
    });
    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 7,
      'phrase': 'East',
      'translation': 'Timur'
    });
    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 7,
      'phrase': 'West',
      'translation': 'Barat'
    });

    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 8,
      'phrase': 'Where is the ATM?',
      'translation': 'Male ATM mano?'
    });
    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 8,
      'phrase': 'I want to exchange money.',
      'translation': 'Kawe nok tukor pitih.'
    });
    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 8,
      'phrase': 'What is the exchange fee?',
      'translation': 'Brp bayor yuran tukor?'
    });
    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 8,
      'phrase': 'How much does it cost?',
      'translation': 'Brp hargo?'
    });

    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 9,
      'phrase': 'Where is the toilet?',
      'translation': 'Male jambang mano?'
    });
    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 9,
      'phrase': 'Where is the grocery store?',
      'translation': 'Male kdai runcik mano?'
    });
    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 9,
      'phrase': 'This is an emergency!',
      'translation': 'Ni kecemase!'
    });
    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 9,
      'phrase': 'I need help.',
      'translation': 'Kawe perlu tolong.'
    });

    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 10,
      'phrase': 'Do you speak ___?',
      'translation': 'Demo kecek ___?'
    });
    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 10,
      'phrase': 'I don\'t speak ___.',
      'translation': 'Kawe tak kecek ___.'
    });
    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 10,
      'phrase': 'I don\'t understand.',
      'translation': 'Kawe tak paham.'
    });
    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 10,
      'phrase': 'I speak ___.',
      'translation': 'Kawe kecek ___.'
    });

    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 11,
      'phrase': 'Hello',
      'translation': 'Alo'
    });
    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 11,
      'phrase': 'My name is __.',
      'translation': 'Nammo kawe __.'
    });
    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 11,
      'phrase': 'Excuse me',
      'translation': 'Sori laa'
    });
    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 11,
      'phrase': 'Goodbye',
      'translation': 'Selamok tinggal'
    });
    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 11,
      'phrase': 'How are you?',
      'translation': 'Gapo khabar?'
    });
    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 11,
      'phrase': 'Nice to meet you!',
      'translation': 'Suke tengok demo!'
    });

    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 12,
      'phrase': 'Where is the airport?',
      'translation': 'Male lapang tebang mano?'
    });
    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 12,
      'phrase': 'Where is the train station?',
      'translation': 'Male stesen kereta api mano?'
    });
    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 12,
      'phrase': 'Where is the subway?',
      'translation': 'Male kereta api bawah tanah mano?'
    });
    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 12,
      'phrase': 'Where is the bus station?',
      'translation': 'Male stesen bas mano?'
    });
    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 12,
      'phrase': 'Where is the ___ museum?',
      'translation': 'Male muzium ___ mano?'
    });
    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 12,
      'phrase': 'Where is a good restaurant?',
      'translation': 'Male restoran molo?'
    });
    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 12,
      'phrase': 'Where is a nice coffee place?',
      'translation': 'Male kdai kopi molo?'
    });
    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 12,
      'phrase': 'Where is a nice bar?',
      'translation': 'Male bar molo?'
    });

    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 13,
      'phrase': 'Where can I buy a ticket?',
      'translation': 'Male nok beli tiket mano?'
    });
    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 13,
      'phrase': 'How much is a ticket?',
      'translation': 'Brp hargo tiket?'
    });
    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 13,
      'phrase': 'I need ___ tickets, please.',
      'translation': 'Kawe nok ___ tiket, tolong.'
    });
    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 13,
      'phrase': 'I would like to change my ticket.',
      'translation': 'Kawe nok tukar tiket kawe.'
    });

    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 14,
      'phrase': 'Which platform?',
      'translation': 'Platform mano?'
    });
    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 14,
      'phrase': 'Where is the platform?',
      'translation': 'Male platform mano?'
    });
    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 14,
      'phrase': 'Where should I get off?',
      'translation': 'Male nok turun mano?'
    });
    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 14,
      'phrase': 'I\'d like to get off at ___.',
      'translation': 'Kawe nok turun di ___.'
    });
    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 14,
      'phrase': 'Where do I change trains?',
      'translation': 'Male nok tukar kereta api mano?'
    });
    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 14,
      'phrase': 'Where do I change buses?',
      'translation': 'Male nok tukar bas mano?'
    });

    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 15,
      'phrase': 'Here is my passport.',
      'translation': 'Ni pasport kawe.'
    });
    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 15,
      'phrase': 'Do I need a visa?',
      'translation': 'Kawe perlu visa ko?'
    });
    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 15,
      'phrase': 'I am an immigrant.',
      'translation': 'Kawe se ore pindah.'
    });
    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 15,
      'phrase': 'I am a refugee.',
      'translation': 'Kawe se ore pelare.'
    });
    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 15,
      'phrase': 'I have nothing to declare.',
      'translation': 'Kawe dokdok gapo nok diistiharkan.'
    });
    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 15,
      'phrase': 'I have something to declare.',
      'translation': 'Kawe ado gapo nok diistiharkan.'
    });

    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 16,
      'phrase': 'I have allergies.',
      'translation': 'Kawe aloh alahan.'
    });
    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 16,
      'phrase': 'I am allergic to ___.',
      'translation': 'Kawe alah ko ___.'
    });
    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 16,
      'phrase': 'I am allergic to penicillin.',
      'translation': 'Kawe alah ko penisilin.'
    });
    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 16,
      'phrase': 'I am allergic to antibiotics.',
      'translation': 'Kawe alah ko antibiotik.'
    });
    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 16,
      'phrase': 'I have Asthma.',
      'translation': 'Kawe asmo.'
    });

    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 17,
      'phrase': 'I would like to check in.',
      'translation': 'Kawe nok check in.'
    });
    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 17,
      'phrase': 'I would like to change my reservation.',
      'translation': 'Kawe nok tukar tempoh kawe.'
    });
    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 17,
      'phrase': 'Can we have a room with ___ view?',
      'translation': 'Buleh ko bilik kawe view ___?'
    });
    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 17,
      'phrase': 'When does breakfast start?',
      'translation': 'Bilo sarapo start?'
    });
    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 17,
      'phrase': 'When does lunch start?',
      'translation': 'Bilo makang tengohari start?'
    });
    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 17,
      'phrase': 'When does dinner start?',
      'translation': 'Bilo makang maley start?'
    });
    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 17,
      'phrase': 'When is check out?',
      'translation': 'Bilo nok check out?'
    });
    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 17,
      'phrase': 'My room needs to be cleaned.',
      'translation': 'Bilik kawe perlu bersih.'
    });

    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 18,
      'phrase': 'Do you have free rooms?',
      'translation': 'Demo ado bilik free ko?'
    });
    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 18,
      'phrase': 'I would like ___ rooms.',
      'translation': 'Kawe nok ___ bilik.'
    });
    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 18,
      'phrase': 'We are ___ people.',
      'translation': 'Kawe ___ ore.'
    });
    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 18,
      'phrase': 'How much does the room cost?',
      'translation': 'Brp hargo bilik?'
    });
    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 18,
      'phrase': 'Is it air conditioned?',
      'translation': 'Bilik ado aircon ko?'
    });
    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 18,
      'phrase': 'Is there room service?',
      'translation': 'Bilik ado servis ko?'
    });
    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 18,
      'phrase': 'Is breakfast included?',
      'translation': 'Sarapo included dok?'
    });
    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 18,
      'phrase': 'Is lunch included?',
      'translation': 'Makang tengohari included dok?'
    });
    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 18,
      'phrase': 'Is dinner included?',
      'translation': 'Makang maley included dok?'
    });
    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 18,
      'phrase': 'Is there a restaurant?',
      'translation': 'Ado restoran dok?'
    });
    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 18,
      'phrase': 'When is check out?',
      'translation': 'Bilo nok check out?'
    });

    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 19,
      'phrase': 'May I see the menu?',
      'translation': 'Buleh ko kawe tengok menu?'
    });
    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 19,
      'phrase': 'I would like to order __.',
      'translation': 'Kawe nok order __.'
    });
    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 19,
      'phrase': 'I would like breakfast.',
      'translation': 'Kawe nok sarapo.'
    });
    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 19,
      'phrase': 'I would like lunch.',
      'translation': 'Kawe nok makang tengohari.'
    });
    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 19,
      'phrase': 'I would like dinner.',
      'translation': 'Kawe nok makang maley.'
    });
    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 19,
      'phrase': 'I\'m a vegetarian.',
      'translation': 'Kawe vegetarian.'
    });
    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 19,
      'phrase': 'I\'m vegan.',
      'translation': 'Kawe vegan.'
    });
    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 19,
      'phrase': 'I don\'t eat pork.',
      'translation': 'Kawe dok makan daging babi.'
    });
    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 19,
      'phrase': 'I don\'t eat beef.',
      'translation': 'Kawe dok makan daging lembu.'
    });
    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 19,
      'phrase': 'I don\'t eat __.',
      'translation': 'Kawe dok makan __.'
    });
    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 19,
      'phrase': 'The bill please.',
      'translation': 'Bil, tolong.'
    });

    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 20,
      'phrase': 'I would like some __.',
      'translation': 'Kawe nok __ sikik.'
    });
    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 20,
      'phrase': 'I would like some bottled water.',
      'translation': 'Kawe nok air botol.'
    });
    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 20,
      'phrase': 'I would like some carbonated water.',
      'translation': 'Kawe nok air berkarbonat.'
    });
    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 20,
      'phrase': 'No ice.',
      'translation': 'Tanpo ais.'
    });
    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 20,
      'phrase': 'With ice.',
      'translation': 'Dengan ais.'
    });

    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 21,
      'phrase': 'I would like some __.',
      'translation': 'Kawe nok __ sikik.'
    });
    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 21,
      'phrase': 'I would like some bottled water.',
      'translation': 'Kawe nok air botol.'
    });
    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 21,
      'phrase': 'I would like some carbonated water.',
      'translation': 'Kawe nok air berkarbonat.'
    });
    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 21,
      'phrase': 'No ice.',
      'translation': 'Tanpo ais.'
    });
    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 21,
      'phrase': 'With ice.',
      'translation': 'Dengan ais.'
    });

    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 22,
      'phrase': 'Where is the milk?',
      'translation': 'Male susu mano?'
    });
    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 22,
      'phrase': 'Where are the eggs?',
      'translation': 'Male telur mano?'
    });
    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 22,
      'phrase': 'Where is the ice cream?',
      'translation': 'Male aiskrim mano?'
    });
    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 22,
      'phrase': 'Where is the bottled water?',
      'translation': 'Male air botol mano?'
    });
    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 22,
      'phrase': 'Where are the soft drinks?',
      'translation': 'Male minuman ringan mano?'
    });
    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 22,
      'phrase': 'Where are the fruits?',
      'translation': 'Male buoh mano?'
    });
    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 22,
      'phrase': 'Where are the vegetables?',
      'translation': 'Male sayur mano?'
    });
    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 22,
      'phrase': 'Where is the meat?',
      'translation': 'Male daging mano?'
    });
    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 22,
      'phrase': 'Where is the bread?',
      'translation': 'Male roti mano?'
    });
    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 22,
      'phrase': 'Where is the beer?',
      'translation': 'Male bir mano?'
    });
    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 22,
      'phrase': 'Where is the wine?',
      'translation': 'Male wain mano?'
    });

    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 23,
      'phrase': 'I need a phone charger.',
      'translation': 'Kawe perlu pengecas telefon.'
    });
    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 23,
      'phrase': 'I need to check my email.',
      'translation': 'Kawe perlu cek email kawe.'
    });
    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 23,
      'phrase': 'Can you change it to English?',
      'translation': 'Buleh ko tukar ke Inggerih?'
    });
    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 23,
      'phrase': 'I need a printer.',
      'translation': 'Kawe perlu printer.'
    });
    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 23,
      'phrase': 'I need a __.',
      'translation': 'Kawe perlu __.'
    });

    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 24,
      'phrase': 'Is there Wi-Fi?',
      'translation': 'Ado Wi-Fi dok?'
    });
    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 24,
      'phrase': 'What is the password?',
      'translation': 'Gapo password?'
    });
    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 24,
      'phrase': 'The Wi-fi isn\'t working.',
      'translation': 'Wi-Fi tak berfungsi.'
    });

    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 25,
      'phrase': 'What is your email?',
      'translation': 'Gapo email demo?'
    });
    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 25,
      'phrase': 'I need to check my emails.',
      'translation': 'Kawe perlu cek email kawe.'
    });
    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 25,
      'phrase': 'Can you email it to me?',
      'translation': 'Buleh ko email ke kawe?'
    });

    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 26,
      'phrase': 'Can you send it to me?',
      'translation': 'Buleh ko hantar ke kawe?'
    });
    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 26,
      'phrase': 'Can you message it to me?',
      'translation': 'Buleh ko mesej ke kawe?'
    });
    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 26,
      'phrase': 'Can you Whatsapp it to me?',
      'translation': 'Buleh ko Whatsapp ke kawe?'
    });

    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 27,
      'phrase': 'I lost my phone.',
      'translation': 'Kawe hilang telefon.'
    });
    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 27,
      'phrase': 'I lost my laptop.',
      'translation': 'Kawe hilang laptop.'
    });
    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 27,
      'phrase': 'I lost my __.',
      'translation': 'Kawe hilang __.'
    });

    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 28,
      'phrase': 'Monday',
      'translation': 'Isning'
    });
    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 28,
      'phrase': 'Tuesday',
      'translation': 'Selase'
    });
    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 28,
      'phrase': 'Wednesday',
      'translation': 'Rabu'
    });
    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 28,
      'phrase': 'Thursday',
      'translation': 'Khamih'
    });
    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 28,
      'phrase': 'Friday',
      'translation': 'Jumaat'
    });
    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 28,
      'phrase': 'Saturday',
      'translation': 'Satu'
    });
    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 28,
      'phrase': 'Sunday',
      'translation': 'Aha'
    });

    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 29,
      'phrase': 'Morning',
      'translation': 'Pagi'
    });
    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 29,
      'phrase': 'Noon',
      'translation': 'Tengahari'
    });
    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 29,
      'phrase': 'Afternoon',
      'translation': 'Petang'
    });
    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 29,
      'phrase': 'Evening',
      'translation': 'Malam'
    });
    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 29,
      'phrase': 'Night',
      'translation': 'Malam'
    });
    await db.insert('phrases', {
      'languageId': 2,
      'categoryId': 29,
      'phrase': 'Midnight',
      'translation': 'Tengah malam'
    });

    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 1,
      'phrase': 'Hello',
      'translation': 'Alo'
    });
    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 1,
      'phrase': 'My name is',
      'translation': 'Nama saye'
    });
    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 1,
      'phrase': 'Excuse me',
      'translation': 'Pah cer'
    });
    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 1,
      'phrase': 'Goodbye',
      'translation': 'Selamat tinggal'
    });
    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 1,
      'phrase': 'How are you?',
      'translation': 'Gane mu?'
    });
    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 1,
      'phrase': 'Nice to meet you!',
      'translation': 'Seronok jumpe mu!'
    });

    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 2,
      'phrase': 'Please',
      'translation': 'Tolonge'
    });
    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 2,
      'phrase': 'I\'m sorry.',
      'translation': 'Saye minta maap.'
    });
    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 2,
      'phrase': 'Thank you.',
      'translation': 'Terime kasih.'
    });

    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 3,
      'phrase': 'Left',
      'translation': 'Kire'
    });
    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 3,
      'phrase': 'Right',
      'translation': 'Kanan'
    });
    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 3,
      'phrase': 'Straight ahead',
      'translation': 'Lurus jah'
    });
    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 3,
      'phrase': 'In ___ meters.',
      'translation': 'Dalam ___ meter.'
    });
    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 3,
      'phrase': 'Traffic light',
      'translation': 'Lampu isyarak'
    });
    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 3,
      'phrase': 'Stop sign',
      'translation': 'Tanda berhenti'
    });
    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 3,
      'phrase': 'North',
      'translation': 'Utare'
    });
    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 3,
      'phrase': 'South',
      'translation': 'Selateng'
    });
    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 3,
      'phrase': 'East',
      'translation': 'Timur'
    });
    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 3,
      'phrase': 'West',
      'translation': 'Barak'
    });

    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 4,
      'phrase': 'Where is the ATM?',
      'translation': 'Mano ATM?'
    });
    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 4,
      'phrase': 'I want to exchange money.',
      'translation': 'Saye nak tukar pitih.'
    });
    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 4,
      'phrase': 'What is the exchange fee?',
      'translation': 'Berapo yuran tukar?'
    });
    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 4,
      'phrase': 'How much does it cost?',
      'translation': 'Berapo harga?'
    });

    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 5,
      'phrase': 'Where is the toilet?',
      'translation': 'Mano jamban?'
    });
    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 5,
      'phrase': 'Where is the grocery store?',
      'translation': 'Mano kedai runcik?'
    });
    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 5,
      'phrase': 'This is an emergency!',
      'translation': 'Ni kecemase!'
    });
    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 5,
      'phrase': 'I need help.',
      'translation': 'Saye perlu tolong.'
    });

    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 6,
      'phrase': 'Do you speak ___?',
      'translation': 'Mu cakak ___?'
    });
    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 6,
      'phrase': 'I don\'t speak ___.',
      'translation': 'Saye dok cakak ___.'
    });
    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 6,
      'phrase': 'I don\'t understand.',
      'translation': 'Saye dok paham.'
    });
    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 6,
      'phrase': 'I speak ___.',
      'translation': 'Saye cakak ___.'
    });

    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 7,
      'phrase': 'Left',
      'translation': 'Kire'
    });
    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 7,
      'phrase': 'Right',
      'translation': 'Kanan'
    });
    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 7,
      'phrase': 'Straight ahead',
      'translation': 'Lurus jah'
    });
    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 7,
      'phrase': 'In ___ meters.',
      'translation': 'Dalam ___ meter.'
    });
    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 7,
      'phrase': 'Traffic light',
      'translation': 'Lampu isyarak'
    });
    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 7,
      'phrase': 'Stop sign',
      'translation': 'Tanda berhenti'
    });
    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 7,
      'phrase': 'North',
      'translation': 'Utare'
    });
    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 7,
      'phrase': 'South',
      'translation': 'Selateng'
    });
    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 7,
      'phrase': 'East',
      'translation': 'Timur'
    });
    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 7,
      'phrase': 'West',
      'translation': 'Barak'
    });

    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 8,
      'phrase': 'Where is the ATM?',
      'translation': 'Mano ATM?'
    });
    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 8,
      'phrase': 'I want to exchange money.',
      'translation': 'Saye nak tukar pitih.'
    });
    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 8,
      'phrase': 'What is the exchange fee?',
      'translation': 'Berapo yuran tukar?'
    });
    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 8,
      'phrase': 'How much does it cost?',
      'translation': 'Berapo harga?'
    });

    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 9,
      'phrase': 'Where is the toilet?',
      'translation': 'Mano jamban?'
    });
    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 9,
      'phrase': 'Where is the grocery store?',
      'translation': 'Mano kedai runcik?'
    });
    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 9,
      'phrase': 'This is an emergency!',
      'translation': 'Ni kecemase!'
    });
    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 9,
      'phrase': 'I need help.',
      'translation': 'Saye perlu tolong.'
    });

    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 10,
      'phrase': 'Do you speak ___?',
      'translation': 'Mu cakak ___?'
    });
    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 10,
      'phrase': 'I don\'t speak ___.',
      'translation': 'Saye dok cakak ___.'
    });
    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 10,
      'phrase': 'I don\'t understand.',
      'translation': 'Saye dok paham.'
    });
    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 10,
      'phrase': 'I speak ___.',
      'translation': 'Saye cakak ___.'
    });

    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 11,
      'phrase': 'Hello',
      'translation': 'Alo'
    });
    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 11,
      'phrase': 'My name is __.',
      'translation': 'Nama saye __.'
    });
    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 11,
      'phrase': 'Excuse me',
      'translation': 'Pah cer'
    });
    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 11,
      'phrase': 'Goodbye',
      'translation': 'Selamat tinggal'
    });
    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 11,
      'phrase': 'How are you?',
      'translation': 'Gane mu?'
    });
    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 11,
      'phrase': 'Nice to meet you!',
      'translation': 'Seronok jumpe mu!'
    });

    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 12,
      'phrase': 'Where is the airport?',
      'translation': 'Mano lapang terbang?'
    });
    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 12,
      'phrase': 'Where is the train station?',
      'translation': 'Mano stesen kereta api?'
    });
    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 12,
      'phrase': 'Where is the subway?',
      'translation': 'Mano kereta api bawah tanah?'
    });
    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 12,
      'phrase': 'Where is the bus station?',
      'translation': 'Mano stesen bas?'
    });
    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 12,
      'phrase': 'Where is the ___ museum?',
      'translation': 'Mano muzium ___?'
    });
    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 12,
      'phrase': 'Where is a good restaurant?',
      'translation': 'Mano restoran sedak?'
    });
    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 12,
      'phrase': 'Where is a nice coffee place?',
      'translation': 'Mano kedai kopi sedak?'
    });
    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 12,
      'phrase': 'Where is a nice bar?',
      'translation': 'Mano bar sedak?'
    });

    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 13,
      'phrase': 'Where can I buy a ticket?',
      'translation': 'Mano buleh beli tiket?'
    });
    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 13,
      'phrase': 'How much is a ticket?',
      'translation': 'Berapo harga tiket?'
    });
    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 13,
      'phrase': 'I need ___ tickets, please.',
      'translation': 'Saye nak ___ tiket, tolong.'
    });
    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 13,
      'phrase': 'I would like to change my ticket.',
      'translation': 'Saye nak tukar tiket.'
    });

    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 14,
      'phrase': 'Which platform?',
      'translation': 'Platform mano?'
    });
    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 14,
      'phrase': 'Where is the platform?',
      'translation': 'Mano platform?'
    });
    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 14,
      'phrase': 'Where should I get off?',
      'translation': 'Mano nok turun?'
    });
    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 14,
      'phrase': 'I\'d like to get off at ___.',
      'translation': 'Saye nok turun di ___.'
    });
    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 14,
      'phrase': 'Where do I change trains?',
      'translation': 'Mano tukar kereta api?'
    });
    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 14,
      'phrase': 'Where do I change buses?',
      'translation': 'Mano tukar bas?'
    });

    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 15,
      'phrase': 'Here is my passport.',
      'translation': 'Ni pasport saye.'
    });
    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 15,
      'phrase': 'Do I need a visa?',
      'translation': 'Perlu visa dok?'
    });
    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 15,
      'phrase': 'I am an immigrant.',
      'translation': 'Saye ore pindoh.'
    });
    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 15,
      'phrase': 'I am a refugee.',
      'translation': 'Saye ore pelare.'
    });
    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 15,
      'phrase': 'I have nothing to declare.',
      'translation': 'Saye dokdok gapo nok istihar.'
    });
    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 15,
      'phrase': 'I have something to declare.',
      'translation': 'Saye ado gapo nok istihar.'
    });

    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 16,
      'phrase': 'I have allergies.',
      'translation': 'Saye ade alahan.'
    });
    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 16,
      'phrase': 'I am allergic to ___.',
      'translation': 'Saye alah ___.'
    });
    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 16,
      'phrase': 'I am allergic to penicillin.',
      'translation': 'Saye alah penicillin.'
    });
    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 16,
      'phrase': 'I am allergic to antibiotics.',
      'translation': 'Saye alah antibiotik.'
    });
    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 16,
      'phrase': 'I have Asthma.',
      'translation': 'Saye ade asma.'
    });

    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 17,
      'phrase': 'I would like to check in.',
      'translation': 'Saye nok check in.'
    });
    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 17,
      'phrase': 'I would like to change my reservation.',
      'translation': 'Saye nok tukar tempahan.'
    });
    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 17,
      'phrase': 'Can we have a room with ___ view?',
      'translation': 'Buleh ke bilik saye view ___?'
    });
    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 17,
      'phrase': 'When does breakfast start?',
      'translation': 'Bilo sarapan start?'
    });
    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 17,
      'phrase': 'When does lunch start?',
      'translation': 'Bilo makan tengahari start?'
    });
    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 17,
      'phrase': 'When does dinner start?',
      'translation': 'Bilo makan malam start?'
    });
    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 17,
      'phrase': 'When is check out?',
      'translation': 'Bilo nok check out?'
    });
    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 17,
      'phrase': 'My room needs to be cleaned.',
      'translation': 'Bilik saye perlu bersih.'
    });

    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 18,
      'phrase': 'Do you have free rooms?',
      'translation': 'Mu ade bilik free?'
    });
    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 18,
      'phrase': 'I would like ___ rooms.',
      'translation': 'Saye nok ___ bilik.'
    });
    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 18,
      'phrase': 'We are ___ people.',
      'translation': 'Saye ___ ore.'
    });
    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 18,
      'phrase': 'How much does the room cost?',
      'translation': 'Berapo harga bilik?'
    });
    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 18,
      'phrase': 'Is it air conditioned?',
      'translation': 'Bilik ade aircon?'
    });
    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 18,
      'phrase': 'Is there room service?',
      'translation': 'Bilik ade servis?'
    });
    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 18,
      'phrase': 'Is breakfast included?',
      'translation': 'Sarapan included dok?'
    });
    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 18,
      'phrase': 'Is lunch included?',
      'translation': 'Makan tengahari included dok?'
    });
    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 18,
      'phrase': 'Is dinner included?',
      'translation': 'Makan malam included dok?'
    });
    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 18,
      'phrase': 'Is there a restaurant?',
      'translation': 'Ade restoran dok?'
    });
    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 18,
      'phrase': 'When is check out?',
      'translation': 'Bilo nok check out?'
    });

    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 19,
      'phrase': 'May I see the menu?',
      'translation': 'Buleh saye tengok menu?'
    });
    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 19,
      'phrase': 'I would like to order __.',
      'translation': 'Saye nok order __.'
    });
    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 19,
      'phrase': 'I would like breakfast.',
      'translation': 'Saye nok sarapan.'
    });
    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 19,
      'phrase': 'I would like lunch.',
      'translation': 'Saye nok makan tengahari.'
    });
    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 19,
      'phrase': 'I would like dinner.',
      'translation': 'Saye nok makan malam.'
    });
    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 19,
      'phrase': 'I\'m a vegetarian.',
      'translation': 'Saye vegetarian.'
    });
    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 19,
      'phrase': 'I\'m vegan.',
      'translation': 'Saye vegan.'
    });
    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 19,
      'phrase': 'I don\'t eat pork.',
      'translation': 'Saye dok makan daging babi.'
    });
    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 19,
      'phrase': 'I don\'t eat beef.',
      'translation': 'Saye dok makan daging lembu.'
    });
    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 19,
      'phrase': 'I don\'t eat __.',
      'translation': 'Saye dok makan __.'
    });
    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 19,
      'phrase': 'The bill please.',
      'translation': 'Bil, tolong.'
    });

    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 20,
      'phrase': 'I would like some __.',
      'translation': 'Saye nok __ sikit.'
    });
    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 20,
      'phrase': 'I would like some bottled water.',
      'translation': 'Saye nok air botol.'
    });
    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 20,
      'phrase': 'I would like some carbonated water.',
      'translation': 'Saye nok air berkarbonat.'
    });
    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 20,
      'phrase': 'No ice.',
      'translation': 'Tanpo ais.'
    });
    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 20,
      'phrase': 'With ice.',
      'translation': 'Dengan ais.'
    });

    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 21,
      'phrase': 'I would like some __.',
      'translation': 'Saye nok __ sikit.'
    });
    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 21,
      'phrase': 'I would like some bottled water.',
      'translation': 'Saye nok air botol.'
    });
    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 21,
      'phrase': 'I would like some carbonated water.',
      'translation': 'Saye nok air berkarbonat.'
    });
    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 21,
      'phrase': 'No ice.',
      'translation': 'Tanpo ais.'
    });
    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 21,
      'phrase': 'With ice.',
      'translation': 'Dengan ais.'
    });

    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 22,
      'phrase': 'Where is the milk?',
      'translation': 'Mano susu?'
    });
    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 22,
      'phrase': 'Where are the eggs?',
      'translation': 'Mano telur?'
    });
    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 22,
      'phrase': 'Where is the ice cream?',
      'translation': 'Mano aiskrim?'
    });
    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 22,
      'phrase': 'Where is the bottled water?',
      'translation': 'Mano air botol?'
    });
    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 22,
      'phrase': 'Where are the soft drinks?',
      'translation': 'Mano minuman ringan?'
    });
    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 22,
      'phrase': 'Where are the fruits?',
      'translation': 'Mano buoh?'
    });
    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 22,
      'phrase': 'Where are the vegetables?',
      'translation': 'Mano sayur?'
    });
    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 22,
      'phrase': 'Where is the meat?',
      'translation': 'Mano daging?'
    });
    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 22,
      'phrase': 'Where is the bread?',
      'translation': 'Mano roti?'
    });
    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 22,
      'phrase': 'Where is the beer?',
      'translation': 'Mano bir?'
    });
    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 22,
      'phrase': 'Where is the wine?',
      'translation': 'Mano wain?'
    });

    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 23,
      'phrase': 'I need a phone charger.',
      'translation': 'Saye perlu pengecas telefon.'
    });
    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 23,
      'phrase': 'I need to check my email.',
      'translation': 'Saye perlu cek email.'
    });
    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 23,
      'phrase': 'Can you change it to English?',
      'translation': 'Buleh tukar ke bahasa Inggerih?'
    });
    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 23,
      'phrase': 'I need a printer.',
      'translation': 'Saye perlu printer.'
    });
    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 23,
      'phrase': 'I need a __.',
      'translation': 'Saye perlu __.'
    });

    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 24,
      'phrase': 'Is there Wi-Fi?',
      'translation': 'Ade Wi-Fi dok?'
    });
    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 24,
      'phrase': 'What is the password?',
      'translation': 'Gapo password?'
    });
    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 24,
      'phrase': 'The Wi-fi isn\'t working.',
      'translation': 'Wi-Fi dok berfungsi.'
    });

    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 25,
      'phrase': 'What is your email?',
      'translation': 'Gapo email mu?'
    });
    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 25,
      'phrase': 'I need to check my emails.',
      'translation': 'Saye perlu cek email.'
    });
    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 25,
      'phrase': 'Can you email it to me?',
      'translation': 'Buleh email ke saye?'
    });

    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 26,
      'phrase': 'Can you send it to me?',
      'translation': 'Buleh hantar ke saye?'
    });
    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 26,
      'phrase': 'Can you message it to me?',
      'translation': 'Buleh mesej ke saye?'
    });
    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 26,
      'phrase': 'Can you Whatsapp it to me?',
      'translation': 'Buleh Whatsapp ke saye?'
    });

    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 27,
      'phrase': 'I lost my phone.',
      'translation': 'Saye hilang telefon.'
    });
    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 27,
      'phrase': 'I lost my laptop.',
      'translation': 'Saye hilang laptop.'
    });
    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 27,
      'phrase': 'I lost my __.',
      'translation': 'Saye hilang __.'
    });

    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 28,
      'phrase': 'Monday',
      'translation': 'Isnin'
    });
    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 28,
      'phrase': 'Tuesday',
      'translation': 'Selase'
    });
    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 28,
      'phrase': 'Wednesday',
      'translation': 'Rabu'
    });
    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 28,
      'phrase': 'Thursday',
      'translation': 'Khamih'
    });
    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 28,
      'phrase': 'Friday',
      'translation': 'Jumaah'
    });
    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 28,
      'phrase': 'Saturday',
      'translation': 'Satu'
    });
    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 28,
      'phrase': 'Sunday',
      'translation': 'Ahoh'
    });

    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 29,
      'phrase': 'Morning',
      'translation': 'Pagi'
    });
    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 29,
      'phrase': 'Noon',
      'translation': 'Tengahari'
    });
    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 29,
      'phrase': 'Afternoon',
      'translation': 'Petang'
    });
    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 29,
      'phrase': 'Evening',
      'translation': 'Malam'
    });
    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 29,
      'phrase': 'Night',
      'translation': 'Malam'
    });
    await db.insert('phrases', {
      'languageId': 3,
      'categoryId': 29,
      'phrase': 'Midnight',
      'translation': 'Tengah malam'
    });


    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 1,
      'phrase': 'Hello',
      'translation': 'Helo'
    });
    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 1,
      'phrase': 'My name is',
      'translation': 'Namo saye'
    });
    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 1,
      'phrase': 'Excuse me',
      'translation': 'Tumpang lalu'
    });
    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 1,
      'phrase': 'Goodbye',
      'translation': 'Selamat tinggal'
    });
    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 1,
      'phrase': 'How are you?',
      'translation': 'Ape khabar?'
    });
    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 1,
      'phrase': 'Nice to meet you!',
      'translation': 'Seronok jumpe awak!'
    });

    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 2,
      'phrase': 'Please',
      'translation': 'Tolong'
    });
    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 2,
      'phrase': 'I\'m sorry.',
      'translation': 'Saye minta maap.'
    });
    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 2,
      'phrase': 'Thank you.',
      'translation': 'Terime kasih.'
    });

    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 3,
      'phrase': 'Left',
      'translation': 'Kire'
    });
    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 3,
      'phrase': 'Right',
      'translation': 'Kanan'
    });
    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 3,
      'phrase': 'Straight ahead',
      'translation': 'Terus aje'
    });
    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 3,
      'phrase': 'In ___ meters.',
      'translation': 'Dalam ___ meter.'
    });
    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 3,
      'phrase': 'Traffic light',
      'translation': 'Lampu isyarat'
    });
    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 3,
      'phrase': 'Stop sign',
      'translation': 'Tanda berhenti'
    });
    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 3,
      'phrase': 'North',
      'translation': 'Utara'
    });
    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 3,
      'phrase': 'South',
      'translation': 'Selatan'
    });
    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 3,
      'phrase': 'East',
      'translation': 'Timur'
    });
    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 3,
      'phrase': 'West',
      'translation': 'Barat'
    });

    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 4,
      'phrase': 'Where is the ATM?',
      'translation': 'Kat mane ATM?'
    });
    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 4,
      'phrase': 'I want to exchange money.',
      'translation': 'Saye nak tukar duit.'
    });
    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 4,
      'phrase': 'What is the exchange fee?',
      'translation': 'Berapo yuran tukar?'
    });
    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 4,
      'phrase': 'How much does it cost?',
      'translation': 'Berapo hargenye?'
    });

    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 5,
      'phrase': 'Where is the toilet?',
      'translation': 'Kat mane jamban?'
    });
    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 5,
      'phrase': 'Where is the grocery store?',
      'translation': 'Kat mane kedai runcit?'
    });
    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 5,
      'phrase': 'This is an emergency!',
      'translation': 'Ni kecemasan!'
    });
    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 5,
      'phrase': 'I need help.',
      'translation': 'Saye perlu tolongan.'
    });

    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 6,
      'phrase': 'Do you speak ___?',
      'translation': 'Awak cakap ___?'
    });
    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 6,
      'phrase': 'I don\'t speak ___.',
      'translation': 'Saye tak cakap ___.'
    });
    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 6,
      'phrase': 'I don\'t understand.',
      'translation': 'Saye tak faham.'
    });
    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 6,
      'phrase': 'I speak ___.',
      'translation': 'Saye cakap ___.'
    });

    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 7,
      'phrase': 'Left',
      'translation': 'Kire'
    });
    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 7,
      'phrase': 'Right',
      'translation': 'Kanan'
    });
    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 7,
      'phrase': 'Straight ahead',
      'translation': 'Terus aje'
    });
    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 7,
      'phrase': 'In ___ meters.',
      'translation': 'Dalam ___ meter.'
    });
    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 7,
      'phrase': 'Traffic light',
      'translation': 'Lampu isyarat'
    });
    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 7,
      'phrase': 'Stop sign',
      'translation': 'Tanda berhenti'
    });
    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 7,
      'phrase': 'North',
      'translation': 'Utara'
    });
    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 7,
      'phrase': 'South',
      'translation': 'Selatan'
    });
    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 7,
      'phrase': 'East',
      'translation': 'Timur'
    });
    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 7,
      'phrase': 'West',
      'translation': 'Barat'
    });

    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 8,
      'phrase': 'Where is the ATM?',
      'translation': 'Kat mane ATM?'
    });
    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 8,
      'phrase': 'I want to exchange money.',
      'translation': 'Saye nak tukar duit.'
    });
    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 8,
      'phrase': 'What is the exchange fee?',
      'translation': 'Berapo yuran tukar?'
    });
    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 8,
      'phrase': 'How much does it cost?',
      'translation': 'Berapo hargenye?'
    });

    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 9,
      'phrase': 'Where is the toilet?',
      'translation': 'Kat mane jamban?'
    });
    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 9,
      'phrase': 'Where is the grocery store?',
      'translation': 'Kat mane kedai runcit?'
    });
    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 9,
      'phrase': 'This is an emergency!',
      'translation': 'Ni kecemasan!'
    });
    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 9,
      'phrase': 'I need help.',
      'translation': 'Saye perlu tolongan.'
    });

    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 10,
      'phrase': 'Do you speak ___?',
      'translation': 'Awak cakap ___?'
    });
    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 10,
      'phrase': 'I don\'t speak ___.',
      'translation': 'Saye tak cakap ___.'
    });
    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 10,
      'phrase': 'I don\'t understand.',
      'translation': 'Saye tak faham.'
    });
    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 10,
      'phrase': 'I speak ___.',
      'translation': 'Saye cakap ___.'
    });

    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 11,
      'phrase': 'Hello',
      'translation': 'Helo'
    });
    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 11,
      'phrase': 'My name is __.',
      'translation': 'Namo saye __.'
    });
    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 11,
      'phrase': 'Excuse me',
      'translation': 'Tumpang lalu'
    });
    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 11,
      'phrase': 'Goodbye',
      'translation': 'Selamat tinggal'
    });
    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 11,
      'phrase': 'How are you?',
      'translation': 'Ape khabar?'
    });
    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 11,
      'phrase': 'Nice to meet you!',
      'translation': 'Seronok jumpe awak!'
    });

    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 12,
      'phrase': 'Where is the airport?',
      'translation': 'Kat mane lapangan terbang?'
    });
    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 12,
      'phrase': 'Where is the train station?',
      'translation': 'Kat mane stesen kereta api?'
    });
    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 12,
      'phrase': 'Where is the subway?',
      'translation': 'Kat mane kereta api bawah tanah?'
    });
    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 12,
      'phrase': 'Where is the bus station?',
      'translation': 'Kat mane stesen bas?'
    });
    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 12,
      'phrase': 'Where is the ___ museum?',
      'translation': 'Kat mane muzium ___?'
    });
    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 12,
      'phrase': 'Where is a good restaurant?',
      'translation': 'Kat mane restoran bagus?'
    });
    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 12,
      'phrase': 'Where is a nice coffee place?',
      'translation': 'Kat mane kedai kopi bagus?'
    });
    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 12,
      'phrase': 'Where is a nice bar?',
      'translation': 'Kat mane bar bagus?'
    });

    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 13,
      'phrase': 'Where can I buy a ticket?',
      'translation': 'Kat mane boleh beli tiket?'
    });
    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 13,
      'phrase': 'How much is a ticket?',
      'translation': 'Berapo harga tiket?'
    });
    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 13,
      'phrase': 'I need ___ tickets, please.',
      'translation': 'Saye nak ___ tiket, tolong.'
    });
    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 13,
      'phrase': 'I would like to change my ticket.',
      'translation': 'Saye nak tukar tiket saye.'
    });

    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 14,
      'phrase': 'Which platform?',
      'translation': 'Platform mane?'
    });
    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 14,
      'phrase': 'Where is the platform?',
      'translation': 'Kat mane platform?'
    });
    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 14,
      'phrase': 'Where should I get off?',
      'translation': 'Kat mane saye patut turun?'
    });
    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 14,
      'phrase': 'I\'d like to get off at ___.',
      'translation': 'Saye nak turun kat ___.'
    });
    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 14,
      'phrase': 'Where do I change trains?',
      'translation': 'Kat mane tukar kereta api?'
    });
    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 14,
      'phrase': 'Where do I change buses?',
      'translation': 'Kat mane tukar bas?'
    });

    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 15,
      'phrase': 'Here is my passport.',
      'translation': 'Ni pasport saye.'
    });
    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 15,
      'phrase': 'Do I need a visa?',
      'translation': 'Perlu visa ke?'
    });
    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 15,
      'phrase': 'I am an immigrant.',
      'translation': 'Saye orang pendatang.'
    });
    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 15,
      'phrase': 'I am a refugee.',
      'translation': 'Saye orang pelarian.'
    });
    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 15,
      'phrase': 'I have nothing to declare.',
      'translation': 'Saye tak ade ape nok diisytiharkan.'
    });
    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 15,
      'phrase': 'I have something to declare.',
      'translation': 'Saye ade barang nok diisytiharkan.'
    });

    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 16,
      'phrase': 'I have allergies.',
      'translation': 'Saye ade alahan.'
    });
    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 16,
      'phrase': 'I am allergic to ___.',
      'translation': 'Saye alah kat ___.'
    });
    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 16,
      'phrase': 'I am allergic to penicillin.',
      'translation': 'Saye alah penicillin.'
    });
    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 16,
      'phrase': 'I am allergic to antibiotics.',
      'translation': 'Saye alah antibiotik.'
    });
    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 16,
      'phrase': 'I have Asthma.',
      'translation': 'Saye ade asma.'
    });

    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 17,
      'phrase': 'I would like to check in.',
      'translation': 'Saye nak check in.'
    });
    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 17,
      'phrase': 'I would like to change my reservation.',
      'translation': 'Saye nak tukar tempahan saye.'
    });
    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 17,
      'phrase': 'Can we have a room with ___ view?',
      'translation': 'Boleh ke bilik saye view ___?'
    });
    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 17,
      'phrase': 'When does breakfast start?',
      'translation': 'Bile sarapan start?'
    });
    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 17,
      'phrase': 'When does lunch start?',
      'translation': 'Bile makan tengahari start?'
    });
    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 17,
      'phrase': 'When does dinner start?',
      'translation': 'Bile makan malam start?'
    });
    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 17,
      'phrase': 'When is check out?',
      'translation': 'Bile nok check out?'
    });
    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 17,
      'phrase': 'My room needs to be cleaned.',
      'translation': 'Bilik saye perlu dibersihkan.'
    });

    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 18,
      'phrase': 'Do you have free rooms?',
      'translation': 'Ade bilik free?'
    });
    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 18,
      'phrase': 'I would like ___ rooms.',
      'translation': 'Saye nak ___ bilik.'
    });
    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 18,
      'phrase': 'We are ___ people.',
      'translation': 'Saye ___ orang.'
    });
    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 18,
      'phrase': 'How much does the room cost?',
      'translation': 'Berapo harga bilik?'
    });
    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 18,
      'phrase': 'Is it air conditioned?',
      'translation': 'Bilik ade aircon?'
    });
    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 18,
      'phrase': 'Is there room service?',
      'translation': 'Ade servis bilik?'
    });
    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 18,
      'phrase': 'Is breakfast included?',
      'translation': 'Sarapan included ke?'
    });
    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 18,
      'phrase': 'Is lunch included?',
      'translation': 'Makan tengahari included ke?'
    });
    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 18,
      'phrase': 'Is dinner included?',
      'translation': 'Makan malam included ke?'
    });
    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 18,
      'phrase': 'Is there a restaurant?',
      'translation': 'Ade restoran?'
    });
    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 18,
      'phrase': 'When is check out?',
      'translation': 'Bile nok check out?'
    });

    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 19,
      'phrase': 'May I see the menu?',
      'translation': 'Boleh saye tengok menu?'
    });
    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 19,
      'phrase': 'I would like to order __.',
      'translation': 'Saye nak order __.'
    });
    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 19,
      'phrase': 'I would like breakfast.',
      'translation': 'Saye nak sarapan.'
    });
    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 19,
      'phrase': 'I would like lunch.',
      'translation': 'Saye nak makan tengahari.'
    });
    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 19,
      'phrase': 'I would like dinner.',
      'translation': 'Saye nak makan malam.'
    });
    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 19,
      'phrase': 'I\'m a vegetarian.',
      'translation': 'Saye vegetarian.'
    });
    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 19,
      'phrase': 'I\'m vegan.',
      'translation': 'Saye vegan.'
    });
    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 19,
      'phrase': 'I don\'t eat pork.',
      'translation': 'Saye tak makan daging babi.'
    });
    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 19,
      'phrase': 'I don\'t eat beef.',
      'translation': 'Saye tak makan daging lembu.'
    });
    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 19,
      'phrase': 'I don\'t eat __.',
      'translation': 'Saye tak makan __.'
    });
    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 19,
      'phrase': 'The bill please.',
      'translation': 'Bil, tolong.'
    });

    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 20,
      'phrase': 'I would like some __.',
      'translation': 'Saye nak __ sikit.'
    });
    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 20,
      'phrase': 'I would like some bottled water.',
      'translation': 'Saye nak air botol.'
    });
    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 20,
      'phrase': 'I would like some carbonated water.',
      'translation': 'Saye nak air berkarbonat.'
    });
    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 20,
      'phrase': 'No ice.',
      'translation': 'Takde ais.'
    });
    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 20,
      'phrase': 'With ice.',
      'translation': 'Dengan ais.'
    });

    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 21,
      'phrase': 'I would like some __.',
      'translation': 'Saye nak __ sikit.'
    });
    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 21,
      'phrase': 'I would like some bottled water.',
      'translation': 'Saye nak air botol.'
    });
    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 21,
      'phrase': 'I would like some carbonated water.',
      'translation': 'Saye nak air berkarbonat.'
    });
    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 21,
      'phrase': 'No ice.',
      'translation': 'Takde ais.'
    });
    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 21,
      'phrase': 'With ice.',
      'translation': 'Dengan ais.'
    });

    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 22,
      'phrase': 'Where is the milk?',
      'translation': 'Kat mane susu?'
    });
    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 22,
      'phrase': 'Where are the eggs?',
      'translation': 'Kat mane telur?'
    });
    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 22,
      'phrase': 'Where is the ice cream?',
      'translation': 'Kat mane aiskrim?'
    });
    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 22,
      'phrase': 'Where is the bottled water?',
      'translation': 'Kat mane air botol?'
    });
    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 22,
      'phrase': 'Where are the soft drinks?',
      'translation': 'Kat mane minuman ringan?'
    });
    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 22,
      'phrase': 'Where are the fruits?',
      'translation': 'Kat mane buah-buahan?'
    });
    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 22,
      'phrase': 'Where are the vegetables?',
      'translation': 'Kat mane sayur-sayuran?'
    });
    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 22,
      'phrase': 'Where is the meat?',
      'translation': 'Kat mane daging?'
    });
    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 22,
      'phrase': 'Where is the bread?',
      'translation': 'Kat mane roti?'
    });
    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 22,
      'phrase': 'Where is the beer?',
      'translation': 'Kat mane bir?'
    });
    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 22,
      'phrase': 'Where is the wine?',
      'translation': 'Kat mane wain?'
    });

    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 23,
      'phrase': 'I need a phone charger.',
      'translation': 'Saye perlu pengecas telefon.'
    });
    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 23,
      'phrase': 'I need to check my email.',
      'translation': 'Saye perlu cek email.'
    });
    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 23,
      'phrase': 'Can you change it to English?',
      'translation': 'Boleh tukar ke bahasa Inggeris?'
    });
    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 23,
      'phrase': 'I need a printer.',
      'translation': 'Saye perlu printer.'
    });
    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 23,
      'phrase': 'I need a __.',
      'translation': 'Saye perlu __.'
    });

    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 24,
      'phrase': 'Is there Wi-Fi?',
      'translation': 'Ade Wi-Fi?'
    });
    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 24,
      'phrase': 'What is the password?',
      'translation': 'Ape password?'
    });
    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 24,
      'phrase': 'The Wi-fi isn\'t working.',
      'translation': 'Wi-Fi tak berfungsi.'
    });

    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 25,
      'phrase': 'What is your email?',
      'translation': 'Ape email awak?'
    });
    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 25,
      'phrase': 'I need to check my emails.',
      'translation': 'Saye perlu cek email.'
    });
    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 25,
      'phrase': 'Can you email it to me?',
      'translation': 'Boleh email ke saye?'
    });

    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 26,
      'phrase': 'Can you send it to me?',
      'translation': 'Boleh hantar ke saye?'
    });
    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 26,
      'phrase': 'Can you message it to me?',
      'translation': 'Boleh mesej ke saye?'
    });
    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 26,
      'phrase': 'Can you Whatsapp it to me?',
      'translation': 'Boleh Whatsapp ke saye?'
    });

    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 27,
      'phrase': 'I lost my phone.',
      'translation': 'Saye hilang telefon.'
    });
    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 27,
      'phrase': 'I lost my laptop.',
      'translation': 'Saye hilang laptop.'
    });
    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 27,
      'phrase': 'I lost my __.',
      'translation': 'Saye hilang __.'
    });

    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 28,
      'phrase': 'Monday',
      'translation': 'Isnin'
    });
    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 28,
      'phrase': 'Tuesday',
      'translation': 'Selase'
    });
    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 28,
      'phrase': 'Wednesday',
      'translation': 'Rabu'
    });
    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 28,
      'phrase': 'Thursday',
      'translation': 'Khamis'
    });
    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 28,
      'phrase': 'Friday',
      'translation': 'Jumaat'
    });
    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 28,
      'phrase': 'Saturday',
      'translation': 'Sabtu'
    });
    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 28,
      'phrase': 'Sunday',
      'translation': 'Ahad'
    });

    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 29,
      'phrase': 'Morning',
      'translation': 'Pagi'
    });
    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 29,
      'phrase': 'Noon',
      'translation': 'Tengahari'
    });
    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 29,
      'phrase': 'Afternoon',
      'translation': 'Petang'
    });
    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 29,
      'phrase': 'Evening',
      'translation': 'Malam'
    });
    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 29,
      'phrase': 'Night',
      'translation': 'Malam'
    });
    await db.insert('phrases', {
      'languageId': 4,
      'categoryId': 29,
      'phrase': 'Midnight',
      'translation': 'Tengah malam'
    });

    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 1,
      'phrase': 'Hello',
      'translation': 'Halo'
    });
    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 1,
      'phrase': 'My name is',
      'translation': 'Nama saya'
    });
    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 1,
      'phrase': 'Excuse me',
      'translation': 'Tumpang lalu'
    });
    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 1,
      'phrase': 'Goodbye',
      'translation': 'Selamat tinggal'
    });
    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 1,
      'phrase': 'How are you?',
      'translation': 'Apa khabar?'
    });
    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 1,
      'phrase': 'Nice to meet you!',
      'translation': 'Seronok jumpa awak!'
    });

    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 2,
      'phrase': 'Please',
      'translation': 'Tolong'
    });
    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 2,
      'phrase': 'I\'m sorry.',
      'translation': 'Saya minta maaf.'
    });
    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 2,
      'phrase': 'Thank you.',
      'translation': 'Terima kasih.'
    });

    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 3,
      'phrase': 'Left',
      'translation': 'Kiri'
    });
    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 3,
      'phrase': 'Right',
      'translation': 'Kanan'
    });
    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 3,
      'phrase': 'Straight ahead',
      'translation': 'Terus saja'
    });
    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 3,
      'phrase': 'In ___ meters.',
      'translation': 'Dalam ___ meter.'
    });
    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 3,
      'phrase': 'Traffic light',
      'translation': 'Lampu isyarat'
    });
    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 3,
      'phrase': 'Stop sign',
      'translation': 'Tanda berhenti'
    });
    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 3,
      'phrase': 'North',
      'translation': 'Utara'
    });
    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 3,
      'phrase': 'South',
      'translation': 'Selatan'
    });
    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 3,
      'phrase': 'East',
      'translation': 'Timur'
    });
    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 3,
      'phrase': 'West',
      'translation': 'Barat'
    });

    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 4,
      'phrase': 'Where is the ATM?',
      'translation': 'Mana ATM?'
    });
    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 4,
      'phrase': 'I want to exchange money.',
      'translation': 'Saya nak tukar duit.'
    });
    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 4,
      'phrase': 'What is the exchange fee?',
      'translation': 'Berapa yuran tukar?'
    });
    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 4,
      'phrase': 'How much does it cost?',
      'translation': 'Berapa harganya?'
    });

    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 5,
      'phrase': 'Where is the toilet?',
      'translation': 'Mana tandas?'
    });
    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 5,
      'phrase': 'Where is the grocery store?',
      'translation': 'Mana kedai runcit?'
    });
    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 5,
      'phrase': 'This is an emergency!',
      'translation': 'Ini kecemasan!'
    });
    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 5,
      'phrase': 'I need help.',
      'translation': 'Saya perlukan bantuan.'
    });

    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 6,
      'phrase': 'Do you speak ___?',
      'translation': 'Awak cakap ___?'
    });
    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 6,
      'phrase': 'I don\'t speak ___.',
      'translation': 'Saya tak cakap ___.'
    });
    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 6,
      'phrase': 'I don\'t understand.',
      'translation': 'Saya tak faham.'
    });
    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 6,
      'phrase': 'I speak ___.',
      'translation': 'Saya cakap ___.'
    });

    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 7,
      'phrase': 'Left',
      'translation': 'Kiri'
    });
    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 7,
      'phrase': 'Right',
      'translation': 'Kanan'
    });
    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 7,
      'phrase': 'Straight ahead',
      'translation': 'Terus saja'
    });
    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 7,
      'phrase': 'In ___ meters.',
      'translation': 'Dalam ___ meter.'
    });
    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 7,
      'phrase': 'Traffic light',
      'translation': 'Lampu isyarat'
    });
    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 7,
      'phrase': 'Stop sign',
      'translation': 'Tanda berhenti'
    });
    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 7,
      'phrase': 'North',
      'translation': 'Utara'
    });
    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 7,
      'phrase': 'South',
      'translation': 'Selatan'
    });
    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 7,
      'phrase': 'East',
      'translation': 'Timur'
    });
    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 7,
      'phrase': 'West',
      'translation': 'Barat'
    });

    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 8,
      'phrase': 'Where is the ATM?',
      'translation': 'Mana ATM?'
    });
    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 8,
      'phrase': 'I want to exchange money.',
      'translation': 'Saya nak tukar duit.'
    });
    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 8,
      'phrase': 'What is the exchange fee?',
      'translation': 'Berapa yuran tukar?'
    });
    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 8,
      'phrase': 'How much does it cost?',
      'translation': 'Berapa harganya?'
    });

    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 9,
      'phrase': 'Where is the toilet?',
      'translation': 'Mana tandas?'
    });
    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 9,
      'phrase': 'Where is the grocery store?',
      'translation': 'Mana kedai runcit?'
    });
    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 9,
      'phrase': 'This is an emergency!',
      'translation': 'Ini kecemasan!'
    });
    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 9,
      'phrase': 'I need help.',
      'translation': 'Saya perlukan bantuan.'
    });

    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 10,
      'phrase': 'Do you speak ___?',
      'translation': 'Awak cakap ___?'
    });
    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 10,
      'phrase': 'I don\'t speak ___.',
      'translation': 'Saya tak cakap ___.'
    });
    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 10,
      'phrase': 'I don\'t understand.',
      'translation': 'Saya tak faham.'
    });
    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 10,
      'phrase': 'I speak ___.',
      'translation': 'Saya cakap ___.'
    });

    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 11,
      'phrase': 'Hello',
      'translation': 'Halo'
    });
    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 11,
      'phrase': 'My name is __.',
      'translation': 'Nama saya __.'
    });
    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 11,
      'phrase': 'Excuse me',
      'translation': 'Tumpang lalu'
    });
    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 11,
      'phrase': 'Goodbye',
      'translation': 'Selamat tinggal'
    });
    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 11,
      'phrase': 'How are you?',
      'translation': 'Apa khabar?'
    });
    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 11,
      'phrase': 'Nice to meet you!',
      'translation': 'Seronok jumpa awak!'
    });

    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 12,
      'phrase': 'Where is the airport?',
      'translation': 'Mana lapangan terbang?'
    });
    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 12,
      'phrase': 'Where is the train station?',
      'translation': 'Mana stesen kereta api?'
    });
    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 12,
      'phrase': 'Where is the subway?',
      'translation': 'Mana kereta api bawah tanah?'
    });
    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 12,
      'phrase': 'Where is the bus station?',
      'translation': 'Mana stesen bas?'
    });
    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 12,
      'phrase': 'Where is the ___ museum?',
      'translation': 'Mana muzium ___?'
    });
    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 12,
      'phrase': 'Where is a good restaurant?',
      'translation': 'Mana restoran bagus?'
    });
    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 12,
      'phrase': 'Where is a nice coffee place?',
      'translation': 'Mana kedai kopi bagus?'
    });
    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 12,
      'phrase': 'Where is a nice bar?',
      'translation': 'Mana bar bagus?'
    });

    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 13,
      'phrase': 'Where can I buy a ticket?',
      'translation': 'Mana boleh beli tiket?'
    });
    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 13,
      'phrase': 'How much is a ticket?',
      'translation': 'Berapa harga tiket?'
    });
    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 13,
      'phrase': 'I need ___ tickets, please.',
      'translation': 'Saya nak ___ tiket, tolong.'
    });
    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 13,
      'phrase': 'I would like to change my ticket.',
      'translation': 'Saya nak tukar tiket saya.'
    });

    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 14,
      'phrase': 'Which platform?',
      'translation': 'Platform mana?'
    });
    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 14,
      'phrase': 'Where is the platform?',
      'translation': 'Mana platform?'
    });
    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 14,
      'phrase': 'Where should I get off?',
      'translation': 'Mana saya patut turun?'
    });
    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 14,
      'phrase': 'I\'d like to get off at ___.',
      'translation': 'Saya nak turun di ___.'
    });
    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 14,
      'phrase': 'Where do I change trains?',
      'translation': 'Mana tukar kereta api?'
    });
    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 14,
      'phrase': 'Where do I change buses?',
      'translation': 'Mana tukar bas?'
    });

    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 15,
      'phrase': 'Here is my passport.',
      'translation': 'Ini pasport saya.'
    });
    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 15,
      'phrase': 'Do I need a visa?',
      'translation': 'Perlu visa ke?'
    });
    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 15,
      'phrase': 'I am an immigrant.',
      'translation': 'Saya orang pendatang.'
    });
    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 15,
      'phrase': 'I am a refugee.',
      'translation': 'Saya orang pelarian.'
    });
    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 15,
      'phrase': 'I have nothing to declare.',
      'translation': 'Saya tak ada apa nak diisytiharkan.'
    });
    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 15,
      'phrase': 'I have something to declare.',
      'translation': 'Saya ada barang nak diisytiharkan.'
    });

    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 16,
      'phrase': 'I have allergies.',
      'translation': 'Saya ada alahan.'
    });
    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 16,
      'phrase': 'I am allergic to ___.',
      'translation': 'Saya alah pada ___.'
    });
    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 16,
      'phrase': 'I am allergic to penicillin.',
      'translation': 'Saya alah pada penicillin.'
    });
    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 16,
      'phrase': 'I am allergic to antibiotics.',
      'translation': 'Saya alah pada antibiotik.'
    });
    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 16,
      'phrase': 'I have Asthma.',
      'translation': 'Saya ada asma.'
    });

    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 17,
      'phrase': 'I would like to check in.',
      'translation': 'Saya nak check in.'
    });
    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 17,
      'phrase': 'I would like to change my reservation.',
      'translation': 'Saya nak tukar tempahan saya.'
    });
    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 17,
      'phrase': 'Can we have a room with ___ view?',
      'translation': 'Boleh ke bilik saya ada view ___?'
    });
    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 17,
      'phrase': 'When does breakfast start?',
      'translation': 'Bila sarapan mula?'
    });
    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 17,
      'phrase': 'When does lunch start?',
      'translation': 'Bila makan tengahari mula?'
    });
    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 17,
      'phrase': 'When does dinner start?',
      'translation': 'Bila makan malam mula?'
    });
    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 17,
      'phrase': 'When is check out?',
      'translation': 'Bila nak check out?'
    });
    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 17,
      'phrase': 'My room needs to be cleaned.',
      'translation': 'Bilik saya perlu dibersihkan.'
    });

    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 18,
      'phrase': 'Do you have free rooms?',
      'translation': 'Ada bilik kosong?'
    });
    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 18,
      'phrase': 'I would like ___ rooms.',
      'translation': 'Saya nak ___ bilik.'
    });
    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 18,
      'phrase': 'We are ___ people.',
      'translation': 'Kami ___ orang.'
    });
    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 18,
      'phrase': 'How much does the room cost?',
      'translation': 'Berapa harga bilik?'
    });
    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 18,
      'phrase': 'Is it air conditioned?',
      'translation': 'Ada aircon ke?'
    });
    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 18,
      'phrase': 'Is there room service?',
      'translation': 'Ada servis bilik?'
    });
    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 18,
      'phrase': 'Is breakfast included?',
      'translation': 'Sarapan termasuk ke?'
    });
    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 18,
      'phrase': 'Is lunch included?',
      'translation': 'Makan tengahari termasuk ke?'
    });
    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 18,
      'phrase': 'Is dinner included?',
      'translation': 'Makan malam termasuk ke?'
    });
    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 18,
      'phrase': 'Is there a restaurant?',
      'translation': 'Ada restoran?'
    });
    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 18,
      'phrase': 'When is check out?',
      'translation': 'Bila nak check out?'
    });

    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 19,
      'phrase': 'May I see the menu?',
      'translation': 'Boleh saya tengok menu?'
    });
    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 19,
      'phrase': 'I would like to order __.',
      'translation': 'Saya nak order __.'
    });
    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 19,
      'phrase': 'I would like breakfast.',
      'translation': 'Saya nak sarapan.'
    });
    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 19,
      'phrase': 'I would like lunch.',
      'translation': 'Saya nak makan tengahari.'
    });
    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 19,
      'phrase': 'I would like dinner.',
      'translation': 'Saya nak makan malam.'
    });
    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 19,
      'phrase': 'I\'m a vegetarian.',
      'translation': 'Saya vegetarian.'
    });
    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 19,
      'phrase': 'I\'m vegan.',
      'translation': 'Saya vegan.'
    });
    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 19,
      'phrase': 'I don\'t eat pork.',
      'translation': 'Saya tak makan daging babi.'
    });
    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 19,
      'phrase': 'I don\'t eat beef.',
      'translation': 'Saya tak makan daging lembu.'
    });
    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 19,
      'phrase': 'I don\'t eat __.',
      'translation': 'Saya tak makan __.'
    });
    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 19,
      'phrase': 'The bill please.',
      'translation': 'Bil, tolong.'
    });

    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 20,
      'phrase': 'I would like some __.',
      'translation': 'Saya nak __ sikit.'
    });
    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 20,
      'phrase': 'I would like some bottled water.',
      'translation': 'Saya nak air botol.'
    });
    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 20,
      'phrase': 'I would like some carbonated water.',
      'translation': 'Saya nak air berkarbonat.'
    });
    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 20,
      'phrase': 'No ice.',
      'translation': 'Takde ais.'
    });
    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 20,
      'phrase': 'With ice.',
      'translation': 'Dengan ais.'
    });

    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 21,
      'phrase': 'I would like some __.',
      'translation': 'Saya nak __ sikit.'
    });
    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 21,
      'phrase': 'I would like some bottled water.',
      'translation': 'Saya nak air botol.'
    });
    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 21,
      'phrase': 'I would like some carbonated water.',
      'translation': 'Saya nak air berkarbonat.'
    });
    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 21,
      'phrase': 'No ice.',
      'translation': 'Takde ais.'
    });
    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 21,
      'phrase': 'With ice.',
      'translation': 'Dengan ais.'
    });

    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 22,
      'phrase': 'Where is the milk?',
      'translation': 'Mana susu?'
    });
    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 22,
      'phrase': 'Where are the eggs?',
      'translation': 'Mana telur?'
    });
    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 22,
      'phrase': 'Where is the ice cream?',
      'translation': 'Mana aiskrim?'
    });
    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 22,
      'phrase': 'Where is the bottled water?',
      'translation': 'Mana air botol?'
    });
    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 22,
      'phrase': 'Where are the soft drinks?',
      'translation': 'Mana minuman ringan?'
    });
    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 22,
      'phrase': 'Where are the fruits?',
      'translation': 'Mana buah-buahan?'
    });
    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 22,
      'phrase': 'Where are the vegetables?',
      'translation': 'Mana sayur-sayuran?'
    });
    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 22,
      'phrase': 'Where is the meat?',
      'translation': 'Mana daging?'
    });
    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 22,
      'phrase': 'Where is the bread?',
      'translation': 'Mana roti?'
    });
    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 22,
      'phrase': 'Where is the beer?',
      'translation': 'Mana bir?'
    });
    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 22,
      'phrase': 'Where is the wine?',
      'translation': 'Mana wain?'
    });

    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 23,
      'phrase': 'I need a phone charger.',
      'translation': 'Saya perlu pengecas telefon.'
    });
    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 23,
      'phrase': 'I need to check my email.',
      'translation': 'Saya perlu cek email.'
    });
    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 23,
      'phrase': 'Can you change it to English?',
      'translation': 'Boleh tukar ke bahasa Inggeris?'
    });
    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 23,
      'phrase': 'I need a printer.',
      'translation': 'Saya perlu printer.'
    });
    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 23,
      'phrase': 'I need a __.',
      'translation': 'Saya perlu __.'
    });

    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 24,
      'phrase': 'Is there Wi-Fi?',
      'translation': 'Ada Wi-Fi?'
    });
    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 24,
      'phrase': 'What is the password?',
      'translation': 'Apa password?'
    });
    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 24,
      'phrase': 'The Wi-fi isn\'t working.',
      'translation': 'Wi-Fi tak berfungsi.'
    });

    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 25,
      'phrase': 'What is your email?',
      'translation': 'Apa email awak?'
    });
    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 25,
      'phrase': 'I need to check my emails.',
      'translation': 'Saya perlu cek email.'
    });
    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 25,
      'phrase': 'Can you email it to me?',
      'translation': 'Boleh email ke saya?'
    });

    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 26,
      'phrase': 'Can you send it to me?',
      'translation': 'Boleh hantar ke saya?'
    });
    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 26,
      'phrase': 'Can you message it to me?',
      'translation': 'Boleh mesej ke saya?'
    });
    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 26,
      'phrase': 'Can you Whatsapp it to me?',
      'translation': 'Boleh Whatsapp ke saya?'
    });

    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 27,
      'phrase': 'I lost my phone.',
      'translation': 'Saya hilang telefon.'
    });
    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 27,
      'phrase': 'I lost my laptop.',
      'translation': 'Saya hilang laptop.'
    });
    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 27,
      'phrase': 'I lost my __.',
      'translation': 'Saya hilang __.'
    });

    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 28,
      'phrase': 'Monday',
      'translation': 'Isnin'
    });
    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 28,
      'phrase': 'Tuesday',
      'translation': 'Selasa'
    });
    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 28,
      'phrase': 'Wednesday',
      'translation': 'Rabu'
    });
    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 28,
      'phrase': 'Thursday',
      'translation': 'Khamis'
    });
    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 28,
      'phrase': 'Friday',
      'translation': 'Jumaat'
    });
    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 28,
      'phrase': 'Saturday',
      'translation': 'Sabtu'
    });
    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 28,
      'phrase': 'Sunday',
      'translation': 'Ahad'
    });

    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 29,
      'phrase': 'Morning',
      'translation': 'Pagi'
    });
    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 29,
      'phrase': 'Noon',
      'translation': 'Tengahari'
    });
    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 29,
      'phrase': 'Afternoon',
      'translation': 'Petang'
    });
    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 29,
      'phrase': 'Evening',
      'translation': 'Malam'
    });
    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 29,
      'phrase': 'Night',
      'translation': 'Malam'
    });
    await db.insert('phrases', {
      'languageId': 5,
      'categoryId': 29,
      'phrase': 'Midnight',
      'translation': 'Tengah malam'
    });


    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 1,
      'phrase': 'Hello',
      'translation': 'Halo'
    });
    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 1,
      'phrase': 'My name is',
      'translation': 'Nama saya'
    });
    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 1,
      'phrase': 'Excuse me',
      'translation': 'Tumpang lalu'
    });
    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 1,
      'phrase': 'Goodbye',
      'translation': 'Selamat tinggal'
    });
    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 1,
      'phrase': 'How are you?',
      'translation': 'Apa khabar?'
    });
    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 1,
      'phrase': 'Nice to meet you!',
      'translation': 'Seronok jumpa awak!'
    });

    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 2,
      'phrase': 'Please',
      'translation': 'Tolong'
    });
    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 2,
      'phrase': 'I\'m sorry.',
      'translation': 'Saya minta maaf.'
    });
    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 2,
      'phrase': 'Thank you.',
      'translation': 'Terima kasih.'
    });

    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 3,
      'phrase': 'Left',
      'translation': 'Kiri'
    });
    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 3,
      'phrase': 'Right',
      'translation': 'Kanan'
    });
    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 3,
      'phrase': 'Straight ahead',
      'translation': 'Terus saja'
    });
    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 3,
      'phrase': 'In ___ meters.',
      'translation': 'Dalam ___ meter.'
    });
    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 3,
      'phrase': 'Traffic light',
      'translation': 'Lampu isyarat'
    });
    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 3,
      'phrase': 'Stop sign',
      'translation': 'Tanda berhenti'
    });
    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 3,
      'phrase': 'North',
      'translation': 'Utara'
    });
    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 3,
      'phrase': 'South',
      'translation': 'Selatan'
    });
    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 3,
      'phrase': 'East',
      'translation': 'Timur'
    });
    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 3,
      'phrase': 'West',
      'translation': 'Barat'
    });

    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 4,
      'phrase': 'Where is the ATM?',
      'translation': 'Mana ATM?'
    });
    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 4,
      'phrase': 'I want to exchange money.',
      'translation': 'Saya nak tukar duit.'
    });
    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 4,
      'phrase': 'What is the exchange fee?',
      'translation': 'Berapa yuran tukar?'
    });
    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 4,
      'phrase': 'How much does it cost?',
      'translation': 'Berapa harganya?'
    });

    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 5,
      'phrase': 'Where is the toilet?',
      'translation': 'Mana tandas?'
    });
    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 5,
      'phrase': 'Where is the grocery store?',
      'translation': 'Mana kedai runcit?'
    });
    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 5,
      'phrase': 'This is an emergency!',
      'translation': 'Ini kecemasan!'
    });
    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 5,
      'phrase': 'I need help.',
      'translation': 'Saya perlukan bantuan.'
    });

    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 6,
      'phrase': 'Do you speak ___?',
      'translation': 'Awak cakap ___?'
    });
    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 6,
      'phrase': 'I don\'t speak ___.',
      'translation': 'Saya tak cakap ___.'
    });
    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 6,
      'phrase': 'I don\'t understand.',
      'translation': 'Saya tak faham.'
    });
    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 6,
      'phrase': 'I speak ___.',
      'translation': 'Saya cakap ___.'
    });

    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 7,
      'phrase': 'Left',
      'translation': 'Kiri'
    });
    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 7,
      'phrase': 'Right',
      'translation': 'Kanan'
    });
    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 7,
      'phrase': 'Straight ahead',
      'translation': 'Terus saja'
    });
    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 7,
      'phrase': 'In ___ meters.',
      'translation': 'Dalam ___ meter.'
    });
    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 7,
      'phrase': 'Traffic light',
      'translation': 'Lampu isyarat'
    });
    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 7,
      'phrase': 'Stop sign',
      'translation': 'Tanda berhenti'
    });
    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 7,
      'phrase': 'North',
      'translation': 'Utara'
    });
    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 7,
      'phrase': 'South',
      'translation': 'Selatan'
    });
    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 7,
      'phrase': 'East',
      'translation': 'Timur'
    });
    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 7,
      'phrase': 'West',
      'translation': 'Barat'
    });

    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 8,
      'phrase': 'Where is the ATM?',
      'translation': 'Mana ATM?'
    });
    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 8,
      'phrase': 'I want to exchange money.',
      'translation': 'Saya nak tukar duit.'
    });
    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 8,
      'phrase': 'What is the exchange fee?',
      'translation': 'Berapa yuran tukar?'
    });
    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 8,
      'phrase': 'How much does it cost?',
      'translation': 'Berapa harganya?'
    });

    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 9,
      'phrase': 'Where is the toilet?',
      'translation': 'Mana tandas?'
    });
    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 9,
      'phrase': 'Where is the grocery store?',
      'translation': 'Mana kedai runcit?'
    });
    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 9,
      'phrase': 'This is an emergency!',
      'translation': 'Ini kecemasan!'
    });
    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 9,
      'phrase': 'I need help.',
      'translation': 'Saya perlukan bantuan.'
    });

    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 10,
      'phrase': 'Do you speak ___?',
      'translation': 'Awak cakap ___?'
    });
    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 10,
      'phrase': 'I don\'t speak ___.',
      'translation': 'Saya tak cakap ___.'
    });
    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 10,
      'phrase': 'I don\'t understand.',
      'translation': 'Saya tak faham.'
    });
    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 10,
      'phrase': 'I speak ___.',
      'translation': 'Saya cakap ___.'
    });

    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 11,
      'phrase': 'Hello',
      'translation': 'Halo'
    });
    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 11,
      'phrase': 'My name is __.',
      'translation': 'Nama saya __.'
    });
    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 11,
      'phrase': 'Excuse me',
      'translation': 'Tumpang lalu'
    });
    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 11,
      'phrase': 'Goodbye',
      'translation': 'Selamat tinggal'
    });
    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 11,
      'phrase': 'How are you?',
      'translation': 'Apa khabar?'
    });
    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 11,
      'phrase': 'Nice to meet you!',
      'translation': 'Seronok jumpa awak!'
    });

    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 12,
      'phrase': 'Where is the airport?',
      'translation': 'Mana lapangan terbang?'
    });
    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 12,
      'phrase': 'Where is the train station?',
      'translation': 'Mana stesen kereta api?'
    });
    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 12,
      'phrase': 'Where is the subway?',
      'translation': 'Mana kereta api bawah tanah?'
    });
    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 12,
      'phrase': 'Where is the bus station?',
      'translation': 'Mana stesen bas?'
    });
    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 12,
      'phrase': 'Where is the ___ museum?',
      'translation': 'Mana muzium ___?'
    });
    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 12,
      'phrase': 'Where is a good restaurant?',
      'translation': 'Mana restoran bagus?'
    });
    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 12,
      'phrase': 'Where is a nice coffee place?',
      'translation': 'Mana kedai kopi bagus?'
    });
    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 12,
      'phrase': 'Where is a nice bar?',
      'translation': 'Mana bar bagus?'
    });

    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 13,
      'phrase': 'Where can I buy a ticket?',
      'translation': 'Mana boleh beli tiket?'
    });
    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 13,
      'phrase': 'How much is a ticket?',
      'translation': 'Berapa harga tiket?'
    });
    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 13,
      'phrase': 'I need ___ tickets, please.',
      'translation': 'Saya nak ___ tiket, tolong.'
    });
    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 13,
      'phrase': 'I would like to change my ticket.',
      'translation': 'Saya nak tukar tiket saya.'
    });

    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 14,
      'phrase': 'Which platform?',
      'translation': 'Platform mana?'
    });
    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 14,
      'phrase': 'Where is the platform?',
      'translation': 'Mana platform?'
    });
    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 14,
      'phrase': 'Where should I get off?',
      'translation': 'Mana saya patut turun?'
    });
    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 14,
      'phrase': 'I\'d like to get off at ___.',
      'translation': 'Saya nak turun di ___.'
    });
    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 14,
      'phrase': 'Where do I change trains?',
      'translation': 'Mana tukar kereta api?'
    });
    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 14,
      'phrase': 'Where do I change buses?',
      'translation': 'Mana tukar bas?'
    });

    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 15,
      'phrase': 'Here is my passport.',
      'translation': 'Ini pasport saya.'
    });
    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 15,
      'phrase': 'Do I need a visa?',
      'translation': 'Perlu visa ke?'
    });
    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 15,
      'phrase': 'I am an immigrant.',
      'translation': 'Saya orang pendatang.'
    });
    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 15,
      'phrase': 'I am a refugee.',
      'translation': 'Saya orang pelarian.'
    });
    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 15,
      'phrase': 'I have nothing to declare.',
      'translation': 'Saya tak ada apa nak diisytiharkan.'
    });
    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 15,
      'phrase': 'I have something to declare.',
      'translation': 'Saya ada barang nak diisytiharkan.'
    });

    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 16,
      'phrase': 'I have allergies.',
      'translation': 'Saya ada alahan.'
    });
    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 16,
      'phrase': 'I am allergic to ___.',
      'translation': 'Saya alah pada ___.'
    });
    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 16,
      'phrase': 'I am allergic to penicillin.',
      'translation': 'Saya alah pada penicillin.'
    });
    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 16,
      'phrase': 'I am allergic to antibiotics.',
      'translation': 'Saya alah pada antibiotik.'
    });
    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 16,
      'phrase': 'I have Asthma.',
      'translation': 'Saya ada asma.'
    });

    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 17,
      'phrase': 'I would like to check in.',
      'translation': 'Saya nak check in.'
    });
    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 17,
      'phrase': 'I would like to change my reservation.',
      'translation': 'Saya nak tukar tempahan saya.'
    });
    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 17,
      'phrase': 'Can we have a room with ___ view?',
      'translation': 'Boleh ke bilik saya ada view ___?'
    });
    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 17,
      'phrase': 'When does breakfast start?',
      'translation': 'Bila sarapan mula?'
    });
    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 17,
      'phrase': 'When does lunch start?',
      'translation': 'Bila makan tengahari mula?'
    });
    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 17,
      'phrase': 'When does dinner start?',
      'translation': 'Bila makan malam mula?'
    });
    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 17,
      'phrase': 'When is check out?',
      'translation': 'Bila nak check out?'
    });
    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 17,
      'phrase': 'My room needs to be cleaned.',
      'translation': 'Bilik saya perlu dibersihkan.'
    });

    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 18,
      'phrase': 'Do you have free rooms?',
      'translation': 'Ada bilik kosong?'
    });
    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 18,
      'phrase': 'I would like ___ rooms.',
      'translation': 'Saya nak ___ bilik.'
    });
    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 18,
      'phrase': 'We are ___ people.',
      'translation': 'Kami ___ orang.'
    });
    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 18,
      'phrase': 'How much does the room cost?',
      'translation': 'Berapa harga bilik?'
    });
    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 18,
      'phrase': 'Is it air conditioned?',
      'translation': 'Ada aircon ke?'
    });
    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 18,
      'phrase': 'Is there room service?',
      'translation': 'Ada servis bilik?'
    });
    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 18,
      'phrase': 'Is breakfast included?',
      'translation': 'Sarapan termasuk ke?'
    });
    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 18,
      'phrase': 'Is lunch included?',
      'translation': 'Makan tengahari termasuk ke?'
    });
    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 18,
      'phrase': 'Is dinner included?',
      'translation': 'Makan malam termasuk ke?'
    });
    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 18,
      'phrase': 'Is there a restaurant?',
      'translation': 'Ada restoran?'
    });
    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 18,
      'phrase': 'When is check out?',
      'translation': 'Bila nak check out?'
    });

    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 19,
      'phrase': 'May I see the menu?',
      'translation': 'Boleh saya tengok menu?'
    });
    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 19,
      'phrase': 'I would like to order __.',
      'translation': 'Saya nak order __.'
    });
    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 19,
      'phrase': 'I would like breakfast.',
      'translation': 'Saya nak sarapan.'
    });
    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 19,
      'phrase': 'I would like lunch.',
      'translation': 'Saya nak makan tengahari.'
    });
    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 19,
      'phrase': 'I would like dinner.',
      'translation': 'Saya nak makan malam.'
    });
    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 19,
      'phrase': 'I\'m a vegetarian.',
      'translation': 'Saya vegetarian.'
    });
    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 19,
      'phrase': 'I\'m vegan.',
      'translation': 'Saya vegan.'
    });
    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 19,
      'phrase': 'I don\'t eat pork.',
      'translation': 'Saya tak makan daging babi.'
    });
    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 19,
      'phrase': 'I don\'t eat beef.',
      'translation': 'Saya tak makan daging lembu.'
    });
    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 19,
      'phrase': 'I don\'t eat __.',
      'translation': 'Saya tak makan __.'
    });
    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 19,
      'phrase': 'The bill please.',
      'translation': 'Bil, tolong.'
    });

    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 20,
      'phrase': 'I would like some __.',
      'translation': 'Saya nak __ sikit.'
    });
    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 20,
      'phrase': 'I would like some bottled water.',
      'translation': 'Saya nak air botol.'
    });
    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 20,
      'phrase': 'I would like some carbonated water.',
      'translation': 'Saya nak air berkarbonat.'
    });
    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 20,
      'phrase': 'No ice.',
      'translation': 'Takde ais.'
    });
    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 20,
      'phrase': 'With ice.',
      'translation': 'Dengan ais.'
    });

    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 21,
      'phrase': 'I would like some __.',
      'translation': 'Saya nak __ sikit.'
    });
    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 21,
      'phrase': 'I would like some bottled water.',
      'translation': 'Saya nak air botol.'
    });
    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 21,
      'phrase': 'I would like some carbonated water.',
      'translation': 'Saya nak air berkarbonat.'
    });
    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 21,
      'phrase': 'No ice.',
      'translation': 'Takde ais.'
    });
    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 21,
      'phrase': 'With ice.',
      'translation': 'Dengan ais.'
    });

    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 22,
      'phrase': 'Where is the milk?',
      'translation': 'Mana susu?'
    });
    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 22,
      'phrase': 'Where are the eggs?',
      'translation': 'Mana telur?'
    });
    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 22,
      'phrase': 'Where is the ice cream?',
      'translation': 'Mana aiskrim?'
    });
    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 22,
      'phrase': 'Where is the bottled water?',
      'translation': 'Mana air botol?'
    });
    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 22,
      'phrase': 'Where are the soft drinks?',
      'translation': 'Mana minuman ringan?'
    });
    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 22,
      'phrase': 'Where are the fruits?',
      'translation': 'Mana buah-buahan?'
    });
    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 22,
      'phrase': 'Where are the vegetables?',
      'translation': 'Mana sayur-sayuran?'
    });
    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 22,
      'phrase': 'Where is the meat?',
      'translation': 'Mana daging?'
    });
    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 22,
      'phrase': 'Where is the bread?',
      'translation': 'Mana roti?'
    });
    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 22,
      'phrase': 'Where is the beer?',
      'translation': 'Mana bir?'
    });
    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 22,
      'phrase': 'Where is the wine?',
      'translation': 'Mana wain?'
    });

    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 23,
      'phrase': 'I need a phone charger.',
      'translation': 'Saya perlu pengecas telefon.'
    });
    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 23,
      'phrase': 'I need to check my email.',
      'translation': 'Saya perlu cek email.'
    });
    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 23,
      'phrase': 'Can you change it to English?',
      'translation': 'Boleh tukar ke bahasa Inggeris?'
    });
    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 23,
      'phrase': 'I need a printer.',
      'translation': 'Saya perlu printer.'
    });
    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 23,
      'phrase': 'I need a __.',
      'translation': 'Saya perlu __.'
    });

    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 24,
      'phrase': 'Is there Wi-Fi?',
      'translation': 'Ada Wi-Fi?'
    });
    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 24,
      'phrase': 'What is the password?',
      'translation': 'Apa password?'
    });
    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 24,
      'phrase': 'The Wi-fi isn\'t working.',
      'translation': 'Wi-Fi tak berfungsi.'
    });

    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 25,
      'phrase': 'What is your email?',
      'translation': 'Apa email awak?'
    });
    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 25,
      'phrase': 'I need to check my emails.',
      'translation': 'Saya perlu cek email.'
    });
    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 25,
      'phrase': 'Can you email it to me?',
      'translation': 'Boleh email ke saya?'
    });

    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 26,
      'phrase': 'Can you send it to me?',
      'translation': 'Boleh hantar ke saya?'
    });
    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 26,
      'phrase': 'Can you message it to me?',
      'translation': 'Boleh mesej ke saya?'
    });
    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 26,
      'phrase': 'Can you Whatsapp it to me?',
      'translation': 'Boleh Whatsapp ke saya?'
    });

    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 27,
      'phrase': 'I lost my phone.',
      'translation': 'Saya hilang telefon.'
    });
    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 27,
      'phrase': 'I lost my laptop.',
      'translation': 'Saya hilang laptop.'
    });
    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 27,
      'phrase': 'I lost my __.',
      'translation': 'Saya hilang __.'
    });

    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 28,
      'phrase': 'Monday',
      'translation': 'Isnin'
    });
    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 28,
      'phrase': 'Tuesday',
      'translation': 'Selasa'
    });
    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 28,
      'phrase': 'Wednesday',
      'translation': 'Rabu'
    });
    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 28,
      'phrase': 'Thursday',
      'translation': 'Khamis'
    });
    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 28,
      'phrase': 'Friday',
      'translation': 'Jumaat'
    });
    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 28,
      'phrase': 'Saturday',
      'translation': 'Sabtu'
    });
    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 28,
      'phrase': 'Sunday',
      'translation': 'Ahad'
    });

    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 29,
      'phrase': 'Morning',
      'translation': 'Pagi'
    });
    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 29,
      'phrase': 'Noon',
      'translation': 'Tengahari'
    });
    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 29,
      'phrase': 'Afternoon',
      'translation': 'Petang'
    });
    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 29,
      'phrase': 'Evening',
      'translation': 'Petang'
    });
    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 29,
      'phrase': 'Night',
      'translation': 'Malam'
    });
    await db.insert('phrases', {
      'languageId': 6,
      'categoryId': 29,
      'phrase': 'Midnight',
      'translation': 'Tengah malam'
    });

    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 1,
      'phrase': 'Hello',
      'translation': 'Halo'
    });
    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 1,
      'phrase': 'My name is',
      'translation': 'Namo den'
    });
    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 1,
      'phrase': 'Excuse me',
      'translation': 'Tumpang lalu'
    });
    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 1,
      'phrase': 'Goodbye',
      'translation': 'Selamat tinggal'
    });
    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 1,
      'phrase': 'How are you?',
      'translation': 'Apo khabar?'
    });
    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 1,
      'phrase': 'Nice to meet you!',
      'translation': 'Seronok jumpa kau!'
    });

    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 2,
      'phrase': 'Please',
      'translation': 'Tolong'
    });
    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 2,
      'phrase': 'I\'m sorry.',
      'translation': 'Den mintak maaf.'
    });
    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 2,
      'phrase': 'Thank you.',
      'translation': 'Terimo kasih.'
    });

    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 3,
      'phrase': 'Left',
      'translation': 'Kiri'
    });
    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 3,
      'phrase': 'Right',
      'translation': 'Kanan'
    });
    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 3,
      'phrase': 'Straight ahead',
      'translation': 'Teruih jo'
    });
    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 3,
      'phrase': 'In ___ meters.',
      'translation': 'Dalam ___ meter.'
    });
    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 3,
      'phrase': 'Traffic light',
      'translation': 'Lampu isyarat'
    });
    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 3,
      'phrase': 'Stop sign',
      'translation': 'Tandoh benti'
    });
    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 3,
      'phrase': 'North',
      'translation': 'Utara'
    });
    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 3,
      'phrase': 'South',
      'translation': 'Selatan'
    });
    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 3,
      'phrase': 'East',
      'translation': 'Timur'
    });
    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 3,
      'phrase': 'West',
      'translation': 'Barat'
    });

    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 4,
      'phrase': 'Where is the ATM?',
      'translation': 'Mano ATM?'
    });
    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 4,
      'phrase': 'I want to exchange money.',
      'translation': 'Den nak tukar pitih.'
    });
    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 4,
      'phrase': 'What is the exchange fee?',
      'translation': 'Berapo yuran tukar?'
    });
    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 4,
      'phrase': 'How much does it cost?',
      'translation': 'Berapo harganyo?'
    });

    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 5,
      'phrase': 'Where is the toilet?',
      'translation': 'Mano jamban?'
    });
    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 5,
      'phrase': 'Where is the grocery store?',
      'translation': 'Mano kedai runcit?'
    });
    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 5,
      'phrase': 'This is an emergency!',
      'translation': 'Ini kecemasan!'
    });
    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 5,
      'phrase': 'I need help.',
      'translation': 'Den perlu bantuan.'
    });

    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 6,
      'phrase': 'Do you speak ___?',
      'translation': 'Kau cakap ___?'
    });
    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 6,
      'phrase': 'I don\'t speak ___.',
      'translation': 'Den tak cakap ___.'
    });
    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 6,
      'phrase': 'I don\'t understand.',
      'translation': 'Den tak faham.'
    });
    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 6,
      'phrase': 'I speak ___.',
      'translation': 'Den cakap ___.'
    });

    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 7,
      'phrase': 'Left',
      'translation': 'Kiri'
    });
    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 7,
      'phrase': 'Right',
      'translation': 'Kanan'
    });
    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 7,
      'phrase': 'Straight ahead',
      'translation': 'Teruih jo'
    });
    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 7,
      'phrase': 'In ___ meters.',
      'translation': 'Dalam ___ meter.'
    });
    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 7,
      'phrase': 'Traffic light',
      'translation': 'Lampu isyarat'
    });
    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 7,
      'phrase': 'Stop sign',
      'translation': 'Tandoh benti'
    });
    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 7,
      'phrase': 'North',
      'translation': 'Utara'
    });
    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 7,
      'phrase': 'South',
      'translation': 'Selatan'
    });
    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 7,
      'phrase': 'East',
      'translation': 'Timur'
    });
    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 7,
      'phrase': 'West',
      'translation': 'Barat'
    });

    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 8,
      'phrase': 'Where is the ATM?',
      'translation': 'Mano ATM?'
    });
    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 8,
      'phrase': 'I want to exchange money.',
      'translation': 'Den nak tukar pitih.'
    });
    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 8,
      'phrase': 'What is the exchange fee?',
      'translation': 'Berapo yuran tukar?'
    });
    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 8,
      'phrase': 'How much does it cost?',
      'translation': 'Berapo harganyo?'
    });

    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 9,
      'phrase': 'Where is the toilet?',
      'translation': 'Mano jamban?'
    });
    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 9,
      'phrase': 'Where is the grocery store?',
      'translation': 'Mano kedai runcit?'
    });
    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 9,
      'phrase': 'This is an emergency!',
      'translation': 'Ini kecemasan!'
    });
    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 9,
      'phrase': 'I need help.',
      'translation': 'Den perlu bantuan.'
    });

    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 10,
      'phrase': 'Do you speak ___?',
      'translation': 'Kau cakap ___?'
    });
    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 10,
      'phrase': 'I don\'t speak ___.',
      'translation': 'Den tak cakap ___.'
    });
    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 10,
      'phrase': 'I don\'t understand.',
      'translation': 'Den tak faham.'
    });
    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 10,
      'phrase': 'I speak ___.',
      'translation': 'Den cakap ___.'
    });

    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 11,
      'phrase': 'Hello',
      'translation': 'Halo'
    });
    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 11,
      'phrase': 'My name is __.',
      'translation': 'Namo den __.'
    });
    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 11,
      'phrase': 'Excuse me',
      'translation': 'Tumpang lalu'
    });
    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 11,
      'phrase': 'Goodbye',
      'translation': 'Selamat tinggal'
    });
    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 11,
      'phrase': 'How are you?',
      'translation': 'Apo khabar?'
    });
    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 11,
      'phrase': 'Nice to meet you!',
      'translation': 'Seronok jumpa kau!'
    });

    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 12,
      'phrase': 'Where is the airport?',
      'translation': 'Mano lapangan terbang?'
    });
    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 12,
      'phrase': 'Where is the train station?',
      'translation': 'Mano stesen kereta api?'
    });
    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 12,
      'phrase': 'Where is the subway?',
      'translation': 'Mano kereta api bawah tanah?'
    });
    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 12,
      'phrase': 'Where is the bus station?',
      'translation': 'Mano stesen bas?'
    });
    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 12,
      'phrase': 'Where is the ___ museum?',
      'translation': 'Mano muzium ___?'
    });
    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 12,
      'phrase': 'Where is a good restaurant?',
      'translation': 'Mano restoran bagus?'
    });
    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 12,
      'phrase': 'Where is a nice coffee place?',
      'translation': 'Mano kedai kopi bagus?'
    });
    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 12,
      'phrase': 'Where is a nice bar?',
      'translation': 'Mano bar bagus?'
    });

    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 13,
      'phrase': 'Where can I buy a ticket?',
      'translation': 'Mano boleh beli tiket?'
    });
    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 13,
      'phrase': 'How much is a ticket?',
      'translation': 'Berapo harga tiket?'
    });
    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 13,
      'phrase': 'I need ___ tickets, please.',
      'translation': 'Den nak ___ tiket, tolong.'
    });
    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 13,
      'phrase': 'I would like to change my ticket.',
      'translation': 'Den nak tukar tiket den.'
    });

    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 14,
      'phrase': 'Which platform?',
      'translation': 'Platform mano?'
    });
    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 14,
      'phrase': 'Where is the platform?',
      'translation': 'Mano platform?'
    });
    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 14,
      'phrase': 'Where should I get off?',
      'translation': 'Mano den patut turun?'
    });
    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 14,
      'phrase': 'I\'d like to get off at ___.',
      'translation': 'Den nak turun di ___.'
    });
    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 14,
      'phrase': 'Where do I change trains?',
      'translation': 'Mano tukar kereta api?'
    });
    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 14,
      'phrase': 'Where do I change buses?',
      'translation': 'Mano tukar bas?'
    });

    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 15,
      'phrase': 'Here is my passport.',
      'translation': 'Ini pasport den.'
    });
    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 15,
      'phrase': 'Do I need a visa?',
      'translation': 'Perlu visa ke?'
    });
    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 15,
      'phrase': 'I am an immigrant.',
      'translation': 'Den orang pendatang.'
    });
    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 15,
      'phrase': 'I am a refugee.',
      'translation': 'Den orang pelarian.'
    });
    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 15,
      'phrase': 'I have nothing to declare.',
      'translation': 'Den tak ado apo nak diisytiharkan.'
    });
    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 15,
      'phrase': 'I have something to declare.',
      'translation': 'Den ado barang nak diisytiharkan.'
    });

    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 16,
      'phrase': 'I have allergies.',
      'translation': 'Den ado alahan.'
    });
    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 16,
      'phrase': 'I am allergic to ___.',
      'translation': 'Den alah kat ___.'
    });
    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 16,
      'phrase': 'I am allergic to penicillin.',
      'translation': 'Den alah penicillin.'
    });
    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 16,
      'phrase': 'I am allergic to antibiotics.',
      'translation': 'Den alah antibiotik.'
    });
    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 16,
      'phrase': 'I have Asthma.',
      'translation': 'Den ado asma.'
    });

    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 17,
      'phrase': 'I would like to check in.',
      'translation': 'Den nak check in.'
    });
    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 17,
      'phrase': 'I would like to change my reservation.',
      'translation': 'Den nak tukar tempahan den.'
    });
    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 17,
      'phrase': 'Can we have a room with ___ view?',
      'translation': 'Boleh ke bilik den ado view ___?'
    });
    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 17,
      'phrase': 'When does breakfast start?',
      'translation': 'Bilo sarapan start?'
    });
    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 17,
      'phrase': 'When does lunch start?',
      'translation': 'Bilo makan tengahari start?'
    });
    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 17,
      'phrase': 'When does dinner start?',
      'translation': 'Bilo makan malam start?'
    });
    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 17,
      'phrase': 'When is check out?',
      'translation': 'Bilo nak check out?'
    });
    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 17,
      'phrase': 'My room needs to be cleaned.',
      'translation': 'Bilik den perlu dibersihkan.'
    });

    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 18,
      'phrase': 'Do you have free rooms?',
      'translation': 'Ado bilik kosong?'
    });
    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 18,
      'phrase': 'I would like ___ rooms.',
      'translation': 'Den nak ___ bilik.'
    });
    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 18,
      'phrase': 'We are ___ people.',
      'translation': 'Kami ___ orang.'
    });
    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 18,
      'phrase': 'How much does the room cost?',
      'translation': 'Berapo harga bilik?'
    });
    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 18,
      'phrase': 'Is it air conditioned?',
      'translation': 'Ado aircon ke?'
    });
    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 18,
      'phrase': 'Is there room service?',
      'translation': 'Ado servis bilik?'
    });
    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 18,
      'phrase': 'Is breakfast included?',
      'translation': 'Sarapan termasuk ke?'
    });
    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 18,
      'phrase': 'Is lunch included?',
      'translation': 'Makan tengahari termasuk ke?'
    });
    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 18,
      'phrase': 'Is dinner included?',
      'translation': 'Makan malam termasuk ke?'
    });
    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 18,
      'phrase': 'Is there a restaurant?',
      'translation': 'Ado restoran?'
    });
    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 18,
      'phrase': 'When is check out?',
      'translation': 'Bilo nak check out?'
    });

    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 19,
      'phrase': 'May I see the menu?',
      'translation': 'Boleh den tengok menu?'
    });
    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 19,
      'phrase': 'I would like to order __.',
      'translation': 'Den nak order __.'
    });
    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 19,
      'phrase': 'I would like breakfast.',
      'translation': 'Den nak sarapan.'
    });
    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 19,
      'phrase': 'I would like lunch.',
      'translation': 'Den nak makan tengahari.'
    });
    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 19,
      'phrase': 'I would like dinner.',
      'translation': 'Den nak makan malam.'
    });
    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 19,
      'phrase': 'I\'m a vegetarian.',
      'translation': 'Den vegetarian.'
    });
    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 19,
      'phrase': 'I\'m vegan.',
      'translation': 'Den vegan.'
    });
    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 19,
      'phrase': 'I don\'t eat pork.',
      'translation': 'Den tak makan daging babi.'
    });
    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 19,
      'phrase': 'I don\'t eat beef.',
      'translation': 'Den tak makan daging lembu.'
    });
    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 19,
      'phrase': 'I don\'t eat __.',
      'translation': 'Den tak makan __.'
    });
    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 19,
      'phrase': 'The bill please.',
      'translation': 'Bil, tolong.'
    });

    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 20,
      'phrase': 'I would like some __.',
      'translation': 'Den nak __ sikit.'
    });
    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 20,
      'phrase': 'I would like some bottled water.',
      'translation': 'Den nak air botol.'
    });
    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 20,
      'phrase': 'I would like some carbonated water.',
      'translation': 'Den nak air berkarbonat.'
    });
    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 20,
      'phrase': 'No ice.',
      'translation': 'Takdo ais.'
    });
    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 20,
      'phrase': 'With ice.',
      'translation': 'Dengan ais.'
    });

    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 21,
      'phrase': 'I would like some __.',
      'translation': 'Den nak __ sikit.'
    });
    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 21,
      'phrase': 'I would like some bottled water.',
      'translation': 'Den nak air botol.'
    });
    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 21,
      'phrase': 'I would like some carbonated water.',
      'translation': 'Den nak air berkarbonat.'
    });
    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 21,
      'phrase': 'No ice.',
      'translation': 'Takdo ais.'
    });
    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 21,
      'phrase': 'With ice.',
      'translation': 'Dengan ais.'
    });

    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 22,
      'phrase': 'Where is the milk?',
      'translation': 'Mano susu?'
    });
    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 22,
      'phrase': 'Where are the eggs?',
      'translation': 'Mano telur?'
    });
    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 22,
      'phrase': 'Where is the ice cream?',
      'translation': 'Mano aiskrim?'
    });
    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 22,
      'phrase': 'Where is the bottled water?',
      'translation': 'Mano air botol?'
    });
    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 22,
      'phrase': 'Where are the soft drinks?',
      'translation': 'Mano minuman ringan?'
    });
    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 22,
      'phrase': 'Where are the fruits?',
      'translation': 'Mano buah-buahan?'
    });
    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 22,
      'phrase': 'Where are the vegetables?',
      'translation': 'Mano sayur-sayuran?'
    });
    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 22,
      'phrase': 'Where is the meat?',
      'translation': 'Mano daging?'
    });
    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 22,
      'phrase': 'Where is the bread?',
      'translation': 'Mano roti?'
    });
    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 22,
      'phrase': 'Where is the beer?',
      'translation': 'Mano bir?'
    });
    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 22,
      'phrase': 'Where is the wine?',
      'translation': 'Mano wain?'
    });

    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 23,
      'phrase': 'I need a phone charger.',
      'translation': 'Den perlu pengecas telefon.'
    });
    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 23,
      'phrase': 'I need to check my email.',
      'translation': 'Den perlu cek email.'
    });
    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 23,
      'phrase': 'Can you change it to English?',
      'translation': 'Boleh tukar ke bahasa Inggeris?'
    });
    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 23,
      'phrase': 'I need a printer.',
      'translation': 'Den perlu printer.'
    });
    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 23,
      'phrase': 'I need a __.',
      'translation': 'Den perlu __.'
    });

    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 24,
      'phrase': 'Is there Wi-Fi?',
      'translation': 'Ado Wi-Fi?'
    });
    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 24,
      'phrase': 'What is the password?',
      'translation': 'Apo password?'
    });
    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 24,
      'phrase': 'The Wi-fi isn\'t working.',
      'translation': 'Wi-Fi tak berfungsi.'
    });

    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 25,
      'phrase': 'What is your email?',
      'translation': 'Apo email kau?'
    });
    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 25,
      'phrase': 'I need to check my emails.',
      'translation': 'Den perlu cek email.'
    });
    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 25,
      'phrase': 'Can you email it to me?',
      'translation': 'Boleh email ke den?'
    });

    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 26,
      'phrase': 'Can you send it to me?',
      'translation': 'Boleh hantar ke den?'
    });
    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 26,
      'phrase': 'Can you message it to me?',
      'translation': 'Boleh mesej ke den?'
    });
    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 26,
      'phrase': 'Can you Whatsapp it to me?',
      'translation': 'Boleh Whatsapp ke den?'
    });

    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 27,
      'phrase': 'I lost my phone.',
      'translation': 'Den hilang telefon.'
    });
    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 27,
      'phrase': 'I lost my laptop.',
      'translation': 'Den hilang laptop.'
    });
    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 27,
      'phrase': 'I lost my __.',
      'translation': 'Den hilang __.'
    });

    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 28,
      'phrase': 'Monday',
      'translation': 'Isnin'
    });
    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 28,
      'phrase': 'Tuesday',
      'translation': 'Selasa'
    });
    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 28,
      'phrase': 'Wednesday',
      'translation': 'Rabu'
    });
    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 28,
      'phrase': 'Thursday',
      'translation': 'Khamis'
    });
    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 28,
      'phrase': 'Friday',
      'translation': 'Jumaat'
    });
    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 28,
      'phrase': 'Saturday',
      'translation': 'Sabtu'
    });
    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 28,
      'phrase': 'Sunday',
      'translation': 'Ahad'
    });

    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 29,
      'phrase': 'Morning',
      'translation': 'Pagi'
    });
    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 29,
      'phrase': 'Noon',
      'translation': 'Tengahari'
    });
    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 29,
      'phrase': 'Afternoon',
      'translation': 'Petang'
    });
    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 29,
      'phrase': 'Evening',
      'translation': 'Malam'
    });
    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 29,
      'phrase': 'Night',
      'translation': 'Malam'
    });
    await db.insert('phrases', {
      'languageId': 7,
      'categoryId': 29,
      'phrase': 'Midnight',
      'translation': 'Tengah malam'
    });

    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 1,
      'phrase': 'Hello',
      'translation': 'Halo'
    });
    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 1,
      'phrase': 'My name is',
      'translation': 'Nama teman'
    });
    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 1,
      'phrase': 'Excuse me',
      'translation': 'Tumpang lalu'
    });
    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 1,
      'phrase': 'Goodbye',
      'translation': 'Selamat tinggal'
    });
    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 1,
      'phrase': 'How are you?',
      'translation': 'Apa khabar?'
    });
    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 1,
      'phrase': 'Nice to meet you!',
      'translation': 'Seronok jumpa mike!'
    });

    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 2,
      'phrase': 'Please',
      'translation': 'Tolong'
    });
    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 2,
      'phrase': 'I\'m sorry.',
      'translation': 'Teman minta maaf.'
    });
    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 2,
      'phrase': 'Thank you.',
      'translation': 'Terima kasih.'
    });

    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 3,
      'phrase': 'Left',
      'translation': 'Kiri'
    });
    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 3,
      'phrase': 'Right',
      'translation': 'Kanan'
    });
    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 3,
      'phrase': 'Straight ahead',
      'translation': 'Terus je'
    });
    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 3,
      'phrase': 'In ___ meters.',
      'translation': 'Dalam ___ meter.'
    });
    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 3,
      'phrase': 'Traffic light',
      'translation': 'Lampu isyarat'
    });
    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 3,
      'phrase': 'Stop sign',
      'translation': 'Tanda berhenti'
    });
    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 3,
      'phrase': 'North',
      'translation': 'Utara'
    });
    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 3,
      'phrase': 'South',
      'translation': 'Selatan'
    });
    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 3,
      'phrase': 'East',
      'translation': 'Timur'
    });
    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 3,
      'phrase': 'West',
      'translation': 'Barat'
    });

    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 4,
      'phrase': 'Where is the ATM?',
      'translation': 'Mana ATM?'
    });
    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 4,
      'phrase': 'I want to exchange money.',
      'translation': 'Teman nak tukar duit.'
    });
    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 4,
      'phrase': 'What is the exchange fee?',
      'translation': 'Berapo yuran tukar?'
    });
    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 4,
      'phrase': 'How much does it cost?',
      'translation': 'Berapo harganyo?'
    });

    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 5,
      'phrase': 'Where is the toilet?',
      'translation': 'Mana jamban?'
    });
    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 5,
      'phrase': 'Where is the grocery store?',
      'translation': 'Mana kedai runcit?'
    });
    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 5,
      'phrase': 'This is an emergency!',
      'translation': 'Ini kecemasan!'
    });
    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 5,
      'phrase': 'I need help.',
      'translation': 'Teman perlu bantuan.'
    });

    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 6,
      'phrase': 'Do you speak ___?',
      'translation': 'Mike cakap ___?'
    });
    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 6,
      'phrase': 'I don\'t speak ___.',
      'translation': 'Teman tak cakap ___.'
    });
    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 6,
      'phrase': 'I don\'t understand.',
      'translation': 'Teman tak faham.'
    });
    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 6,
      'phrase': 'I speak ___.',
      'translation': 'Teman cakap ___.'
    });

    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 7,
      'phrase': 'Left',
      'translation': 'Kiri'
    });
    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 7,
      'phrase': 'Right',
      'translation': 'Kanan'
    });
    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 7,
      'phrase': 'Straight ahead',
      'translation': 'Terus je'
    });
    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 7,
      'phrase': 'In ___ meters.',
      'translation': 'Dalam ___ meter.'
    });
    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 7,
      'phrase': 'Traffic light',
      'translation': 'Lampu isyarat'
    });
    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 7,
      'phrase': 'Stop sign',
      'translation': 'Tanda berhenti'
    });
    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 7,
      'phrase': 'North',
      'translation': 'Utara'
    });
    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 7,
      'phrase': 'South',
      'translation': 'Selatan'
    });
    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 7,
      'phrase': 'East',
      'translation': 'Timur'
    });
    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 7,
      'phrase': 'West',
      'translation': 'Barat'
    });

    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 8,
      'phrase': 'Where is the ATM?',
      'translation': 'Mana ATM?'
    });
    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 8,
      'phrase': 'I want to exchange money.',
      'translation': 'Teman nak tukar duit.'
    });
    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 8,
      'phrase': 'What is the exchange fee?',
      'translation': 'Berapo yuran tukar?'
    });
    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 8,
      'phrase': 'How much does it cost?',
      'translation': 'Berapo harganyo?'
    });

    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 9,
      'phrase': 'Where is the toilet?',
      'translation': 'Mana jamban?'
    });
    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 9,
      'phrase': 'Where is the grocery store?',
      'translation': 'Mana kedai runcit?'
    });
    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 9,
      'phrase': 'This is an emergency!',
      'translation': 'Ini kecemasan!'
    });
    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 9,
      'phrase': 'I need help.',
      'translation': 'Teman perlu bantuan.'
    });

    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 10,
      'phrase': 'Do you speak ___?',
      'translation': 'Mike cakap ___?'
    });
    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 10,
      'phrase': 'I don\'t speak ___.',
      'translation': 'Teman tak cakap ___.'
    });
    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 10,
      'phrase': 'I don\'t understand.',
      'translation': 'Teman tak faham.'
    });
    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 10,
      'phrase': 'I speak ___.',
      'translation': 'Teman cakap ___.'
    });

    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 11,
      'phrase': 'Hello',
      'translation': 'Halo'
    });
    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 11,
      'phrase': 'My name is __.',
      'translation': 'Nama teman __.'
    });
    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 11,
      'phrase': 'Excuse me',
      'translation': 'Tumpang lalu'
    });
    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 11,
      'phrase': 'Goodbye',
      'translation': 'Selamat tinggal'
    });
    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 11,
      'phrase': 'How are you?',
      'translation': 'Apa khabar?'
    });
    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 11,
      'phrase': 'Nice to meet you!',
      'translation': 'Seronok jumpa mike!'
    });

    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 12,
      'phrase': 'Where is the airport?',
      'translation': 'Mana lapangan terbang?'
    });
    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 12,
      'phrase': 'Where is the train station?',
      'translation': 'Mana stesen kereta api?'
    });
    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 12,
      'phrase': 'Where is the subway?',
      'translation': 'Mana kereta api bawah tanah?'
    });
    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 12,
      'phrase': 'Where is the bus station?',
      'translation': 'Mana stesen bas?'
    });
    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 12,
      'phrase': 'Where is the ___ museum?',
      'translation': 'Mana muzium ___?'
    });
    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 12,
      'phrase': 'Where is a good restaurant?',
      'translation': 'Mana restoran bagus?'
    });
    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 12,
      'phrase': 'Where is a nice coffee place?',
      'translation': 'Mana kedai kopi bagus?'
    });
    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 12,
      'phrase': 'Where is a nice bar?',
      'translation': 'Mana bar bagus?'
    });

    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 13,
      'phrase': 'Where can I buy a ticket?',
      'translation': 'Mana boleh beli tiket?'
    });
    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 13,
      'phrase': 'How much is a ticket?',
      'translation': 'Berapo harga tiket?'
    });
    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 13,
      'phrase': 'I need ___ tickets, please.',
      'translation': 'Teman nak ___ tiket, tolong.'
    });
    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 13,
      'phrase': 'I would like to change my ticket.',
      'translation': 'Teman nak tukar tiket teman.'
    });

    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 14,
      'phrase': 'Which platform?',
      'translation': 'Platform mana?'
    });
    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 14,
      'phrase': 'Where is the platform?',
      'translation': 'Mana platform?'
    });
    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 14,
      'phrase': 'Where should I get off?',
      'translation': 'Mana teman patut turun?'
    });
    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 14,
      'phrase': 'I\'d like to get off at ___.',
      'translation': 'Teman nak turun di ___.'
    });
    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 14,
      'phrase': 'Where do I change trains?',
      'translation': 'Mana tukar kereta api?'
    });
    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 14,
      'phrase': 'Where do I change buses?',
      'translation': 'Mana tukar bas?'
    });

    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 15,
      'phrase': 'Here is my passport.',
      'translation': 'Ini pasport teman.'
    });
    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 15,
      'phrase': 'Do I need a visa?',
      'translation': 'Perlu visa ke?'
    });
    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 15,
      'phrase': 'I am an immigrant.',
      'translation': 'Teman orang pendatang.'
    });
    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 15,
      'phrase': 'I am a refugee.',
      'translation': 'Teman orang pelarian.'
    });
    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 15,
      'phrase': 'I have nothing to declare.',
      'translation': 'Teman tak ado apo nak diisytiharkan.'
    });
    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 15,
      'phrase': 'I have something to declare.',
      'translation': 'Teman ado barang nak diisytiharkan.'
    });

    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 16,
      'phrase': 'I have allergies.',
      'translation': 'Teman ado alahan.'
    });
    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 16,
      'phrase': 'I am allergic to ___.',
      'translation': 'Teman alah kat ___.'
    });
    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 16,
      'phrase': 'I am allergic to penicillin.',
      'translation': 'Teman alah penicillin.'
    });
    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 16,
      'phrase': 'I am allergic to antibiotics.',
      'translation': 'Teman alah antibiotik.'
    });
    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 16,
      'phrase': 'I have Asthma.',
      'translation': 'Teman ado asma.'
    });

    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 17,
      'phrase': 'I would like to check in.',
      'translation': 'Teman nak check in.'
    });
    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 17,
      'phrase': 'I would like to change my reservation.',
      'translation': 'Teman nak tukar tempahan teman.'
    });
    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 17,
      'phrase': 'Can we have a room with ___ view?',
      'translation': 'Boleh ke bilik teman ado view ___?'
    });
    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 17,
      'phrase': 'When does breakfast start?',
      'translation': 'Bila sarapan start?'
    });
    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 17,
      'phrase': 'When does lunch start?',
      'translation': 'Bila makan tengahari start?'
    });
    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 17,
      'phrase': 'When does dinner start?',
      'translation': 'Bila makan malam start?'
    });
    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 17,
      'phrase': 'When is check out?',
      'translation': 'Bila nak check out?'
    });
    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 17,
      'phrase': 'My room needs to be cleaned.',
      'translation': 'Bilik teman perlu dibersihkan.'
    });

    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 18,
      'phrase': 'Do you have free rooms?',
      'translation': 'Ado bilik kosong?'
    });
    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 18,
      'phrase': 'I would like ___ rooms.',
      'translation': 'Teman nak ___ bilik.'
    });
    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 18,
      'phrase': 'We are ___ people.',
      'translation': 'Kami ___ orang.'
    });
    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 18,
      'phrase': 'How much does the room cost?',
      'translation': 'Berapo harga bilik?'
    });
    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 18,
      'phrase': 'Is it air conditioned?',
      'translation': 'Ado aircon ke?'
    });
    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 18,
      'phrase': 'Is there room service?',
      'translation': 'Ado servis bilik?'
    });
    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 18,
      'phrase': 'Is breakfast included?',
      'translation': 'Sarapan termasuk ke?'
    });
    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 18,
      'phrase': 'Is lunch included?',
      'translation': 'Makan tengahari termasuk ke?'
    });
    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 18,
      'phrase': 'Is dinner included?',
      'translation': 'Makan malam termasuk ke?'
    });
    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 18,
      'phrase': 'Is there a restaurant?',
      'translation': 'Ado restoran?'
    });
    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 18,
      'phrase': 'When is check out?',
      'translation': 'Bila nak check out?'
    });

    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 19,
      'phrase': 'May I see the menu?',
      'translation': 'Boleh teman tengok menu?'
    });
    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 19,
      'phrase': 'I would like to order __.',
      'translation': 'Teman nak order __.'
    });
    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 19,
      'phrase': 'I would like breakfast.',
      'translation': 'Teman nak sarapan.'
    });
    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 19,
      'phrase': 'I would like lunch.',
      'translation': 'Teman nak makan tengahari.'
    });
    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 19,
      'phrase': 'I would like dinner.',
      'translation': 'Teman nak makan malam.'
    });
    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 19,
      'phrase': 'I\'m a vegetarian.',
      'translation': 'Teman vegetarian.'
    });
    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 19,
      'phrase': 'I\'m vegan.',
      'translation': 'Teman vegan.'
    });
    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 19,
      'phrase': 'I don\'t eat pork.',
      'translation': 'Teman tak makan daging babi.'
    });
    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 19,
      'phrase': 'I don\'t eat beef.',
      'translation': 'Teman tak makan daging lembu.'
    });
    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 19,
      'phrase': 'I don\'t eat __.',
      'translation': 'Teman tak makan __.'
    });
    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 19,
      'phrase': 'The bill please.',
      'translation': 'Bil, tolong.'
    });

    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 20,
      'phrase': 'I would like some __.',
      'translation': 'Teman nak __ sikit.'
    });
    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 20,
      'phrase': 'I would like some bottled water.',
      'translation': 'Teman nak air botol.'
    });
    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 20,
      'phrase': 'I would like some carbonated water.',
      'translation': 'Teman nak air berkarbonat.'
    });
    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 20,
      'phrase': 'No ice.',
      'translation': 'Takdo ais.'
    });
    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 20,
      'phrase': 'With ice.',
      'translation': 'Dengan ais.'
    });

    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 21,
      'phrase': 'I would like some __.',
      'translation': 'Teman nak __ sikit.'
    });
    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 21,
      'phrase': 'I would like some bottled water.',
      'translation': 'Teman nak air botol.'
    });
    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 21,
      'phrase': 'I would like some carbonated water.',
      'translation': 'Teman nak air berkarbonat.'
    });
    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 21,
      'phrase': 'No ice.',
      'translation': 'Takdo ais.'
    });
    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 21,
      'phrase': 'With ice.',
      'translation': 'Dengan ais.'
    });

    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 22,
      'phrase': 'Where is the milk?',
      'translation': 'Mana susu?'
    });
    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 22,
      'phrase': 'Where are the eggs?',
      'translation': 'Mana telur?'
    });
    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 22,
      'phrase': 'Where is the ice cream?',
      'translation': 'Mana aiskrim?'
    });
    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 22,
      'phrase': 'Where is the bottled water?',
      'translation': 'Mana air botol?'
    });
    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 22,
      'phrase': 'Where are the soft drinks?',
      'translation': 'Mana minuman ringan?'
    });
    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 22,
      'phrase': 'Where are the fruits?',
      'translation': 'Mana buah-buahan?'
    });
    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 22,
      'phrase': 'Where are the vegetables?',
      'translation': 'Mana sayur-sayuran?'
    });
    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 22,
      'phrase': 'Where is the meat?',
      'translation': 'Mana daging?'
    });
    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 22,
      'phrase': 'Where is the bread?',
      'translation': 'Mana roti?'
    });
    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 22,
      'phrase': 'Where is the beer?',
      'translation': 'Mana bir?'
    });
    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 22,
      'phrase': 'Where is the wine?',
      'translation': 'Mana wain?'
    });

    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 23,
      'phrase': 'I need a phone charger.',
      'translation': 'Teman perlu pengecas telefon.'
    });
    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 23,
      'phrase': 'I need to check my email.',
      'translation': 'Teman perlu cek email.'
    });
    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 23,
      'phrase': 'Can you change it to English?',
      'translation': 'Boleh tukar ke bahasa Inggeris?'
    });
    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 23,
      'phrase': 'I need a printer.',
      'translation': 'Teman perlu printer.'
    });
    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 23,
      'phrase': 'I need a __.',
      'translation': 'Teman perlu __.'
    });

    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 24,
      'phrase': 'Is there Wi-Fi?',
      'translation': 'Ado Wi-Fi?'
    });
    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 24,
      'phrase': 'What is the password?',
      'translation': 'Apo password?'
    });
    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 24,
      'phrase': 'The Wi-fi isn\'t working.',
      'translation': 'Wi-Fi tak berfungsi.'
    });

    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 25,
      'phrase': 'What is your email?',
      'translation': 'Apo email mike?'
    });
    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 25,
      'phrase': 'I need to check my emails.',
      'translation': 'Teman perlu cek email.'
    });
    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 25,
      'phrase': 'Can you email it to me?',
      'translation': 'Boleh email ke teman?'
    });

    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 26,
      'phrase': 'Can you send it to me?',
      'translation': 'Boleh hantar ke teman?'
    });
    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 26,
      'phrase': 'Can you message it to me?',
      'translation': 'Boleh mesej ke teman?'
    });
    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 26,
      'phrase': 'Can you Whatsapp it to me?',
      'translation': 'Boleh Whatsapp ke teman?'
    });

    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 27,
      'phrase': 'I lost my phone.',
      'translation': 'Teman hilang telefon.'
    });
    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 27,
      'phrase': 'I lost my laptop.',
      'translation': 'Teman hilang laptop.'
    });
    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 27,
      'phrase': 'I lost my __.',
      'translation': 'Teman hilang __.'
    });

    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 28,
      'phrase': 'Monday',
      'translation': 'Isnin'
    });
    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 28,
      'phrase': 'Tuesday',
      'translation': 'Selasa'
    });
    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 28,
      'phrase': 'Wednesday',
      'translation': 'Rabu'
    });
    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 28,
      'phrase': 'Thursday',
      'translation': 'Khamis'
    });
    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 28,
      'phrase': 'Friday',
      'translation': 'Jumaat'
    });
    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 28,
      'phrase': 'Saturday',
      'translation': 'Sabtu'
    });
    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 28,
      'phrase': 'Sunday',
      'translation': 'Ahad'
    });

    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 29,
      'phrase': 'Morning',
      'translation': 'Pagi'
    });
    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 29,
      'phrase': 'Noon',
      'translation': 'Tengahari'
    });
    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 29,
      'phrase': 'Afternoon',
      'translation': 'Petang'
    });
    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 29,
      'phrase': 'Evening',
      'translation': 'Malam'
    });
    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 29,
      'phrase': 'Night',
      'translation': 'Malam'
    });
    await db.insert('phrases', {
      'languageId': 8,
      'categoryId': 29,
      'phrase': 'Midnight',
      'translation': 'Tengah malam'
    });

    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 1,
      'phrase': 'Hello',
      'translation': 'Halo'
    });
    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 1,
      'phrase': 'My name is',
      'translation': 'Nama aku'
    });
    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 1,
      'phrase': 'Excuse me',
      'translation': 'Tumpang lalu'
    });
    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 1,
      'phrase': 'Goodbye',
      'translation': 'Selamat tinggal'
    });
    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 1,
      'phrase': 'How are you?',
      'translation': 'Apa khabaq?'
    });
    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 1,
      'phrase': 'Nice to meet you!',
      'translation': 'Seronok jumpa hang!'
    });

    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 2,
      'phrase': 'Please',
      'translation': 'Tolong'
    });
    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 2,
      'phrase': 'I\'m sorry.',
      'translation': 'Aku minta maaf.'
    });
    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 2,
      'phrase': 'Thank you.',
      'translation': 'Terima kasih.'
    });

    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 3,
      'phrase': 'Left',
      'translation': 'Kiri'
    });
    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 3,
      'phrase': 'Right',
      'translation': 'Kanan'
    });
    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 3,
      'phrase': 'Straight ahead',
      'translation': 'Teruih ja'
    });
    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 3,
      'phrase': 'In ___ meters.',
      'translation': 'Dalam ___ meter.'
    });
    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 3,
      'phrase': 'Traffic light',
      'translation': 'Lampu isyarat'
    });
    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 3,
      'phrase': 'Stop sign',
      'translation': 'Tanda berhenti'
    });
    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 3,
      'phrase': 'North',
      'translation': 'Utara'
    });
    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 3,
      'phrase': 'South',
      'translation': 'Selatan'
    });
    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 3,
      'phrase': 'East',
      'translation': 'Timur'
    });
    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 3,
      'phrase': 'West',
      'translation': 'Barat'
    });

    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 4,
      'phrase': 'Where is the ATM?',
      'translation': 'Mana ATM?'
    });
    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 4,
      'phrase': 'I want to exchange money.',
      'translation': 'Aku nak tukar duit.'
    });
    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 4,
      'phrase': 'What is the exchange fee?',
      'translation': 'Berapah yuran tukar?'
    });
    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 4,
      'phrase': 'How much does it cost?',
      'translation': 'Berapah harganya?'
    });

    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 5,
      'phrase': 'Where is the toilet?',
      'translation': 'Mana jamban?'
    });
    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 5,
      'phrase': 'Where is the grocery store?',
      'translation': 'Mana kedai runcit?'
    });
    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 5,
      'phrase': 'This is an emergency!',
      'translation': 'Ini kecemasan!'
    });
    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 5,
      'phrase': 'I need help.',
      'translation': 'Aku perlu bantuan.'
    });

    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 6,
      'phrase': 'Do you speak ___?',
      'translation': 'Hang cakap ___?'
    });
    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 6,
      'phrase': 'I don\'t speak ___.',
      'translation': 'Aku tak cakap ___.'
    });
    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 6,
      'phrase': 'I don\'t understand.',
      'translation': 'Aku tak faham.'
    });
    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 6,
      'phrase': 'I speak ___.',
      'translation': 'Aku cakap ___.'
    });

    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 7,
      'phrase': 'Left',
      'translation': 'Kiri'
    });
    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 7,
      'phrase': 'Right',
      'translation': 'Kanan'
    });
    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 7,
      'phrase': 'Straight ahead',
      'translation': 'Teruih ja'
    });
    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 7,
      'phrase': 'In ___ meters.',
      'translation': 'Dalam ___ meter.'
    });
    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 7,
      'phrase': 'Traffic light',
      'translation': 'Lampu isyarat'
    });
    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 7,
      'phrase': 'Stop sign',
      'translation': 'Tanda berhenti'
    });
    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 7,
      'phrase': 'North',
      'translation': 'Utara'
    });
    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 7,
      'phrase': 'South',
      'translation': 'Selatan'
    });
    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 7,
      'phrase': 'East',
      'translation': 'Timur'
    });
    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 7,
      'phrase': 'West',
      'translation': 'Barat'
    });

    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 8,
      'phrase': 'Where is the ATM?',
      'translation': 'Mana ATM?'
    });
    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 8,
      'phrase': 'I want to exchange money.',
      'translation': 'Aku nak tukar duit.'
    });
    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 8,
      'phrase': 'What is the exchange fee?',
      'translation': 'Berapah yuran tukar?'
    });
    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 8,
      'phrase': 'How much does it cost?',
      'translation': 'Berapah harganya?'
    });

    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 9,
      'phrase': 'Where is the toilet?',
      'translation': 'Mana jamban?'
    });
    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 9,
      'phrase': 'Where is the grocery store?',
      'translation': 'Mana kedai runcit?'
    });
    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 9,
      'phrase': 'This is an emergency!',
      'translation': 'Ini kecemasan!'
    });
    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 9,
      'phrase': 'I need help.',
      'translation': 'Aku perlu bantuan.'
    });

    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 10,
      'phrase': 'Do you speak ___?',
      'translation': 'Hang cakap ___?'
    });
    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 10,
      'phrase': 'I don\'t speak ___.',
      'translation': 'Aku tak cakap ___.'
    });
    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 10,
      'phrase': 'I don\'t understand.',
      'translation': 'Aku tak faham.'
    });
    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 10,
      'phrase': 'I speak ___.',
      'translation': 'Aku cakap ___.'
    });

    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 11,
      'phrase': 'Hello',
      'translation': 'Halo'
    });
    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 11,
      'phrase': 'My name is __.',
      'translation': 'Nama aku __.'
    });
    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 11,
      'phrase': 'Excuse me',
      'translation': 'Tumpang lalu'
    });
    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 11,
      'phrase': 'Goodbye',
      'translation': 'Selamat tinggal'
    });
    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 11,
      'phrase': 'How are you?',
      'translation': 'Apa habaq?'
    });
    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 11,
      'phrase': 'Nice to meet you!',
      'translation': 'Seronok jumpa hang!'
    });

    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 12,
      'phrase': 'Where is the airport?',
      'translation': 'Mana lapangan terbang?'
    });
    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 12,
      'phrase': 'Where is the train station?',
      'translation': 'Mana stesen kereta api?'
    });
    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 12,
      'phrase': 'Where is the subway?',
      'translation': 'Mana kereta api bawah tanah?'
    });
    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 12,
      'phrase': 'Where is the bus station?',
      'translation': 'Mana stesen bas?'
    });
    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 12,
      'phrase': 'Where is the ___ museum?',
      'translation': 'Mana muzium ___?'
    });
    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 12,
      'phrase': 'Where is a good restaurant?',
      'translation': 'Mana restoran bagus?'
    });
    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 12,
      'phrase': 'Where is a nice coffee place?',
      'translation': 'Mana kedai kopi bagus?'
    });
    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 12,
      'phrase': 'Where is a nice bar?',
      'translation': 'Mana bar bagus?'
    });

    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 13,
      'phrase': 'Where can I buy a ticket?',
      'translation': 'Mana boleh beli tiket?'
    });
    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 13,
      'phrase': 'How much is a ticket?',
      'translation': 'Berapah harga tiket?'
    });
    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 13,
      'phrase': 'I need ___ tickets, please.',
      'translation': 'Aku nak ___ tiket, tolong.'
    });
    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 13,
      'phrase': 'I would like to change my ticket.',
      'translation': 'Aku nak tukar tiket aku.'
    });

    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 14,
      'phrase': 'Which platform?',
      'translation': 'Platform mana?'
    });
    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 14,
      'phrase': 'Where is the platform?',
      'translation': 'Mana platform?'
    });
    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 14,
      'phrase': 'Where should I get off?',
      'translation': 'Mana aku patut turun?'
    });
    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 14,
      'phrase': 'I\'d like to get off at ___.',
      'translation': 'Aku nak turun di ___.'
    });
    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 14,
      'phrase': 'Where do I change trains?',
      'translation': 'Mana tukar kereta api?'
    });
    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 14,
      'phrase': 'Where do I change buses?',
      'translation': 'Mana tukar bas?'
    });

    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 15,
      'phrase': 'Here is my passport.',
      'translation': 'Ini pasport aku.'
    });
    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 15,
      'phrase': 'Do I need a visa?',
      'translation': 'Perlu visa ka?'
    });
    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 15,
      'phrase': 'I am an immigrant.',
      'translation': 'Aku orang pendatang.'
    });
    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 15,
      'phrase': 'I am a refugee.',
      'translation': 'Aku orang pelarian.'
    });
    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 15,
      'phrase': 'I have nothing to declare.',
      'translation': 'Aku tak ada apa nak diisytiharkan.'
    });
    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 15,
      'phrase': 'I have something to declare.',
      'translation': 'Aku ada barang nak diisytiharkan.'
    });

    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 16,
      'phrase': 'I have allergies.',
      'translation': 'Aku ada alahan.'
    });
    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 16,
      'phrase': 'I am allergic to ___.',
      'translation': 'Aku alah kat ___.'
    });
    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 16,
      'phrase': 'I am allergic to penicillin.',
      'translation': 'Aku alah penicillin.'
    });
    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 16,
      'phrase': 'I am allergic to antibiotics.',
      'translation': 'Aku alah antibiotik.'
    });
    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 16,
      'phrase': 'I have Asthma.',
      'translation': 'Aku ada asma.'
    });

    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 17,
      'phrase': 'I would like to check in.',
      'translation': 'Aku nak check in.'
    });
    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 17,
      'phrase': 'I would like to change my reservation.',
      'translation': 'Aku nak tukar tempahan aku.'
    });
    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 17,
      'phrase': 'Can we have a room with ___ view?',
      'translation': 'Boleh ke bilik aku ada view ___?'
    });
    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 17,
      'phrase': 'When does breakfast start?',
      'translation': 'Bila sarapan start?'
    });
    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 17,
      'phrase': 'When does lunch start?',
      'translation': 'Bila makan tengahari start?'
    });
    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 17,
      'phrase': 'When does dinner start?',
      'translation': 'Bila makan malam start?'
    });
    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 17,
      'phrase': 'When is check out?',
      'translation': 'Bila nak check out?'
    });
    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 17,
      'phrase': 'My room needs to be cleaned.',
      'translation': 'Bilik aku perlu dibersihkan.'
    });

    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 18,
      'phrase': 'Do you have free rooms?',
      'translation': 'Ada bilik kosong?'
    });
    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 18,
      'phrase': 'I would like ___ rooms.',
      'translation': 'Aku nak ___ bilik.'
    });
    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 18,
      'phrase': 'We are ___ people.',
      'translation': 'Kami ___ orang.'
    });
    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 18,
      'phrase': 'How much does the room cost?',
      'translation': 'Berapah harga bilik?'
    });
    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 18,
      'phrase': 'Is it air conditioned?',
      'translation': 'Ada aircon ka?'
    });
    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 18,
      'phrase': 'Is there room service?',
      'translation': 'Ada servis bilik?'
    });
    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 18,
      'phrase': 'Is breakfast included?',
      'translation': 'Sarapan termasuk ka?'
    });
    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 18,
      'phrase': 'Is lunch included?',
      'translation': 'Makan tengahari termasuk ka?'
    });
    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 18,
      'phrase': 'Is dinner included?',
      'translation': 'Makan malam termasuk ka?'
    });
    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 18,
      'phrase': 'Is there a restaurant?',
      'translation': 'Ada restoran?'
    });
    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 18,
      'phrase': 'When is check out?',
      'translation': 'Bila nak check out?'
    });

    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 19,
      'phrase': 'May I see the menu?',
      'translation': 'Boleh aku tengok menu?'
    });
    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 19,
      'phrase': 'I would like to order __.',
      'translation': 'Aku nak order __.'
    });
    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 19,
      'phrase': 'I would like breakfast.',
      'translation': 'Aku nak sarapan.'
    });
    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 19,
      'phrase': 'I would like lunch.',
      'translation': 'Aku nak makan tengahari.'
    });
    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 19,
      'phrase': 'I would like dinner.',
      'translation': 'Aku nak makan malam.'
    });
    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 19,
      'phrase': 'I\'m a vegetarian.',
      'translation': 'Aku vegetarian.'
    });
    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 19,
      'phrase': 'I\'m vegan.',
      'translation': 'Aku vegan.'
    });
    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 19,
      'phrase': 'I don\'t eat pork.',
      'translation': 'Aku tak makan daging babi.'
    });
    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 19,
      'phrase': 'I don\'t eat beef.',
      'translation': 'Aku tak makan daging lembu.'
    });
    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 19,
      'phrase': 'I don\'t eat __.',
      'translation': 'Aku tak makan __.'
    });
    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 19,
      'phrase': 'The bill please.',
      'translation': 'Bil, tolong.'
    });

    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 20,
      'phrase': 'I would like some __.',
      'translation': 'Aku nak __ sikit.'
    });
    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 20,
      'phrase': 'I would like some bottled water.',
      'translation': 'Aku nak air botol.'
    });
    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 20,
      'phrase': 'I would like some carbonated water.',
      'translation': 'Aku nak air berkarbonat.'
    });
    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 20,
      'phrase': 'No ice.',
      'translation': 'Takdak ais.'
    });
    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 20,
      'phrase': 'With ice.',
      'translation': 'Dengan ais.'
    });

    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 21,
      'phrase': 'I would like some __.',
      'translation': 'Aku nak __ sikit.'
    });
    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 21,
      'phrase': 'I would like some bottled water.',
      'translation': 'Aku nak air botol.'
    });
    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 21,
      'phrase': 'I would like some carbonated water.',
      'translation': 'Aku nak air berkarbonat.'
    });
    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 21,
      'phrase': 'No ice.',
      'translation': 'Takdak ais.'
    });
    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 21,
      'phrase': 'With ice.',
      'translation': 'Dengan ais.'
    });

    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 22,
      'phrase': 'Where is the milk?',
      'translation': 'Mana susu?'
    });
    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 22,
      'phrase': 'Where are the eggs?',
      'translation': 'Mana telur?'
    });
    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 22,
      'phrase': 'Where is the ice cream?',
      'translation': 'Mana aiskrim?'
    });
    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 22,
      'phrase': 'Where is the bottled water?',
      'translation': 'Mana air botol?'
    });
    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 22,
      'phrase': 'Where are the soft drinks?',
      'translation': 'Mana minuman ringan?'
    });
    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 22,
      'phrase': 'Where are the fruits?',
      'translation': 'Mana buah-buahan?'
    });
    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 22,
      'phrase': 'Where are the vegetables?',
      'translation': 'Mana sayur-sayuran?'
    });
    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 22,
      'phrase': 'Where is the meat?',
      'translation': 'Mana daging?'
    });
    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 22,
      'phrase': 'Where is the bread?',
      'translation': 'Mana roti?'
    });
    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 22,
      'phrase': 'Where is the beer?',
      'translation': 'Mana bir?'
    });
    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 22,
      'phrase': 'Where is the wine?',
      'translation': 'Mana wain?'
    });

    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 23,
      'phrase': 'I need a phone charger.',
      'translation': 'Aku perlu pengecas telefon.'
    });
    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 23,
      'phrase': 'I need to check my email.',
      'translation': 'Aku perlu cek email.'
    });
    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 23,
      'phrase': 'Can you change it to English?',
      'translation': 'Boleh tukar ke bahasa Inggeris?'
    });
    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 23,
      'phrase': 'I need a printer.',
      'translation': 'Aku perlu printer.'
    });
    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 23,
      'phrase': 'I need a __.',
      'translation': 'Aku perlu __.'
    });

    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 24,
      'phrase': 'Is there Wi-Fi?',
      'translation': 'Ada Wi-Fi?'
    });
    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 24,
      'phrase': 'What is the password?',
      'translation': 'Apa password?'
    });
    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 24,
      'phrase': 'The Wi-fi isn\'t working.',
      'translation': 'Wi-Fi tak berfungsi.'
    });

    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 25,
      'phrase': 'What is your email?',
      'translation': 'Apa email hang?'
    });
    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 25,
      'phrase': 'I need to check my emails.',
      'translation': 'Aku perlu cek email.'
    });
    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 25,
      'phrase': 'Can you email it to me?',
      'translation': 'Boleh email ke aku?'
    });

    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 26,
      'phrase': 'Can you send it to me?',
      'translation': 'Boleh hantar ke aku?'
    });
    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 26,
      'phrase': 'Can you message it to me?',
      'translation': 'Boleh mesej ke aku?'
    });
    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 26,
      'phrase': 'Can you Whatsapp it to me?',
      'translation': 'Boleh Whatsapp ke aku?'
    });

    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 27,
      'phrase': 'I lost my phone.',
      'translation': 'Aku hilang telefon.'
    });
    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 27,
      'phrase': 'I lost my laptop.',
      'translation': 'Aku hilang laptop.'
    });
    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 27,
      'phrase': 'I lost my __.',
      'translation': 'Aku hilang __.'
    });

    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 28,
      'phrase': 'Monday',
      'translation': 'Isnin'
    });
    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 28,
      'phrase': 'Tuesday',
      'translation': 'Selasa'
    });
    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 28,
      'phrase': 'Wednesday',
      'translation': 'Rabu'
    });
    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 28,
      'phrase': 'Thursday',
      'translation': 'Khamis'
    });
    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 28,
      'phrase': 'Friday',
      'translation': 'Jumaat'
    });
    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 28,
      'phrase': 'Saturday',
      'translation': 'Sabtu'
    });
    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 28,
      'phrase': 'Sunday',
      'translation': 'Ahad'
    });

    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 29,
      'phrase': 'Morning',
      'translation': 'Pagi'
    });
    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 29,
      'phrase': 'Noon',
      'translation': 'Tengahari'
    });
    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 29,
      'phrase': 'Afternoon',
      'translation': 'Petang'
    });
    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 29,
      'phrase': 'Evening',
      'translation': 'Malam'
    });
    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 29,
      'phrase': 'Night',
      'translation': 'Malam'
    });
    await db.insert('phrases', {
      'languageId': 9,
      'categoryId': 29,
      'phrase': 'Midnight',
      'translation': 'Tengah malam'
    });

    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 1,
      'phrase': 'Hello',
      'translation': 'Halo'
    });
    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 1,
      'phrase': 'My name is',
      'translation': 'Nama sia'
    });
    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 1,
      'phrase': 'Excuse me',
      'translation': 'Tumpang lalu'
    });
    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 1,
      'phrase': 'Goodbye',
      'translation': 'Selamat tinggal'
    });
    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 1,
      'phrase': 'How are you?',
      'translation': 'Apa khabar?'
    });
    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 1,
      'phrase': 'Nice to meet you!',
      'translation': 'Gembira jumpa ko!'
    });

    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 2,
      'phrase': 'Please',
      'translation': 'Tolong'
    });
    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 2,
      'phrase': 'I\'m sorry.',
      'translation': 'Sia minta maaf.'
    });
    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 2,
      'phrase': 'Thank you.',
      'translation': 'Terima kasih.'
    });

    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 3,
      'phrase': 'Left',
      'translation': 'Kiri'
    });
    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 3,
      'phrase': 'Right',
      'translation': 'Kanan'
    });
    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 3,
      'phrase': 'Straight ahead',
      'translation': 'Terus saja'
    });
    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 3,
      'phrase': 'In ___ meters.',
      'translation': 'Dalam ___ meter.'
    });
    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 3,
      'phrase': 'Traffic light',
      'translation': 'Lampu isyarat'
    });
    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 3,
      'phrase': 'Stop sign',
      'translation': 'Tanda berhenti'
    });
    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 3,
      'phrase': 'North',
      'translation': 'Utara'
    });
    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 3,
      'phrase': 'South',
      'translation': 'Selatan'
    });
    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 3,
      'phrase': 'East',
      'translation': 'Timur'
    });
    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 3,
      'phrase': 'West',
      'translation': 'Barat'
    });

    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 4,
      'phrase': 'Where is the ATM?',
      'translation': 'Mana ATM?'
    });
    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 4,
      'phrase': 'I want to exchange money.',
      'translation': 'Sia mau tukar duit.'
    });
    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 4,
      'phrase': 'What is the exchange fee?',
      'translation': 'Berapa yuran tukar?'
    });
    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 4,
      'phrase': 'How much does it cost?',
      'translation': 'Berapa harganya?'
    });

    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 5,
      'phrase': 'Where is the toilet?',
      'translation': 'Mana tandas?'
    });
    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 5,
      'phrase': 'Where is the grocery store?',
      'translation': 'Mana kedai runcit?'
    });
    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 5,
      'phrase': 'This is an emergency!',
      'translation': 'Ini kecemasan!'
    });
    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 5,
      'phrase': 'I need help.',
      'translation': 'Sia perlu bantuan.'
    });

    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 6,
      'phrase': 'Do you speak ___?',
      'translation': 'Ko cakap ___?'
    });
    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 6,
      'phrase': 'I don\'t speak ___.',
      'translation': 'Sia tidak cakap ___.'
    });
    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 6,
      'phrase': 'I don\'t understand.',
      'translation': 'Sia tidak faham.'
    });
    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 6,
      'phrase': 'I speak ___.',
      'translation': 'Sia cakap ___.'
    });

    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 7,
      'phrase': 'Left',
      'translation': 'Kiri'
    });
    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 7,
      'phrase': 'Right',
      'translation': 'Kanan'
    });
    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 7,
      'phrase': 'Straight ahead',
      'translation': 'Terus saja'
    });
    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 7,
      'phrase': 'In ___ meters.',
      'translation': 'Dalam ___ meter.'
    });
    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 7,
      'phrase': 'Traffic light',
      'translation': 'Lampu isyarat'
    });
    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 7,
      'phrase': 'Stop sign',
      'translation': 'Tanda berhenti'
    });
    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 7,
      'phrase': 'North',
      'translation': 'Utara'
    });
    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 7,
      'phrase': 'South',
      'translation': 'Selatan'
    });
    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 7,
      'phrase': 'East',
      'translation': 'Timur'
    });
    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 7,
      'phrase': 'West',
      'translation': 'Barat'
    });

    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 8,
      'phrase': 'Where is the ATM?',
      'translation': 'Mana ATM?'
    });
    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 8,
      'phrase': 'I want to exchange money.',
      'translation': 'Sia mau tukar duit.'
    });
    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 8,
      'phrase': 'What is the exchange fee?',
      'translation': 'Berapa yuran tukar?'
    });
    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 8,
      'phrase': 'How much does it cost?',
      'translation': 'Berapa harganya?'
    });

    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 9,
      'phrase': 'Where is the toilet?',
      'translation': 'Mana tandas?'
    });
    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 9,
      'phrase': 'Where is the grocery store?',
      'translation': 'Mana kedai runcit?'
    });
    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 9,
      'phrase': 'This is an emergency!',
      'translation': 'Ini kecemasan!'
    });
    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 9,
      'phrase': 'I need help.',
      'translation': 'Sia perlu bantuan.'
    });

    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 10,
      'phrase': 'Do you speak ___?',
      'translation': 'Ko cakap ___?'
    });
    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 10,
      'phrase': 'I don\'t speak ___.',
      'translation': 'Sia tidak cakap ___.'
    });
    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 10,
      'phrase': 'I don\'t understand.',
      'translation': 'Sia tidak faham.'
    });
    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 10,
      'phrase': 'I speak ___.',
      'translation': 'Sia cakap ___.'
    });

    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 11,
      'phrase': 'Hello',
      'translation': 'Halo'
    });
    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 11,
      'phrase': 'My name is __.',
      'translation': 'Nama sia __.'
    });
    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 11,
      'phrase': 'Excuse me',
      'translation': 'Tumpang lalu'
    });
    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 11,
      'phrase': 'Goodbye',
      'translation': 'Selamat tinggal'
    });
    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 11,
      'phrase': 'How are you?',
      'translation': 'Apa khabar?'
    });
    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 11,
      'phrase': 'Nice to meet you!',
      'translation': 'Gembira jumpa ko!'
    });

    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 12,
      'phrase': 'Where is the airport?',
      'translation': 'Mana lapangan terbang?'
    });
    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 12,
      'phrase': 'Where is the train station?',
      'translation': 'Mana stesen kereta api?'
    });
    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 12,
      'phrase': 'Where is the subway?',
      'translation': 'Mana kereta api bawah tanah?'
    });
    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 12,
      'phrase': 'Where is the bus station?',
      'translation': 'Mana stesen bas?'
    });
    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 12,
      'phrase': 'Where is the ___ museum?',
      'translation': 'Mana muzium ___?'
    });
    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 12,
      'phrase': 'Where is a good restaurant?',
      'translation': 'Mana restoran bagus?'
    });
    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 12,
      'phrase': 'Where is a nice coffee place?',
      'translation': 'Mana kedai kopi bagus?'
    });
    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 12,
      'phrase': 'Where is a nice bar?',
      'translation': 'Mana bar bagus?'
    });

    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 13,
      'phrase': 'Where can I buy a ticket?',
      'translation': 'Mana boleh beli tiket?'
    });
    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 13,
      'phrase': 'How much is a ticket?',
      'translation': 'Berapa harga tiket?'
    });
    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 13,
      'phrase': 'I need ___ tickets, please.',
      'translation': 'Sia mau ___ tiket, tolong.'
    });
    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 13,
      'phrase': 'I would like to change my ticket.',
      'translation': 'Sia mau tukar tiket sia.'
    });

    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 14,
      'phrase': 'Which platform?',
      'translation': 'Platform mana?'
    });
    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 14,
      'phrase': 'Where is the platform?',
      'translation': 'Mana platform?'
    });
    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 14,
      'phrase': 'Where should I get off?',
      'translation': 'Mana sia patut turun?'
    });
    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 14,
      'phrase': 'I\'d like to get off at ___.',
      'translation': 'Sia mau turun di ___.'
    });
    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 14,
      'phrase': 'Where do I change trains?',
      'translation': 'Mana tukar kereta api?'
    });
    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 14,
      'phrase': 'Where do I change buses?',
      'translation': 'Mana tukar bas?'
    });

    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 15,
      'phrase': 'Here is my passport.',
      'translation': 'Ini pasport sia.'
    });
    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 15,
      'phrase': 'Do I need a visa?',
      'translation': 'Perlu visa ka?'
    });
    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 15,
      'phrase': 'I am an immigrant.',
      'translation': 'Sia orang pendatang.'
    });
    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 15,
      'phrase': 'I am a refugee.',
      'translation': 'Sia orang pelarian.'
    });
    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 15,
      'phrase': 'I have nothing to declare.',
      'translation': 'Sia tidak ada apa nak diisytiharkan.'
    });
    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 15,
      'phrase': 'I have something to declare.',
      'translation': 'Sia ada barang nak diisytiharkan.'
    });

    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 16,
      'phrase': 'I have allergies.',
      'translation': 'Sia ada alahan.'
    });
    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 16,
      'phrase': 'I am allergic to ___.',
      'translation': 'Sia alah kepada ___.'
    });
    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 16,
      'phrase': 'I am allergic to penicillin.',
      'translation': 'Sia alah kepada penicillin.'
    });
    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 16,
      'phrase': 'I am allergic to antibiotics.',
      'translation': 'Sia alah kepada antibiotik.'
    });
    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 16,
      'phrase': 'I have Asthma.',
      'translation': 'Sia ada asma.'
    });

    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 17,
      'phrase': 'I would like to check in.',
      'translation': 'Sia mau check in.'
    });
    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 17,
      'phrase': 'I would like to change my reservation.',
      'translation': 'Sia mau tukar tempahan sia.'
    });
    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 17,
      'phrase': 'Can we have a room with ___ view?',
      'translation': 'Boleh ka bilik sia ada view ___?'
    });
    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 17,
      'phrase': 'When does breakfast start?',
      'translation': 'Bila sarapan start?'
    });
    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 17,
      'phrase': 'When does lunch start?',
      'translation': 'Bila makan tengahari start?'
    });
    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 17,
      'phrase': 'When does dinner start?',
      'translation': 'Bila makan malam start?'
    });
    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 17,
      'phrase': 'When is check out?',
      'translation': 'Bila mau check out?'
    });
    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 17,
      'phrase': 'My room needs to be cleaned.',
      'translation': 'Bilik sia perlu dibersihkan.'
    });

    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 18,
      'phrase': 'Do you have free rooms?',
      'translation': 'Ada bilik kosong?'
    });
    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 18,
      'phrase': 'I would like ___ rooms.',
      'translation': 'Sia mau ___ bilik.'
    });
    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 18,
      'phrase': 'We are ___ people.',
      'translation': 'Kami ___ orang.'
    });
    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 18,
      'phrase': 'How much does the room cost?',
      'translation': 'Berapa harga bilik?'
    });
    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 18,
      'phrase': 'Is it air conditioned?',
      'translation': 'Ada aircon ka?'
    });
    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 18,
      'phrase': 'Is there room service?',
      'translation': 'Ada servis bilik?'
    });
    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 18,
      'phrase': 'Is breakfast included?',
      'translation': 'Sarapan termasuk ka?'
    });
    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 18,
      'phrase': 'Is lunch included?',
      'translation': 'Makan tengahari termasuk ka?'
    });
    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 18,
      'phrase': 'Is dinner included?',
      'translation': 'Makan malam termasuk ka?'
    });
    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 18,
      'phrase': 'Is there a restaurant?',
      'translation': 'Ada restoran?'
    });
    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 18,
      'phrase': 'When is check out?',
      'translation': 'Bila mau check out?'
    });

    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 19,
      'phrase': 'May I see the menu?',
      'translation': 'Boleh sia tengok menu?'
    });
    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 19,
      'phrase': 'I would like to order __.',
      'translation': 'Sia mau order __.'
    });
    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 19,
      'phrase': 'I would like breakfast.',
      'translation': 'Sia mau sarapan.'
    });
    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 19,
      'phrase': 'I would like lunch.',
      'translation': 'Sia mau makan tengahari.'
    });
    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 19,
      'phrase': 'I would like dinner.',
      'translation': 'Sia mau makan malam.'
    });
    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 19,
      'phrase': 'I\'m a vegetarian.',
      'translation': 'Sia vegetarian.'
    });
    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 19,
      'phrase': 'I\'m vegan.',
      'translation': 'Sia vegan.'
    });
    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 19,
      'phrase': 'I don\'t eat pork.',
      'translation': 'Sia tidak makan daging babi.'
    });
    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 19,
      'phrase': 'I don\'t eat beef.',
      'translation': 'Sia tidak makan daging lembu.'
    });
    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 19,
      'phrase': 'I don\'t eat __.',
      'translation': 'Sia tidak makan __.'
    });
    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 19,
      'phrase': 'The bill please.',
      'translation': 'Bil, tolong.'
    });

    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 20,
      'phrase': 'I would like some __.',
      'translation': 'Sia mau __ sikit.'
    });
    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 20,
      'phrase': 'I would like some bottled water.',
      'translation': 'Sia mau air botol.'
    });
    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 20,
      'phrase': 'I would like some carbonated water.',
      'translation': 'Sia mau air berkarbonat.'
    });
    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 20,
      'phrase': 'No ice.',
      'translation': 'Tiada ais.'
    });
    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 20,
      'phrase': 'With ice.',
      'translation': 'Dengan ais.'
    });

    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 21,
      'phrase': 'I would like some __.',
      'translation': 'Sia mau __ sikit.'
    });
    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 21,
      'phrase': 'I would like some bottled water.',
      'translation': 'Sia mau air botol.'
    });
    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 21,
      'phrase': 'I would like some carbonated water.',
      'translation': 'Sia mau air berkarbonat.'
    });
    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 21,
      'phrase': 'No ice.',
      'translation': 'Tiada ais.'
    });
    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 21,
      'phrase': 'With ice.',
      'translation': 'Dengan ais.'
    });

    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 22,
      'phrase': 'Where is the milk?',
      'translation': 'Mana susu?'
    });
    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 22,
      'phrase': 'Where are the eggs?',
      'translation': 'Mana telur?'
    });
    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 22,
      'phrase': 'Where is the ice cream?',
      'translation': 'Mana aiskrim?'
    });
    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 22,
      'phrase': 'Where is the bottled water?',
      'translation': 'Mana air botol?'
    });
    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 22,
      'phrase': 'Where are the soft drinks?',
      'translation': 'Mana minuman ringan?'
    });
    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 22,
      'phrase': 'Where are the fruits?',
      'translation': 'Mana buah-buahan?'
    });
    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 22,
      'phrase': 'Where are the vegetables?',
      'translation': 'Mana sayur-sayuran?'
    });
    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 22,
      'phrase': 'Where is the meat?',
      'translation': 'Mana daging?'
    });
    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 22,
      'phrase': 'Where is the bread?',
      'translation': 'Mana roti?'
    });
    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 22,
      'phrase': 'Where is the beer?',
      'translation': 'Mana bir?'
    });
    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 22,
      'phrase': 'Where is the wine?',
      'translation': 'Mana wain?'
    });

    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 23,
      'phrase': 'I need a phone charger.',
      'translation': 'Sia perlu pengecas telefon.'
    });
    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 23,
      'phrase': 'I need to check my email.',
      'translation': 'Sia perlu cek email.'
    });
    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 23,
      'phrase': 'Can you change it to English?',
      'translation': 'Boleh tukar ke bahasa Inggeris?'
    });
    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 23,
      'phrase': 'I need a printer.',
      'translation': 'Sia perlu printer.'
    });
    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 23,
      'phrase': 'I need a __.',
      'translation': 'Sia perlu __.'
    });

    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 24,
      'phrase': 'Is there Wi-Fi?',
      'translation': 'Ada Wi-Fi?'
    });
    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 24,
      'phrase': 'What is the password?',
      'translation': 'Apa password?'
    });
    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 24,
      'phrase': 'The Wi-fi isn\'t working.',
      'translation': 'Wi-Fi tidak berfungsi.'
    });

    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 25,
      'phrase': 'What is your email?',
      'translation': 'Apa email ko?'
    });
    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 25,
      'phrase': 'I need to check my emails.',
      'translation': 'Sia perlu cek email.'
    });
    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 25,
      'phrase': 'Can you email it to me?',
      'translation': 'Boleh email ke sia?'
    });

    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 26,
      'phrase': 'Can you send it to me?',
      'translation': 'Boleh hantar ke sia?'
    });
    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 26,
      'phrase': 'Can you message it to me?',
      'translation': 'Boleh mesej ke sia?'
    });
    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 26,
      'phrase': 'Can you Whatsapp it to me?',
      'translation': 'Boleh Whatsapp ke sia?'
    });

    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 27,
      'phrase': 'I lost my phone.',
      'translation': 'Sia hilang telefon.'
    });
    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 27,
      'phrase': 'I lost my laptop.',
      'translation': 'Sia hilang laptop.'
    });
    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 27,
      'phrase': 'I lost my __.',
      'translation': 'Sia hilang __.'
    });

    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 28,
      'phrase': 'Monday',
      'translation': 'Isnin'
    });
    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 28,
      'phrase': 'Tuesday',
      'translation': 'Selasa'
    });
    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 28,
      'phrase': 'Wednesday',
      'translation': 'Rabu'
    });
    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 28,
      'phrase': 'Thursday',
      'translation': 'Khamis'
    });
    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 28,
      'phrase': 'Friday',
      'translation': 'Jumaat'
    });
    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 28,
      'phrase': 'Saturday',
      'translation': 'Sabtu'
    });
    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 28,
      'phrase': 'Sunday',
      'translation': 'Ahad'
    });

    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 29,
      'phrase': 'Morning',
      'translation': 'Pagi'
    });
    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 29,
      'phrase': 'Noon',
      'translation': 'Tengahari'
    });
    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 29,
      'phrase': 'Afternoon',
      'translation': 'Petang'
    });
    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 29,
      'phrase': 'Evening',
      'translation': 'Malam'
    });
    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 29,
      'phrase': 'Night',
      'translation': 'Malam'
    });
    await db.insert('phrases', {
      'languageId': 10,
      'categoryId': 29,
      'phrase': 'Midnight',
      'translation': 'Tengah malam'
    });


    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 1,
      'phrase': 'Hello',
      'translation': 'Halo'
    });
    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 1,
      'phrase': 'My name is',
      'translation': 'Nama kamek'
    });
    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 1,
      'phrase': 'Excuse me',
      'translation': 'Tumpang lalu'
    });
    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 1,
      'phrase': 'Goodbye',
      'translation': 'Selamat tinggal'
    });
    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 1,
      'phrase': 'How are you?',
      'translation': 'Apa khabar?'
    });
    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 1,
      'phrase': 'Nice to meet you!',
      'translation': 'Gembira jumpa kitak!'
    });

    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 2,
      'phrase': 'Please',
      'translation': 'Tolong'
    });
    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 2,
      'phrase': 'I\'m sorry.',
      'translation': 'Kamek minta maaf.'
    });
    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 2,
      'phrase': 'Thank you.',
      'translation': 'Terima kasih.'
    });

    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 3,
      'phrase': 'Left',
      'translation': 'Kiri'
    });
    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 3,
      'phrase': 'Right',
      'translation': 'Kanan'
    });
    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 3,
      'phrase': 'Straight ahead',
      'translation': 'Terus ajak'
    });
    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 3,
      'phrase': 'In ___ meters.',
      'translation': 'Dalam ___ meter.'
    });
    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 3,
      'phrase': 'Traffic light',
      'translation': 'Lampu isyarat'
    });
    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 3,
      'phrase': 'Stop sign',
      'translation': 'Tanda berhenti'
    });
    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 3,
      'phrase': 'North',
      'translation': 'Utara'
    });
    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 3,
      'phrase': 'South',
      'translation': 'Selatan'
    });
    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 3,
      'phrase': 'East',
      'translation': 'Timur'
    });
    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 3,
      'phrase': 'West',
      'translation': 'Barat'
    });

    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 4,
      'phrase': 'Where is the ATM?',
      'translation': 'Kedey ATM di sitok?'
    });
    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 4,
      'phrase': 'I want to exchange money.',
      'translation': 'Kamek maok tukar duit.'
    });
    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 4,
      'phrase': 'What is the exchange fee?',
      'translation': 'Berapa yuran tukar?'
    });
    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 4,
      'phrase': 'How much does it cost?',
      'translation': 'Berapa harganya?'
    });

    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 5,
      'phrase': 'Where is the toilet?',
      'translation': 'Di sitok tandas?'
    });
    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 5,
      'phrase': 'Where is the grocery store?',
      'translation': 'Kedey runcit di sitok?'
    });
    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 5,
      'phrase': 'This is an emergency!',
      'translation': 'Nang kecemasan tok!'
    });
    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 5,
      'phrase': 'I need help.',
      'translation': 'Kamek perlu bantuan.'
    });

    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 6,
      'phrase': 'Do you speak ___?',
      'translation': 'Kitak cakap ___?'
    });
    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 6,
      'phrase': 'I don\'t speak ___.',
      'translation': 'Kamek sik cakap ___.'
    });
    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 6,
      'phrase': 'I don\'t understand.',
      'translation': 'Kamek sik faham.'
    });
    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 6,
      'phrase': 'I speak ___.',
      'translation': 'Kamek cakap ___.'
    });

    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 7,
      'phrase': 'Left',
      'translation': 'Kiri'
    });
    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 7,
      'phrase': 'Right',
      'translation': 'Kanan'
    });
    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 7,
      'phrase': 'Straight ahead',
      'translation': 'Terus ajak'
    });
    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 7,
      'phrase': 'In ___ meters.',
      'translation': 'Dalam ___ meter.'
    });
    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 7,
      'phrase': 'Traffic light',
      'translation': 'Lampu isyarat'
    });
    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 7,
      'phrase': 'Stop sign',
      'translation': 'Tanda berhenti'
    });
    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 7,
      'phrase': 'North',
      'translation': 'Utara'
    });
    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 7,
      'phrase': 'South',
      'translation': 'Selatan'
    });
    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 7,
      'phrase': 'East',
      'translation': 'Timur'
    });
    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 7,
      'phrase': 'West',
      'translation': 'Barat'
    });

    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 8,
      'phrase': 'Where is the ATM?',
      'translation': 'Kedey ATM di sitok?'
    });
    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 8,
      'phrase': 'I want to exchange money.',
      'translation': 'Kamek maok tukar duit.'
    });
    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 8,
      'phrase': 'What is the exchange fee?',
      'translation': 'Berapa yuran tukar?'
    });
    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 8,
      'phrase': 'How much does it cost?',
      'translation': 'Berapa harganya?'
    });

    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 9,
      'phrase': 'Where is the toilet?',
      'translation': 'Di sitok tandas?'
    });
    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 9,
      'phrase': 'Where is the grocery store?',
      'translation': 'Kedey runcit di sitok?'
    });
    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 9,
      'phrase': 'This is an emergency!',
      'translation': 'Nang kecemasan tok!'
    });
    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 9,
      'phrase': 'I need help.',
      'translation': 'Kamek perlu bantuan.'
    });

    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 10,
      'phrase': 'Do you speak ___?',
      'translation': 'Kitak cakap ___?'
    });
    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 10,
      'phrase': 'I don\'t speak ___.',
      'translation': 'Kamek sik cakap ___.'
    });
    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 10,
      'phrase': 'I don\'t understand.',
      'translation': 'Kamek sik faham.'
    });
    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 10,
      'phrase': 'I speak ___.',
      'translation': 'Kamek cakap ___.'
    });

    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 11,
      'phrase': 'Hello',
      'translation': 'Halo'
    });
    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 11,
      'phrase': 'My name is __.',
      'translation': 'Nama kamek __.'
    });
    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 11,
      'phrase': 'Excuse me',
      'translation': 'Tumpang lalu'
    });
    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 11,
      'phrase': 'Goodbye',
      'translation': 'Selamat tinggal'
    });
    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 11,
      'phrase': 'How are you?',
      'translation': 'Apa khabar?'
    });
    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 11,
      'phrase': 'Nice to meet you!',
      'translation': 'Gembira jumpa kitak!'
    });

    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 12,
      'phrase': 'Where is the airport?',
      'translation': 'Di sitok lapangan terbang?'
    });
    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 12,
      'phrase': 'Where is the train station?',
      'translation': 'Di sitok stesen kereta api?'
    });
    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 12,
      'phrase': 'Where is the subway?',
      'translation': 'Di sitok kereta api bawah tanah?'
    });
    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 12,
      'phrase': 'Where is the bus station?',
      'translation': 'Di sitok stesen bas?'
    });
    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 12,
      'phrase': 'Where is the ___ museum?',
      'translation': 'Di sitok muzium ___?'
    });
    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 12,
      'phrase': 'Where is a good restaurant?',
      'translation': 'Kedey makan bagus di sitok?'
    });
    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 12,
      'phrase': 'Where is a nice coffee place?',
      'translation': 'Kedey kopi bagus di sitok?'
    });
    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 12,
      'phrase': 'Where is a nice bar?',
      'translation': 'Bar bagus di sitok?'
    });

    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 13,
      'phrase': 'Where can I buy a ticket?',
      'translation': 'Di sitok boleh beli tiket?'
    });
    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 13,
      'phrase': 'How much is a ticket?',
      'translation': 'Berapa harga tiket?'
    });
    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 13,
      'phrase': 'I need ___ tickets, please.',
      'translation': 'Kamek maok ___ tiket, tolong.'
    });
    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 13,
      'phrase': 'I would like to change my ticket.',
      'translation': 'Kamek maok tukar tiket kamek.'
    });

    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 14,
      'phrase': 'Which platform?',
      'translation': 'Platform yang manak?'
    });
    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 14,
      'phrase': 'Where is the platform?',
      'translation': 'Platform di sitok?'
    });
    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 14,
      'phrase': 'Where should I get off?',
      'translation': 'Di manak kamek patut turun?'
    });
    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 14,
      'phrase': 'I\'d like to get off at ___.',
      'translation': 'Kamek maok turun di ___.'
    });
    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 14,
      'phrase': 'Where do I change trains?',
      'translation': 'Di manak tukar kereta api?'
    });
    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 14,
      'phrase': 'Where do I change buses?',
      'translation': 'Di manak tukar bas?'
    });

    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 15,
      'phrase': 'Here is my passport.',
      'translation': 'Tok pasport kamek.'
    });
    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 15,
      'phrase': 'Do I need a visa?',
      'translation': 'Perlu visa sik?'
    });
    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 15,
      'phrase': 'I am an immigrant.',
      'translation': 'Kamek orang pendatang.'
    });
    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 15,
      'phrase': 'I am a refugee.',
      'translation': 'Kamek orang pelarian.'
    });
    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 15,
      'phrase': 'I have nothing to declare.',
      'translation': 'Kamek sik ada apa maok diisytiharkan.'
    });
    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 15,
      'phrase': 'I have something to declare.',
      'translation': 'Kamek ada barang maok diisytiharkan.'
    });

    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 16,
      'phrase': 'I have allergies.',
      'translation': 'Kamek ada alahan.'
    });
    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 16,
      'phrase': 'I am allergic to ___.',
      'translation': 'Kamek alah kepada ___.'
    });
    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 16,
      'phrase': 'I am allergic to penicillin.',
      'translation': 'Kamek alah kepada penicillin.'
    });
    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 16,
      'phrase': 'I am allergic to antibiotics.',
      'translation': 'Kamek alah kepada antibiotik.'
    });
    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 16,
      'phrase': 'I have Asthma.',
      'translation': 'Kamek ada asma.'
    });

    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 17,
      'phrase': 'I would like to check in.',
      'translation': 'Kamek maok check in.'
    });
    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 17,
      'phrase': 'I would like to change my reservation.',
      'translation': 'Kamek maok tukar tempahan kamek.'
    });
    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 17,
      'phrase': 'Can we have a room with ___ view?',
      'translation': 'Boleh bilik kamek ada view ___?'
    });
    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 17,
      'phrase': 'When does breakfast start?',
      'translation': 'Bila sarapan start?'
    });
    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 17,
      'phrase': 'When does lunch start?',
      'translation': 'Bila makan tengahari start?'
    });
    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 17,
      'phrase': 'When does dinner start?',
      'translation': 'Bila makan malam start?'
    });
    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 17,
      'phrase': 'When is check out?',
      'translation': 'Bila maok check out?'
    });
    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 17,
      'phrase': 'My room needs to be cleaned.',
      'translation': 'Bilik kamek perlu dibersihkan.'
    });

    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 18,
      'phrase': 'Do you have free rooms?',
      'translation': 'Ada bilik kosong?'
    });
    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 18,
      'phrase': 'I would like ___ rooms.',
      'translation': 'Kamek maok ___ bilik.'
    });
    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 18,
      'phrase': 'We are ___ people.',
      'translation': 'Kamek ___ orang.'
    });
    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 18,
      'phrase': 'How much does the room cost?',
      'translation': 'Berapa harga bilik?'
    });
    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 18,
      'phrase': 'Is it air conditioned?',
      'translation': 'Ada aircon sik?'
    });
    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 18,
      'phrase': 'Is there room service?',
      'translation': 'Ada servis bilik?'
    });
    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 18,
      'phrase': 'Is breakfast included?',
      'translation': 'Sarapan termasuk sik?'
    });
    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 18,
      'phrase': 'Is lunch included?',
      'translation': 'Makan tengahari termasuk sik?'
    });
    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 18,
      'phrase': 'Is dinner included?',
      'translation': 'Makan malam termasuk sik?'
    });
    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 18,
      'phrase': 'Is there a restaurant?',
      'translation': 'Ada restoran?'
    });
    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 18,
      'phrase': 'When is check out?',
      'translation': 'Bila maok check out?'
    });

    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 19,
      'phrase': 'May I see the menu?',
      'translation': 'Boleh kamek tengok menu?'
    });
    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 19,
      'phrase': 'I would like to order __.',
      'translation': 'Kamek maok order __.'
    });
    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 19,
      'phrase': 'I would like breakfast.',
      'translation': 'Kamek maok sarapan.'
    });
    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 19,
      'phrase': 'I would like lunch.',
      'translation': 'Kamek maok makan tengahari.'
    });
    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 19,
      'phrase': 'I would like dinner.',
      'translation': 'Kamek maok makan malam.'
    });
    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 19,
      'phrase': 'I\'m a vegetarian.',
      'translation': 'Kamek vegetarian.'
    });
    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 19,
      'phrase': 'I\'m vegan.',
      'translation': 'Kamek vegan.'
    });
    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 19,
      'phrase': 'I don\'t eat pork.',
      'translation': 'Kamek sik makan daging babi.'
    });
    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 19,
      'phrase': 'I don\'t eat beef.',
      'translation': 'Kamek sik makan daging lembu.'
    });
    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 19,
      'phrase': 'I don\'t eat __.',
      'translation': 'Kamek sik makan __.'
    });
    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 19,
      'phrase': 'The bill please.',
      'translation': 'Bil, tolong.'
    });

    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 20,
      'phrase': 'I would like some __.',
      'translation': 'Kamek maok __ sikit.'
    });
    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 20,
      'phrase': 'I would like some bottled water.',
      'translation': 'Kamek maok air botol.'
    });
    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 20,
      'phrase': 'I would like some carbonated water.',
      'translation': 'Kamek maok air berkarbonat.'
    });
    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 20,
      'phrase': 'No ice.',
      'translation': 'Sik ada ais.'
    });
    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 20,
      'phrase': 'With ice.',
      'translation': 'Dengan ais.'
    });

    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 21,
      'phrase': 'I would like some __.',
      'translation': 'Kamek maok __ sikit.'
    });
    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 21,
      'phrase': 'I would like some bottled water.',
      'translation': 'Kamek maok air botol.'
    });
    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 21,
      'phrase': 'I would like some carbonated water.',
      'translation': 'Kamek maok air berkarbonat.'
    });
    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 21,
      'phrase': 'No ice.',
      'translation': 'Sik ada ais.'
    });
    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 21,
      'phrase': 'With ice.',
      'translation': 'Dengan ais.'
    });

    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 22,
      'phrase': 'Where is the milk?',
      'translation': 'Di sitok susu?'
    });
    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 22,
      'phrase': 'Where are the eggs?',
      'translation': 'Di sitok telur?'
    });
    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 22,
      'phrase': 'Where is the ice cream?',
      'translation': 'Di sitok aiskrim?'
    });
    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 22,
      'phrase': 'Where is the bottled water?',
      'translation': 'Di sitok air botol?'
    });
    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 22,
      'phrase': 'Where are the soft drinks?',
      'translation': 'Di sitok minuman ringan?'
    });
    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 22,
      'phrase': 'Where are the fruits?',
      'translation': 'Di sitok buah-buahan?'
    });
    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 22,
      'phrase': 'Where are the vegetables?',
      'translation': 'Di sitok sayur-sayuran?'
    });
    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 22,
      'phrase': 'Where is the meat?',
      'translation': 'Di sitok daging?'
    });
    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 22,
      'phrase': 'Where is the bread?',
      'translation': 'Di sitok roti?'
    });
    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 22,
      'phrase': 'Where is the beer?',
      'translation': 'Di sitok bir?'
    });
    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 22,
      'phrase': 'Where is the wine?',
      'translation': 'Di sitok wain?'
    });

    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 23,
      'phrase': 'I need a phone charger.',
      'translation': 'Kamek perlu pengecas telefon.'
    });
    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 23,
      'phrase': 'I need to check my email.',
      'translation': 'Kamek perlu cek email.'
    });
    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 23,
      'phrase': 'Can you change it to English?',
      'translation': 'Boleh tukar ke bahasa Inggeris?'
    });
    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 23,
      'phrase': 'I need a printer.',
      'translation': 'Kamek perlu printer.'
    });
    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 23,
      'phrase': 'I need a __.',
      'translation': 'Kamek perlu __.'
    });

    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 24,
      'phrase': 'Is there Wi-Fi?',
      'translation': 'Ada Wi-Fi?'
    });
    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 24,
      'phrase': 'What is the password?',
      'translation': 'Apa password?'
    });
    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 24,
      'phrase': 'The Wi-fi isn\'t working.',
      'translation': 'Wi-Fi sik berfungsi.'
    });

    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 25,
      'phrase': 'What is your email?',
      'translation': 'Apa email kitak?'
    });
    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 25,
      'phrase': 'I need to check my emails.',
      'translation': 'Kamek perlu cek email.'
    });
    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 25,
      'phrase': 'Can you email it to me?',
      'translation': 'Boleh email ke kamek?'
    });

    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 26,
      'phrase': 'Can you send it to me?',
      'translation': 'Boleh hantar ke kamek?'
    });
    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 26,
      'phrase': 'Can you message it to me?',
      'translation': 'Boleh mesej ke kamek?'
    });
    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 26,
      'phrase': 'Can you Whatsapp it to me?',
      'translation': 'Boleh Whatsapp ke kamek?'
    });

    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 27,
      'phrase': 'I lost my phone.',
      'translation': 'Kamek hilang telefon.'
    });
    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 27,
      'phrase': 'I lost my laptop.',
      'translation': 'Kamek hilang laptop.'
    });
    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 27,
      'phrase': 'I lost my __.',
      'translation': 'Kamek hilang __.'
    });

    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 28,
      'phrase': 'Monday',
      'translation': 'Isnin'
    });
    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 28,
      'phrase': 'Tuesday',
      'translation': 'Selasa'
    });
    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 28,
      'phrase': 'Wednesday',
      'translation': 'Rabu'
    });
    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 28,
      'phrase': 'Thursday',
      'translation': 'Khamis'
    });
    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 28,
      'phrase': 'Friday',
      'translation': 'Jumaat'
    });
    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 28,
      'phrase': 'Saturday',
      'translation': 'Sabtu'
    });
    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 28,
      'phrase': 'Sunday',
      'translation': 'Ahad'
    });

    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 29,
      'phrase': 'Morning',
      'translation': 'Pagi'
    });
    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 29,
      'phrase': 'Noon',
      'translation': 'Tengahari'
    });
    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 29,
      'phrase': 'Afternoon',
      'translation': 'Petang'
    });
    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 29,
      'phrase': 'Evening',
      'translation': 'Malam'
    });
    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 29,
      'phrase': 'Night',
      'translation': 'Malam'
    });
    await db.insert('phrases', {
      'languageId': 11,
      'categoryId': 29,
      'phrase': 'Midnight',
      'translation': 'Tengah malam'
    });
  }

  Future<void> insertCategory(int situationId, String name) async {
    final db = await database;
    await db.insert('categories', {'situationId': situationId, 'name': name});
  }

  Future<void> insertPhrase(int languageId, int categoryId, String phrase, String translation) async {
    final db = await database;
    await db.insert('phrases', {'languageId': languageId, 'categoryId': categoryId, 'phrase': phrase, 'translation': translation});
  }

  Future<List<Map<String, dynamic>>> getCategories(int situationId) async {
    final db = await database;
    return await db.rawQuery('SELECT * FROM categories WHERE situationId = ?', [situationId]);
  }

  Future<List<Map<String, dynamic>>> getPhrases(int situationId, int languageId) async {
    final db = await database;
    return await db.rawQuery('''
      SELECT p.id, p.phrase, p.translation
      FROM phrases p
      JOIN categories c ON p.categoryId = c.id
      JOIN situations s ON c.situationId = s.id
      JOIN languages l ON p.languageId = l.id
      WHERE s.id = ? AND l.id = ?
    ''', [situationId, languageId]);
  }
}
