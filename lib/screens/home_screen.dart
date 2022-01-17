import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
// Controlador do texto do peso
  TextEditingController weightController = TextEditingController();

// Controlador do texto da altura
  TextEditingController heightController = TextEditingController();

// Chave global de formulario
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = 'Digite os seus dados!';

// Refazer os campos
  void _resetFields() {
    weightController.text = '';
    heightController.text = '';
    setState(() {
      _infoText = 'Digite os seus dados!';
      _formKey = GlobalKey<FormState>();
    });
  }

  void _calculate() {
    setState(
      () {
        final weight = double.parse(weightController.text);
        final height = double.parse(heightController.text) / 100;
        final imc = weight / (height * height);
        if (imc < 18.6) {
          _infoText = 'Abaixo do Peso (${imc.toStringAsPrecision(4)}kg)';
        } else if (imc >= 18.6 && imc < 24.9) {
          _infoText = 'Peso Ideal (${imc.toStringAsPrecision(4)}kg)';
        } else if (imc >= 24.9 && imc < 29.9) {
          _infoText =
              'Levemente Acima do Peso (${imc.toStringAsPrecision(4)}kg)';
        } else if (imc >= 29.9 && imc < 34.9) {
          _infoText = 'Obesidade Grau I (${imc.toStringAsPrecision(4)}kg)';
        } else if (imc >= 34.9 && imc < 39.9) {
          _infoText = 'Obesidade Grau II (${imc.toStringAsPrecision(4)}kg)';
        } else if (imc >= 40) {
          _infoText = 'Obesidade Grau III (${imc.toStringAsPrecision(4)}kg)';
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Calculadora de IMC',
        ),
        backgroundColor: Color.fromRGBO(77, 187, 158, 1), //#4DBB9E
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.refresh_outlined,
            ),
            onPressed: _resetFields,
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(
                Icons.person_outline,
                size: 120,
                color: Colors.green,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Peso (kg)',
                  labelStyle: TextStyle(
                    color: Color.fromRGBO(77, 187, 158, 1),
                  ),
                ),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color.fromRGBO(77, 187, 158, 1),
                  fontSize: 25,
                ),
                controller: weightController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Insira seu Peso!';
                  }
                  return value;
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Altura (cm)',
                  labelStyle: TextStyle(
                    color: Color.fromRGBO(77, 187, 158, 1),
                  ),
                ),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color.fromRGBO(77, 187, 158, 1),
                  fontSize: 25,
                ),
                controller: heightController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Insira sua Altura!';
                  }
                  return value;
                },
              ),
              Padding(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                child: Container(
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _calculate,
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromRGBO(77, 187, 158, 1),
                    ),
                    child: Text(
                      'Calcular',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                      ),
                    ),
                  ),
                ),
              ),
              Text(
                _infoText,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color.fromRGBO(77, 187, 158, 1),
                  fontSize: 25,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
