//
//  Operators.swift
//  IterateOSX
//
//  Created by James Wilson on 10/31/14.
//  Copyright (c) 2014 Noesis Ingenuity LLC. All rights reserved.
//

infix operator |> { associativity left }

func |> <T, U>(left: T, right: T -> U) -> U {
    return right(left)
}