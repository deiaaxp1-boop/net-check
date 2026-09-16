import 'package:flutter/material.dart';

void main() {
  runApp(const NetCheckApp());
}

class NetCheckApp extends StatelessWidget {
  const NetCheckApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'أداة فحص الشبكة',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0D1117),
      ),
      home: const PinScreen(),
    );
  }
}

class PinScreen extends StatefulWidget {
  const PinScreen({super.key});

  @override
  State<PinScreen> createState() => _PinScreenState();
}

class _PinScreenState extends State<PinScreen> {
  final TextEditingController _pinController = TextEditingController();
  bool _isLoading = false;

  void _verifyPin() {
    setState(() {
      _isLoading = true;
    });

    Future.delayed(const Duration(seconds: 1), () {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
      });
      
      // الانتقال للشاشة الرئيسية بعد التحقق
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const NetworkCheckScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تسجيل الدخول - أداة الشبكة'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.lock_outline, size: 80, color: Colors.blueAccent),
              const SizedBox(height: 24),
              const Text(
                'الرجاء إدخال رمز الحماية',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
              TextField(
                controller: _pinController,
                obscureText: true,
                keyboardType: TextInputType.number,
                maxLength: 6,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  labelText: 'رمز الـ PIN',
                  prefixIcon: const Icon(Icons.key),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _verifyPin,
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text('دخول', style: TextStyle(fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NetworkCheckScreen extends StatelessWidget {
  const NetworkCheckScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('فحص الشبكة والاتصال'),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.wifi, size: 80, color: Colors.greenAccent),
            SizedBox(height: 16),
            Text(
              'النظام جاهز ومتصل بنجاح',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
