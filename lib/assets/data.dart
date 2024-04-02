// data.dart

final Map<String, dynamic> jsonData = {
  "questionAnswerSets": [
    {
      "questionTitle": "Question: 1",
      "questionText": "What is the sum of 2 and 3?",
      "answerOptions": [
        {"answerPlace": "A", "answerText": "1", "boxNumber": 1.1},
        {"answerPlace": "B", "answerText": "5", "boxNumber": 1.2},
        {"answerPlace": "C", "answerText": "7", "boxNumber": 1.3}
      ]
    },
    {
      "questionTitle": "Question: 2",
      "questionText": "What is the area of a square with side length 4?",
      "answerOptions": [
        {"answerPlace": "A", "answerText": "8", "boxNumber": 2.1},
        {"answerPlace": "B", "answerText": "12", "boxNumber": 2.2},
        {"answerPlace": "C", "answerText": "16", "boxNumber": 2.3}
      ]
    },
    {
      "questionTitle": "Question: 3",
      "questionText":
          "In this updated implementation, we added an isSelected parameter to the AnswerOption widget. When isSelected is true, the AnswerOption widget will have a yellow background color. You can pass the selectedAnswer variable to the isSelected parameter to indicate which answer option is selected.",
      "answerOptions": [
        {"answerPlace": "A", "answerText": "Berlin", "boxNumber": 1.1},
        {"answerPlace": "B", "answerText": "Paris", "boxNumber": 1.2},
        {"answerPlace": "C", "answerText": "London", "boxNumber": 1.3}
      ]
    },
    {
      "questionTitle": "Question: 4",
      "questionText": "Which is the tallest mountain in the world?",
      "answerOptions": [
        {
          "answerPlace": "A",
          "answerText":
              " added an isSelected parameter to the AnswerOption widget. When isSelected is true, the AnswerOption widget will have a yellow background color. You can pass the selectedAnswer variable to the isSelected parameter to indicate which answer option is selected",
          "boxNumber": 2.1
        },
        {"answerPlace": "B", "answerText": "K2", "boxNumber": 2.2},
        {"answerPlace": "C", "answerText": "Kangchenjunga", "boxNumber": 2.3}
      ]
    },
    {
      "questionTitle": "Question: 5",
      "questionText": "The Earth is flat.",
      "answerOptions": [
        {"answerPlace": "A", "answerText": "True", "boxNumber": 1.1},
        {"answerPlace": "B", "answerText": "False", "boxNumber": 1.2}
      ]
    },
    {
      "questionTitle": "Question: 6",
      "questionText":
          "We create a list of QuestionAnswerSet objects and pass each object to the questioAnswerSet() method. We also update the AnswerOption widget to accept an isCorrect parameter and change the color based on whether the answer is correct or not. Finally, we update the selectAnswer() method to accept a boolean parameter to indicate whether the selected answer is correct or not.We create a list of QuestionAnswerSet objects and pass each object to the questioAnswerSet() method. We also update the AnswerOption widget to accept an isCorrect parameter and change the color based on whether the answer is correct or not. Finally, we update the selectAnswer() method to accept a boolean parameter to indicate whether the selected answer is correct or not.",
      "answerOptions": [
        {"answerPlace": "A", "answerText": "True", "boxNumber": 2.1},
        {"answerPlace": "B", "answerText": "False", "boxNumber": 2.2}
      ]
    },
    {
      "questionTitle": "Question: 7",
      "questionText": "Which animal is known for its long neck?",
      "answerOptions": [
        {
          "answerPlace": "A",
          "answerText": "Elephant",
          "boxNumber": 1.1,
          "imageUrl": "[Image of Elephant]"
        },
        {
          "answerPlace": "B",
          "answerText": "Giraffe",
          "boxNumber": 1.2,
          "imageUrl": "[Image of Giraffe]"
        },
        {
          "answerPlace": "C",
          "answerText": "Lion",
          "boxNumber": 1.3,
          "imageUrl": "[Image of Lion]"
        }
      ]
    }
  ]
};
