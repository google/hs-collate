-- Copyright 2018-2021 Google LLC
--
-- Licensed under the Apache License, Version 2.0 (the "License");
-- you may not use this file except in compliance with the License.
-- You may obtain a copy of the License at
--
--      http://www.apache.org/licenses/LICENSE-2.0
--
-- Unless required by applicable law or agreed to in writing, software
-- distributed under the License is distributed on an "AS IS" BASIS,
-- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
-- See the License for the specific language governing permissions and
-- limitations under the License.

{-# LANGUAGE ScopedTypeVariables #-}

module Main(main) where

import qualified Data.List.NonEmpty as NE

import Test.Framework.Providers.QuickCheck2 (testProperty)
import Test.QuickCheck ((===), arbitrary, forAll)
import Test.Framework(defaultMain)

import Data.Collate

main :: IO ()
main = defaultMain
  [ testProperty "sample equivalent to indexing" $
      forAll ((NE.:|) <$> arbitrary <*> arbitrary) $
      \ (xs :: NE.NonEmpty Int) i0 ->
        let n = length xs
            i = i0 `mod` n
        in  xs NE.!! i === collate (sample i id) xs
  , testProperty "bulkSample equivalent to indexing" $
      forAll ((NE.:|) <$> arbitrary <*> arbitrary) $
      \ (xs :: NE.NonEmpty Int) (is0 :: [Int]) ->
        let n = length xs
            is = map (`mod` n) is0
        in  map (xs NE.!!) is === collate (bulkSample is id) xs
  , testProperty "not quadratic" $
      collate (bulkSample (replicate 10000 999999) id) [0..1000000] ===
      replicate 10000 (999999 :: Integer)
  ]
