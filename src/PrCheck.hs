{-# LANGUAGE OverloadedStrings #-}
module PrCheck
    ( someFunc
    ) where

import GitHub
import GitHub.Endpoints.PullRequests
import Data.List
import qualified Data.Vector as V

someFunc :: IO ()
someFunc = do
    pulls <- pullRequestsFor "aslatter" "parsec"
    case pulls of
        (Left error) -> putStrLn "Error"
        (Right pullRequests) ->
             print . V.head $ pullRequests
