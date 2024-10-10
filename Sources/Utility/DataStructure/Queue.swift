//
//  Copyright © 2022 reers.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

public struct Queue<E> {
    private var array: [E?] = []
    private var head = 0
    
    public init() {}
    
    public var count: Int {
        return array.count - head
    }
    
    public var isEmpty: Bool {
        return count == 0
    }
    
    public mutating func enqueue(_ element: E) {
        array.append(element)
    }
    
    @discardableResult
    public mutating func dequeue() -> E? {
        guard head < array.count, let element = array[head] else { return nil }
        
        array[head] = nil
        head += 1
        
        if array.count > 50 && (Double(head) / Double(array.count) > 0.25) {
            array.removeFirst(head)
            head = 0
        }
        return element
    }
    
    public var front: E? {
        if isEmpty {
            return nil
        } else {
            return array[head]
        }
    }
}

extension Queue: CustomStringConvertible {
    public var description: String {
        if isEmpty {
            return "Empty queue"
        }
        let elements = array
            .compactMap { $0 }
            .map { String(describing: $0) }
            .joined(separator: ", ")
        return "<<< \(elements)"
    }
}
