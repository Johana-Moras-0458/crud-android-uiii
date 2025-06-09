import 'package:flutter/material.dart';
import 'package:myapp/services/firebase_services.dart';

class EditPeluchePage extends StatefulWidget {
  const EditPeluchePage({super.key});

  @override
  State<EditPeluchePage> createState() => _EditPeluchePageState();
}

class _EditPeluchePageState extends State<EditPeluchePage> {
  final Map<String, TextEditingController> controllers = {
    "id_peluche": TextEditingController(),
    "id_proveedor": TextEditingController(),
    "id_sucursal": TextEditingController(),
    "nombre": TextEditingController(),
    "color": TextEditingController(),
    "precio": TextEditingController(),
    "tamaño": TextEditingController(),
    "tipo_de_tela": TextEditingController(),
  };

  String? docId;

  @override
  void dispose() {
    for (var controller in controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    docId = args["uid"];

    // Llenar los campos
    controllers.forEach((key, controller) {
      controller.text = args[key]?.toString() ?? '';
    });

    return Scaffold(
      appBar: AppBar(title: const Text("Editar Peluche")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            ...controllers.entries.map((entry) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: TextField(
                controller: entry.value,
                decoration: InputDecoration(
                  labelText: entry.key,
                  border: const OutlineInputBorder(),
                ),
              ),
            )),
            ElevatedButton(
              onPressed: () async {
                Map<String, dynamic> data = {
                  for (var entry in controllers.entries) entry.key: entry.value.text,
                  "precio": double.tryParse(controllers["precio"]!.text) ?? 0.0,
                };
                await updatePeluche(docId!, data);
                Navigator.pop(context);
              },
              child: const Text("Actualizar"),
            ),
          ],
        ),
      ),
    );
  }
}
