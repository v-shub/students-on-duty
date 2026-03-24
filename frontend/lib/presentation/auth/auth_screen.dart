// lib/presentation/auth/auth_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/core/constants/app_colors.dart';
import 'package:frontend/presentation/auth/auth_provider.dart';

class AuthScreen extends ConsumerStatefulWidget {
  const AuthScreen({super.key});

  @override
  ConsumerState<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _codeController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isRegistration = false;
  bool _codeSent = false;

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);

    // В методе build внутри слушателя:

    String? lastErrorMessage;

    ref.listen<AuthState>(authProvider, (previous, next) {
      if (next.errorMessage != null &&
          next.errorMessage!.isNotEmpty &&
          next.errorMessage != lastErrorMessage) {
        lastErrorMessage = next.errorMessage;
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(next.errorMessage!),
              backgroundColor: AppColors.error,
              duration: const Duration(seconds: 3),
            ),
          );
        }
      }
    });

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        title: Text(
          _isRegistration ? 'Регистрация' : 'Вход',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: AppColors.primaryDark,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Логотип или иконка приложения
              Center(
                child: Container(
                  width: 100,
                  height: 100,
                  margin: const EdgeInsets.only(bottom: 24, top: 16),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.schedule,
                    size: 50,
                    color: AppColors.primaryDark,
                  ),
                ),
              ),

              // Карточка формы
              Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        if (!_codeSent) ...[
                          // Этап 1: ввод email/телефона
                          const Text(
                            'Добро пожаловать!',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Введите email или телефон для получения кода',
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.textSecondary,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 32),

                          // Поле email
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.shade50,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.grey.shade200),
                            ),
                            child: TextFormField(
                              controller: _emailController,
                              decoration: InputDecoration(
                                labelText: 'Email',
                                labelStyle: TextStyle(
                                  color: AppColors.textSecondary,
                                ),
                                prefixIcon: Icon(
                                  Icons.email,
                                  color: AppColors.primaryDark,
                                ),
                                border: InputBorder.none,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 14,
                                ),
                              ),
                              keyboardType: TextInputType.emailAddress,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'или',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: AppColors.textSecondary),
                          ),
                          const SizedBox(height: 8),

                          // Поле телефон
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.shade50,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.grey.shade200),
                            ),
                            child: TextFormField(
                              controller: _phoneController,
                              decoration: InputDecoration(
                                labelText: 'Телефон',
                                labelStyle: TextStyle(
                                  color: AppColors.textSecondary,
                                ),
                                prefixIcon: Icon(
                                  Icons.phone,
                                  color: AppColors.primaryDark,
                                ),
                                border: InputBorder.none,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 14,
                                ),
                              ),
                              keyboardType: TextInputType.phone,
                            ),
                          ),
                          const SizedBox(height: 32),

                          // Кнопка получения кода
                          ElevatedButton(
                            onPressed: authState.status == AuthStatus.loading
                                ? null
                                : _requestCode,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              foregroundColor: Colors.black,
                              minimumSize: const Size(double.infinity, 54),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              elevation: 4,
                            ),
                            child: authState.status == AuthStatus.loading
                                ? const CircularProgressIndicator(
                                    color: Colors.black,
                                  )
                                : const Text(
                                    'Получить код',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                          ),
                        ] else ...[
                          // Этап 2: ввод кода
                          const Text(
                            'Подтверждение',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Введите код, отправленный на ${_emailController.text.isNotEmpty ? _emailController.text : _phoneController.text}',
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.textSecondary,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 32),

                          // Поле для кода
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.shade50,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.grey.shade200),
                            ),
                            child: TextFormField(
                              controller: _codeController,
                              decoration: InputDecoration(
                                labelText: 'Код подтверждения',
                                labelStyle: TextStyle(
                                  color: AppColors.textSecondary,
                                ),
                                prefixIcon: Icon(
                                  Icons.lock_outline,
                                  color: AppColors.primaryDark,
                                ),
                                border: InputBorder.none,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 14,
                                ),
                              ),
                              keyboardType: TextInputType.number,
                              maxLength: 6,
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Если регистрация - дополнительные поля
                          if (_isRegistration) ...[
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.grey.shade50,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: Colors.grey.shade200),
                              ),
                              child: TextFormField(
                                controller: _usernameController,
                                decoration: InputDecoration(
                                  labelText: 'Имя пользователя',
                                  labelStyle: TextStyle(
                                    color: AppColors.textSecondary,
                                  ),
                                  prefixIcon: Icon(
                                    Icons.person,
                                    color: AppColors.primaryDark,
                                  ),
                                  border: InputBorder.none,
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 14,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.grey.shade50,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: Colors.grey.shade200),
                              ),
                              child: TextFormField(
                                controller: _passwordController,
                                decoration: InputDecoration(
                                  labelText: 'Пароль',
                                  labelStyle: TextStyle(
                                    color: AppColors.textSecondary,
                                  ),
                                  prefixIcon: Icon(
                                    Icons.lock,
                                    color: AppColors.primaryDark,
                                  ),
                                  border: InputBorder.none,
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 14,
                                  ),
                                ),
                                obscureText: true,
                              ),
                            ),
                            const SizedBox(height: 16),
                          ],

                          // Кнопка подтверждения
                          ElevatedButton(
                            onPressed: authState.status == AuthStatus.loading
                                ? null
                                : _verifyCode,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              foregroundColor: Colors.black,
                              minimumSize: const Size(double.infinity, 54),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              elevation: 4,
                            ),
                            child: authState.status == AuthStatus.loading
                                ? const CircularProgressIndicator(
                                    color: Colors.black,
                                  )
                                : Text(
                                    _isRegistration
                                        ? 'Зарегистрироваться'
                                        : 'Войти',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                          ),

                          const SizedBox(height: 12),

                          // Кнопка "Назад"
                          TextButton(
                            onPressed: () {
                              setState(() {
                                _codeSent = false;
                                _isRegistration = false;
                                _codeController.clear();
                              });
                            },
                            style: TextButton.styleFrom(
                              foregroundColor: AppColors.primaryDark,
                            ),
                            child: const Text('Назад'),
                          ),
                        ],

                        // Переключатель между входом и регистрацией (только на первом этапе)
                        if (!_codeSent) ...[
                          const SizedBox(height: 24),
                          Row(
                            children: [
                              Expanded(
                                child: Divider(
                                  color: Colors.grey.shade300,
                                  thickness: 1,
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                child: Text(
                                  'или',
                                  style: TextStyle(
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Divider(
                                  color: Colors.grey.shade300,
                                  thickness: 1,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                _isRegistration = !_isRegistration;
                              });
                            },
                            style: TextButton.styleFrom(
                              foregroundColor: AppColors.primaryDark,
                              textStyle: const TextStyle(fontSize: 16),
                            ),
                            child: Text(
                              _isRegistration
                                  ? 'Уже есть аккаунт? Войти'
                                  : 'Нет аккаунта? Зарегистрироваться',
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _requestCode() async {
    if (_emailController.text.isEmpty && _phoneController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Введите email или телефон'),
          backgroundColor: AppColors.warning,
        ),
      );
      return;
    }

    final success = await ref
        .read(authProvider.notifier)
        .requestCode(
          email: _emailController.text.isNotEmpty
              ? _emailController.text
              : null,
          phone: _phoneController.text.isNotEmpty
              ? _phoneController.text
              : null,
        );

    if (success && mounted) {
      setState(() {
        _codeSent = true;
      });
    }
  }

  Future<void> _verifyCode() async {
    if (_codeController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Введите код'),
          backgroundColor: AppColors.warning,
        ),
      );
      return;
    }

    bool success;
    if (_isRegistration) {
      if (_usernameController.text.isEmpty ||
          _passwordController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Заполните все поля'),
            backgroundColor: AppColors.warning,
          ),
        );
        return;
      }
      success = await ref
          .read(authProvider.notifier)
          .register(
            code: _codeController.text,
            username: _usernameController.text,
            password: _passwordController.text,
            email: _emailController.text.isNotEmpty
                ? _emailController.text
                : null,
            phone: _phoneController.text.isNotEmpty
                ? _phoneController.text
                : null,
          );
    } else {
      success = await ref
          .read(authProvider.notifier)
          .login(
            email: _emailController.text.isNotEmpty
                ? _emailController.text
                : null,
            phone: _phoneController.text.isNotEmpty
                ? _phoneController.text
                : null,
            code: _codeController.text,
          );
    }

    if (!success && mounted) {
      // Ошибка уже показывается через listener
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _phoneController.dispose();
    _codeController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
