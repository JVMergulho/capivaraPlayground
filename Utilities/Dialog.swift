//
//  Dialog.swift
//  capivARa
//
//  Created by João Vitor Lima Mergulhão on 12/02/25.
//

import SwiftUI

struct Dialog{
    let text: Text
    let image: String
}

let dialogs = [
    Dialog(text: Text("""
    Welcome to **Serra da Capivara National Park**!
    
    You are in one of the most fascinating places in the world! The park is home to the largest concentration of cave paintings ever recorded.
    """), image: "capivara1"),
    Dialog(text: Text("""
    We are in the state of **Piauí, in Northeastern Brazil**. 
    This park covers more than 320 thousand acres and has archaeological sites that provide evidence of human presence over **50 thousand years ago** on the American continent.
    """), image: "capivara4"),
    Dialog(text: Text("""
    The discoveries made here were crucial in supporting new theories about the peopling of America by archaeologist **Niède Guidon**. 
    She was instrumental in the **foundation of the park in 1979** and its recognition as a **UNESCO World Heritage Site in 1991**.
    """), image: "capivara3"),
    Dialog(text: Text("""
    Oh, sorry, I got so excited that I forgot to introduce myself… my name is Niède (as you can see, my parents are archaeology fans).
    I’ll be your guide on this journey through time. Get ready to hike along amazing trails and discover ancient secrets!
    """), image: "capivara2")
]
