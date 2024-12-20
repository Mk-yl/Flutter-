import 'package:epsi_shop/article.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
 import 'package:epsi_shop/page/cart.dart';


class DetailArticlePage extends StatelessWidget {
  DetailArticlePage({super.key, required this.article});


  final article;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Details"),
        backgroundColor: Theme
            .of(context)
            .colorScheme
            .inversePrimary,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(
              height: 300,
              article.image,
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    article.nom,
                    style: Theme
                        .of(context)
                        .textTheme
                        .headlineMedium,
                  ),
                  Text(
                    article.prixEuro(),
                    style: Theme
                        .of(context)
                        .textTheme
                        .titleLarge,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Categorie : ${article.categorie}",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                article.description,
                textAlign: TextAlign.start,
              ),
            ),
            // FutureBuilder(
            //     future: wait5Seconds(),
            //     builder: (context, snapshot) {
            //       if (snapshot.hasData) {
            //         return Text("Donnee telecharger : ${snapshot.data}");
            //       } else {
            //         return CircularProgressIndicator();
            //       }
            //     }),
            OutlinedButton(onPressed: () {
              context.read<Cart>().add(article);
            },
                child: Text("Ajouter au panier")
            ),
          ],
        ),
      ),
    );
  }
}