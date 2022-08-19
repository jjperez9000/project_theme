

//
//  ContentView.swift
//  project_theme
//
//  Created by John Perez on 7/29/22.
//

import SwiftUI

enum Destination: Hashable {
    case writing
    case goal
    case idea
}


struct ContentView: View {
    //general information
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var database: Store
    @State private var sidebarDestination: Destination = .goal
    @State private var navVisibility: NavigationSplitViewVisibility = .all
    
    // writing page data
    // request pages sorted on creation date
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \WritingPage.date, ascending: true)],
        animation: .default)
    private var writingPages: FetchedResults<WritingPage>
    
    @State private var selectedWritingPageId: WritingPage.ID?
    
    private var selectedWritingPage: WritingPage? {
        guard let selectedPage = writingPages.filter({$0.id == selectedWritingPageId}).first else {
            return nil
        }
        return selectedPage
    }
    
    // idea page data
    // request pages sorted on creation date
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \IdeaPage.date, ascending: true)],
        animation: .default)
    private var ideaPages: FetchedResults<IdeaPage>
    
    @State private var selectedIdeaPageId: IdeaPage.ID?
    
    private var selectedIdeaPage: IdeaPage? {
        guard let selectedPage = ideaPages.filter({$0.id == selectedIdeaPageId}).first else {
            return nil
        }
        return selectedPage
    }

    //goal page data
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \GoalPage.date, ascending: true)],
        animation: .default)
    private var goalPages: FetchedResults<GoalPage>
    
    @State private var selectedGoalPageId: GoalPage.ID?
    
    private var selectedGoalPage: GoalPage? {
        guard let selectedPage = goalPages.filter({$0.id == selectedGoalPageId}).first else {
            return nil
        }
        return selectedPage
    }

    
    
    var body: some View {
        //main navigation view for application
        //Sidebar has 3 options, which display a menu, which then
        //generate a set of page view to choose from
        NavigationSplitView(columnVisibility: $navVisibility) {
            SidebarView(destination: $sidebarDestination)
        } content: {
            switch sidebarDestination {
            case .writing:
                WritingMenuView(selectedWritingPageId: $selectedWritingPageId)
            case .goal:
                GoalMenuView(selectedGoalPageId: $selectedGoalPageId)
            case .idea:
                IdeaMenuView(selectedIdeaPageId: $selectedIdeaPageId)
            }
        } detail: {
            switch sidebarDestination {
            case .writing:
                if let page = selectedWritingPage {
                    WritingPageView(page: page)
                } else {
                    ThemeView(sidebarDestination: $sidebarDestination)
                }
            case .goal:
                if ((selectedGoalPage ?? nil) != nil) {
                    GoalPageView(page: selectedGoalPage!)
                } else {
                    ThemeView(sidebarDestination: $sidebarDestination)
                }
            case .idea:
                if let page = selectedIdeaPage {
                    IdeaPageView(page: page)
                } else {
                    ThemeView(sidebarDestination: $sidebarDestination)
                }
            }

        }
    }
}


struct SidebarView: View {
    //simple view for displaying the primary sidebar 
    @Binding var destination: Destination
    var body: some View {
        List(selection: $destination) {
            NavigationLink(value: Destination.writing) {
                Label("writing", systemImage: "book")
            }
            NavigationLink(value: Destination.goal) {
                Label("goal", systemImage: "flag.fill")
            }
            NavigationLink(value: Destination.idea) {
                Label("idea", systemImage: "circle.hexagonpath")
            }
        }
    }
}
