import 'package:flutter/material.dart';
import 'dart:math';

class Investimentos extends StatefulWidget {
  const Investimentos({super.key});

  @override
  State<Investimentos> createState() => _InvestimentosState();
}

class _InvestimentosState extends State<Investimentos> {
  double valorMensal = 0.0;
  int meses = 0;
  double taxa = 0.0;

  double calcularSemJuros() {
    return valorMensal * meses;
  }

  double calcularComJuros() {
    double i = taxa / 100;

    if (i == 0) return calcularSemJuros();

    double montante = 0;

    // Juros compostos com aportes mensais
    for (int t = 1; t <= meses; t++) {
      montante += valorMensal * pow(1 + i, meses - t);
    }

    return montante;
  }

  void resultado() {
    if (mounted) {
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text("Resultado"),
          content: Text(
            "Total sem juros: R\$ ${calcularSemJuros().toStringAsFixed(2)}\n"
            "Total com juros: R\$ ${calcularComJuros().toStringAsFixed(2)}",
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK"),
            )
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/fundo.webp"),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Color.fromRGBO(0, 0, 0, 0.3),
              BlendMode.dstATop,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 30.0,
            children: [
              const Center(
                child: Text(
                  "Simulador de Investimentos",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),

              TextField(
                decoration: const InputDecoration(
                  labelText: "Investimento mensal",
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  valorMensal = double.tryParse(value) ?? 0;
                },
              ),

              TextField(
                decoration: const InputDecoration(
                  labelText: "Número de meses",
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  meses = int.tryParse(value) ?? 0;
                },
              ),

              TextField(
                decoration: const InputDecoration(
                  labelText: "Taxa de juros (%)",
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  taxa = double.tryParse(value) ?? 0;
                },
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () => resultado(),
                    child: const Text("Simular"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}