import 'package:flutter/material.dart';

class PaymentPage extends StatelessWidget {
  final double total;

  const PaymentPage({super.key, required this.total});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    // Contrôleurs pour la saisie des informations
    final nameController = TextEditingController();
    final cardNumberController = TextEditingController();
    final expiryDateController = TextEditingController();
    final cvvController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Paiement"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Total à payer : ${total.toStringAsFixed(2)} €",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(labelText: "Nom complet"),
                validator: (value) => value!.isEmpty ? "Champ requis" : null,
              ),
              TextFormField(
                controller: cardNumberController,
                decoration: const InputDecoration(labelText: "Numéro de carte"),
                keyboardType: TextInputType.number,
                maxLength: 16,
                validator: (value) => value!.length != 16 ? "Numéro invalide" : null,
              ),
              TextFormField(
                controller: expiryDateController,
                decoration: const InputDecoration(labelText: "Date d'expiration (MM/YY)"),
                keyboardType: TextInputType.datetime,
                validator: (value) => value!.isEmpty ? "Champ requis" : null,
              ),
              TextFormField(
                controller: cvvController,
                decoration: const InputDecoration(labelText: "CVV"),
                keyboardType: TextInputType.number,
                maxLength: 3,
                validator: (value) => value!.length != 3 ? "CVV invalide" : null,
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Paiement effectué avec succès !")),
                      );
                      Navigator.pop(context);
                    }
                  },
                  child: const Text("Payer"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
