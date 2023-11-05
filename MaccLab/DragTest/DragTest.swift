//
//  DragTest.swift
//  MaccLab
//
//  Created by Toughie on 11/5/23.
//

import SwiftUI

struct Memo {
    var name: String
    var done: Bool
}

final class MemoManager: ObservableObject {
    var memos: [Memo] = []
    
    init() {
        self.memos.append(Memo(name: "test1", done: false))
        self.memos.append(Memo(name: "test2", done: false))
        self.memos.append(Memo(name: "test3", done: false))
    }
}

struct MemoCell: View {
    var memo: Memo

    var body: some View {
        HStack {
            Text(memo.name)
        }
        .foregroundStyle(.blue)
        .frame(maxWidth: .infinity)
        .frame(height: 100)
    }
}

struct DragTest: View {
    @ObservedObject var memoManager = MemoManager()

    var body: some View {
        NavigationStack {
            
            ZStack {
                Color.yellow
                    .ignoresSafeArea()
                
                VStack {
                    Text("순서를 이동하시오")
                    
                    List {
                        ForEach(memoManager.memos, id: \.name) { memo in
                            MemoCell(memo: memo)
                                .listRowSeparator(.hidden)
                        }
                        .onMove { indexSet, int in
                            memoManager.memos.move(fromOffsets: indexSet, toOffset: int)
                        }
                    }
                    .background(.pink)
                    .scrollContentBackground(.hidden)
                    .listStyle(.grouped)
                    
                    Spacer()

                    Button(action: {}, label: {
                        /*@START_MENU_TOKEN@*/Text("Button")/*@END_MENU_TOKEN@*/
                    })
                    Spacer()
                }
            }
        }
    }
}

#Preview {
    DragTest()
}
