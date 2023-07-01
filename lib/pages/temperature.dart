import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TemperaturePage extends StatefulWidget {
  const TemperaturePage({super.key});

  @override
  State<TemperaturePage> createState() => _TemperaturePageState();
}

class _TemperaturePageState extends State<TemperaturePage> {

  String? result;

  final FocusNode _tempInput = FocusNode();
  final TextEditingController _tempValueController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void toFarenheit(value) {
    value = ((double.parse(value) * 1.8) + 32).toStringAsFixed(2);
    result = "Farenheit : $value";
    setState(() { });
  }

  void toCelcius (value) {
    value = ((double.parse(value)-32) / 1.8).toStringAsFixed(2);
    result = "Celcius : $value";
    setState(() { });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tempValueController.addListener(() {
       // do something
    });
  }

  @override
  Widget build(BuildContext context) {

    Future.delayed(const Duration(seconds: 3), () {
      FocusScope.of(context).requestFocus(_tempInput);
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text("Temperature Convertor"),
        elevation: 0,
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: Container(
        color: Colors.black,
        padding: const EdgeInsets.all(50),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
          
              if(result != null) 
              Container(
                padding: const EdgeInsets.all(30),
                child: Text(result.toString(), style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white),)
              ),

              // Input Field
              tempInputField(),
          
              // Button Group
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  tempButton("To Farenheit", (value){
                    toFarenheit(value);
                  }),
                  const SizedBox(width: 20),
                  tempButton("To Celcius", (value){
                    toCelcius(value);
                  }),
                ],
              )
          
            ],
          ),
        ),
      ),
      
    );
  }

  Widget tempInputField() {
    return Container(
        margin: const EdgeInsets.only(bottom: 20),
        child: Form(
          key: _formKey,
          child: TextFormField(
            controller: _tempValueController,
            keyboardType: TextInputType.number,
            focusNode: _tempInput,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter a search term',
              fillColor: Colors.white,
              filled: true,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: Colors.yellow),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: Colors.yellow),
              ),
            ),
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            validator: (value) {
              if(value == null || value.trim() == "") {
                return "Please Enter Value";
              }
              return null;
            },
          ),
        ),
      );
  }

  Widget tempButton(String title, Function calculate) {
    return ElevatedButton(
      onPressed: () {
        if(_formKey.currentState!.validate()) {
          _tempInput.unfocus();
          calculate(_tempValueController.text);
         // _tempValueController.text = "";
        }
      } ,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.yellow,
        foregroundColor: Colors.black
      ), 
      child: Text(title),
      );
  }

}