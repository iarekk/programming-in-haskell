-- option 1 (https://github.com/PiotrJustyna/haskell-anywhere):
-- ./ghci.bat C:\Users\piotr_justyna\Documents\github\programming-in-haskell\part1_chapter9_countdown\brute_force
-- option 2 (stack):
-- stack ghci
-- option 3 (ghci):
-- ghci
--
-- :load Main
main = do
    putStrLn "Operators:"
    putStrLn . show $ Add
    putStrLn . show $ Subtract
    putStrLn . show $ Multiply
    putStrLn . show $ Divide

    putStrLn "isValidOperation Add 1 3:"
    putStrLn . show $ isValidOperation Add 1 3

    putStrLn "isValidOperation Subtract 1 3:"
    putStrLn . show $ isValidOperation Subtract 1 3

    putStrLn "isValidOperation Subtract 3 1:"
    putStrLn . show $ isValidOperation Subtract 3 1

    putStrLn "isValidOperation Multiply 1 3:"
    putStrLn . show $ isValidOperation Multiply 1 3

    putStrLn "isValidOperation Divide 2 4:"
    putStrLn . show $ isValidOperation Divide 2 4

    putStrLn "isValidOperation Divide 4 2:"
    putStrLn . show $ isValidOperation Divide 4 2

    putStrLn "isValidOperation Divide 4 0:"
    putStrLn . show $ isValidOperation Divide 4 0

    putStrLn "isValidExpression (Application Add (Value 1) (Value 3)):"
    putStrLn . show $ isValidExpression (Application Add (Value 1) (Value 3))

    putStrLn "isValidExpression (Application Subtract (Value 1) (Value 3)):"
    putStrLn . show $ isValidExpression (Application Subtract (Value 1) (Value 3))

    putStrLn "isValidExpression (Application Subtract (Value 3) (Value 1)):"
    putStrLn . show $ isValidExpression (Application Subtract (Value 3) (Value 1))

    putStrLn "isValidExpression (Application Multiply (Value 1) (Value 3)):"
    putStrLn . show $ isValidExpression (Application Multiply (Value 1) (Value 3))

    putStrLn "isValidExpression (Application Divide (Value 2) (Value 4)):"
    putStrLn . show $ isValidExpression (Application Divide (Value 2) (Value 4))

    putStrLn "isValidExpression (Application Divide (Value 4) (Value 2):"
    putStrLn . show $ isValidExpression (Application Divide (Value 4) (Value 2))

    putStrLn "isValidExpression (Application Divide (Value 4) (Value 0):"
    putStrLn . show $ isValidExpression (Application Divide (Value 4) (Value 0))

    putStrLn "apply Add 4 2:"
    putStrLn . show $ apply Add 4 2

    putStrLn "apply Subtract 4 2:"
    putStrLn . show $ apply Subtract 4 2

    putStrLn "apply Multiply 4 2:"
    putStrLn . show $ apply Multiply 4 2

    putStrLn "apply Divide 4 2:"
    putStrLn . show $ apply Divide 4 2

    putStrLn "Expression: Value (5 :: Int):"
    putStrLn . show $ Value (5 :: Int)

    putStrLn "Expression: expression1:"
    putStrLn $ show expression1

    putStrLn "values expression1:"
    putStrLn . show $ values expression1

    putStrLn "evaluate expression1:"
    putStrLn . show $ evaluate expression1

    putStrLn "subSequences [1, 2, 3]"
    putStrLn . show $ subSequences [1, 2, 3]

    putStrLn "interleave 4 [1, 2, 3]"
    putStrLn . show $ interleave 4 [1, 2, 3]

    putStrLn "permutations [1, 2, 3]"
    putStrLn . show $ permutations [1, 2, 3]

    putStrLn "allPossibleChoices [1, 2]"
    putStrLn . show $ allPossibleChoices [1, 2]

    putStrLn "allPossibleChoices [1, 2, 3]"
    putStrLn . show $ allPossibleChoices [1, 2, 3]

    putStrLn "expression2:"
    putStrLn . show $ expression2

    putStrLn "isASolution expression2 [1, 3, 7, 10, 25, 50] 765"
    putStrLn . show $ isASolution expression2 [1, 3, 7, 10, 25, 50] 765

    putStrLn "allPossibleSplits [1, 2, 3, 4]"
    putStrLn . show $ allPossibleSplits [1, 2, 3, 4]

    putStrLn "allPossibleOperations (Value (1 :: Int)) (Value (2 :: Int)):"
    putStrLn . show $ allPossibleOperations (Value (1 :: Int)) (Value (2 :: Int))

    putStrLn "allPossibleOperations expression1 expression2:"
    putStrLn . show $ allPossibleOperations expression1 expression2

    putStrLn "allPossibleExpressions [1, 2, 3]"
    putStrLn . show $ allPossibleExpressions [1, 2, 3]

    putStrLn "allPossibleSolutions [1, 3, 7, 10, 25, 50] 765"
    putStrLn . show $ allPossibleSolutions [1, 3, 7, 10, 25, 50] 765

    putStrLn "allPossibleSolutions [1, 2, 3] 6"
    putStrLn . show $ allPossibleSolutions [1, 2, 3] 6

expression1 :: Expression
expression1 = Application Add (Value (5 :: Int)) (Application Multiply (Value (2 :: Int)) (Value (3 :: Int)))

expression2 :: Expression
expression2 = Application
    Multiply
    (Application Add (Value (1 :: Int)) (Value (50 :: Int)))
    (Application Subtract (Value (25 :: Int)) (Value (10 :: Int)))

data Operator = Add | Subtract | Multiply | Divide

instance Show Operator where
    show Add = "+"
    show Subtract = "-"
    show Multiply = "*"
    show Divide = "/"

data Expression = Value Int | Application Operator Expression Expression

instance Show Expression where
    show (Value x) = show x
    show (Application operator expression1 expression2) =
        (brackets expression1) ++ show operator ++ (brackets expression2)
        where
            brackets (Value x) = show x
            brackets application = "(" ++ show application ++ ")"

isValidOperation :: Operator -> Int -> Int -> Bool
isValidOperation Add _ _ = True
isValidOperation Subtract x y = x > y
isValidOperation Multiply _ _ = True
isValidOperation Divide x y = y /= 0 && x `mod` y == 0

isValidExpression :: Expression -> Bool
isValidExpression (Value x) = x > 0
isValidExpression (Application operator expression1 expression2) =
    isValidExpression expression1 &&
    isValidExpression expression2 &&
    isValidOperation operator evaluatedExpression1 evaluatedExpression2
    where
        evaluatedExpression1 = evaluate expression1
        evaluatedExpression2 = evaluate expression2

apply :: Operator -> Int -> Int -> Int
apply Add x y = x + y
apply Subtract x y = x - y
apply Multiply x y = x * y
apply Divide x y = x `div` y

values :: Expression -> [Int]
values (Value x) = [x]
values (Application operator expression1 (expression2)) = (values expression1) ++ (values expression2)

evaluate :: Expression -> Int
evaluate (Value x) =
    if (x > 0)
        then x
        else error "Expression value should be positive."
evaluate (Application operator expression1 expression2) =
    apply operator (evaluate expression1) (evaluate expression2)

subSequences :: [a] -> [[a]]
subSequences [] = [[]]
subSequences (x:xs) = ys ++ [x:n | n <- ys]
    where
        ys = subSequences xs

interleave :: a -> [a] -> [[a]]
interleave x [] = [[x]]
interleave x list = [(left y) ++ [x] ++ (right y) | y <- [0 .. (length list)]]
    where
        left n = take n list
        right n = drop n list

permutations :: [a] -> [[a]]
permutations [] = [[]]
permutations (x:xs) = concat (map (interleave x) (permutations xs))

allPossibleChoices :: [a] -> [[a]]
allPossibleChoices = concat . map permutations . subSequences

isASolution :: Expression -> [Int] -> Int -> Bool
isASolution expression numbers target =
    elem (values expression) (allPossibleChoices numbers) &&
    (evaluate expression) == target

allPossibleSplits :: [a] -> [([a], [a])]
allPossibleSplits list = [splitAt pivot list | pivot <- [1 .. ((length list) - 1)]]

allPossibleOperations :: Expression -> Expression -> [Expression]
allPossibleOperations expression1 expression2 =
    [Application operator expression1 expression2 |
        operator <- [Add, Subtract, Multiply, Divide]]

allPossibleExpressions :: [Int] -> [Expression]
allPossibleExpressions [] = []
allPossibleExpressions [x] = [Value x]
allPossibleExpressions xs =
    [bothSidesExpressions |
        (leftSideValues, rightSideValues) <- allPossibleSplits xs,
        leftSideExpression <- allPossibleExpressions leftSideValues,
        rightSideExpression <- allPossibleExpressions rightSideValues,
        bothSidesExpressions <- allPossibleOperations leftSideExpression rightSideExpression]

allPossibleSolutions :: [Int] -> Int -> [Expression]
allPossibleSolutions numbers target =
    [expression |
        singleChoice <- allPossibleChoices numbers,
        expression <- allPossibleExpressions singleChoice,
        isValidExpression expression,
        isASolution expression numbers target]
