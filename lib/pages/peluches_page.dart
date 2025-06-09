import 'package:flutter/material.dart';
import 'package:myapp/services/firebase_services.dart';

class PeluchesPage extends StatefulWidget {
  const PeluchesPage({super.key});

  @override
  State<PeluchesPage> createState() => _PeluchesPageState();
}

class _PeluchesPageState extends State<PeluchesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Peluches"),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: FutureBuilder(
        future: getPeluches(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasData) {
            final peluches = snapshot.data!;
            return ListView.builder(
              itemCount: peluches.length,
              itemBuilder: (context, index) {
                final peluche = peluches[index];
                return Dismissible(
                  key: Key(peluche["uid"]),
                  background: Container(
                    padding: const EdgeInsets.only(right: 20),
                    alignment: Alignment.centerRight,
                    color: Colors.red,
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  direction: DismissDirection.endToStart,
                  confirmDismiss: (direction) async {
                    return await showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: Text("¿Eliminar ${peluche["nombre"]}?"),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context, false),
                            child: const Text("Cancelar"),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(context, true),
                            child: const Text("Eliminar"),
                          ),
                        ],
                      ),
                    );
                  },
                  onDismissed: (_) async {
                    await deletePeluche(peluche["uid"]);
                    setState(() {});
                  },
                  child: Card(
                    margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            peluche["nombre"] ?? "Sin nombre",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.teal,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Row(children: [
                            const Icon(Icons.label_important, size: 16, color: Colors.grey),
                            const SizedBox(width: 6),
                            Text("ID: ${peluche["id_peluche"]}"),
                          ]),
                          Text("Proveedor: ${peluche["id_proveedor"]}"),
                          Text("Sucursal: ${peluche["id_sucursal"]}"),
                          Text("Color: ${peluche["color"]}"),
                          Text("Tamaño: ${peluche["tamaño"]}"),
                          Text("Tela: ${peluche["tipo_de_tela"]}"),
                          Text(
                            "Precio: \$${(peluche["precio"] is int) ? peluche["precio"].toStringAsFixed(2) : peluche["precio"]}",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 10),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: TextButton.icon(
                              onPressed: () async {
                                await Navigator.pushNamed(
                                  context,
                                  "/edit",
                                  arguments: peluche,
                                );
                                setState(() {});
                              },
                              icon: const Icon(Icons.edit, size: 18),
                              label: const Text("Editar"),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(child: Text("No hay peluches."));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        onPressed: () async {
          await Navigator.pushNamed(context, "/add");
          setState(() {});
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
