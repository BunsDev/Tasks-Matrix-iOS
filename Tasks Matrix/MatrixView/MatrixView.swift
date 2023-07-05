//
//  MatrixView.swift
//  Tasks Matrix
//
//  Created by Amante Castino on 6/29/23.
//

import SwiftUI

struct MatrixView: View {

    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    let matrixCases = Matrix.allCases

    @State var allTasks = TaskItem.sampleData
    var matrixCounts: [Matrix: Int] {
        matrixCases.reduce(into: [Matrix: Int]()) { partialResult, matrix in
            partialResult[matrix] = allTasks.filter(by: matrix).filter({ task in
                Status.visibleCases.contains(task.status)
            }).count
        }
    }

    var body: some View {
        NavigationStack {
            VStack {
                LazyVGrid(columns: columns) {
                    ForEach(matrixCases, id: \.self) { matrix in
                        NavigationLink {
                            ListView(matrix: matrix, allTasks: $allTasks)
                        } label: {
                            GroupBoxView(matrix: matrix, count: matrixCounts[matrix] ?? 0)
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
            .padding()
            .navigationTitle("Tasks Matrix")
            
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MatrixView()
    }
}
