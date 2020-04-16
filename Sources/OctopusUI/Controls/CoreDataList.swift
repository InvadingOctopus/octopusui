//
//  CoreDataList.swift
//  OctopusUI
//  https://github.com/InvadingOctopus/octopusui
//
//  Created by ShinryakuTako@invadingoctopus.io on 2019/9/15.
//  Copyright © 2020 Invading Octopus. Licensed under Apache License v2.0 (see LICENSE.txt)
//

import SwiftUI
import CoreData

// A prototype for a list that displays a customizable Core Data query.
public struct CoreDataList<ManagedObjectType, RowContent>: View
    where ManagedObjectType: NSManagedObject,
    RowContent: View
{
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @FetchRequest var items: FetchedResults<ManagedObjectType>
    
    public var rowContent: (ManagedObjectType) -> RowContent
    
    init(sortDescriptors: [NSSortDescriptor],
        @ViewBuilder rowContent: @escaping (ManagedObjectType) -> RowContent)
    {
        self._items = FetchRequest(entity: ManagedObjectType.entity(),
                                   sortDescriptors: sortDescriptors,
                                   predicate: NSPredicate(value: true))
        
        self.rowContent = rowContent
    }
    
    public var body: some View {
        List {
            Section {
                ForEach(items, id: \.self) { item in
                    self.rowContent(item)
                }
            }
        }
    }
}

//struct CoreDataList_Previews: PreviewProvider {
//    static var previews: some View {
//        CoreDataList()
//    }
//}
