// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';

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
                data = await callApiData();
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

Future<BookModel?> callApiData() async {
  Request request = Request('GET', Uri.parse('http://openlibrary.org/people/george08/lists.json'));
  StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    BookModel data = bookModelFromJson(await response.stream.bytesToString());
    return data;
  } else {
    return null;
  }
}

BookModel bookModelFromJson(String str) => BookModel.fromJson(json.decode(str));

String bookModelToJson(BookModel data) => json.encode(data.toJson());

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
