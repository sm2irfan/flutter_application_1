// data.dart

final Map<String, dynamic> jsonData = {
  "questionAnswerSets": [
    {
      "questionTitle": "வினா இலக்கம்: 1",
      "questionText":
          "மொழிக்கு நிலைபேறு அளிப்பது எழுத்தாகும். ஒலி வடிவத்திற்கு வரிவடிவம் கொடுப்பது எழுத்து என்பர். எழுதப் படுவதனால் எழுத்து எனப் பெயர் பெற்றது. தமிழ் மொழி என்பது செம்மொழியாகவும் பண்டைகாலம் தொட்டே சிறந்த இலக்கண, இலக்கியங்கள் பெற்ற மொழியாகவும் உள்ளது. இந்த மொழியில் எத்தனை எழுத்துக்கள் உள்ளன",
      "answerOptions": [
        {"answerPlace": "A", "answerText": "245", "boxNumber": "1.1"},
        {"answerPlace": "B", "answerText": "256", "boxNumber": "1.2"},
        {"answerPlace": "C", "answerText": "247", "boxNumber": "1.3"}
      ]
    },
    {
      "questionTitle": "வினா இலக்கம்: 2",
      "questionText": "What is the area of a square with side length 4?",
      "answerOptions": [
        {"answerPlace": "A", "answerText": "8", "boxNumber": "2.1"},
        {"answerPlace": "B", "answerText": "12", "boxNumber": "2.2"},
        {"answerPlace": "C", "answerText": "16", "boxNumber": "2.3"}
      ]
    },
    {
      "questionTitle": "வினா இலக்கம்: 3",
      "questionText":
          "In this updated implementation, we added an isSelected parameter to the AnswerOption widget. When isSelected is true, the AnswerOption widget will have a yellow background color. You can pass the selectedAnswer variable to the isSelected parameter to indicate which answer option is selected.",
      "answerOptions": [
        {"answerPlace": "A", "answerText": "Berlin", "boxNumber": "3.1"},
        {"answerPlace": "B", "answerText": "Paris", "boxNumber": "3.2"},
        {"answerPlace": "C", "answerText": "London", "boxNumber": "3.3"}
      ]
    },
    {
      "questionTitle": "வினா இலக்கம்: 4",
      "questionText": "Which is the tallest mountain in the world?",
      "answerOptions": [
        {
          "answerPlace": "A",
          "answerText":
              " added an isSelected parameter to the AnswerOption widget. When isSelected is true, the AnswerOption widget will have a yellow background color. You can pass the selectedAnswer variable to the isSelected parameter to indicate which answer option is selected",
          "boxNumber": "4.1"
        },
        {"answerPlace": "B", "answerText": "K2", "boxNumber": "4.2"},
        {"answerPlace": "C", "answerText": "Kangchenjunga", "boxNumber": "4.3"}
      ]
    },
    {
      "questionTitle": "வினா இலக்கம்: 5",
      "questionText": "The Earth is flat.",
      "answerOptions": [
        {"answerPlace": "A", "answerText": "True", "boxNumber": "5.1"},
        {"answerPlace": "B", "answerText": "False", "boxNumber": "5.2"}
      ]
    },
    {
      "questionTitle": "வினா இலக்கம்: 6",
      "questionText":
          "We create a list of QuestionAnswerSet objects and pass each object to the questioAnswerSet() method. We also update the AnswerOption widget to accept an isCorrect parameter and change the color based on whether the answer is correct or not. Finally, we update the selectAnswer() method to accept a boolean parameter to indicate whether the selected answer is correct or not.We create a list of QuestionAnswerSet objects and pass each object to the questioAnswerSet() method. We also update the AnswerOption widget to accept an isCorrect parameter and change the color based on whether the answer is correct or not. Finally, we update the selectAnswer() method to accept a boolean parameter to indicate whether the selected answer is correct or not.",
      "answerOptions": [
        {"answerPlace": "A", "answerText": "True", "boxNumber": "6.1"},
        {"answerPlace": "B", "answerText": "False", "boxNumber": "6.2"}
      ]
    },
    {
      "questionTitle": "வினா இலக்கம்: 7",
      "questionText": "Which animal is known for its long neck?",
      "answerOptions": [
        {
          "answerPlace": "A",
          "answerText": "Elephant",
          "boxNumber": "7.1",
          "imageUrl": "[Image of Elephant]"
        },
        {
          "answerPlace": "B",
          "answerText": "Giraffe",
          "boxNumber": "7.2",
          "imageUrl": "[Image of Giraffe]"
        },
        {
          "answerPlace": "C",
          "answerText": "Lion",
          "boxNumber": "7.3",
          "imageUrl": "[Image of Lion]"
        }
      ]
    }
  ]
};
