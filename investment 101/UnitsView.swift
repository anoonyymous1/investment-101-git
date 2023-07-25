//
//  UnitsView.swift
//  investment 101
//
//  Created by Celine Tsai on 25/7/23.
//

import SwiftUI

struct Question: Equatable, Hashable {
    let text: String
    let answers: [String]
    let rightAnswer: String

    static func == (lhs: Question, rhs: Question) -> Bool {
        return lhs.text == rhs.text
            && lhs.answers == rhs.answers
            && lhs.rightAnswer == rhs.rightAnswer
    }

    init(q: String, a: [String], correctAnswer: String) {
        text = q
        answers = a
        rightAnswer = correctAnswer
    }
}

struct Topic: Identifiable {
    let id: Int
    let name: String
    let article: String
    let questions: [Question]
}

struct UnitsView: View {
    let topics = [
        Topic(id: 1, name: K.unit1, article: K.article1, questions: K.quiz1),
        Topic(id: 2, name: K.unit2, article: K.article2, questions: K.quiz1),
        Topic(id: 3, name: K.unit3, article: K.article1, questions: K.quiz1),
        Topic(id: 4, name: K.unit4, article: K.article1, questions: K.quiz1)
    ]

    var body: some View {
        VStack {
            Text("Units")
                .font(.largeTitle)
                .padding(.all)
            
            List(topics) { topic in
                NavigationLink(destination: TopicDetailView(topic: topic)) {
                    Text(topic.name)
                }
            }
            .navigationBarHidden(true) // Hide the navigation bar
            .navigationBarBackButtonHidden(true)
        }
    }
}

struct UnitsView_Previews: PreviewProvider {
    static var previews: some View {
        UnitsView()
    }
}

struct TopicDetailView: View {
    var topic: Topic

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 4) {
                parseMarkdown(topic.article)
                    .padding(.horizontal)
                    .padding(.vertical, 2)
                
                NavigationLink(destination: QuizView(questions: topic.questions)) {
                    Text("Quiz time!!")
                        .foregroundColor(.white)
                        .font(.title)
                        .frame(maxWidth: .infinity)
                        .frame(height: 70)
                        .background(Color(#colorLiteral(red: 0.0431372549, green: 0.1411764706, blue: 0.2784313725, alpha: 1))) // #0B2447
                        .cornerRadius(10)
                        .padding(.top, 30)
                }
            }
            .padding(.all)
        }
    }

    func parseMarkdown(_ text: String) -> some View {
        let lines = text.components(separatedBy: "\n")

        return ForEach(lines, id: \.self) { line in
            parseLine(line)
        }
    }

    @ViewBuilder
    func parseLine(_ line: String) -> some View {
        if line.starts(with: "# ") {
            Text(line.trimmingCharacters(in: .whitespaces).replacingOccurrences(of: "# ", with: ""))
                .font(.largeTitle)
                .bold()
                .lineLimit(nil) // Allow the text to wrap to multiple lines
                .fixedSize(horizontal: false, vertical: true) // Allow vertical expansion
                .padding(.bottom, 2) // Adjust the bottom padding
        } else if line.starts(with: "## ") {
            Text(line.trimmingCharacters(in: .whitespaces).replacingOccurrences(of: "## ", with: ""))
                .font(.title)
                .bold()
                .padding(.bottom, 1) // Adjust the bottom padding
        } else if line.starts(with: "### ") {
            Text(line.trimmingCharacters(in: .whitespaces).replacingOccurrences(of: "### ", with: ""))
                .font(.headline)
                .bold()
                .padding(.bottom, 0.5) // Adjust the bottom padding
        } else {
            Text(line)
                .font(.body)
        }
    }
}
