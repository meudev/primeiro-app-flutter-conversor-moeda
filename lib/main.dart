import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _formKey = GlobalKey<FormState>();
  final controllerName = TextEditingController();
  final controllerPhone = TextEditingController();
  final controllerValue = TextEditingController();

  var maskFormatterPhone = MaskTextInputFormatter(mask: '(##) # ####-####', filter: { "#": RegExp(r'[0-9]')});

  int index = 0;
  double valueDolar = 0;
  double valueEuro = 0;
  String textDolar = "";
  String textEuro = "";
  List<Widget> bodyList = [
    SingleChildScrollView(
      child: Form(
        //key: _formKey,
        child: Column(
          children: [
            TextFormField(
              validator: (value) {
                if(value.isEmpty) {
                  return "Informe seu nome";
                }
                return null;
              },
            )
          ],
        ),
      )
    ),
    SingleChildScrollView(
      child: Container(color: Colors.red),
    ),
    SingleChildScrollView(
      child: Container(color: Colors.blue),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(-15527865),
        title: Text("Conversor de Moeda"),
        centerTitle: true,
      ),
      //body: bodyList[index],
      body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(padding: EdgeInsets.only(right: 20, left: 20), child:
                TextFormField(
                  controller: controllerName,
                  decoration: InputDecoration(
                    labelText: "Nome",
                  ),
                  validator: (value) {
                    if(value == null || value.isEmpty) {
                      return "Informe seu nome";
                    }
                    return null;
                  },
                )),
                Padding(padding: EdgeInsets.only(right: 20, left: 20), child:
                TextFormField(
                  inputFormatters: [maskFormatterPhone],
                  controller: controllerPhone,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: "Telefone Celular",
                  ),
                  validator: (value) {
                    if(value == null || value.isEmpty) {
                      return "Informe seu telefone";
                    }
                    return null;
                  },
                )),
                Padding(padding: EdgeInsets.only(right: 20, left: 20, bottom: 20), child:
                TextFormField(
                  controller: controllerValue,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Valor em Reais",
                  ),
                  validator: (value) {
                    if(value == null || value.isEmpty) {
                      return "Informe um valor";
                    }
                    return null;
                  },
                )),
                ElevatedButton(onPressed: () {
                  if(_formKey.currentState.validate()) {
                    double value = double.parse(controllerValue.text);
                    setState(() {
                      valueDolar = value / 5.5;
                      valueEuro = value / 6;
                      textDolar = "Valor Convertido em Dolar: $valueDolar";
                      textEuro = "Valor Convertido em Dolar: $valueEuro";
                      controllerName.text = "";
                      controllerPhone.text = "";
                      controllerValue.text = "";
                    });
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Dados calculados com sucesso.")));
                  }
                }, child: Text("Calcular")),
             Padding(padding: EdgeInsets.only(right: 20, left: 20, top: 20), child:
                Text("$textDolar")),
             Padding(padding: EdgeInsets.only(right: 20, left: 20, top: 20), child:
                Text("$textEuro")),
              ],
            ),
          )
      ),
      /*floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
        backgroundColor: Color(-15527865),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (page) {
          setState(() {
            index = page;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.location_history), label: "Dados Pessoais"),
          BottomNavigationBarItem(icon: Icon(Icons.location_on_rounded), label: "Endereço"),
          BottomNavigationBarItem(icon: Icon(Icons.contact_mail), label: "Contatos"),
        ],
      ),*/
    );
  }
}
