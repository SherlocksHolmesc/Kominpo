import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MaschainService {
  final String apiUrl =
      'https://service-testnet.maschain.com/api/audit/audit'; // Replace with actual API URL

  Future<bool> createAuditTrail({
    required String walletAddress,
    required String contractAddress,
    required Map<String, dynamic> metadata,
    List<String>? callbackUrl,
    List<String>? categoryId,
    List<String>? tagId,
    File? file,
  }) async {
    try {
      print("Starting request setup...");

      final request = http.MultipartRequest('POST', Uri.parse(apiUrl));

      // Adding headers
      request.headers['client_id'] =
          '3e0be746da462e2b4d5a43f629bff738b468b91235eb8f10333d6ced335175ec';
      request.headers['client_secret'] =
          'sk_6397da49b935dd7a42a338ba06b92d3fbe06c09b3fab17b508144fc896f51d18';
      request.headers['content-type'] = 'multipart/form-data';

      print("Headers added: ${request.headers}");

      // Adding form-data fields
      request.fields['wallet_address'] = walletAddress;
      request.fields['contract_address'] = contractAddress;
      request.fields['metadata'] = jsonEncode(metadata);

      if (callbackUrl != null && callbackUrl.isNotEmpty) {
        request.fields['callback_url'] = callbackUrl.join(',');
      }
      print("Fields added: ${request.fields}");

      if (categoryId != null) {
        request.fields['category_id'] = jsonEncode(categoryId);
        print("Category ID added: ${request.fields['category_id']}");
      }

      if (tagId != null) {
        request.fields['tag_id'] = jsonEncode(tagId);
        print("Tag ID added: ${request.fields['tag_id']}");
      }

      if (file != null) {
        request.files.add(await http.MultipartFile.fromPath('file', file.path));
        print("File added: ${file.path}");
      }

      print("Sending request...");
      final response = await request.send();
      final responseData = await response.stream.bytesToString();

      print("Response Status: ${response.statusCode}");
      print("Response Data: $responseData");

      if (response.statusCode == 200) {
        print("Successfully created audit trail.");
        return true;
      } else {
        print(
            "Failed to create audit trail. Status Code: ${response.statusCode}, Response: $responseData");
        return false;
      }
    } catch (e) {
      print("An error occurred while creating audit trail: $e");
      return false;
    }
  }
}
