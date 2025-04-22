import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:path_provider/path_provider.dart';
import 'package:recipr/screens/home.dart';

class LoginRegisterPage extends StatefulWidget {
  final Function(String languageCode) onChangeLanguage;

  LoginRegisterPage({required this.onChangeLanguage});

  @override
  _LoginRegisterPageState createState() => _LoginRegisterPageState();
}

class _LoginRegisterPageState extends State<LoginRegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLogin = true;

  Future<File> _getAccountsFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/accounts.json');
  }

  Future<Map<String, String>> _loadAccounts() async {
    try {
      final file = await _getAccountsFile();
      if (await file.exists()) {
        final content = await file.readAsString();
        return Map<String, String>.from(json.decode(content));
      }
    } catch (e) {
      print('Error loading accounts: $e');
    }
    return {};
  }

  Future<void> _saveAccounts(Map<String, String> accounts) async {
    final file = await _getAccountsFile();
    await file.writeAsString(json.encode(accounts));
  }

  void _handleSubmit() async {
    if (_formKey.currentState!.validate()) {
      final username = _usernameController.text;
      final password = _passwordController.text;
      final accounts = await _loadAccounts();

      if (_isLogin) {
        if (accounts.containsKey(username) && accounts[username] == password) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(AppLocalizations.of(context)!.login_success),
            ),
          );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(
                onChangeLanguage: (languageCode) {
                  widget.onChangeLanguage(languageCode);
                },
              ),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(AppLocalizations.of(context)!.login_failed)),
          );
        }
      } else {
        if (accounts.containsKey(username)) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(AppLocalizations.of(context)!.register_failed),
            ),
          );
        } else {
          accounts[username] = password;
          await _saveAccounts(accounts);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(AppLocalizations.of(context)!.register_success),
            ),
          );
          setState(() {
            _isLogin = true;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          _isLogin ? localizations!.login_title : localizations!.register_title,
        ),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: (languageCode) {
              widget.onChangeLanguage(languageCode);
            },
            icon: Icon(Icons.language),
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(value: 'en', child: Text('English')),
                PopupMenuItem(value: 'vi', child: Text('Tiếng Việt')),
                PopupMenuItem(value: 'fr', child: Text('Français')),
              ];
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: localizations.username_label,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return localizations.username_required;
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: localizations.password_label,
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return localizations.password_required;
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _handleSubmit,
                child: Text(
                  _isLogin
                      ? localizations.login_button
                      : localizations.register_button,
                ),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    _isLogin = !_isLogin;
                  });
                },
                child: Text(
                  _isLogin
                      ? localizations.switch_to_register
                      : localizations.switch_to_login,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
