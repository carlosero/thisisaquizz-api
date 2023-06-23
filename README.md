# This Is A Quiz - API

Backend for thisisaquizz.fyi

## Running it

1. I developed with Ruby 3.1, but I guess 2.5+ will work
2. Install libraries with `bundle install`
3. Run specs to make sure everything is ok `rspec`
4. Run server with `rails server`

## Requests

There are 3 main requests in this API.

### `GET /api/v1/quizzes/:id`

- Response, if the quiz is in progress: `{ state: 'in_progress', question: { number: int, question: string, options: array(string) }}`
- Response, if the quiz is already completed: `{ state: 'completed', score: int }`

### `POST /api/v1/quizzes`

Creates a quiz, returning its id, state and first question (as the previous GET response).

### `POST /api/v1/quizzes/:id/next`

Used to advance to the next question. Will record the answer and respond with the same body as the above `GET` request.

## Models

### Question

Question itself, with properties:
- `number: int` - Number of the question
- `question: string` - Question
- `correct_answer: string` - The correct answer to the question

### QuestionOption

All the options of the question, with properties:
- `question_id: int` - Related question
- `option: string` - The option

### Quiz

Holds the quiz, and keeps a control during the questionaire. Properties:
- `state: string` - Used to know the status of the quiz. Enum (in_progress, completed)
- `current_question: int` - Current quetion that the user needs to answer.
- `final_score: int` - Score of the quiz, only calculated after the last question is answered.

### QuizAnswer

Stores the answer to each question. Is optional (no answers are required to complete a quiz). Properties:
- `quiz_id: int` - Quiz related
- `question_id: int` - Question related
- `answer: string` - Answer submitted
- `score: int` - 1 or 0 if the answer is correct
