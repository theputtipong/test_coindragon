// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('API Load Test', () {
    BookModel? data;

    testWidgets('test call API openlibrary when tap widget', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ElevatedButton(
              onPressed: () async {
                data = await callData();
              },
              child: const Text('Tap me'),
            ),
          ),
        ),
      );

      await tester.tap(find.byType(ElevatedButton));

      expect(data, isNotNull);

      expect(data?.entries, isNotEmpty);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ListView.builder(
              itemCount: data?.entries?.length,
              itemBuilder: (context, index) {
                Entry value = data!.entries![index];
                return Text(value.name ?? '');
              },
            ),
          ),
        ),
      );

      expect(find.byType(Text), findsNWidgets(data!.entries!.length));

      expect(data!.entries!.length, data!.entries!.length);
    });
  });
}

Future<BookModel> callData() async {
  var value = {
    "links": {"self": "/people/george08/lists.json"},
    "size": 2,
    "entries": [
      {
        "url": "/people/george08/lists/OL95357L",
        "full_url": "/people/george08/lists/OL95357L/Museum_in_a_Box",
        "name": "Museum in a Box",
        "seed_count": 3,
        "last_update": "2023-11-15T02:45:45.349490"
      },
      {
        "url": "/people/george08/lists/OL92303L",
        "full_url": "/people/george08/lists/OL92303L/Museums",
        "name": "Museums",
        "seed_count": 28,
        "last_update": "2023-12-19T22:19:58.316154"
      },
    ]
  };

  BookModel data = BookModel.fromJson(value);
  return data;
}

class BookModel {
  Links? links;
  int? size;
  List<Entry>? entries;

  BookModel({
    this.links,
    this.size,
    this.entries,
  });

  factory BookModel.fromJson(Map<String, dynamic> json) => BookModel(
        links: json["links"] == null ? null : Links.fromJson(json["links"]),
        size: json["size"],
        entries: json["entries"] == null ? [] : List<Entry>.from(json["entries"]!.map((x) => Entry.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "links": links?.toJson(),
        "size": size,
        "entries": entries == null ? [] : List<dynamic>.from(entries!.map((x) => x.toJson())),
      };
}

class Entry {
  String? url;
  String? fullUrl;
  String? name;
  int? seedCount;
  DateTime? lastUpdate;

  Entry({
    this.url,
    this.fullUrl,
    this.name,
    this.seedCount,
    this.lastUpdate,
  });

  factory Entry.fromJson(Map<String, dynamic> json) => Entry(
        url: json["url"],
        fullUrl: json["full_url"],
        name: json["name"],
        seedCount: json["seed_count"],
        lastUpdate: json["last_update"] == null ? null : DateTime.parse(json["last_update"]),
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "full_url": fullUrl,
        "name": name,
        "seed_count": seedCount,
        "last_update": lastUpdate?.toIso8601String(),
      };
}

class Links {
  String? self;

  Links({
    this.self,
  });

  factory Links.fromJson(Map<String, dynamic> json) => Links(
        self: json["self"],
      );

  Map<String, dynamic> toJson() => {
        "self": self,
      };
}
