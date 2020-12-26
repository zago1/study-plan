import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:study_plan/bloc/database_bloc.dart';
import 'package:study_plan/bloc/database_event.dart';
import 'package:study_plan/models/task_models.dart';
import 'package:study_plan/scoped_models/global_model.dart';

class TaskEntry extends StatelessWidget {
  final GlobalKey<FormState> formKey = new GlobalKey();
  final Task inModel = Task();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: addTaskFormulario(context),
    );
  }

  Widget addTaskFormulario(BuildContext context) {
    bool updated = false;
    return ScopedModelDescendant<SelectedTask>(
        builder: (BuildContext _context, Widget child, SelectedTask model) {
      return Form(
          key: formKey,
          child: Container(
            padding: EdgeInsets.all(32),
            child: Column(
              children: [
                TextFormField(
                    initialValue: !updated ? model.selectedTask?.titulo : "",
                    validator: (value) {
                      if (value.length == 0) {
                        return "Please enter titulo";
                      }
                      return null;
                    },
                    onSaved: (String value) {
                      inModel.titulo = value;
                    },
                    decoration: InputDecoration(
                        hintText: "Nome da Disciplina",
                        labelText: "Disciplina")),
                TextFormField(
                    initialValue:
                        !updated ? model.selectedTask?.done?.toString() : "",
                    onSaved: (String value) {
                      inModel.done = true;
                    },
                    decoration: InputDecoration(
                        hintText: "Já foi feito o estudo da disciplina?",
                        labelText: "Concluído")),
                InputDatePickerFormField(
                  onDateSaved: (DateTime date) {
                    inModel.date = Timestamp.fromDate(date);
                  },
                  fieldLabelText: "Data",
                  firstDate: DateTime(2020),
                  lastDate: DateTime(2025),
                  initialDate: DateTime.now(),
                  errorFormatText: "Preencha corretamente o campo Data!!",
                  errorInvalidText: "Preencha corretamente o campo Data!",
                ),
                Divider(
                  height: 16,
                  color: Colors.transparent,
                ),
                ButtonTheme(
                  minWidth: double.infinity,
                  height: 42,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  child: MaterialButton(
                      child: Text("Adicionar"),
                      color: Colors.grey[850],
                      textColor: Colors.white,
                      onPressed: () {
                        if (formKey.currentState.validate()) {
                          formKey.currentState.save();
                          DatabaseEvent _event;
                          if ((model.selectedTask?.id?.length ?? 0) > 0) {
                            updated = true;
                            _event = UpdateDatabase(
                                bookId: model.selectedTask?.id,
                                titulo: inModel.titulo,
                                date: inModel.date,
                                done: inModel.done);
                          } else {
                            _event = AddDatabase(
                                titulo: inModel.titulo,
                                date: inModel.date,
                                done: inModel.done);
                          }

                          BlocProvider.of<DatabaseBloc>(context).add(_event);
                          formKey.currentState.reset();
                          model.selectedTask = Task();
                        }
                      }),
                ),
              ],
            ),
          ));
    });
  }
}
