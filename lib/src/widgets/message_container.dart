import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/chat_bloc.dart';

class MessageContainer extends StatelessWidget {
  final String? message;
  final bool isUserMessage;
  final String? question1;
  final String? question2;
  final String? question3;
  final String? question4;
  final String? question5;

  const MessageContainer({
    Key? key,

    /// Indicamos que siempre se debe mandar un mensaje
    @required this.message,
    this.isUserMessage = false,
    this.question1,
    this.question2,
    this.question3,
    this.question4,
    this.question5,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      /// Cambia el lugar del mensaje
      mainAxisAlignment:
          isUserMessage ? MainAxisAlignment.end : MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        question1 == '' || question1 == null
            ? Container(
                /// Limita nuestro contenedor a un ancho máximo de 250
                constraints: BoxConstraints(maxWidth: 250),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: isUserMessage == false
                            ? Radius.circular(15)
                            : Radius.circular(0),
                        topLeft: isUserMessage == true
                            ? Radius.circular(15)
                            : Radius.circular(0),
                        bottomRight: Radius.circular(15),
                        bottomLeft: Radius.circular(15)),

                    /// Cambia el color del contenedor del mensaje
                    color: (isUserMessage == false
                        ? Colors.grey.shade200
                        : Colors.indigo[400]),
                  ),

                  /// Espaciado
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    /// Obtenemos el texto del mensaje y lo pintamos.
                    /// Si es nulo, enviamos un string vacío.
                    message!,
                    style: TextStyle(
                        color: isUserMessage == true
                            ? Colors.white
                            : Colors.black),
                  ),
                ),
              )
            : Container(
                /// Limita nuestro contenedor a un ancho máximo de 250
                constraints: BoxConstraints(maxWidth: 250),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: isUserMessage == false
                            ? Radius.circular(15)
                            : Radius.circular(0),
                        topLeft: isUserMessage == true
                            ? Radius.circular(15)
                            : Radius.circular(0),
                        bottomRight: Radius.circular(15),
                        bottomLeft: Radius.circular(15)),

                    /// Cambia el color del contenedor del mensaje
                    color: (isUserMessage == false
                        ? Colors.grey.shade200
                        : Colors.indigo[400]),
                  ),

                  /// Espaciado
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        /// Obtenemos el texto del mensaje y lo pintamos.
                        /// Si es nulo, enviamos un string vacío.
                        message!,
                        style: TextStyle(
                            color: isUserMessage == true
                                ? Colors.white
                                : Colors.black),
                      ),
                      if (question1 != null)
                        cardStyle(context, question1!),
                      if (question2 != null)
                        cardStyle(context, question2!),
                      if (question3 != null)
                        cardStyle(context, question3!),
                      if (question4 != null)
                        cardStyle(context, question4!),
                      if (question5 != null)
                        cardStyle(context, question5!),
                    ],
                  ),
                ),
              ),
      ],
    );
  }

  Widget cardStyle(BuildContext context, String question) {
    return GestureDetector(
      onTap: () async{
        context.read<ChatBloc>().add(OnSendMessage(message: question));

        context.read<ChatBloc>().add(OnRecivedMessage(message: question));
      },
      child: Card(
        color: Colors.indigo[400],
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Text(
            question,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
