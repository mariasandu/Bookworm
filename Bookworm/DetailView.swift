//
//  DetailView.swift
//  Bookworm
//  Uncomment the lines to see the preview. But in the same time comment all lines that have "book" in them.
//  Also, in the ContentView.swift comment the line that has "DetailView(book: book)" in it and uncomment the line that has "DetailView()" in it.
//
//  Created by Maria Sandu on 20.09.2023.
//

import SwiftUI
import CoreData


struct DetailView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    @State private var showingDeleteAlert = false
    
    let book: Book
    
    var body: some View {
        ScrollView {
            ZStack(alignment: .bottomTrailing) {
//                Image("Fantasy")
                Image(book.genre ?? "Fantasy")
                    .resizable()
                    .scaledToFit()
                
//                Text("FANTASY")
                Text(book.genre?.uppercased() ?? "FANTASY")
                    .font(.caption)
                    .fontWeight(.black)
                    .padding(8)
                    .foregroundColor(.white)
                    .background(.black.opacity(0.75))
                    .clipShape(Capsule())
                    .offset(x: -5, y: -5)
            }
//            Text("Unknown author")
            Text(book.author ?? "Unknown author")
                .font(.title)
                .foregroundColor(.secondary)
            
//            Text("No review")
            Text(book.review ?? "No review")
                .padding()

//            RatingView(rating: .constant(3))
            RatingView(rating: .constant(Int(book.rating)))
                .font(.largeTitle)
        }
        .navigationTitle("Unknown Book")

//        .navigationTitle(book.title ?? "Unknown Book")
        .navigationBarTitleDisplayMode(.inline)
        
        .alert("Delete book", isPresented: $showingDeleteAlert) {
            Button("Delete", role: .destructive, action: deleteBook)
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("Are you sure you want to delete this book?")
        }
        
        
    }
    func deleteBook() {
        moc.delete(book)

        // uncomment this line if you want to make the deletion permanent
        // try? moc.save()
        dismiss()
    }
}

//struct DetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailView()
//    }
//}
