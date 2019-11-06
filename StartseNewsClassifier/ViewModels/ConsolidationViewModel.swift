//
//  ConsolidationViewModel.swift
//  StartseNewsClassifier
//
//  Created by Cristiano Araújo on 05/11/19.
//  Copyright © 2019 Cristiano Araújo. All rights reserved.
//

import Foundation
import CoreData

class ConsolidationViewModel {
    private var context:NSManagedObjectContext
    
    var segmentSentences:[SentenceViewModel] {
        return fetchSentences()
    }
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    private func fetchSentences() -> [SentenceViewModel]{
        var result:[SentenceViewModel] = []
        let request = NSFetchRequest<SentenceData>(entityName: "SentenceData")
        let predicate = NSPredicate(format: "containsSegment = %@", true)
        request.predicate = predicate
        
        do {
            let sentenceData = try context.fetch(request)
            let sentences = sentenceData
            
            sentences.forEach{sentence in
                print (sentence.text!)
            }
        }catch {
            print("Error: \(error)")
        }
        return result
    }
}
