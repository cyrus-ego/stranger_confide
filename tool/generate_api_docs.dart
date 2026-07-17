// ignore_for_file: avoid_print
import 'dart:convert';
import 'dart:io';

/// Script tự động tách Swagger JSON thành các file markdown theo tag/domain.
/// Chạy: dart run tool/generate_api_docs.dart
///
/// Output:
///   docs/api/api-index.md   — index nhẹ liệt kê tất cả endpoints
///   docs/api/auth.md        — chi tiết endpoints tag auth
///   docs/api/profile.md     — ...
///   docs/api/common.md      — shared schemas (error, response wrappers)

const swaggerUrl = 'https://api.chatvn.online/api/docs-json';
const outputDir = 'docs/api';

Future<void> main() async {
  // 1. Fetch swagger JSON
  print('Fetching swagger from $swaggerUrl ...');
  final client = HttpClient();
  final request = await client.getUrl(Uri.parse(swaggerUrl));
  final response = await request.close();
  final body = await response.transform(utf8.decoder).join();
  client.close();

  final Map<String, dynamic> spec = jsonDecode(body);
  final paths = spec['paths'] as Map<String, dynamic>;
  final schemas =
      (spec['components'] as Map<String, dynamic>?)?['schemas']
          as Map<String, dynamic>? ??
      {};

  // 2. Group endpoints by tag
  final Map<String, List<_Endpoint>> tagEndpoints = {};
  for (final entry in paths.entries) {
    final path = entry.key;
    final methods = entry.value as Map<String, dynamic>;
    for (final mEntry in methods.entries) {
      final method = mEntry.key.toUpperCase();
      if (['GET', 'POST', 'PUT', 'PATCH', 'DELETE'].contains(method)) {
        final op = mEntry.value as Map<String, dynamic>;
        final tags = (op['tags'] as List?)?.cast<String>() ?? ['other'];
        final endpoint = _Endpoint(
          method: method,
          path: path,
          summary: op['summary'] as String? ?? '',
          description: op['description'] as String? ?? '',
          parameters: op['parameters'] as List? ?? [],
          requestBody: op['requestBody'] as Map<String, dynamic>?,
          responses: op['responses'] as Map<String, dynamic>? ?? {},
          operationId: op['operationId'] as String? ?? '',
        );
        for (final tag in tags) {
          tagEndpoints.putIfAbsent(tag, () => []).add(endpoint);
        }
      }
    }
  }

  // 3. Identify shared schemas vs domain-specific
  final sharedSchemaNames = ['ApiErrorResponseDto', 'FieldErrorDto', 'MessageResponseDto'];

  // 4. Collect which schemas each tag references
  final Map<String, Set<String>> tagSchemas = {};
  for (final tag in tagEndpoints.keys) {
    tagSchemas[tag] = {};
    for (final ep in tagEndpoints[tag]!) {
      _collectRefs(ep.requestBody, tagSchemas[tag]!);
      _collectRefs(ep.responses, tagSchemas[tag]!);
    }
    // Remove shared schemas from domain files
    tagSchemas[tag]!.removeAll(sharedSchemaNames);
  }

  // 5. Generate output directory
  final dir = Directory(outputDir);
  if (!dir.existsSync()) dir.createSync(recursive: true);

  // 6. Generate api-index.md
  final indexBuf = StringBuffer();
  indexBuf.writeln('# API Endpoints Index');
  indexBuf.writeln();
  indexBuf.writeln('Base URL: `https://api.chatvn.online`');
  indexBuf.writeln();
  indexBuf.writeln('Chi tiết từng domain xem file tương ứng trong `docs/api/`.');
  indexBuf.writeln();

  final sortedTags = tagEndpoints.keys.toList()..sort();
  for (final tag in sortedTags) {
    indexBuf.writeln('## ${tag[0].toUpperCase()}${tag.substring(1)}');
    indexBuf.writeln();
    indexBuf.writeln('File: `docs/api/$tag.md`');
    indexBuf.writeln();
    indexBuf.writeln('| Method | Path | Summary |');
    indexBuf.writeln('|--------|------|---------|');
    for (final ep in tagEndpoints[tag]!) {
      indexBuf.writeln('| ${ep.method} | `${ep.path}` | ${ep.summary} |');
    }
    indexBuf.writeln();
  }

  indexBuf.writeln('## Common Schemas');
  indexBuf.writeln();
  indexBuf.writeln('File: `docs/api/common.md` — Error response, field errors, generic message.');
  indexBuf.writeln();

  File('$outputDir/api-index.md').writeAsStringSync(indexBuf.toString());
  print('Generated: $outputDir/api-index.md');

  // 7. Generate domain files
  for (final tag in sortedTags) {
    final buf = StringBuffer();
    buf.writeln('# API: ${tag[0].toUpperCase()}${tag.substring(1)}');
    buf.writeln();

    for (final ep in tagEndpoints[tag]!) {
      buf.writeln('## ${ep.method} `${ep.path}`');
      buf.writeln();
      if (ep.summary.isNotEmpty) {
        buf.writeln('**${ep.summary}**');
        buf.writeln();
      }
      if (ep.description.isNotEmpty && ep.description != ep.summary) {
        buf.writeln(ep.description);
        buf.writeln();
      }

      // Parameters
      if (ep.parameters.isNotEmpty) {
        buf.writeln('### Parameters');
        buf.writeln();
        buf.writeln('| Name | In | Type | Required | Description |');
        buf.writeln('|------|----|------|----------|-------------|');
        for (final p in ep.parameters) {
          final param = p as Map<String, dynamic>;
          final schema = param['schema'] as Map<String, dynamic>? ?? {};
          buf.writeln(
            '| ${param['name']} | ${param['in']} | ${schema['type'] ?? 'string'} | ${param['required'] ?? false} | ${param['description'] ?? ''} |',
          );
        }
        buf.writeln();
      }

      // Request body
      if (ep.requestBody != null) {
        buf.writeln('### Request Body');
        buf.writeln();
        final content = ep.requestBody!['content'] as Map<String, dynamic>? ?? {};
        for (final ct in content.entries) {
          final schemaData = (ct.value as Map<String, dynamic>)['schema'] as Map<String, dynamic>?;
          if (schemaData != null) {
            final ref = schemaData[r'$ref'] as String?;
            if (ref != null) {
              final schemaName = ref.split('/').last;
              buf.writeln('Content-Type: `${ct.key}`');
              buf.writeln();
              _writeSchema(buf, schemaName, schemas);
            } else {
              buf.writeln('Content-Type: `${ct.key}`');
              buf.writeln();
              buf.writeln('```json');
              buf.writeln(const JsonEncoder.withIndent('  ').convert(schemaData));
              buf.writeln('```');
            }
          }
        }
        buf.writeln();
      }

      // Responses
      buf.writeln('### Responses');
      buf.writeln();
      for (final rEntry in ep.responses.entries) {
        final status = rEntry.key;
        final rData = rEntry.value as Map<String, dynamic>;
        final desc = rData['description'] ?? '';
        buf.writeln('**$status** — $desc');
        buf.writeln();

        final content = rData['content'] as Map<String, dynamic>?;
        if (content != null) {
          for (final ct in content.entries) {
            final schemaData = (ct.value as Map<String, dynamic>)['schema'] as Map<String, dynamic>?;
            if (schemaData != null) {
              final ref = schemaData[r'$ref'] as String?;
              if (ref != null) {
                final schemaName = ref.split('/').last;
                if (!sharedSchemaNames.contains(schemaName)) {
                  _writeSchema(buf, schemaName, schemas);
                } else {
                  buf.writeln('Schema: `$schemaName` (xem `common.md`)');
                  buf.writeln();
                }
              } else {
                // Inline schema - extract data ref if exists
                final dataRef = schemaData['properties']?['data']?[r'$ref'] as String?;
                if (dataRef != null) {
                  final schemaName = dataRef.split('/').last;
                  buf.writeln('Response data schema:');
                  buf.writeln();
                  _writeSchema(buf, schemaName, schemas);
                } else {
                  buf.writeln('```json');
                  buf.writeln(const JsonEncoder.withIndent('  ').convert(schemaData));
                  buf.writeln('```');
                  buf.writeln();
                }
              }
            }
          }
        }
      }

      buf.writeln('---');
      buf.writeln();
    }

    // Domain schemas section
    if (tagSchemas[tag]!.isNotEmpty) {
      buf.writeln('## Schemas');
      buf.writeln();
      for (final schemaName in tagSchemas[tag]!) {
        _writeSchema(buf, schemaName, schemas);
      }
    }

    File('$outputDir/$tag.md').writeAsStringSync(buf.toString());
    print('Generated: $outputDir/$tag.md');
  }

  // 8. Generate common.md
  final commonBuf = StringBuffer();
  commonBuf.writeln('# Common Schemas');
  commonBuf.writeln();
  commonBuf.writeln('Các schema dùng chung cho tất cả endpoints.');
  commonBuf.writeln();
  for (final name in sharedSchemaNames) {
    _writeSchema(commonBuf, name, schemas);
  }
  File('$outputDir/common.md').writeAsStringSync(commonBuf.toString());
  print('Generated: $outputDir/common.md');

  print('\nDone! Generated ${sortedTags.length + 2} files in $outputDir/');
}

void _writeSchema(StringBuffer buf, String name, Map<String, dynamic> schemas) {
  buf.writeln('#### `$name`');
  buf.writeln();
  final schema = schemas[name] as Map<String, dynamic>?;
  if (schema == null) {
    buf.writeln('_(schema not found)_');
    buf.writeln();
    return;
  }

  final properties = schema['properties'] as Map<String, dynamic>? ?? {};
  final required = (schema['required'] as List?)?.cast<String>() ?? [];

  if (properties.isEmpty) {
    buf.writeln('```json');
    buf.writeln(const JsonEncoder.withIndent('  ').convert(schema));
    buf.writeln('```');
    buf.writeln();
    return;
  }

  buf.writeln('| Field | Type | Required | Description |');
  buf.writeln('|-------|------|----------|-------------|');
  for (final pEntry in properties.entries) {
    final field = pEntry.key;
    final prop = pEntry.value as Map<String, dynamic>;
    final type = _resolveType(prop);
    final isRequired = required.contains(field);
    final desc = prop['description'] ?? prop['example'] ?? '';
    buf.writeln('| `$field` | $type | ${isRequired ? "Yes" : "No"} | $desc |');
  }
  buf.writeln();
}

String _resolveType(Map<String, dynamic> prop) {
  if (prop.containsKey(r'$ref')) {
    return '`${(prop[r'$ref'] as String).split('/').last}`';
  }
  final type = prop['type'] as String? ?? 'object';
  if (type == 'array') {
    final items = prop['items'] as Map<String, dynamic>? ?? {};
    if (items.containsKey(r'$ref')) {
      return '`${(items[r'$ref'] as String).split('/').last}[]`';
    }
    return '${items['type'] ?? 'object'}[]';
  }
  final format = prop['format'] as String?;
  if (format != null) return '$type ($format)';
  final enumValues = prop['enum'] as List?;
  if (enumValues != null) return 'enum: ${enumValues.join(", ")}';
  return type;
}

void _collectRefs(dynamic obj, Set<String> refs) {
  if (obj == null) return;
  if (obj is Map) {
    if (obj.containsKey(r'$ref')) {
      final ref = obj[r'$ref'] as String;
      refs.add(ref.split('/').last);
    }
    for (final v in obj.values) {
      _collectRefs(v, refs);
    }
  } else if (obj is List) {
    for (final item in obj) {
      _collectRefs(item, refs);
    }
  }
}

class _Endpoint {
  final String method;
  final String path;
  final String summary;
  final String description;
  final List parameters;
  final Map<String, dynamic>? requestBody;
  final Map<String, dynamic> responses;
  final String operationId;

  _Endpoint({
    required this.method,
    required this.path,
    required this.summary,
    required this.description,
    required this.parameters,
    required this.requestBody,
    required this.responses,
    required this.operationId,
  });
}
