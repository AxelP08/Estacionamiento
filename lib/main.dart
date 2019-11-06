import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

void main() => runApp(Estacionamiento());

class Estacionamiento extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new EstadoEstacionamiento();
  }
}
class EstadoEstacionamiento extends State {

  //Horas:
  String entrada = "--:--:--";
  String salida = "--:--:--";

  //Costos:
  int costoHora = 30;
  int costoFraccion = 15;

  //Totales:
  int horasTotales = 0;
  int minutosTotales = 0;
  int segundosTotales = 0;
  String tiempoTotal = "--:--:--";
  int costoTotal = 0;

  void snackBar(BuildContext context) {
    final scaffold = Scaffold.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: const Text("No puedes viajar en el tiempo!!!"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return new MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Estacionamiento"),
          backgroundColor: Colors.teal,
        ),
        body:  Builder( //El contexto no servía para el timePicker.
          builder: (context) => Padding( //Se usa Builder para tener otro contexto que si se pueda usar.
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: <Widget>[

                //Botones para poner la fecha en DateTimePicker:

                /** Botón entrada **/
                Container(
                  child: Text("Hora de entrada:",
                    style: TextStyle(
                        color: Colors.teal,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0),
                  ),
                  margin: EdgeInsets.only(bottom: 15, top: 15),
                ),

                RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0)
                  ),
                  elevation: 4.0,
                  onPressed: () {
                    DatePicker.showTimePicker(
                      context,
                      showTitleActions: true,
                      onConfirm: (hora) {
                        setState(() {
                          String horas, minutos, segundos;
                          (hora.hour.toString().length == 1) ? horas = "0${hora.hour}" : horas = "${hora.hour}";
                          (hora.minute.toString().length == 1) ? minutos = "0${hora.minute}" : minutos = "${hora.minute}";
                          (hora.second.toString().length == 1) ? segundos = "0${hora.second}" : segundos = "${hora.second}";

                          entrada = "$horas:$minutos:$segundos";

                          if (salida != "--:--:--") {
                            horasTotales = int.parse(salida.substring(0, 1)) - int.parse(entrada.substring(0, 1));
                            minutosTotales = int.parse(salida.substring(3, 4)) - int.parse(entrada.substring(3, 4));
                            segundosTotales = int.parse(salida.substring(6, 7)) - int.parse(entrada.substring(6, 7));

                            if (minutosTotales < 0) {
                              horasTotales--;
                              minutosTotales = 60 + minutosTotales;
                            }
                            if (segundosTotales < 0) {
                              if (minutosTotales == 0) {
                                horasTotales--;
                                minutosTotales = 60;
                              }
                              minutosTotales--;
                              segundosTotales = 60 + segundosTotales;
                            }

                            String h, m, s;
                            (horasTotales.toString().length == 1) ? h = "0${horasTotales.toString()}" : h = "${horasTotales.toString()}";
                            (minutosTotales.toString().length == 1) ? m = "0${minutosTotales.toString()}" : m = "${minutosTotales.toString()}";
                            (segundosTotales.toString().length == 1) ? s = "0${segundosTotales.toString()}" : s = "${segundosTotales.toString()}";

                            if (horasTotales < 0 || minutosTotales < 0 || segundosTotales <0) {
                              snackBar(context);
                              tiempoTotal = "--:--:--";
                              costoTotal = 0;
                            } else {
                              tiempoTotal = "$h:$m:$s";

                              if (horasTotales > 0) {
                                costoTotal = horasTotales * 30;
                              }
                              if (minutosTotales > 0 || segundosTotales > 0) {
                                costoTotal += 15;
                              }
                            }
                          }
                        });
                      },
                      currentTime: DateTime.now(),
                      locale: LocaleType.es,
                    );
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 50.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Container(
                              child: Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.access_time,
                                    color: Colors.teal,
                                  ),
                                  Text(
                                    "$entrada",
                                    style: TextStyle(
                                        color: Colors.teal,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.0),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        Text(
                          "Establecer",
                          style: TextStyle(
                              color: Colors.teal,
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0),
                        ),
                      ],
                    ),
                  ),
                  color: Colors.white,
                ),
                /** Fin botón entrada **/

                /** Botón salida **/
                Container(
                  child: Text("Hora de salida:",
                    style: TextStyle(
                        color: Colors.teal,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0),
                  ),
                  margin: EdgeInsets.only(bottom: 15, top: 25),
                ),

                RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0)
                  ),
                  elevation: 4.0,
                  onPressed: () {
                    DatePicker.showTimePicker(
                      context,
                      showTitleActions: true,
                      onConfirm: (hora) {
                        salida = "";
                        setState(() {
                          String horas, minutos, segundos;
                          (hora.hour.toString().length == 1) ? horas = "0${hora.hour}" : horas = "${hora.hour}";
                          (hora.minute.toString().length == 1) ? minutos = "0${hora.minute}" : minutos = "${hora.minute}";
                          (hora.second.toString().length == 1) ? segundos = "0${hora.second}" : segundos = "${hora.second}";

                          salida = "$horas:$minutos:$segundos";

                          if (entrada != "--:--:--") {
                            horasTotales = int.parse(horas) - int.parse(entrada.substring(0, 2));
                            minutosTotales = int.parse(minutos) - int.parse(entrada.substring(3, 5));
                            segundosTotales = int.parse(segundos) - int.parse(entrada.substring(6, 8));

                            if (minutosTotales < 0) {
                              horasTotales--;
                              minutosTotales = 60 + minutosTotales;
                            }
                            if (segundosTotales < 0) {
                              if (minutosTotales == 0) {
                                horasTotales--;
                                minutosTotales = 60;
                              }
                              minutosTotales--;
                              segundosTotales = 60 + segundosTotales;
                            }

                            String h, m, s;
                            (horasTotales.toString().length == 1) ? h = "0${horasTotales.toString()}" : h = "${horasTotales.toString()}";
                            (minutosTotales.toString().length == 1) ? m = "0${minutosTotales.toString()}" : m = "${minutosTotales.toString()}";
                            (segundosTotales.toString().length == 1) ? s = "0${segundosTotales.toString()}" : s = "${segundosTotales.toString()}";

                            if (horasTotales < 0 || minutosTotales < 0 || segundosTotales <0) {
                              snackBar(context);
                              tiempoTotal = "--:--:--";
                              costoTotal = 0;
                            } else {
                              tiempoTotal = "$h:$m:$s";

                              if (horasTotales > 0) {
                                costoTotal = horasTotales * 30;
                              }
                              if (minutosTotales > 0 || segundosTotales > 0) {
                                costoTotal += 15;
                              }
                            }
                          }
                        });
                      },
                      currentTime: DateTime.now(),
                      locale: LocaleType.es,
                    );
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 50.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Container(
                              child: Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.access_time,
                                    color: Colors.teal,
                                  ),
                                  Text(
                                    "$salida",
                                    style: TextStyle(
                                        color: Colors.teal,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.0),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        Text(
                          "Establecer",
                          style: TextStyle(
                              color: Colors.teal,
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0),
                        ),
                      ],
                    ),
                  ),
                  color: Colors.white,
                ),
                /** Fin botón salida **/

                //Textos para mostrar los resultados:
                Container(
                  child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.timer,
                          color: Colors.teal,
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              "Costo por hora: ",
                              style: TextStyle(
                                  color: Colors.teal,
                                  fontSize: 15.0
                              ),
                            ),
                            Text(
                              "\$30",
                              style: TextStyle(
                                  fontSize: 15.0
                              ),
                            ),
                          ],
                        ),
                      ]),
                  margin: EdgeInsets.only(top: 40),
                ),

                Container(
                  child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.timelapse,
                          color: Colors.teal,
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              "Costo por fracción: ",
                              style: TextStyle(
                                  color: Colors.teal,
                                  fontSize: 15.0
                              ),
                            ),
                            Text(
                              "\$15",
                              style: TextStyle(
                                  fontSize: 15.0
                              ),
                            ),
                          ],
                        ),
                ])),

                Container(
                  child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.av_timer,
                          color: Colors.teal,
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              "Tiempo total: ",
                              style: TextStyle(
                                  color: Colors.teal,
                                  fontSize: 20.0
                              ),
                            ),
                            Text(
                              "$tiempoTotal",
                              style: TextStyle(
                                  fontSize: 20.0
                              ),
                            ),
                          ],
                        ),
                      ]),
                  margin: EdgeInsets.only(top: 40),
                ),

                Container(
                  child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.monetization_on,
                          color: Colors.teal
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              "Costo total: ",
                              style: TextStyle(
                                  color: Colors.teal,
                                  fontSize: 20.0
                              ),
                            ),
                            Text(
                              "\$$costoTotal",
                              style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ]),
                  margin: EdgeInsets.only(top: 20),
                ),

              ],
            ),
          ),
        )
      ),
    );
  }

}
