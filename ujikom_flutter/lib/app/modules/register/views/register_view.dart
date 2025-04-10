import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lottie/lottie.dart';
import 'package:ujikom_flutter/app/modules/login/views/login_view.dart';
import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    RegisterController controller = Get.put(RegisterController());

    return Scaffold(
      backgroundColor: HexColor('#feeee8'),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Lottie.network(
                'https://gist.githubusercontent.com/olipiskandar/2095343e6b34255dcfb042166c4a3283/raw/d76e1121a2124640481edcf6e7712130304d6236/praujikom_kucing.json',
                height: 150,
              ),
              const SizedBox(height: 20),
              _buildTextField(
                  controller.nameController, 'Full Name', Icons.person),
              _buildTextField(
                controller.emailController, 'Email', Icons.email),
              _buildTextField(
                  controller.passwordController, 'Password', Icons.lock, obscureText: true),
              _buildTextField(
                controller.passwordConfirmationController,'Confirm Password', Icons.lock,obscureText: true),
              _buildDropdownField(
                  controller.jenisKelaminController,'Jenis Kelamin',Icons.wc,{'L': 'Laki-laki', 'P': 'Perempuan'}),
              _buildDropdownField( 
                controller.kelasIdController, 'Kelas', Icons.school, {'1': 'Kelas 10', '2': 'Kelas 11', '3': 'Kelas 12'}),
              _buildDropdownField(
                controller.jurusanIdController, 'Jurusan',Icons.business, {'1': 'RPL', '2': 'TKRO', '3': 'TBSM'}),
              _buildDropdownField(
                 controller.gelombangBelajarIdController, 'Gelombang Belajar', Icons.schedule, {'1': '1', '2': '2', '3': '3'}),
              _buildTextField(
                controller.nomorTelpController, 'Nomor Telepon', Icons.phone,keyboardType: TextInputType.phone),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: controller.registerNow,
                  child: const Text(
                    'Register Now',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Sudah punya akun? "),
                  GestureDetector(
                    onTap: () {
                      Get.to(() => LoginView());
                    },
                    child: Text(
                      "Login",
                      style: TextStyle(
                        color: HexColor('#4e54c8'),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      TextEditingController controller, String label, IconData icon,
      {bool obscureText = false,
      TextInputType keyboardType = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }

  Widget _buildDropdownField(TextEditingController controller, String label,
      IconData icon, Map<String, String> items) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: DropdownButtonFormField(
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
        items: items.entries.map((entry) {
          return DropdownMenuItem(value: entry.key, child: Text(entry.value));
        }).toList(),
        onChanged: (value) => controller.text = value!,
      ),
    );
  }
}
