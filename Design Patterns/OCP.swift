//
//  OCP.swift
//  Design Patterns
//
//  Created by SAHIL AMRUT AGASHE on 15/04/24.
//

import Foundation

enum Color {
    case red
    case green
    case blue
}

enum Size {
    case small
    case medium
    case large
    case huge
}

class Product {
    var name: String
    var color: Color
    var size: Size
     
    init(_ name: String, _ color: Color, _ size: Size) {
        self.name = name
        self.color = color
        self.size = size
    }
}


class ProductFilter {
    
    func filterByColor(_ products: [Product], _ color: Color) -> [Product] {
        var result = [Product]()
        for p in products {
            if p.color == color { result.append(p) }
        }
        return result
    }
    
    func filterBySize(_ products: [Product], _ size: Size) -> [Product] {
        var result = [Product]()
        for p in products {
            if p.size == size { result.append(p) }
        }
        return result
    }
    
    func filterBySizeAndColor(_ products: [Product], _ size: Size, _ color: Color) -> [Product] {
        var result = [Product]()
        for p in products {
            if p.size == size, p.color == color {
                result.append(p)
            }
        }
        return result
    }
}

protocol Specification {
    associatedtype T
    func isSatisfied(_ item: T) -> Bool
}

protocol Filter {
    associatedtype T
    func filter<Spec: Specification>(_ items: [T], _ spec: Spec) -> [T] where Spec.T == T
}

class ColorSpecification: Specification {
    typealias T = Product
    let color: Color
    
    init(_ color: Color) {
        self.color = color
    }
    
    func isSatisfied(_ item: Product) -> Bool {
        item.color == color
    }
}

class sizeSpecification: Specification {
    typealias T = Product
    let size: Size
    
    init(_ size: Size) {
        self.size = size
    }
    
    func isSatisfied(_ item: Product) -> Bool {
        item.size == size
    }
}

class AndSpecification<T,
                       SpecA: Specification,
                       SpecB: Specification>: Specification where SpecA.T == SpecB.T , SpecA.T == T {
    let first: SpecA
    let second: SpecB
    
    init(_ first: SpecA, _ second: SpecB) {
        self.first = first
        self.second = second
    }
    
    func isSatisfied(_ item: T) -> Bool {
        return first.isSatisfied(item) && second.isSatisfied(item)
    }
}

class BetterFilter: Filter {
    typealias T = Product
    
    func filter<Spec>(_ items: [Product], _ spec: Spec) -> [Product] where Spec : Specification, Product == Spec.T {
        var result = [Product]()
        
        items.forEach { i in
            if spec.isSatisfied(i) {
                result.append(i)
            }
        }
        
        return result
    }
    
}

struct OCPLearn {
    
    // Tip: - From this main function, you can easily get high-level design.
    static func main() {
        let apple = Product("Apple", .green, .small)
        let tree = Product("Tree", .green, .large)
        let house = Product("House", .blue, .large)
        let products = [apple, tree, house]
        
        let pf = ProductFilter()
        print("Green products: Using ProductFilter")
        for p in pf.filterByColor(products, .green) {
            print(" - \(p.name) is green")
        }
        
        let bf = BetterFilter()
        print("Green Products: Using BetterFilter")
        for p in bf.filter(products, ColorSpecification(.green)) {
            print(" - \(p.name) is green")
        }
        
        print("Large Blue items: Using BetterFilter")
        for p in bf.filter(products,
                           AndSpecification(ColorSpecification(.blue),
                                            sizeSpecification(.large))) {
            print(" - \(p.name) is large and blue")
        }
        
    }
}
