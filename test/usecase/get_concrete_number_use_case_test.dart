import 'dart:convert';
import 'dart:io';

import 'package:clean_architecture/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:clean_architecture/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:clean_architecture/features/number_trivia/domain/use_cases/get_concrete_number_trivia.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';


class MockNumberTriviaRepository extends Mock
    implements NumberTriviaRepository {}
void main() {

  GetConcreteNumberTrivia? useCase;
  MockNumberTriviaRepository? mockNumberTriviaRepository;

  setUp(() {
    mockNumberTriviaRepository = MockNumberTriviaRepository();
    useCase = GetConcreteNumberTrivia(mockNumberTriviaRepository!);
  });

  group('GetConcreteNumberTrivia', () {
    final file = File('test/test data/test_cases.json');
    final jsonString = file.readAsStringSync();
    final List testCases = jsonDecode(jsonString);

    testCases.forEach((testCase) {
      final input = testCase['input'];
      final expectedOutput = NumberTrivia(
        number: testCase['number'],
        text: testCase['text'],
      );

      test('input: $input, expectedOutput: $expectedOutput', () async {
        // Arrange
        when(() => mockNumberTriviaRepository!.getConcreteNumberTrivia(input))
            .thenAnswer((_) async => Right(NumberTrivia(number: input, text: 'test')));

        // Act
        final result = await useCase!(Params(number: input));

        // Assert
        expect(result, equals(Right(expectedOutput)));
        verify(() => mockNumberTriviaRepository!.getConcreteNumberTrivia(input));

        verifyNoMoreInteractions(
          mockNumberTriviaRepository,
        );
      });
    });
  });
}
