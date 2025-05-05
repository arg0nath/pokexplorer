part of 'type_results_bloc.dart';

sealed class TypeResultsState extends Equatable {
  const TypeResultsState();
  
  @override
  List<Object> get props => [];
}

final class TypeResultsInitial extends TypeResultsState {}
