import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../article.dart';

import 'cart.dart';
import 'payment_page.dart';



class PanierPage extends StatelessWidget {
  const PanierPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<Cart>().getAll();


    double total = cart.fold<double>(0.0, (sum, article) => sum + article.prix) * 1.2;


    return Scaffold(
      appBar: AppBar(
        title: const Text("Panier"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: cart.isEmpty
          ? const Center(child: Text("Votre Panier est vide"))
          : Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cart.length,
              itemBuilder: (context, index) {
                final article = cart[index];
                return ListTile(
                  leading: Image.network(article.image, width: 50),
                  title: Text(article.nom),
                  subtitle: Text("${article.prix}€"),
                  trailing: TextButton(
                    onPressed: () {
                      context.read<Cart>().remove(article);
                    },
                    child: const Text(
                      "SUPPRIMER",
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "Total avec (TVA 20%) : ${total.toStringAsFixed(2)}€",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                if (cart.isNotEmpty)
                  ElevatedButton(
                    onPressed: () {
                      final total = cart.fold(0.0, (sum, article) => sum + article.prix) * 1.2;
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PaymentPage(total: total),
                        ),
                      );
                    },
                    child: const Text("Procéder au paiement"),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
