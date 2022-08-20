//
//  GoalView.swift
//  project_theme
//
//  Created by John Perez on 8/15/22.
//

import SwiftUI

struct GoalView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var goal: Goal
   
    var body: some View {
        ZStack {
            HStack {
                TextField("goal", text: $goal.title.toUnwrapped(defaultValue: ""))
                    .onChange(of:$goal.title.toUnwrapped(defaultValue: "").wrappedValue) {_ in
                        do  {
                            try viewContext.save()
                        } catch {
                            let nsError = error as NSError
                            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                        }
                    }
                    .frame(width: 200, height: 40)
                    .border(.black)
                    .background(.clear)
                    .multilineTextAlignment(.center)
                    .textFieldStyle(.plain)
                if goal.results != nil {
                    HStack {
                        
                        ForEach(getSortedResults(), id: \.self) { result in
                            Rectangle()
                                .fill(Color.gray.opacity(0.5))
                                .frame(width: 20, height: 1)
                            
                            ResultView(result: result)
                        }
                    }
                }
            }
            .padding(.leading, -40)
            ZStack {
                Circle()
                    .fill(Color.gray.opacity(0.01))
                    .frame(width: 30.0, height: 30.0)
                Image(systemName: "x.circle")
                
            }
            .onTapGesture(perform: {viewContext.delete(goal)})
            .padding(.leading, 850)
        }
    }
    func compare(_ lhs: Result, _ rhs: Result) ->  Bool {
        return lhs.number < rhs.number
    }
    func getSortedResults() -> [Result] {
        return (goal.results as! Set<Result>).sorted(by: {$0.number < $1.number})
    }
}
