//
//  DataStructure.swift
//  TeetHTTP
//
//  Created by Matt Tian on 2018/5/3.
//  Copyright © 2018 TeetBox. All rights reserved.
//

import Foundation

/* ✅ */
class Node<T> {
    
    var value: T
    var next: Node<T>?
    weak var previous: Node<T>?
    
    init(value: T) {
        self.value = value
    }
    
}

/* ✅ */
struct LinkedList<T> {
    
    var head: Node<T>?
    var tail: Node<T>?
    
    var isEmpty: Bool {
        return head == nil
    }
    
    mutating func append(_ element: T) {
        let node = Node(value: element)
        
        if let tailNode = tail {
            tailNode.next = node
            node.previous = tailNode
        } else {
            head = node
        }
        
        tail = node
    }
    
    func node(at index: Int) -> Node<T>? {
        guard index >= 0 else {
            return nil
        }
        
        var node = head
        var i = 0
        while node != nil {
            if i == index {
                return node
            }
            
            node = node!.next
            i += 1
        }
        
        return nil
    }
    
    @discardableResult
    mutating func remove(at index: Int) -> Node<T>? {
        guard index >= 0 else {
            return nil
        }
        
        var node = head
        var i = 0
        while node != nil {
            if i == index {
                if let previousNode = node!.previous {
                    if let nextNode = node!.next {
                        previousNode.next = nextNode
                        nextNode.previous = previousNode
                    } else {
                        previousNode.next = nil
                        tail = previousNode
                    }
                } else {
                    head = node!.next
                    if head == nil {
                        tail = nil
                    }
                }
                return node
            }
            
            node = node!.next
            i += 1
        }
        
        return nil
    }
    
    @discardableResult
    mutating func remove(node: Node<T>) -> Node<T> {
        let previous = node.previous
        let next = node.next
        
        if let previous = previous {
            previous.next = next
        } else {
            head = next
        }
        
        next?.previous = previous
        
        if next == nil {
            tail = previous
        }
        
        node.previous = nil
        node.next = nil
        
        return node
    }
    
    mutating func removeAll() {
        head = nil
        tail = nil
    }
    
}

/* ✅ */
struct Queue<T> {
    
    private var list = LinkedList<T>()
    
    var isEmpty: Bool {
        return list.isEmpty
    }
    
    mutating func enqueue(_ element: T) {
        list.append(element)
    }
    
    mutating func dequeue() -> T? {
        guard !isEmpty else {
            return nil
        }
        
        return list.remove(node: list.head!).value
    }
    
    func peek() -> T? {
        return list.head?.value
    }
    
}
